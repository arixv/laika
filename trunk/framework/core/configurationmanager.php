<?php
class ConfigurationManager
{
	protected static $_databaseConnection = array();
	protected static $_modules = array();
	protected static $_configuration = null;
	protected static $dom;

	protected static $_ApplicationID = null;
	protected static $_SMTPConnection = null;
	protected static $_ErrorReportingInitialized = false;
	protected static $_LoggingInitialized = false;
	protected static $_SessionInitialized = false;
	protected static $_EnvironmentConfig = false;
	protected static $_configurationEnabled = null;

	
	protected static function SetApplicationID($applicationID)
	{
		if (strtolower($applicationID) == 'framework')
		{
			die('The application ID can\'t be "framework"');
		}

		self::$_ApplicationID = $applicationID;
	}
	
	protected static function GetBaseDir()
	{
		if (HTTPContext::Enabled())
		{
			$baseDir = getcwd();
		}
		else
		{
			$baseDir = dirname(realpath($_SERVER['SCRIPT_FILENAME']));
		}
		
		return $baseDir;
	}
	
	public static function InitializeErrorReporting()
	{
		if (!self::$_ErrorReportingInitialized)
		{

			if (!self::ConfigurationEnabled())
			{

				Error::SetScreen(true, false);
			}
			else
			{

				$screen = self::Query('/configuration/errorReporting/screen');
				if ($screen && $screen->item(0)->getAttribute('enabled') == 'true')
				{
					Error::SetScreen(true);
				}
				else
				{
					Error::SetScreen(false);
				}
				
				$email = self::Query('/configuration/errorReporting/email');

				if ($email && $email->item(0)->getAttribute('enabled') == 'true')
				{
					Error::SetEMail(true);
				}else{
					Error::SetEMail(false);
				}

			}
			self::$_ErrorReportingInitialized = true;
		}
	}
	
	public static function ConfigurationEnabled()
	{
		if (!isset(self::$_configurationEnabled)){

			self::$_configurationEnabled = (self::GetConfigFile()) ? true : false;
		}
		return self::$_configurationEnabled;
	}
	
	public static function SetEnvironment($environment)
	{
		self::$_EnvironmentConfig = ($environment !== false) ? '/configuration/environments/'.$environment.'.xml' : false;
	}

	public static function GetConfigFile()
	{
		if(self::$_EnvironmentConfig){
			$file = PathManager::GetFrameworkPath().self::$_EnvironmentConfig;
			if(file_exists($file) && self::isValidXml($file)){
				return $file;
			}else{
				die('Configuration File not found!');
			}
		}else{
			die('No Enviroment defined. Set your enviroment in Application::Initialize().');
		}
		
	}
	
	public static function GetApplicationID()
	{
		$query = self::Query('/configuration/applicationID');
		return $query->item(0)->nodeValue;
	}
	
	
	public static function GetDatabaseConnection()
	{
		

		$request = $_SERVER["REQUEST_URI"];
		$pattern = '#^\/admin#';
		$matched = preg_match($pattern, $request);

		//Get Session Site
		if($matched)
		{
			$Site = Session::get("backend_site");
			$siteId = $Site["id"];

		}elseif(Session::get("site")){
			$Site = Session::get("site");
			$siteId = $Site["id"];
		}else{
			$siteId = 1;
		}


		$dbconf = self::Query('/configuration/database');


		if (!$dbconf)
		{
			die ('ConnectionString not properly configured. Check your configuration file.');
		}else{
			$dbconf = $dbconf->item(0);
		}
		

		$socket = self::Query('socket',$dbconf);
		if($socket){
			$_databaseConnection['dns'] = 'mysql:unix_socket='.$socket->item(0)->nodeValue .';';
			$_databaseConnection['dns'] .= 'port='.$socket->item(0)->getAttribute('port') .';';
		}
		$host = self::Query('host',$dbconf);
		if($host){
			$_databaseConnection['dns'] = 'mysql:host='.$host->item(0)->nodeValue .';';
			$_databaseConnection['dns'] .= 'port='.$host->item(0)->getAttribute('port') .';';
		}
		$_databaseConnection['dns'] .= 'dbname='.self::Query('dbname',$dbconf)->item(0)->nodeValue;
		$_databaseConnection['user'] = self::Query('user',$dbconf)->item(0)->nodeValue;
		$_databaseConnection['pass'] = self::Query('pass',$dbconf)->item(0)->nodeValue;

		return $_databaseConnection;
	}
	
	public static function GetEmails()
	{
		$destination = self::Query('/configuration/errorReporting/email');
		return $destination->item(0)->getAttribute('destination');
	}
	
	public static function GetSender()
	{
		$sender = self::Query('/configuration/errorReporting/email');
		return $sender->item(0)->getAttribute('sender');
	}
	
	public static function GetSenderName()
	{
		$sender = self::Query('/configuration/errorReporting/email');
		return $sender->item(0)->getAttribute('sendername');
	}
	
	
/*	public static function GetLogin()
	{
		$configuration = self::GetConfiguration();
		return $configuration->login;
	}
	
	public static function GetLoginAdmin()
	{
		$configuration = self::GetConfiguration();
		return $configuration->loginAdmin;
	}*/
	
	
	
	public static function GetSMTPConnection()
	{
		if (!isset(self::$_SMTPConnection))
		{			
			$SMTPNode = self::Query('/configuration/smtp');
			if ($SMTPNode){
				self::$_SMTPConnection = new SMTPConnection($SMTPNode->item(0)->nodeValue);
			}
		}
		return self::$_SMTPConnection;
	}
	

	public static function GetModuleConfiguration($moduleName)
	{	
		$module = self::Query("/configuration/modules/module[@name='".$moduleName."']");
		return $module->item(0);
	}
	

	public static function GetModuleConfigurationByType($typeId)
	{	
		$module = self::Query("/configuration/modules/module[@type_id='".$typeId."']");
		return $module->item(0);
	}

	public static function GetSkinConfiguration(){
		$configuration = self::GetConfiguration();
		$skins = $configuration->skins;
		foreach($skins->skin as $skin){
			if($skin['active']==1){
				return $skin;
			}
		}
		return false;
	}

	public static function GetLoginPage()
	{
		$configuration = self::GetConfiguration();
		
		if (count($configuration->LoginPage) == 1)
		{
			return (string) $configuration->LoginPage;
		}
		else
		{
			die('The login page location has not been defined.');
		}
	}
	
		
	public static function isValidXml($filePath, $isFile=true)
	{
		if($isFile):
			$xml = file_get_contents($filePath);
		else:
			$xml = $filePath;
		endif;
		//$xml = file_get_contents($filePath);
		libxml_use_internal_errors(true);
		$doc = new DOMDocument('1.0', 'UTF-8');
		$doc->loadXML(utf8_encode($xml));

		$errors = libxml_get_errors();
		
		if (empty($errors)){
			return true;
		}else{
			$error = $errors[0];
			if($error->code == 4):
				return false;
			else:
				$lines = explode("\n", $xml);
				$line = $lines[($error->line)-1];
				$message = "<h1>XML Configuration not well formed</h1>";
				$message .= "<b>Archivo:</b> ".$filePath."<br/>";
				$message .= "<b>Error:</b> ".$error->message.'<br />';
				$message .= "<b>Linea ".$error->line.": </b>".htmlentities($line)."<br/>";
				//$message .= "<b>Columna ".$error->column.": </b>".substr($line, strpos($line, $error->column), strlen($line));
				echo $message."<br/>";
				die();
			endif;
		}
	}
	

	
	/* New configuration */

	public static function LoadConfiguration()
	{

		if(self::ConfigurationEnabled())
		{
			$file = self::GetConfigFile();
			$domDoc = new DOMDocument("1.0", "UTF-8");
			$domDoc->load($file);
			$domDoc->formatOutput = true;
			$modules = $domDoc->createElement('modules'); // This is where we'll insert each modules config.
			$domDoc->documentElement->appendChild($modules);
			self::$dom = $domDoc;
		}
		else{
			die('Configuration Not Enabled!');
		}
	}
	
	public static function AddModule($configFile)
	{	
		if(self::isValidXml($configFile)){
			$module = new DOMDocument("1.0", "UTF-8");
			$module->load($configFile);

			$dom_sxe = self::$dom->importNode($module->documentElement, true);
			$modules = self::$dom->getElementsByTagName('modules')->item(0);
			$modules->appendChild($dom_sxe);
		}
	}

	public static function LoadBackendRules()
	{	
		$str  = self::Query('/configuration/backendrules');
		$file = PathManager::GetFrameworkPath().'/'.$str->item(0)->nodeValue;
		
		if(self::isValidXml($file)){
			$module = new DOMDocument("1.0", "UTF-8");
			$module->load($file);

			$dom_sxe = self::$dom->importNode($module->documentElement, true);
			$modules = self::$dom->getElementsByTagName('configuration')->item(0);
			$modules->appendChild($dom_sxe);
		}
	}
	
	public static function Query($node, $xml=false)
	{
		if($xml){
			$source = new DOMDocument("1.0", "UTF-8");
			$dom_sxe = $source->importNode($xml, true);
			$source->appendChild($dom_sxe);			
		}else{
			$source = self::$dom;
		}
		$conf   = new DOMXPath($source);
		$result = $conf->query($node);

		if($result->length == 0){
			return false;
		}else{
			return $result;
		}
	}

	public static function GetConfiguration()
	{
		//util::debug(debug_backtrace());
		echo self::$dom->saveXML();
	}
	
	
	
	
	
}
?>