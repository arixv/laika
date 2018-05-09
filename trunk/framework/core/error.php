<?php
class Error {
	protected static $_Email = false;
	protected static $_Screen = false;
	
	public static function SetEmail($email)
	{
		self::$_Email = $email;
	}
	
	public static function SetScreen($enabled)
	{
		self::$_Screen = $enabled;
	}
	
	protected static function Report($errorMessage, $backTrace, $file, $line)
	{

		ConfigurationManager::InitializeErrorReporting();
		$htmlError = self::BuildBackTrace($errorMessage, $backTrace, $file, $line, true);
		$textError = self::BuildBackTrace($errorMessage, $backTrace, $file, $line, false);


		if (self::$_Screen)
		{
			header('Status: 503 Service Temporarily Unavailable');
			if (HTTPContext::Enabled())
			{
				echo $htmlError;
				die;
			}
			else
			{
				echo $textError;
				die;
			}
			
			$userReported = true;
		}else{
			$userReported = false;
		}

		if (self::$_Email)
		{
			//Mando el mail con el error
			try
			{
				$mails = ConfigurationManager::GetEmails();
				$emailList = preg_split("/[;,]+/", $mails);

				$email = new Email();
				$email->SetFrom(ConfigurationManager::GetSender(), ConfigurationManager::GetSenderName());
				$email->SetSubject('Error - ' . ConfigurationManager::GetApplicationID());
				foreach ($emailList as $destination)
				{
					$email->AddTo($destination);
				}
				$email->SetHTMLBody($textError);
				//$email->AddAttachment(var_export($_POST, true), 'post.txt', 'text/plain');
				//$email->AddAttachment(var_export($_GET, true), 'get.txt', 'text/plain');
				$email->Send();

			}
			catch (EmailException $exception) {}
		}
	
		
		if (!$userReported)
		{
			
			/**
			 * Si no se muestra en pantalla muestro la pagina 404
			 */
			//echo 'Uh Oh! Se produjo un error. Ya creamos un ticket del error para solucionarlo.';
			SkinController::FrontDisplayError();
		}
		exit();
	}

	public static function Alert($message)
	{
		ConfigurationManager::InitializeErrorReporting();
		
		if (self::$_Screen)
		{
			throw new Exception($message);
		}
	}

	protected static function BuildBackTrace($message, array $backTrace, $fileName, $lineNumber, $htmlMode)
	{
		
		return SkinController::DisplayInternalError($message, $backTrace, $fileName, $lineNumber, $htmlMode);
		
			
		//$return .= $eol;
		
		/*foreach ($backTrace as $number => $trace)
		{
			$return .= sprintf('#   %1$s %2$s %3$s %4$s%5$s%6$s',
				$number,
				isset($trace['file']) ? $trace['file'] : '',
				isset($trace['line']) ? ' -> <b>line '.$trace['line'].'</b>' : '',
				isset($trace['class']) ? '<b>Class:'.$trace['class'].'</b>' : '',
				isset($trace['type']) ? '-> <b>Type'.$trace['type'].'</b>' : '',
				isset($trace['function']) ? '-> <b>Function '.$trace['function'].'</b>' : '') . $eol;
		}
			
		$return .= $eol;
			
		if ($htmlMode)
		{
			if ($fileName && $lineNumber)
			{
				$return .= '<b>The error started here: '.$backTrace[count($backTrace)-1]['file'].'</b>';
				$return .= '<div style="padding:0 5px;margin:5px 0; font-size: 12px; background-color: #f0f0f0; border: 1px solid #ccc"><pre style="margin:0">';
				$lines = file($fileName);
				for ($i = max(0, $lineNumber - 10); $i < min($lineNumber + 10, count($lines)); $i++)
				{
					if ($i == $lineNumber - 1)
					{
						$return .= '<div style="color: white; background-color: #bb2222">';
					}
					
					$return .= Util::htmlescape(sprintf("%1\$s\t%2\$s", $i + 1, rtrim($lines[$i])) . PHP_EOL);
					
					if ($i == $lineNumber - 1)
					{
						$return .= '</div>';
					}
				}
				$return .= '</pre></div>';
			}

			$return .= '</div>';
		}
		return $return;
		*/
		
		
	}
	
	protected static function FindLastUserTrace($backTrace)
	{
		for (	$i = 0; 
				$i < count($backTrace) && 
					(!isset($backTrace[$i]['file']) ||
					strstr($backTrace[$i]['file'], PathManager::GetFrameworkPath()) !== false);
				$i++);
		
		if ($i < count($backTrace))
		{
			return $backTrace[$i];
		}
		
		return null;
	}

	public static function ErrorHandler($errorNumber, $errorMessage, $fileName, $lineNumber, $variables)
	{

		if ($errorNumber & error_reporting())
		{

			$backTrace = debug_backtrace();
			//Util::debug($backTrace);

			
			unset($backTrace[0]['function']);
			unset($backTrace[0]['class']);
			unset($backTrace[0]['type']);
			
			$lastUserTrace = self::FindLastUserTrace($backTrace);

			if ($lastUserTrace)
			{
				$file = $lastUserTrace['file'];
				$line = $lastUserTrace['line'];
			}
			else
			{
				$file = null;
				$line = null;
			}
			self::Report($errorMessage, $backTrace, $file, $line);
		}
	}
	
	public static function ExceptionHandler($exception)
	{

		$backTrace = $exception->GetTrace();
		
		$lastUserTrace = self::FindLastUserTrace($exception->GetTrace());
		if ($lastUserTrace)
		{
			$file = $lastUserTrace['file'];
			$line = $lastUserTrace['line'];
		}
		else
		{
			$file = null;
			$line = null;
		}
		
		self::Report(get_class($exception) . '. '. $exception->GetMessage(), $backTrace, $file,	$line);
	}

}
?>