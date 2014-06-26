<?php
class Article extends Object
{
	//static $object_typeid = 1;
	//static $table = 'article';
	//static $tag = 'article';

	public static function FrontSearch()
	{
		$query = Util::getvalue('query', false);
		$page  = Util::getvalue('page', 1);

		//$queryStr = str_replace("'", "\'", $query);
		
		$options = array(
			'query'       => $query,
			'module'      => 'article',
			'model'		  => 'ArticleModel',
			'table'		  => ArticleModel::$table,
			'display'     => 10,
			'currentPage' => $page,
			'type_id'	  => ArticleModel::$object_typeid,
			'state'       => 1,
			'categories'  => false,
		);

		return Article::Search($options);
	}

	public static function Test()
	{
		$params = array(
			'table'  => 'object',
			'fields' => array('object_title as "title-att"', 'object_typeid', 'object_id'),
			'filters' => array('object_id >= 100 and object_id <= 150', 'object_id <= 65'),
			'exclusive' => false,
			'orderby' => 'object_id DESC',
			'limit' => '3, 5',
		);

		$return = parent::select($params, $debug=true);
		Util::debug($return);
		die;
	}

	public static function GetList($options = array())
	{
		if(Application::isFrontend())
		{
			$folder   = "article";
			$expires  = 3600;

			$category_id = ($options['categories']!==false) ? $options['categories'] : 0;
			$page        = ($options['currentPage']!==false)? $options['currentPage'] : 0;

			$cacheKey = 'list.cat'.$category_id.'.page'.$page;

			//if(!($return = Cache::getKey($cacheKey, $folder)))
			//{
				$return = parent::GetList($options);
			//	Cache::setKey($cacheKey, $return, $expires, $folder);
			//}
			return $return;
			
		}else{
			return parent::GetList($options);
		}

	}
	
}

?>
