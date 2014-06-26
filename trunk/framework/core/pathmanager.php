<?php
final class PathManager
{
	private static $_Paths = array();
	private static $_ApplicationPath;
	private static $_TemporaryPath = null;
	

	public static function GetFrameworkPath()
	{
		return dirname(dirname(__FILE__));
	}
	
	public static function AddClassPath($path)
	{
		array_unshift(self::$_Paths, $path);
	}

	public static function Apply()
	{
		set_include_path(implode(PATH_SEPARATOR, self::$_Paths));
		/* Set application path to frontend */

		PathManager::SetApplicationPath(dirname(dirname(dirname(__FILE__))));
		
	}

	public static function GetModuleAdminPath()
	{
		// retorno el path del modulo admin
		return self::GetModulesPath().'/admin/';
	}

	public static function GetApplicationPath()
	{
		return self::$_ApplicationPath;
	}
	
	public static function GetApplicationDir()
	{
		$fullpath = self::GetApplicationPath();
		$start = strlen($_SERVER['DOCUMENT_ROOT']);
		$dir = substr($fullpath, $start, strlen($fullpath)-$start);
		return $dir;
	}
	
	public static function SetApplicationPath($path)
	{
		self::$_ApplicationPath = realpath($path);
	}

	public static function GetFrameworkDir()
	{
		$fullpath = self::GetFrameworkPath();
		$start = strlen(self::GetApplicationPath()) + 1;
		$dir = substr($fullpath, $start, strlen($fullpath)-$start);
		return '/'.$dir;
	}

	public static function GetModulesPath()
	{
		return self::GetFrameworkPath() . '/modules';
	}
	
	public static function GetModulePath()
	{
		/*
			Para retornar el nombre del modulo necesitamos movernos 2 lugares en el array
			porque pasa por la clase controller
		*/
		$x = debug_backtrace();
		
		if(isset($x[1]['file'])):
			return dirname(dirname($x[1]['file']));
		else:
			return dirname(dirname($x[0]['file']));
		endif;
	}


	/**
	* Manejo de paths para contenido generado
	*/
	public static function GetContentTargetPath($options = array())
	{
		$defaults = array(
			'module'=>'',
			'folderoption'=>'',
			'site_preffix'=>''
		);
		
		$query = "/configuration/modules/module[@name='".$options['module']."']/options/group[@name='folders']/option[@name='".$options['folderoption']."']";
		// echo $query;
		$folders = ConfigurationManager::Query($query);
		//util::debug($folders);die;

		if($folders)
		{
			$temp      = explode('/', $folders->item(0)->nodeValue);
			$applicationRootPath = self::GetApplicationPath();
			$content = 'content';

			$directory = $applicationRootPath . "/".$content."/".$options['site_preffix'];

			foreach($temp as $folder)
			{
				if(!is_dir($directory.'/'.$folder)){
					mkdir($directory.'/'.$folder);
					chmod($directory.'/'.$folder, 0775);
				}
				$directory .= '/'.$folder;
			}

			//$directory = $applicationRootPath.'/'.$content.'/'.$site['preffix'].'/'.$temp;

			return $directory;
		}
		else
		{
			return false;
		}
	}

	public static function GetDirectoryFromId($directory, $id)
	{
		$folder = $directory.'/'. substr($id, - 1);
		if (!is_dir($folder)){mkdir($folder, 0777);}
		return $folder;
	}






















	/*
	@Deprecated

	public static function InitializeFramework()
	{
		// Load System Configuration
		ConfigurationManager::LoadConfiguration();

		$frameworkPath = self::GetFrameworkPath();

		// We load configuration, core and admin classes (either admin is enabled or not)
		self::AddClassPath($frameworkPath . DIRECTORY_SEPARATOR . 'configuration');
		self::AddClassPath($frameworkPath . DIRECTORY_SEPARATOR . 'core');

		$dir  = self::GetModulesPath();
		$handle = opendir($dir);
		while (false !== ($item = readdir($handle))):if($item != '.' && $item != '..'):$path = $dir.'/'.$item;if(is_dir($path)):
			$configFile = $path . '/module.configuration.xml';
			if(file_exists($configFile)){
				ConfigurationManager::AddModule($configFile);
			}
		endif;endif;endwhile;
		closedir($handle);

		$modules = ConfigurationManager::Query('/configuration/modules/*');
		
		foreach($modules as $module){

			if($module->getAttribute('active') == 1){
				self::AddClassPath($frameworkPath . DIRECTORY_SEPARATOR . $module->getAttribute('path').'/classes');
			}
		}

		// Set application path to frontend
		self::SetApplicationPath(dirname(dirname(dirname(__FILE__))));
	
	}
	*/
	
	/*
	@deprecated
	public static function InitializeApplication()
	{
		$applicationPath = self::GetApplicationPath();
		return $applicationPath;
	}
	*/


	
	
	
	
	
	






	

	

	
	/*
	@deprecated
	public static function GetModuleDir()
	{
		
		$x = debug_backtrace();
		if(isset($x[1]['file'])):
			$fullpath = dirname(dirname($x[1]['file']));
		else:
			$fullpath = dirname(dirname($x[0]['file']));
		endif;

		$start = strlen(self::GetApplicationPath());
		$dir = substr($fullpath, $start, strlen($fullpath)-$start);
		return $dir;
	}

	
	public static function GetSkinsPath()
	{
		// Este metodo tiene que devolver el path del skin
		$application = self::GetApplicationPath();
		return $application . '/interface/';
	}
	*/
	
}
?>