<?php
abstract class Controller{

	static $template;
	static $module;

	//public static function defaultView();
	//public static function displayDefault();
	
	
	public static function loadAdminInterface($baseXsl=false)
	{
		self::$template = new Templates();
		$accessLevel = false;
		$user = false;
		$validAccess = false;
		
		
		/* 
			Cargamos la configuracion del modulo que estamos manejando
		*/
		$x = debug_backtrace();
		$module = ConfigurationManager::GetModuleConfiguration(basename(dirname(dirname($x[0]['file']))));


		if($user = Admin::IsLoguedIn()):
			self::$template->setconfig($user, null, 'user');
		endif;

		$access_value = ConfigurationManager::Query("/module/options/group[@name='settings']/option[@name='access_level']", $module);
		if($access_value):
			$access_level = $access_value->item(0)->getAttribute('value');
		else:
			$access_level = 'all';
		endif;

		// Validates user access to Module
		if(!Application::isLogin()):
			$validAccess = Admin::validateAccesLevel($user['access-att'], $access_level);
			// TODO: we have to improve this 
			if(!$validAccess):
				echo "You dont have access to this area";
				die();
			endif;
		endif;

		if($Site = Session::get("backend_site")):
			self::$template->setconfig($Site,null,"site");
		endif;

		// Ruta del xml de configuracion del modulo, para cargarlo
		$configFile = PathManager::GetModulePath().'/module.configuration.xml';

		// Insertamos la configuracion del modulo en las paginas
		self::$template->setconfig($configFile, $xpath='', null);

		// Seteamos el path del modulo para la carga de los xsl
		self::$template->setpath(PathManager::GetFrameworkPath().$module->getAttribute('path'));

		// Parametro para que el xsl tenga la ruta de la carpeta del modulo
		//self::$template->setparam('modPath', PathManager::GetFrameworkDir().$module['path']);
		self::$template->setparam('modPath', substr(PathManager::GetFrameworkDir(),0,strlen(PathManager::GetFrameworkDir())).$module->getAttribute('path'));
		self::$template->setparam('modName', $module->getAttribute('name'));
		self::$template->setparam('modToken',Application::generateToken());
		self::$template->setcontext('<lang>es</lang>', null, null);

		$configFile = ConfigurationManager::Query("/configuration/*[not(name()='database')][not(name()='rewrite')][not(name()='devices')][not(name()='errorReporting')][not(name()='modules')]");
		$data = array();
		foreach($configFile as $node){
			$data[$node->nodeName] = $node->nodeValue;
		}
		self::$template->setconfig($data, null, 'system');

		self::$template->debug = $data['debug'];

		//PageUrl
		$request = $_SERVER["REQUEST_URI"];

		if(strpos($request,'?')){
			$splitted_request = explode("?",$request);
			$request = $splitted_request[0];
			$params = $splitted_request[1];
			$patterns = 
				array(
					'/&page=[0-9]/i',
					'/page=[0-9]&/i',
					'/page=[0-9]*/'
					);
			// util::debug($params);
			$params = preg_replace($patterns,'',$params);
			// echo "results";
			// util::debug($params);
			// die;
			self::$template->setparam("page_url",$request);
			self::$template->setparam("page_params",$params);
		}else {
			self::$template->setparam("page_url",$request);
			self::$template->setparam("page_params",'');
		}

		

		// Cargamos la ruta del modulo y su configuracion
		$module = ConfigurationManager::GetModuleConfiguration('admin');

		// Incluimos la configuracion del admin
		$path = PathManager::GetModuleAdminPath();
		$configFile = $path.'module.configuration.xml';
		self::$template->setconfig($configFile, $xpath='/module/*', 'admin');

		$adminPath = substr(PathManager::GetFrameworkDir(),0,strlen(PathManager::GetFrameworkDir())).$module->getAttribute('path');
		self::$template->setparam('adminPath', $adminPath);

		$dispositivo = self::$template->getDevice();

		// Si no recibimos un xsl base, cargamos la interfaz estandart
		if(!$baseXsl):
			// Seteamos el xsl base
			self::$template->setBaseStylesheet($path.$dispositivo.'/xsl/layout.xsl');

			// Incluimos los componentes necesarios
			self::$template->addStylesheet($path.$dispositivo.'/xsl/header.xsl');
		else:
			self::$template->setBaseStylesheet(self::$template->getpath().'/'.$dispositivo.'/xsl/'.$baseXsl);
		endif;
		self::$template->addStylesheet($path.$dispositivo.'/xsl/components.xsl');
		self::$template->addStylesheet($path.$dispositivo.'/xsl/debug.xsl');
	}

}

?>