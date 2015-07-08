<?php

class Cobro extends Object_Custom{

	// Get Entities and people related
	public static function getList($options = array())
	{
		$defaults = array(
			'page'=>1,
			'pagesize'=>20,
			'sort'=>'date',
			'ordering'=>'DESC'
		);

		$options = util::extend($defaults,$options);

		$fields = array('*');
		$fields = Model::parseFields(CobroModel::$tables, $fields, CobroModel::$table);
		
		$params = array(
				'fields'  => array('cobro.*','provider.title as provider_title'),
				'table'   => CobroModel::$table . ' LEFT JOIN provider ON cobro.provider_id = provider.id' ,
				'orderby' => $options['sort'].' '.$options['ordering'],
		);

		if(isset($options['start_date'])){
			$params['filters'][] = "date >='".$options['start_date']."'";
		}
		if(isset($options['pagesize']) && isset($options['page'])){
			$from = $options['page']-1;
			$params['limit'] = $from.','.$options['pagesize'];
		}
		if(isset($options['state'])){
			$params['state'] = $options['state'];
		}
		if(isset($options['orderby'])){
			$params['orderby']=$options['orderby'];
		}
		$return = self::select($params,0);
		


		$return['total-att'] = self::getTotal($params);
		$return['pagesize-att'] = $options['pagesize'];
		$return['page-att'] = $options['page'];

		$return['tag'] = 'cobro';
		return $return;
	}
	

	public static function getTotal($params){
		if(isset($params['limit'])) unset($params['limit']);
		if(isset($params['orderby'])) unset($params['orderby']);
		$params['fields'] = array('count(*) as cant');
		$results = self::select($params);
		$total = $results[0]['cant'];
		return $total;
	}
	public static function getById($options = array()){
		$defaults = array(
			'createdby'=> false
		);
		$options = Util::extend($defaults,$options);

		$Object = Object_Custom::getById(
			$options = array(
				'id'	 	  => $options['id'],
				'model'      => 'CobroModel',
				'table'      => CobroModel::$table,
				'tables'	 => CobroModel::$tables,
				'module'	 => 'cobro',
				'state'		 => false, 
				'relations'	 => true,
				'multimedas' => true,
				'categories' => true,
				'createdby'  => $options['createdby'],
				'debug'		 => false
			)
		);

		return $Object;
	}

}

?>