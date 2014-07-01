<?php
class Client extends Object_Custom
{
	//static $object_typeid = 1;
	//static $table = 'article';
	//static $tag = 'article';

	public static function getList($options = array()){

		$defaults = array(
			'tables'	  => ClientModel::$tables,
			'module'	  => 'client',
			'model'		  => 'ClientModel',
			'table'		  => 'client',
			'page' 		  => 1,
			'display'	  => 15, 
			'state'		  => false, 
			'multimedia'  => false,
			'relations'   => false,
			'startdate'   => false,
			'enddate'     => false,
			'debug'     => false,
		);
		$options = util::extend($defaults,$options);

		$Collection = parent::GetList($options);

		return $Collection;

	}

	public static function getById($options = array())
	{
		$defaults = array(
				'id'		 => false,
				'tables'	  => ClientModel::$tables,
				'module'	  => 'client',
				'model'		  => 'clientModel',
				'table'		  => 'client',
				'state'		 => false, 
				'relations'	 => true,
				'multimedas' => true,
				'categories' => true
		)	;
		$options = util::extend($defaults,$options);
		$Object = parent::getById($options);
		return $Object;
	}

	public static function FrontSearch()
	{
		$query = Util::getvalue('query', false);
		$page  = Util::getvalue('page', 1);
		$categories = Util::getvalue('categories');
		
		$options = array(
			'query'       => $query,
			'module'      => 'article',
			'model'		  => 'clientModel',
			'table'		  => clientModel::$table,
			'display'     => 10,
			'currentPage' => $page,
			'type_id'	  => clientModel::$object_typeid,
			'state'       => 1,
			'categories'  => $categories,
		);

		return parent::Search($options);
	}


}
?>
