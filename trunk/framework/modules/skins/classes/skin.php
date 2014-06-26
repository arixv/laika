<?php
class Skin
{
	
	public static function getDefaultSkin()
	{
		$path = PathManager::GetModulePath();
		$defaultFile = $path.'/defaultskin.xml';
		$default = new DOMDocument('1.0');
		$default->load($defaultFile);
		$data = array();
		$data['name'] = $default->getElementsByTagName('name')->item(0)->nodeValue;
		$data['path'] = $default->getElementsByTagName('path')->item(0)->nodeValue;
		return $data;
	}
	
	public static function getAllSkins(){
		$dir = PathManager::GetSkinsPath();
		$skinlist = array();
		$handle = opendir($dir);
		while (false !== ($item = readdir($handle))):if($item != '.' && $item != '..' && $item != '.svn'): $path = $dir.$item; if(is_dir($path)):
			array_push($skinlist, (string)$path);
		endif;endif;endwhile;
		closedir($handle);
		return $skinlist;
	}
	
	
}