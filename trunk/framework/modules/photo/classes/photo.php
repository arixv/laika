<?php
class Photo extends Multimedia
 {

	public static function getById($options)
	{ 
		$defaults = array(
			'model'         => 'PhotoModel',
			'module'        => 'photo',
			'table'			=> PhotoModel::$table,
			'multimedia_id' => false,
			'type_id'       => 1,
			'state'         => false, 
			'relations'     => false,
			'categories'	=> false
		);

		$options = util::extend($defaults,$options);

		return Multimedia::getById($options);
	}
 }
?>
