<?php
class Project extends Object_Custom
{

	public static function FrontSearch()
	{
		$query = Util::getvalue('query', false);
		$page  = Util::getvalue('page', 1);

		//$queryStr = str_replace("'", "\'", $query);
		
		$options = array(
			'query'       => $query,
			'module'      => 'project',
			'model'		  => 'ProjectModel',
			'table'		  => ProjectModel::$table,
			'display'     => 10,
			'currentPage' => $page,
			'state'       => 1,
			'categories'  => false,
		);

		return Project::Search($options);
	}


	// Filtrar por estado y paginado
	public static function getList($options = array())
	{
		$defaults = array(
			'start_date'=>false,
			'end_date'=>false,
			'page'=>1,
			'pagesize'=>10,
			'orderby'=>'id DESC'
		);

		$options = Util::extend($defaults,$options);

		$filters = array();

		if($options["start_date"] != false):
			$filters[]="contact_date>='".$options["start_date"]." 00:00:00'";
		endif;

		if($options["end_date"] != false):
			$filters[]="contact_date<='".$options["end_date"] ." 24:00:00'";
		endif;

		$from = ($options['page']-1) * $options['pagesize'];



		$params = array(
					'fields'	=> ProjectModel::getFields(array('*'), ProjectModel::$table),
					'table'		=> ProjectModel::$table,
					'filters'	=> $filters,
					'orderby'	=> $options['orderby'],
					'limit'		=> $from.', '.$options['pagesize'],
		);

		
		$result = parent::select($params);

		$result['total-att'] = self::getTotal($options);
		$result['pagesize-att'] = $options['pagesize'];
		$result['page-att'] = $options['page'];
		$result['tag'] = 'object';
		return $result;
	}


	public static function getTotal($options=false)
	{
		$defaults = array(
			'start_date'=>false,
			'end_date'=>false,
		);

		$options = Util::extend($defaults,$options);

		$params = array(
			'fields'=> array('count(*) as cant'),
			'table' => ProjectModel::$table,
			'filters'=> array()
		);


		if($options["start_date"] != false):
			$params['filters'][]="contact_date>='".$options["start_date"]." 00:00:00'";
		endif;

		if($options["end_date"] != false):
			$params['filters'][]="contact_date<='".$options["end_date"] ." 24:00:00'";
		endif;

		$r = parent::select($params);
		if(!empty($r)):
			$total = $r[0]['cant'];
		else:
			$total = 0;
		endif;
		return $total;

	}
	
}

?>
