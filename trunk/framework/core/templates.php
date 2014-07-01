<?php

class Templates {
	
	private $templates=array();
	private $values=array();
	private $params=array();
	private $context=array();
	private $configuration=array();
	public  $device;
	public  $client;
	private $xmlDoc;
	private $xsl;
	private $templateXsl;
	private $dirname;
	public $debug = 0;
	public $ShowingError = false;

	function __construct()
	{
		$this->xmlDoc = new XMLDoc();
		// Detect devide to load proper xsl
		$this->client = new Device();
		$this->device = $this->client->GetFolderName();
	}

	function __destruct(){}

	// Seteamos el dispositivo para la carga de xsl
	public function setDevice($name)
	{
		$this->device = $name;
	}
	
	// Retornamos el dispositivo
	public function getDevice()
	{
		return $this->device;
	}

	public function setparam($name,$value)
	{
		$this->params[$name]=$value;
	}


	function setconfig($path, $nodeSource=false, $destinyNode=false)
	{
		if(is_array($path)): 
			$this->configuration[$destinyNode] = $path; 
		else:
			$isXml = $this->ValidateXML($path);
			if($isXml):
				$string = $path;
			else:
				$string = $this->fileToString($path);
			endif;
			$this->xmlDoc->addXml('config', $string, $nodeSource, $destinyNode);
		endif;
	}
	
	public function setcontent($path, $nodeSource=false, $destinyNode=false)
	{
		if(is_array($path)): 
			$this->values[$destinyNode]=$path;
		elseif(!$path):
			$this->values[$destinyNode]='';
		else:
			$isXml = $this->ValidateXML($path);
			if($isXml):
				$string = $path;
			else:
				$string = $this->fileToString($path);
			endif;
			$this->xmlDoc->addXml('content', $string, $nodeSource, $destinyNode);
		endif;
    }

	function setcontext($path, $nodeSource=false, $destinyNode=false)
	{
		if(is_array($path)): 
			$this->context[$destinyNode] = $path; 
		elseif(!$path):
			$this->values[$destinyNode]='';
		else:
			$isXml = $this->ValidateXML($path);
			if($isXml):
				$string = $path;
			else:
				$string = $this->fileToString($path);
			endif;
			$this->xmlDoc->addXml('context', $string, $nodeSource, $destinyNode);
		endif;
	}


	private function fileToString($file)
	{
		$data = @file_get_contents($file);
		//if ($data === false): Error::Alert('Could not load file "'.$file.'"'); endif;
		$check = $this->ValidateXML($data, $file);
		return $data;
	}

	function setpath($path)
	{
		$this->dirname=$path;
	}
	
	function getpath()
	{
		return $this->dirname;
	}
	
	public function display($debug=false)
	{
		$this->setparam("debug", $this->debug);

		// Cargar la navegacion del backend solo en el admin
		if(Util::isAdmin()):
			$this->loadActivesModulesNavigation();
		endif;
		$this->xmlDoc->generateXML($this->configuration, $this->values, $this->context);

		self::importStylesheets();
		if($debug):
			Util::debug($this);
		else:
			echo $this->xmlDoc->XMLTransform($this->xmlDoc->saveXML(),$this->xsl->saveXML(),$this->params);
		endif;
		exit();
	}

	public function displayXML()
	{
		if(Util::isAdmin()):
			$this->loadActivesModulesNavigation();
		endif;
		$this->xmlDoc->generateXML($this->configuration, $this->values, $this->context);
		header("content-type:text/xml");
		echo $this->xmlDoc->saveXML();
		exit();
	}


	public function displayJSON()
	{
		if(Util::isAdmin()):
			$this->loadActivesModulesNavigation();
		endif;
		$config = json_encode($this->configuration);
		$content = json_encode($this->values);
		$context = json_encode($this->context);
		header('Content-type: application/json');
		echo $content;
		exit();
	}

	public function displayXSL()
	{
		header("content-type:text/xml");
		self::importStylesheets();
		echo $this->xsl->saveXML();
		exit();
	}
	
	public function returnDisplay()
	{
		//Get the content in xml
		$this->xmlDoc->generateXML($this->configuration, $this->values, $this->context);
		self::importStylesheets();
		return $this->xmlDoc->XMLTransform($this->xmlDoc->saveXML(),$this->xsl->saveXML(),$this->params);
		//exit();
	}

	public function loadActivesModulesNavigation()
	{
		$modules = ConfigurationManager::Query('/configuration/modules/module');

		$this->configuration['navigation'] = array();
		$user = Admin::IsLoguedin();

		$userAccessLevel = $user['access-att'];
		$userHasAccess = false;
		
		foreach($modules as $mod){
			
			$moduleAccessLevel = false;
			$option = ConfigurationManager::Query("/module/options/option[@name='access_level']", $mod);

			if($option):	
				$moduleAccessLevel =  $option->item(0)->getAttribute('value');
				$userHasAccess = Admin::validateAccesLevel($userAccessLevel,$moduleAccessLevel);
			else:
				$userHasAccess = true;
			endif;
				
			if($userHasAccess && $mod->getAttribute('active') == 1):
				$navigation = ConfigurationManager::Query("/module/options/group[@name='navigation']/option[@name='item']",$mod);
				$group      = ConfigurationManager::Query("/module/options/group[@name='navigation']",$mod);
				$access     = ConfigurationManager::Query("/module/options/group[@name='settings']/option[@name='access_level']",$mod);
				$item_access = ($access) ? $access->item(0)->getAttribute('value') : false; 
				if($group):
					$arr = array(
						'name-att' => (string)$mod->getAttribute('name'),
						'display-att' => (string)$group->item(0)->getAttribute('display'),
						'group-att' => (string)$group->item(0)->getAttribute('group'),
						'order-att' => (string)$group->item(0)->getAttribute('order'),
					);
					if($item_access):
						$arr['access_level-att'] = $item_access;
					endif;
					if($navigation):
						foreach($navigation as $nav):
							//$name = $nav->getAttribute('name');
							$sub = array(
								'name-att' => (string)$nav->getAttribute('display'),
								'url-att'  => (string)$nav->getAttribute('url'),
								'access_level-att'  => (string)$nav->getAttribute('access_level')
							);
							array_push($arr, $sub);
						endforeach;
						$arr['tag']='subitem';
					endif;
					array_push($this->configuration['navigation'], $arr);
				endif;		
			endif;
		}
		
		$this->configuration['navigation']['tag']='item';
	}

	public static function navigationItem($navigation, $mod)
	{
		$arr = array();
		$sub = array();
		//$display = ConfigurationManager::query('display', $navigation);
		//$arr['display-att']  = utf8_decode($display->item(0)->nodeValue);
		//$arr['group-att']    = (string)$navigation->getAttribute('group');
		//$arr['order-att']    = (string)$navigation->getAttribute('order');
		$arr['name-att']     = (string)$mod->getAttribute('name');
		$subitems = $navigation->getElementsByTagName('subitem');
		foreach($subitems as $subnav):
			$sub['name-att'] = (string)utf8_decode($subnav->getAttribute('name'));
			$sub['url-att']  = (string)$subnav->getAttribute('url');
			array_push($arr, $sub);
		endforeach;
		$arr['tag']='subitem';
		return $arr;
	}

	/**
	* @Add Method
	* Add a stylesheet from the current running module directory
	* @param file: name of the file to load
	**/
	public function add($templatename)
	{
		array_push($this->templates,$this->dirname.'/'.$this->device.'/xsl/'.$templatename);
	}

	/**
	* @AddStylesheet Method
	* Add a stylesheet from any directory
	* @param file: full path to the file to add
	**/
	public function addStylesheet($file)
	{
		array_push($this->templates,$file);
	}

	public function setBaseStylesheet($file)
	{
		if(!file_exists($file)){
			Error::Alert("Base XSL path not valid. <br/> $file");
		}
		$check = $this->ValidateXSL($file);
		$this->xsl = new DOMDocument('1.0', "UTF-8");
		$this->xsl->load($file);
	}

	public function importStylesheets()
	{

		foreach($this->templates as $template):

			if(!$this->ShowingError){
				$check = $this->ValidateXSL($template);
			}
			
			$localStylesheet = new DOMDocument('1.0', "UTF-8");
			$localStylesheet->formatOutput = true;
			$localStylesheet->load($template);
			$root = new DOMXPath($this->xsl);
			$output = $root->query('xsl:output')->item(0);
			$xp = new DOMXPath($localStylesheet);

			$nodes = $xp->query('xsl:template');
			$params = $xp->query('xsl:param');
			$variables = $xp->query('xsl:variable');
			// Include xsl:param nodes from all xsl stylesheets 

			foreach($params as $tag) {
				$dom_sxe = $this->xsl->importNode($tag, true);
				$output->parentNode->insertBefore($dom_sxe, $output->nextSibling);
			}
			// Include xsl:variables nodes from all xsl stylesheets
			foreach($variables as $tag) {
				$dom_sxe = $this->xsl->importNode($tag, true);
				$output->parentNode->insertBefore($dom_sxe, $output->nextSibling);
			}
			// Include xsl:template nodes from all xsl stylesheets
			foreach($nodes as $tag) {
				$dom_sxe = $this->xsl->importNode($tag, true);
				$this->xsl->documentElement->appendChild($dom_sxe);
			}
		endforeach;
		$this->templates=array();
		//flush();
	}




	/*
		File param is used to show the path when this method is
		called from LoadString.
	*/
	public static function ValidateXML($xml, $file=false)
	{
		//echo 'xml: '.$xml . '<BR>';

		if(file_exists($xml)):
			return false;
		else:
			$extension = explode('.', $xml);
			$fileType  = strtolower($extension[count($extension)-1]);

			if($fileType == 'xml' && !file_exists($xml)){
				Error::Alert("XML path not valid. <br/> $xml");
			}
			libxml_use_internal_errors(true);
			$doc = new DOMDocument('1.0', "UTF-8");

			//echo "<BR>XML: " . $xml . " --END XML <BR>";

			$doc->loadXML($xml);
			$errors = libxml_get_errors();

			if (empty($errors)){
				return true;
			}else{
				$error = $errors[0];
				$lines = explode("r", $xml);
				if($error->line > 0){
					$line  = $lines[($error->line)-1];	
				}else{
					$line  = $lines[0];
				}
				
				$message = "Error parsing xml file. <br/>";
				$message .= $error->message.' at line '.$error->line.':<br />'.htmlentities($line).'<br/>';
				$message .= "File: $file";
				Error::Alert($message);
			}
		endif;
	}
	
	
	public static function ValidateXSL($xsl)
	{
		if(!file_exists($xsl)){
			Error::Alert("XSL path not valid. <br/> $xsl");
		}
		
		//echo $xsl;


		libxml_use_internal_errors(true);
		$doc = new DOMDocument('1.0', "UTF-8");
		$doc->load($xsl);
		$errors = libxml_get_errors();


		if (empty($errors)){
			return true;
		}else{
			$error = $errors[0];
			$message = "Error parsing xsl file. <br/>";
			$message .= $error->message.' at line '.$error->line.':<br />';
			$message .= "File: $xsl";
			Error::Alert($message);
		}
	}

	public function setErrorsheet($file)
	{
		if(!file_exists($file)){
			echo "Base XSL path not valid. <br/> $file";
		}
		//$check = $this->ValidateXSL($file);
		$this->xsl = new DOMDocument('1.0', "UTF-8");
		$this->xsl->load($file);
	}

}
