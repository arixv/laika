<?php
class ContactModel extends Model {

	public static $table = 'contact';

	static $tables = array(
		'contact' => array(
			"fields" => array(
				"contact_id"=>array(
					"xml"			=>"attribute",
					"alias"			=>"id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
					"extra" 		=> "auto_increment",
				),
				"contact_name"=>array(
					"xml"			=>"value",
					"alias"			=>"name",
					"type"			=> "varchar(255)",
					"null" 			=> "NOT NULL",
					"default" 		=> 1,
				),
				"contact_lastname"=>array(
					"xml"			=>"value",
					"alias"			=>"lastname",
					"type"			=> "varchar(255)",
					"null" 			=> "NOT NULL",
					"default" 		=> 1,
				),
				"contact_email"=>array(
					"xml"			=>"value",
					"alias"			=>"email",
					"type"			=> "varchar(100)",
					"null" 			=> "NOT NULL",
					"default" 		=> 1,
				),
				"contact_phone"=>array(
					"xml"			=>"value",
					"alias"			=>"phone",
					"type"			=> "varchar(100)",
					"null" 			=> "NOT NULL",
					"default" 		=> 1,
				),
				"contact_location"=>array(
					"xml"			=>"value",
					"alias"			=>"location",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				
				"contact_sublocation"=>array(
					"xml"			=>"value",
					"alias"			=>"sublocation",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				
				"contact_comment"=>array(
					"xml"			=>"value",
					"alias"			=>"comment",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"recibir_newsletter"=>array(
					"xml"			=>"value",
					"alias"			=>"newsletter",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"carrera_id"=>array(
					"xml"			=> "value",
					"alias"			=> "carrera_id",
					"type"			=> "int(11)",
					"null" 			=> "NULL",
					"default" 		=> 0,
				),
				"carrera_title"=>array(
					"xml"			=>"value",
					"alias"			=>"carrera_title",
					"type"			=> "varchar(255)",
					"null" 			=> "NULL",
					"default" 		=> 0,
				),
				"universidad_id"=>array(
					"xml"			=>"value",
					"alias"			=>"universidad_id",
					"type"			=> "int(11)",
					"null" 			=> "NULL",
					"default" 		=> 0,
				),
				"universidad_title"=>array(
					"xml"			=>"value",
					"alias"			=>"universidad_title",
					"type"			=> "varchar(255)",
					"null" 			=> "NULL",
					"default" 		=> 0,
				),
				"contact_date"=>array(
					"xml"			=>"value",
					"alias"			=>"date",
					"type"			=> "datetime",
					"null" 			=> "NOT NULL",
					"default" 		=> '0000-00-00 00:00:00',
				)
			),
			'primary_key'=>'contact_id',
			'charset'=>'utf8',
			"indexes" => array(

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
	}*/
	
}
?>