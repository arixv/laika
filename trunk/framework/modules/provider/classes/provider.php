<?php
class Provider extends Object_Custom
{



	// Filtrar por estado y paginado
	public static function getList($options = array())
	{
		$defaults = array(
			'start_date'=>false,
			'end_date'=>false,
			'page'=>false,
			'pagesize'=>false,
			'orderby'=>'title ASC'
		);

		$options = Util::extend($defaults,$options);

		$filters = array();

		if($options["start_date"] != false):
			$filters[]="contact_date>='".$options["start_date"]." 00:00:00'";
		endif;

		if($options["end_date"] != false):
			$filters[]="contact_date<='".$options["end_date"] ." 24:00:00'";
		endif;

		if($options['pagesize']!=false && $options['page']!=false):
			$from = ($options['page']-1) * $options['pagesize'];
			$limit = $from.', '.$options['pagesize'];
		else:
			$limit = false;
		endif;


		$params = array(
					'fields'	=> ProviderModel::getFields(array('*'), ProviderModel::$table),
					'table'		=> ProviderModel::$table,
					'filters'	=> $filters,
					'orderby'	=> $options['orderby'],
					'limit'		=> $limit,
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
			'table' => ProviderModel::$table,
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
