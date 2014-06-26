<?php
class CategoryModel extends Model
{
	public static $table = 'category';
	public static $objectCategoryTable = 'object_category';
	public static $multimediaTable = 'multimedia_category';

	public static $tables = array(
		'category' => array(
			"fields" => array(
				"category_id"=>array(
					"xml"			=>"attribute",
					"alias"			=>"category_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
					"extra" 		=> "auto_increment",
					),
				"category_name"=>array(
					"xml"			=>"value",
					"alias"			=>"name",
					"type"			=> "varchar(255)",
					"null" 			=> "NOT NULL",
					"default" 		=> '',
					),
				"category_parent"=>array(
					"xml"			=>"attribute",
					"alias"			=>"parent",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
					),
				"category_order"=>array(
					"xml"			=>"attribute",
					"alias"			=>"order",
					"type"			=> "int(3)",
					"null" 			=> "NULL",
					"default" 		=> 0,
					),
				"category_url"=>array(
					"xml"			=>"attribute",
					"alias"			=>"url",
					"type"			=> "url(255)", // El tipo url es un varchar que se transforma en url amigable reemplazando caracteres raros
					"null" 			=> "NULL",
					"default" 		=> '',
					),
				"category_highlight"=>array(
					"xml"			=>"attribute",
					"alias"			=>"highlight",
					"type"			=> "int(1)", 
					"null" 			=> "NULL",
					"default" 		=> '0',
					),
				),
			'primary_key'=>'category_id',
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

	/*
	public static function getFields($fields, $table){
		return parent::parseFields(self::$tables, $fields, $table);
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