<?php
class Application {

	private static $_Paths = array();
	private static $_ApplicationPath;
	private static $_TemporaryPath = null;
	private static $_ApplicationID = null;
	private static $_frontend = false;

	public static function Initialize($environment=false)
	{
		// Load System Configuration
		ConfigurationManager::setEnvironment($environment);
		ConfigurationManager::LoadConfiguration();

		$frameworkPath = PathManager::GetFrameworkPath();

		PathManager::AddClassPath($frameworkPath . DIRECTORY_SEPARATOR . 'core');
		PathManager::AddClassPath($frameworkPath . DIRECTORY_SEPARATOR . 'libs');

		$dir  = PathManager::GetModulesPath();
		$handle = opendir($dir);
		while (false !== ($item = readdir($handle))):if($item != '.' && $item != '..'):$path = $dir.'/'.$item;if(is_dir($path)):
			$configFile = $path . '/module.configuration.xml';
			
			if(file_exists($configFile)){
				ConfigurationManager::AddModule($configFile);
			}
		endif;endif;endwhile;
		closedir($handle);

		

		$modules = ConfigurationManager::Query('/configuration/modules/*');
		$activeTypeIds = array();

		foreach($modules as $module){
			if($module->getAttribute('active') == 1){

				if(
					$module->getAttribute('type_id')
					&& 
					in_array($module->getAttribute('type_id'),$activeTypeIds)
				){
					die('El type_id '.$module->getAttribute('type_id').' ya existe en el sistema');
				}
				array_push($activeTypeIds, $module->getAttribute('type_id'));

				PathManager::AddClassPath($frameworkPath . DIRECTORY_SEPARATOR . $module->getAttribute('path').'/classes');
			}
		}
		PathManager::Apply();
	}




	public static function BackEndHandler($options)
	{
		//Check if the user is logued in
		self::ValidateAdminUser();

		//Check if the call is made whitin the backend
		if(!Util::isAdmin()){die('You are not in the backend.');}

		ConfigurationManager::LoadBackendRules();

		Rewrite::parseAdminURL();

		$modDir = PathManager::GetFrameworkPath () . '/modules/' . $options['module'];
		if(is_dir($modDir))
		{
			if ($options['action'])
			{
				$delimiter = strpos ( $options['action'], '|' );
				if ($delimiter === false)
				{
					$method = ($options['action'] != '') ? $options['action'] : false;
				}
				else
				{
					$params = explode('|', $options['action']);
					$method = $params [0];
					array_shift($params);
					foreach($params as $param) :
						$_POST [substr($param, 0, strpos($param, '=' ))] = substr($param, strpos($param, '=') + 1, strlen($param));
					endforeach;
				}
			}
			else
			{
				$method = $options['action'];
			}

			//Check if the user has authorization to access the request area
			self::ValidateMethodAccess($options['module'], $method);

			$conf = ConfigurationManager::query('/configuration/modules/module[@name="'.$options['module'].'"]');
			$controller = $conf->item(0)->getAttribute('controller');

			if (is_callable ( array (( string ) $controller, $method ) ) && $method)
			{
				call_user_func ( array (( string ) $controller, $method ) );
			}
			exit ();
		}

	}

	public static function ValidateAdminUser()
	{
		$request = $_SERVER["REQUEST_URI"];
		if(strpos($request,'?')){
			$request = substr($request,0,strpos($request,'?'));
		}

		$conf = ConfigurationManager::Query('/configuration/adminpath');
		$isLogin = strpos($request, $conf->item(0)->nodeValue.'login');
		if($isLogin===false):
			if(!$user = Admin::IsLoguedIn()):
				if(isset($_SERVER["QUERY_STRING"])):
					$request .= '?'.$_SERVER["QUERY_STRING"];
				endif;

				Util::redirect($conf->item(0)->nodeValue.'login/ref'.$request);
				die();
			endif;
		else:
			return true;
		endif;
	}

	public static function ValidateMethodAccess($module, $method)
	{
		if(!Application::isLogin()):
			$rule = ConfigurationManager::Query("/configuration/modules/module[@name='".$module."']/rewrite/backend/rule[@apply='".$method."']");
			if($rule):
				$user = Admin::IsLoguedIn();
				$user_access = $user['role']['user_level_name'];
				$rule_access = $rule->item(0)->getAttribute('access_level');
				if($rule_access != ''):
					if(strpos($rule_access, $user_access) === false):
						echo "Hey! You dont have access to this area";
						die();
					endif;
				endif;
			endif;
		endif;
	}

	public static function isLogin()
	{
		$request = $_SERVER["REQUEST_URI"];
		if(strpos($request,'?')){
			$request = substr($request,0,strpos($request,'?'));
		}

		$conf = ConfigurationManager::Query('/configuration/adminpath');
		$isLogin = strpos($request, $conf->item(0)->nodeValue.'login');
		if($isLogin===false):
			return false;
		endif;
		return true;
	}

	public static function Route($options)
	{
		$defaults = array(
			'back'       => 1,
			'module'     => ConfigurationManager::Query('/configuration/defaultModule')->item(0)->nodeValue,
			'item_id'    => false,
			'url'        => false,
			'edit_url'   => 'edit',
			'list_url'   => 'list',
		);

		$options = util::extend(
			$defaults,
			$options
		);

		$pagination = array();
		$moduleVar = Session::Get($options['module']);

		if(isset($moduleVar['currentPage']) && $moduleVar['currentPage'] != '')
			array_push(
				$pagination, 
				'page='.$moduleVar['currentPage']
			);
		if(isset($moduleVar['categories']) && $moduleVar['categories'] != '')
			array_push(
				$pagination, 
				'categories='.$moduleVar['categories']
			);
		if(isset($moduleVar['state']) && $moduleVar['state'] != '')
			array_push(
				$pagination, 
				'state='.$moduleVar['state']
			);

		$queryStr = '';
		if(!empty($pagination)){
			$queryStr = '?';
			$queryStr .= implode('&', $pagination);
		}

		$config = ConfigurationManager::Query('/configuration/adminpath');
		if($options['url'] !== false){
			Util::redirect($options['url']);
		}
		if($options['back'] == 1)
		{
			Util::redirect($config->item(0)->nodeValue.$options['module'].'/'.$options['list_url'].'/'.$queryStr);
		}
		else
		{
			Util::redirect($config->item(0)->nodeValue.$options['module'].'/'.$options['edit_url'].'/'.$options['item_id']);	
		}
	}

	public static function generateToken(){
		$salt 		= date('ymdhis') . $_SERVER['REMOTE_ADDR'];
		$modToken 	= md5(mt_rand(1,1000000) . $salt);
        session::set('modToken',$modToken);
        return $modToken;
	}

	public static function validateToken(){
		$modToken 	= Session::get("modToken");
		$postToken 	= Util::getpost('modToken');
		Session::delete('modToken');

		if($modToken !== $postToken){
			//die('Token Error Ocurred');
		}
	}


	public static function setFrontend()
	{
		self::$_frontend = true;
	}

	public static function isFrontend()
	{
		return self::$_frontend;
	}

	/*
	@deprecated
	// Las urls se manejan con rewrite

	public static function FrontendHandler($options)
	{
		$modDir = PathManager::GetFrameworkPath () . '/modules/' . $options['module'];
		if(is_dir($modDir)):
			
			$conf = ConfigurationManager::query('/configuration/modules/module[@name="'.$options['module'].'"]');
			$controller = $conf->item(0)->getAttribute('controller');
			$method = $options['action'];

			if (is_callable(array((string)$controller,$method))){
				call_user_func(array((string) $controller, $method));
			}
			exit ();
		endif;
	}
	*/


}
?>