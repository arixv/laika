<?php

class Settings extends Module {
	
	public static function getlist(){

		$result = self::select(array(
			'fields'=>array(),
			'table'=>'settings',
		));

		return $result;


	}
	public static function get($setting){

		$result = self::select(array(
			'fields'=>array('*'),
			'table'=>'settings',
			'filters'=>array(
				'settings.setting_name="'.$setting.'"'
			)
		));

		if(isset($result[0])){
			return $result[0];
		}else{
			return false;
		}
	}

	public static function set($data)
	{
		self::insertupdate(array(
			'table'=>'settings',
			'fields'=>array(
				'setting_name'=>$data['setting_name'],
				'setting_value'=>$data['setting_value']
			),
			'update'=>'setting_value="'.$data['setting_value'].'"'
		));

	}
}

?>