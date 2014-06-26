<?php
class MenuModel extends Model {
	
	static $table = 'menu';

	static $tables = array(
		'menu' => array(
			"fields" => array(
				"menu_id"=>array(
					"xml"			=>"attribute",
					"alias"			=>"menu_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
					"extra" 		=> "auto_increment",
				),
				"menu_name"=>array(
					"xml"			=>"value",
					"alias"			=>"name",
					"type"			=> "varchar(255)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"menu_parent"=>array(
					"xml"			=>"attribute",
					"alias"			=>"parent",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0
				),
				"menu_url"=>array(
					"xml"			=>"value",
					"alias"			=>"url",
					"type"			=> "varchar(255)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"menu_order"=>array(
					"xml"			=>"attribute",
					"alias"			=>"order",
					"type"			=> "int(5)",
					"null" 			=> "NOT NULL",
					"default" 		=> '0',
				),
				"menu_state"=>array(
					"xml"			=>"attribute",
					"alias"			=>"state",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> '0',
				),
			),
			'primary_key'=>'menu_id',
			'charset'=>'utf8',
			"indexes" => array(
			)
		)

	);


	public static function getFields($fields, $table){
		return parent::parseFields(self::$tables, $fields, $table);
	}

	// public static function getPrimaryKeyAlias($table){
	// 	return parent::parsePrimaryKeyAlias(self::$tables, $table);
	// }

	// public static function getPrimaryKeyTable($table){
	// 	return parent::parsePrimaryKey(self::$tables, $table);
	// }

	// public static function createTable(){
	// 	return parent::parsecreateTable(self::$tables);
	// }
	
	// public static function inputFields($fields, $table, $verbose=false){
	// 	return parent::parseInputFields(self::$tables, $fields, $table, $verbose);
	// }

}

?>