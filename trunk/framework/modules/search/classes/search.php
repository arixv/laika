<?php
class Search extends Module
{
	
	public static function GetResult($query, $currentPage)
	{
		$module = ConfigurationManager::GetModuleConfiguration('search');
		$config = ConfigurationManager::Query("/module/options/group[@name='modules']/option", $module);
		

		foreach($config as $item){
				
				$class  = $item->getAttribute('module');
				$method = $item->getAttribute('method');

				$result[$class.'s'] = call_user_func_array(array($class, $method), array('query'=>$query, 'page'=>$currentPage));
		}
		//$result['tag'] = 'search';
		//Util::debug($result);
		return $result;
	}

}
?>