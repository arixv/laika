<?php

class Cobro extends Object_Custom{

	// Get Entities and people related
	public static function getList($options = array())
	{
		$fields = array('*');
		$fields = Model::parseFields(CobroModel::$tables, $fields, CobroModel::$table);

		$params = array(
				'fields'  => $fields,
				'table'   => CobroModel::$table,
				'orderby' => 'date DESC',
		);

		if(isset($options['start_date'])){
			$params['filters'][] = "date >='".$options['start_date']."'";
		}
		if(isset($options['limit']) && isset($options['page'])){
			$from = $options['page']-1;
			$params['limit'] = $from.','.$options['limit'];
		}
		if(isset($options['state'])){
			$params['state'] = $options['state'];
		}
		if(isset($options['orderby'])){
			$params['orderby']=$options['orderby'];
		}
		$return = self::select($params,0);
		$return['tag'] = 'cobro';
		return $return;
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