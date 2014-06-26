<?php
class SMTPConnection
{
	const NetworkError = 1;
	const TransactionError = 2;
	const EmailError = 3;
	
	const EOL = "\r\n";
	protected $_LastCommand = null;
	protected $_LastResponseCode = null;
	protected $_ConnectionTimeout = 60;
	protected $_CommunicationTimeout = 20;
	protected $_ConnectionString = null;
	protected $_Identification = null;
	protected $_Handle = null;
	
	public function __construct($connectionString, $identification = '127.0.0.1')
	{
		$this->_ConnectionString = $connectionString;
		$this->_Identification = $identification;
	}
	
	public function SetConnectionTimeout($seconds)
	{
		$this->_ConnectionTimeout = $seconds;
	}
	
	public function SetCommunicationTimeout($seconds)
	{
		$this->_CommunicationTimeout = $seconds;
	}
	
	public function GetLastCommand()
	{
		return $this->_LastCommand;
	}
	
	public function GetLastResponseCode()
	{
		return $this->_LastResponseCode;
	}
	
	public function Connect()
	{
		$errno  = null;
		$errstr = null;
		
		$stream = @stream_socket_client($this->_ConnectionString, $errno, $errstr, $this->_ConnectionTimeout);
		
		if ($stream === false) 
		{
			if (!$errno) 
			{
				$msg = 'Could not open socket';
			}
			else 
			{
				$msg = $errstr;
			}
			throw new EmailException($msg, self::NetworkError);
		}
		
		$this->_Handle = $stream;
		
		try 
		{
			if (!stream_set_timeout($this->_Handle, $this->_CommunicationTimeout)) 
			{
				throw new EmailException('Could not set stream timeout', self::NetworkError);
			}
			
			/**
			 * Now the connection is open. Wait for the welcome message:
			 *   welcome message has error code 220
			 */
			$this->Expect(220);
			$this->Helo();
		}
		catch (EmailException $exception)
		{
			fclose($stream);
			throw $exception;
		}
	}
	
	public function Helo()
	{
		$this->Send('EHLO ' . $this->_Identification);
	
	    try 
	    {
			$this->Expect(250);
	    }
	    catch (EmailException $exception) 
	    {
			// propably wrong status code, RFC 2821 requires sending HELO in this case:
			$this->Send('HELO ' . $this->_Identification);
			$this->Expect(250);
	    }
	}
	
	public function MailFrom($email)
	{
		$this->Send('MAIL FROM:<' . $email . '>');
		$this->Expect(250);
	}
	
	public function RcptTo($email)
	{
		$this->Send('RCPT TO:<' . $email . '>');
		$this->Expect(250, 251);
	}
	
	public function Data($data)
	{
		$this->Send('DATA');
		$this->Expect(354);
		
		foreach (explode(self::EOL, $data) as $line) 
		{
			if (substr($line, 0, 1) == '.')
			{
				$line = '.' . $line;
			}
			$this->Send($line, false);
		}
		
		$this->Send('.', false);
		$this->Expect(250);
	}
	
	public function Rset()
	{
		$this->Send('RSET');
		$this->Expect(250);
	}
	
	public function Noop()
	{
		$this->Send('NOOP');
		$this->Expect(250);
	}
	
	public function Quit()
	{
		$this->Send('QUIT');
		$this->Expect(221);
	}
	
	public function Disconnect()
	{
		$this->Quit();
		fclose($this->_Handle);
		$this->_Handle = null;
	}
	
	protected function Expect()
	{
		/**
		 * according to the new RFC2821, a multiline response can be sent
		 * so we now check if it is the case here.
		 * a multiline response is structured as follows:
		 *   250-ok welcome 127.0.0.1
		 *   250-PIPELINING
		 *   250 HELP
		 * normal answer would be:
		 *
		 * 250 ok.
		 */
		
		$expectedCodes = func_get_args();

		do
		{
			// blocking
			$res = $this->Receive();
			
			// returncode is always 3 digits at the beginning of the line
			$errorCode = substr($res, 0, 3);

			$this->_LastResponseCode = $errorCode;
			
			if ($errorCode === null || !in_array($errorCode, $expectedCodes))
			{
				Util::debug($res);
			}
		}
		while($res[3] == '-');
	}
	
	protected function Receive()
	{
		$res = @fgets($this->_Handle, 1024);
		if ($res === false) 
		{
			//Util::debug('Could not read from SMTP server', self::NetworkError);
		}
		return $res;
	}
	
	protected function Send($string, $isCommand = true)
	{
		
		$res = @fwrite($this->_Handle, $string . self::EOL);
		if ($res === false) 
		{
			throw new EmailException('Could not write to SMTP server', self::NetworkError);
		}
		
		if ($isCommand)
		{
			$this->_LastCommand = $string;
		}
	}
	
	public function SendMail(Email $email)
	{
		if (!count($email->GetDestinationEmails()))
		{
			throw new EmailException('No recipients have been defined.', self::EmailError);
		}
		
		$wasConnected = ($this->_Handle !== null); // check if the connection is already there
		if(!$wasConnected)
		{
			$this->Connect();
		}
		else 
		{
			$this->Rset();
		}
		
		try 
		{
			$this->MailFrom($email->GetFromEmail());
			foreach ($email->GetDestinationEmails() as $recipient)
			{
				$this->RcptTo($recipient);
			}
			$this->Data($email->GetContent());
		}
		catch (EmailException $exception) 
		{
			if(!$wasConnected)
			{
				$this->Disconnect();
			}
			throw $exception;
		}
		
		if (!$wasConnected)
		{
			$this->Disconnect();
		}
	}
}
?>