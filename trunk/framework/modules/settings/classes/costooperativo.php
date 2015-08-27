<?php

class CostoOperativo extends Module {

	// Get Entities and people related
	public static function getList($options = array())
	{
		$params = array(
				'fields'  => array('*'),
				'table'   => 'costo_operativo',
				'orderby' => 'title ASC',
		);

		$return = self::select($params,$debug=false);
		$return['tag'] = 'costo_operativo';
		return $return;
	}

	/* total  */
	public static function getTotal()
	{
		$params = array(
				'fields'  => array('sum(amount) as total'),
				'table'   => 'costo_operativo',
		);

		$return = self::select($params,$debug=false);
		return $return[0]['total'];
	}

	/* create */
	public static function create($dto){
		$params = array(
			'fields' => array(
				'title'=>$dto['title'],
				'amount'=>$dto['amount']
			),
			'table'  => 'costo_operativo'
		);
		$r = self::insert($params);
		return $r;
	}

	// Get by id
	public static function getById($options = array()){
		if(isset($options['id'])):
			$params = array(
				'fields'=>array('*'),
				'table'   => 'costo_operativo',
				'filters' => array('id='.$options['id'])
			);
			$result = self::select($params,false);
			
			if(isset($result[0])):
				return $result[0];
			else:
				return false;
			endif;

		endif;
	}


	//Update
	public static function edit($data=array()){

		if(is_array($data))
		{
			$params = array(
				'fields'=>array(
					'title'=>$data['title'],
					'amount'=>$data['amount']
				),
				'table'=> 'costo_operativo',
				'filters'=>array(
					'id='.$data['id']
				)
			);
			$return = self::update($params);
			return $return;
		}
		else
		{
			return false;
		}

	}

	public static function Remove($data=array()){

		if(isset($data['id'])):
			$params = array(
				'table'=>'costo_operativo',
				'filters'=>array(
					'id='.$data['id']
				)
			);
			return self::delete($params);
		endif;

	}

}

?>