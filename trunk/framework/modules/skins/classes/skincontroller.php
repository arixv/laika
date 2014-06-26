<?php
class SkinController extends Controller{

	public static function BackDisplayDefault()
	{

		echo 'defaul skin: ';
		Util::debug(Skin::getDefaultSkin());
		echo '<br/><br/>';
		echo 'skins: <br/>';
		Util::debug(Skin::getAllSkins());
		

	}

	public static function loadInterface($baseXsl=false)
	{
		$Site = Session::get('site');
		$Interface = false;

		//Validate Site Interface
		if(is_array($Site) && isset($Site["interface"])):
			$Interface["path"] = "/interface/".$Site["interface"];
		else:
			$Interface = Skin::getDefaultSkin();
		endif;

		$template = new Templates();

		$template->setconfig($template->client->GetDetails(), null, 'client');

		$template->setpath(PathManager::GetApplicationPath().$Interface['path']);
		$template->setconfig(PathManager::GetApplicationPath().$Interface['path'].'/'.$template->device.'/skinconfiguration.xml', '/skin', null);
		
		$configFile = ConfigurationManager::Query("/configuration/*[not(name()='database')][not(name()='rewrite')][not(name()='devices')][not(name()='errorReporting')][not(name()='modules')]");
		$data = array();
		foreach($configFile as $node){
			$data[$node->nodeName] = $node->nodeValue;
		}
		$template->setconfig($data, null, 'system');	


		if(!$baseXsl):
			$template->setBaseStylesheet(PathManager::GetApplicationPath().$Interface['path'].'/'.$template->device.'/xsl/core/layout.xsl');
			$template->add('core/header.xsl');
			$template->add('core/footer.xsl');
		else:
			$template->setBaseStylesheet(PathManager::GetApplicationPath().$Interface['path'].'/'.$template->device.'/xsl/'.$baseXsl);
		endif;
		$template->add('core/components.xsl');
		$template->add('core/templates.xsl');


		//PageUrl
		if(strpos($_SERVER["REQUEST_URI"],'?') ):
			$page_url = substr($_SERVER["REQUEST_URI"],0,strpos($_SERVER["REQUEST_URI"],'?'));
			$template->setparam("page_url",$page_url);
		else:
			$page_url =  $_SERVER["REQUEST_URI"];
			$template->setparam("page_url",$page_url);
		endif;
		
		$page_query_string = $_SERVER["QUERY_STRING"];
		$template->setparam("page_query_string",$page_query_string);

		
		if(is_array($Site)):
			
			$template->setconfig($Site,null,'site');

			 //Niveles
		 	 $key = 'niveles';
			 $folder = "categories";
			 $expires = 7200;
			 $site_preffix = $Site['preffix'];
			 $Niveles = Cache::getKey($key,$folder,$site_preffix);
			 if($Niveles == false):
			 	$Niveles = Category::getList($parent=44);
			 	Cache::setKey($key,$Niveles,$expires,$folder,$site_preffix);
			 endif;
			 $template->setcontext($Niveles,null,'niveles');		


			 //Modalidades
			 $key = 'modalidades';
			 $folder = "categories";
			 $expires = 7200;
			 $site_preffix = $Site['preffix'];
			 $Modalidades = Cache::getKey($key,$folder,$site_preffix);
			 if($Modalidades == false):
			 	$Modalidades = Category::getList($parent=41);
			 	Cache::setKey($key,$Modalidades,$expires,$folder,$site_preffix);
			 endif;
			 $template->setcontext($Modalidades,null,'modalidades');		


			//Menu
			$menu_parent=0;
			$key = 'menu.'.$menu_parent;
			$folder = "menu";
			$site_preffix = $Site['preffix'];
			$Menu = Cache::getKey($key,$folder,$site_preffix);
			$expires = 7200;
			if($Menu == false):
				$Menu = Menu::getList($menu_parent,$state=1);
				Cache::setKey($key,$Menu,$expires,$folder,$site_preffix);
			endif;
			$template->setcontext($Menu,null,'menus');


			//Locations
			$key = 'locations.'.$Site["locations"];
			$folder = "locations";
			$site_preffix = $Site['preffix'];
			$expires = 7200;
			$Locations = Cache::getKey($key,$folder,$site_preffix);
			if($Locations == false):
				$Locations = Location::getList($parent = $Site["locations"]);
				Cache::setKey($key,$Locations,$expires,$folder,$site_preffix);
			endif;
			$template->setcontext($Locations,null,'locations');

		endif;

		
		

		// Skinpath nuevo con la carpeta del dispositivo incluida
		$template->setparam('skinpath',$Interface['path'].'/'.$template->device);
		$template->setparam('fechaActual', date('Y-m-d'));

		$debug = ConfigurationManager::Query('/configuration/debug');
		if($debug->item(0)->nodeValue == '1'):
			$template->addStylesheet(PathManager::GetModuleAdminPath().'desktop/xsl/debug.xsl');
			$template->debug = 1;
		endif;

		return $template;
	}


	/* Front end */
	public static function FrontDisplayDefault(){
		exit();
	}
	
	public static function FrontDisplayNotFound()
	{
		$interface = SkinController::loadInterface();
		$interface->setparam("error", '404');
		$interface->add("core/error.xsl");
		header("Status: 404 Not Found");
		$interface->display();
	}
	
	public static function FrontDisplayError()
	{

		$interface = SkinController::loadInterface();
		$interface->setparam("error", '500-100');
		$interface->add("core/error.xsl");

		header('Status: 503 Service Temporarily Unavailable');
		$interface->display();
	}

	public static function DisplayInternalError($message, $backTrace, $fileName, $lineNumber, $htmlMode=true)
	{
		
		$xsl = ($htmlMode) ? 'error.xsl' : 'error.text.xsl';
		
		$thisTemplate = new Templates();	
		$path = PathManager::GetModulesPath().'/skins/desktop/xsl/'.$xsl;

		$thisTemplate->setErrorsheet($path);
		$thisTemplate->ShowingError = true;

		$backTrace['get_params']  = $_GET;
		$backTrace['post_params'] = $_POST;
		$backTrace['tag'] = 'resource';
		

		$request = $_SERVER["REQUEST_URI"];
		if(strpos($request,'?')){
			$request = substr($request,0,strpos($request,'?'));
		}
		$thisTemplate->setparam("page_url",$request);
		$thisTemplate->setparam('message', $message);

		//self::walk_recursive($backTrace);

		
		$thisTemplate->setcontent($backTrace, null, 'backtrace');
		$thisTemplate->setparam('referer', (isset($_SERVER['HTTP_REFERER'])) ? $_SERVER['HTTP_REFERER'] : '');

		$adminPath = substr(PathManager::GetFrameworkDir(),0,strlen(PathManager::GetFrameworkDir())).'/modules/admin';
		$thisTemplate->setparam('adminPath', $adminPath);
		$thisTemplate->setparam('modPath', substr(PathManager::GetFrameworkDir(),0,strlen(PathManager::GetFrameworkDir())).'/modules/skins');
		
		if($user = Admin::isLoguedIn()){
			$thisTemplate->setcontent($user, null, 'user');
		}

		$thisTemplate->setparam('sqlquery', DBManager::$queryStr);
		$thisTemplate->setparam("error", '500-100');

		$thisTemplate->AddStylesheet(PathManager::GetModuleAdminPath().'desktop/xsl/components.xsl');
		$thisTemplate->AddStylesheet(PathManager::GetModuleAdminPath().'desktop/xsl/debug.xsl');

		// Util::debug($thisTemplate);
		// die;
		$thisTemplate->display();

		return $thisTemplate->returnDisplay();
	}

	public static function FrontDisplayCatpchaImage()
	{
		$num = Util::getvalue('n', false);
		if($num && is_numeric($num)):
			$interface = Skin::getDefaultSkin();
			header('Location:'.$interface['path'].'/default/imgs/layout/captcha/'.Captcha::assign_rand_value($num).'.gif');
		endif;
	}
	
	public static function validateCaptcha()
	{
		$captcha = strtolower(Util::getvalue('captcha'));
		$captchavalue = Util::getvalue('captchavalue');
		
		$string = Captcha::valueFromNumbers($captchavalue);

		if($string == $captcha):
			echo "1";
		else:
			echo "0";
		endif;
	}

	private static function walk_recursive(&$input)
	{
		foreach ($input as $key => $value):
			if (is_array($input[$key])):
				self::walk_recursive($input[$key]);
			else:
				$saved_value = $value;
				$saved_key = $key;
				if($saved_key == 'xmlDoc' || $saved_key == 'xslDoc'):
					unset($input[$saved_key]);
				endif;
				if(!is_object($saved_value) && strpos($saved_value, '<?xml version') !== false):
					unset($input[$saved_key]);
				endif;
			endif;
		endforeach;
		return true;
	}

	public static function FrontSetSite()
	{
		$siteId = Util::getvalue('site');

		if($siteId):

			$ConfigSite = ConfigurationManager::Query("/configuration/sites/site[@id=".$siteId."]/*");

			if($ConfigSite):

				$Site = array(
					'id' => $siteId,
				);
				
				foreach($ConfigSite as $node){
					$Site[$node->nodeName] = $node->nodeValue;
				}

				Session::set('site',$Site);
				echo '1';
			else:
				echo '0';
			endif;
		else:
			echo '0';
		endif;

	}
}

?>