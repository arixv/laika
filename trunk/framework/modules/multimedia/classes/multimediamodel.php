<?php
class MultimediaModel extends Model 
{

	public static $table = 'multimedia';
	public static $relationTable = 'multimedia_object';
	public static $categoryTable = 'multimedia_category';


	static $tables = array(
		'multimedia' => array(
			"fields" => array(
				"multimedia_id"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
					"extra" 		=> "auto_increment",
				),
				"multimedia_typeid"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_typeid",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"multimedia_source"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_source",
					"type"			=> "varchar(10)",
					"null" 			=> "NOT NULL",
					"default" 		=> '',
				),
				"multimedia_weight"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_weight",
					"type"			=> "int(15)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"multimedia_parent"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_parent",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"multimedia_title"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_title",
					"type"			=> "varchar(500)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"multimedia_content"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_content",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"multimedia_state"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_state",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"creation_date"=>array(
					"xml"			=>"value",
					"alias"			=>"creation_date",
					"type"			=> "datetime",
					"null" 			=> "NOT NULL",
					"default" 		=> '0000-00-00 00:00:00',
				),
				"creation_userid"=>array(
					"xml"			=>"value",
					"alias"			=>"creation_userid",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> '0',
				),
				"creation_usertype"=>array(
					"xml"			=>"value",
					"alias"			=>"creation_usertype",
					"type"			=> "varchar(50)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"modification_date"=>array(
					"xml"			=>"value",
					"alias"			=>"modification_date",
					"type"			=> "datetime",
					"null" 			=> "NOT NULL",
					"default" 		=> '0000-00-00 00:00:00',
				),
				"modification_userid"=>array(
					"xml"			=>"value",
					"alias"			=>"modification_userid",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> '0',
				),
				"modification_usertype"=>array(
					"xml"			=>"value",
					"alias"			=>"modification_usertype",
					"type"			=> "varchar(50)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"object_custom"=>array(
					"xml"			=>"value",
					"alias"			=>"object_custom",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
			),
			'primary_key'=>'multimedia_id',
			'charset'=>'utf8',
			"indexes" => array(
				array(
					"index_name"	=> "busqueda",
					"fields_name"	=> array('multimedia_title', 'multimedia_content', 'object_custom'),
					"index_type"	=> "FULLTEXT"
				),
			)
		),

		'multimedia_object' => array(
			"fields" => array(
				"object_id"=>array(
					"xml"			=>"value",
					"alias"			=>"object_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"multimedia_id"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"relation_order"=>array(
					"xml"			=>"value",
					"alias"			=>"relation_order",
					"type"			=> "int(3)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"object_typeid"=>array(
					"xml"			=>"value",
					"alias"			=>"object_typeid",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"multimedia_typeid"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_typeid",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
			),
			'primary_key'=>'',
			'charset'=>'utf8',
			"indexes" => array(
			)
		),

		'multimedia_category' => array(
			"fields" => array(
				"multimedia_id"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"category_id"=>array(
					"xml"			=>"value",
					"alias"			=>"category_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"category_parentid"=>array(
					"xml"			=>"value",
					"alias"			=>"parent_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
			),
			'primary_key'=>'',
			'charset'=>'utf8',
			"indexes" => array(
			)
		),

		'multimedia_deleted' => array(
			"fields" => array(
				"multimedia_id"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
					"extra" 		=> "auto_increment",
				),
				"multimedia_typeid"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_typeid",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"multimedia_source"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_source",
					"type"			=> "varchar(10)",
					"null" 			=> "NOT NULL",
					"default" 		=> '',
				),
				"multimedia_weight"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_weight",
					"type"			=> "int(15)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"multimedia_parent"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_parent",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"multimedia_title"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_title",
					"type"			=> "varchar(500)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"multimedia_content"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_content",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"multimedia_state"=>array(
					"xml"			=>"value",
					"alias"			=>"multimedia_state",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"creation_date"=>array(
					"xml"			=>"value",
					"alias"			=>"creation_date",
					"type"			=> "datetime",
					"null" 			=> "NOT NULL",
					"default" 		=> '0000-00-00 00:00:00',
				),
				"creation_userid"=>array(
					"xml"			=>"value",
					"alias"			=>"creation_userid",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> '0',
				),
				"creation_usertype"=>array(
					"xml"			=>"value",
					"alias"			=>"creation_usertype",
					"type"			=> "varchar(50)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"modification_date"=>array(
					"xml"			=>"value",
					"alias"			=>"modification_date",
					"type"			=> "datetime",
					"null" 			=> "NOT NULL",
					"default" 		=> '0000-00-00 00:00:00',
				),
				"modification_userid"=>array(
					"xml"			=>"value",
					"alias"			=>"modification_userid",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> '0',
				),
				"modification_usertype"=>array(
					"xml"			=>"value",
					"alias"			=>"modification_usertype",
					"type"			=> "varchar(50)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"object_custom"=>array(
					"xml"			=>"value",
					"alias"			=>"object_custom",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
			),
			'primary_key'=>'multimedia_id',
			'charset'=>'utf8',
			"indexes" => array(

			)
		),
	);

	/*
	public static function getFields($fields, $table){
		return parent::parseFields(self::$tables, $fields[0], $table);
	}

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