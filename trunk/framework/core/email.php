<?php
class EMail
{
	protected $_CustomHeaders = array();
	protected $_Charset = null;
	protected $_From = null;
	protected $_ReturnPath = null;
	protected $_Subject = null;
	protected $_To = array();
	protected $_CC = array();
	protected $_BCC = array();
	protected $_TextBody = null;
	protected $_HTMLBody = null;
	protected $_Attachments = array();
	protected $_Images = array();
	protected $_BodyChanged = true;
	protected $_Content = null;

	function __construct($charset = 'UTF-8')
	{
		$this->_Charset = $charset;
	}
	
	public function SetFrom($email, $name = '')
	{
		$this->_From = array($email, $name);
	}
	
	public function SetSubject($subject)
	{
		$this->_Subject = $subject;
	}
	
	public function SetReturnPath($email)
	{
		$this->_ReturnPath = $email;
	}
	
	public function SetTextBody($text, $charset = null)
	{
		$this->_BodyChanged = true;
		
		if (is_null($text))
		{
			$this->_TextBody = null;
		}
		else
		{
			if (is_null($charset)) 
			{
				$charset = $this->_Charset;
			}
			
			$this->_TextBody = array($text, $charset);
		}
	}
	
	public function SetHTMLBody($HTML, $charset = null)
	{
		$this->_BodyChanged = true;
		
		if (is_null($HTML))
		{
			$this->_HTMLBody = null;
		}
		else
		{
			if (is_null($charset)) 
			{
				$charset = $this->_Charset;
			}
			
			$this->_HTMLBody = array($HTML, $charset);
		}
	}
	
	public function AddTo($email, $name = '')
	{
		$this->_To[] = array($email, $name);
	}
	
	public function AddCC($email, $name = '')
	{
		$this->_CC[] = array($email, $name);
	}
	
	public function AddBCC($email)
	{
		$this->_BCC[] = array($email, '');
	}
	
	public function AddAttachment($content, $filename, $contentType)
	{
		$this->_BodyChanged = true;
		
		$this->_Attachments[] = array($content, $filename, $contentType);
	}
	
	public function AddImage($content, $htmlReference, $contentType)
	{
		$this->_BodyChanged = true;
		
		$this->_Images[] = array($content, $htmlReference, $contentType);
	}
	
	public function AddCustomHeader($name, $value)
	{
		if (in_array(strtolower($name), array('to', 'cc', 'bcc', 'from', 'subject', 'return-path', 'date'))) 
		{
			throw new EmailException('Cannot set standard header with AddHeader.');
		}
		
		$this->_CustomHeaders[] = array($name, $value);
	}
	
	public function ClearRecipients()
	{
		$this->_CC = $this->_BCC = $this->_To = array();
	}
	
	public function ClearAttachments()
	{
		$this->_BodyChanged = true;
		
		$this->_Attachments = array();
	}
	
	public function ClearImages()
	{
		$this->_BodyChanged = true;
		
		$this->_Images = array();
	}
	
	/**
	 * Used by SMTPConnection.
	 */
	public function GetDestinationEmails()
	{
		$emails = array();
		foreach ($this->_To as $to)
		{
			$emails[] = $to[0];
		}
		foreach ($this->_CC as $cc)
		{
			$emails[] = $cc[0];
		}
		foreach ($this->_BCC as $bcc)
		{
			$emails[] = $bcc[0];
		}
		$emails = array_unique($emails);
		
		return $emails;
	}
	
	/**
	 * Used by SMTPConnection.
	 */
	public function GetFromEmail()
	{
		if (is_array($this->_From))
		{
			return $this->_From[0];
		}
		return null;
	}
	
	/**
	 * Used by SMTPConnection
	 */
	public function GetContent()
	{
		if ($this->_BodyChanged)
		{
			/**
			 * Build the parts
			 */
			$HTMLPart = null;
			$imageParts = array();
			if (is_array($this->_HTMLBody))
			{
				if (count($this->_Images))
				{
					$htmlReplacements = $imageParts = array();
					foreach ($this->_Images as $image)
					{
						$mimePart = MimePart::CreateImage($image[0], $image[2]);
						$imageParts[] = $mimePart;
						$htmlReplacements[$image[1]] = $mimePart->GetId();
					}
					
					$html = preg_replace("/\\s+(src|background)\\s*=\\s*(([^\">\\s]+)|\"([^\"]+)\")/mie",
						'Email::ReplaceInline($htmlReplacements, \'\\0\', \'\\1\', \'\\3\\4\')', $this->_HTMLBody[0]);
				}
				else
				{
					$html = $this->_HTMLBody[0];
				}
				
				$HTMLPart = MimePart::CreateHTML(self::ProcessCharset($html, $this->_HTMLBody[1]), $this->_HTMLBody[1]);
			}
			
			$textPart = null;
			if (is_array($this->_TextBody))
			{
				$textPart = MimePart::CreateText(self::ProcessCharset($this->_TextBody[0], $this->_TextBody[1]), $this->_TextBody[1]);
			}
			
			$attachmentParts = array();
			foreach ($this->_Attachments as $attachment)
			{
				$attachmentParts[] = MimePart::CreateAttachment($attachment[0], $attachment[1], $attachment[2]);
			}
			
			/**
			 * Build multi parts
			 */
			if ($HTMLPart instanceof MimePart && count($imageParts))
			{
				$relatedPart = MimePart::CreateMultipartRelated();
				$relatedPart->AddPart($HTMLPart);
				$relatedPart->AddParts($imageParts);
				
				$HTMLPart = $relatedPart;
			}
			
			if ($HTMLPart instanceof MimePart && $textPart instanceof MimePart)
			{
				$contentPart = MimePart::CreateMultipartAlternative();
				$contentPart->AddPart($textPart);
				$contentPart->AddPart($HTMLPart);
			}
			elseif ($HTMLPart instanceof MimePart)
			{
				$contentPart = $HTMLPart;
			}
			elseif ($textPart instanceof MimePart)
			{
				$contentPart = $textPart;
			}
			
			if (!count($attachmentParts))
			{
				$rootPart = $contentPart;
			}
			else
			{
				$rootPart = MimePart::CreateMultipartMixed();
				if ($contentPart instanceof MimePart)
				{
					$rootPart->AddPart($contentPart);
				}
				$rootPart->AddParts($attachmentParts);
			}
			
			if (!($rootPart instanceof MimePart))
			{
				throw new EmailException('Invalid message');
			}
			else
			{
				$this->_Content = $rootPart->GetContent();
				$this->_BodyChanged = false;
			}
		}
		
		$additionalHeaders = $this->_CustomHeaders;
		$additionalHeaders[] = array('MIME-Version', '1.0');
		$additionalHeaders[] = array('From', self::FormatRecipientHeader(array($this->_From), $this->_Charset));
		$additionalHeaders[] = array('To', self::FormatRecipientHeader($this->_To, $this->_Charset));
		//$additionalHeaders[] = array('Date', date_default_timezone_set("UTC"));
		$additionalHeaders[] = array('Date', date('Y-m-d H:i:s'));
		if (count($this->_CC))
		{
			$additionalHeaders[] = array('Cc', self::FormatRecipientHeader($this->_CC, $this->_Charset));
		}
		if (isset($this->_ReturnPath))
		{
			$additionalHeaders[] = array('Return-Path', '<' . $this->_ReturnPath . '>');
		}
		if (isset($this->_Subject))
		{
			$additionalHeaders[] = array('Subject', self::EncodeHeaderString($this->_Subject, $this->_Charset));
		}
		
		$wholeMailHeaders = '';
		foreach ($additionalHeaders as $additionalHeader)
		{
			$wholeMailHeaders .= $additionalHeader[0] . ': ' . $additionalHeader[1] . MimePart::EOL;
		}
		
		return $wholeMailHeaders . $this->_Content;
	}
	
	public function Send($SMTPConnection = null)
	{
		if (is_null($SMTPConnection))
		{
			$SMTPConnection = ConfigurationManager::GetSMTPConnection();
		}
		
		if (!($SMTPConnection instanceof SMTPConnection))
		{
			die ('No SMTPConnection has been provided.');
		}
		
		$SMTPConnection->SendMail($this);
	}
	
	protected static function FormatRecipientHeader($recipients, $charset)
	{
		$out = array();
		foreach ($recipients as $recipient)
		{
			if (strlen($recipient[1]))
			{
				$recipient[1] = self::EncodeHeaderString($recipient[1], $charset);
			}
			
			$out[] = $recipient[1] . '<' . $recipient[0] . '>';
		}
		
		return implode(',', $out);
	}
	
	protected static function EncodeHeaderString($value, $charset)
	{
		$value = self::ProcessCharset($value, $charset);
		/*
		if (!MimePart::IsPrintable($value))
		{
			$value = MimePart::Encode($value, MimePart::QuotedPrintableEncoding);
			$value = str_replace('?', '=3F', $value);
			$value = '=?' . $charset . '?Q?' . $value . '?=';
		}
		*/
		return $value;
	}
	
	protected static function ProcessCharset($content, $charset)
	{
		if (strtolower($charset) != 'utf-8')
		{
			return mb_convert_encoding($content, $charset, 'utf-8');
		}
		
		return $content;
	}
	
	protected static function ReplaceInline($replacements, $expression, $tag, $filename)
	{
		if (isset($replacements[$filename]))
		{
			return ' ' . $tag . '="cid:' . $replacements[$filename] . '"';
		}
		else
		{
			return str_replace('\"', '"', $expression);
		}
	}
}
?>