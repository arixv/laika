<?php
class LocationModel extends Model
{
	public static $table = 'location';
	
	public static $tables = array(
		'location' => array(
			"fields" => array(
				"location_id"=>array(
					"xml"			=>"attribute",
					"alias"			=>"id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
					"extra" 		=> "auto_increment",
				),
				"location_name"=>array(
					"xml"			=>"value",
					"alias"			=>"name",
					"type"			=> "varchar(255)",
					"null" 			=> "NOT NULL",
					"default" 		=> '',
				),
				"location_parent"=>array(
					"xml"			=>"attribute",
					"alias"			=>"parent",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"location_order"=>array(
					"xml"			=>"attribute",
					"alias"			=>"order",
					"type"			=> "int(3)",
					"null" 			=> "NULL",
					"default" 		=> 0,
				)
				),
			'primary_key'=>'location_id',
			'charset'=>'utf8',
			"indexes" => array(
				/*
				array(
					"index_name"	=> "busqueda",
					"fields_name"	=> array("estate_title", "estate_url"),
					"index_type"	=> "FULLTEXT"
				),
				*/
				)
			),
	);

	
	public static function getFields($fields, $table){
		return parent::parseFields(self::$tables, $fields, $table);
	}
	/*
	public static function getPrimaryKeyAlias($table){
		return parent::parsePrimaryKeyAlias(self::$tables, $table);
	}

	public static function getPrimaryKeyTable($table){
		return parent::parsePrimaryKey(self::$tables, $table);
	}

	public static function createTable(){
		return parent::parsecreateTable(self::$tables);
	}
	
	public static function inputFields($fields, $table, $verbose=false){
		return parent::parseInputFields(self::$tables, $fields, $table, $verbose);
	}
	*/



}

?>