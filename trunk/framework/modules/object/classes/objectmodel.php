<?php
class ObjectModel extends Model 
{
	public static $table = 'object';
	public static $objectRelarionTable = 'object_relation';
	public static $objectCategoryTable = 'object_category';

	static $objectFields = array(
		'object_id'      => 'object_id',
		'object_typeid'  => 'object_typeid',
		'object_parent'  => 'object_parent',
		'object_userid'  => 'object_userid',
		'creation_date'     => 'creation_date',
		'creation_userid'       => 'creation_userid',
		'creation_usertype'     => 'creation_usertype',
		'modification_date'     => 'modification_date',
		'modification_userid'   => 'modification_userid',
		'modification_usertype' => 'modification_usertype',
		'object_datemod' => 'object_datemod',
		'object_title'   => 'object_title',
		'object_shorttitle'   => 'object_shorttitle',
		'object_content' => 'object_content',
		'object_summary' => 'object_summary',
		'object_state'   => 'object_state',
		'location_id'   => 'location_id',
	);
	
	static $tables = array(
		'object' => array(
			"fields" => array(
				"object_id"=>array(
					"xml"			=>"value",
					"alias"			=>"object_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
					"extra" 		=> "auto_increment",
				),
				"object_typeid"=>array(
					"xml"			=>"value",
					"alias"			=>"object_typeid",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"object_parent"=>array(
					"xml"			=>"value",
					"alias"			=>"object_parent",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"object_title"=>array(
					"xml"			=>"value",
					"alias"			=>"object_title",
					"type"			=> "varchar(500)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"object_shorttitle"=>array(
					"xml"			=>"value",
					"alias"			=>"object_shorttitle",
					"type"			=> "varchar(255)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"object_content"=>array(
					"xml"			=>"value",
					"alias"			=>"object_content",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"object_summary"=>array(
					"xml"			=>"value",
					"alias"			=>"object_summary",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"object_tags"=>array(
					"xml"			=>"value",
					"alias"			=>"object_tags",
					"type"			=> "varchar(255)",
					"null" 			=> "NULL",
					"default" 		=> '',
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
				"publication_date"=>array(
					"xml"			=>"value",
					"alias"			=>"publication_date",
					"type"			=> "datetime",
					"null" 			=> "NOT NULL",
					"default" 		=> '0000-00-00 00:00:00',
				),
				"publication_userid"=>array(
					"xml"			=>"value",
					"alias"			=>"publication_userid",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> '0',
				),
				"object_state"=>array(
					"xml"			=>"value",
					"alias"			=>"object_state",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				
				"location_id"=>array(
					"xml"			=>"attribute",
					"alias"			=>"location_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"object_custom"=>array(
					"xml"			=>"value",
					"alias"			=>"object_custom",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
			),
			'primary_key'=>'object_id',
			'charset'=>'utf8',
			"indexes" => array(
				array(
					"index_name"	=> "busqueda",
					"fields_name"	=> array('object_title', 'object_content', 'object_custom'),
					"index_type"	=> "FULLTEXT"
				),
			)
		),

		'object_relation' => array(
			"fields" => array(
				"object_id"=>array(
					"xml"			=>"value",
					"alias"			=>"object_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"object_typeid"=>array(
					"xml"			=>"value",
					"alias"			=>"type_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"object_relationid"=>array(
					"xml"			=>"value",
					"alias"			=>"relation_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"object_relation_typeid"=>array(
					"xml"			=>"value",
					"alias"			=>"relation_type_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"object_relation_order1"=>array(
					"xml"			=>"value",
					"alias"			=>"relation_order1",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"object_relation_order2"=>array(
					"xml"			=>"value",
					"alias"			=>"relation_order2",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"object_relation_date"=>array(
					"xml"			=>"value",
					"alias"			=>"date",
					"type"			=> "datetime",
					"null" 			=> "NOT NULL",
					"default" 		=> '0000-00-00 00:00:00',
				),
			),
			'primary_key'=>'',
			'charset'=>'utf8',
			"indexes" => array(
			)
		),

		'object_category' => array(
			"fields" => array(
				"object_id"=>array(
					"xml"			=>"value",
					"alias"			=>"object_id",
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
				"category_order"=>array(
					"xml"			=>"attribute",
					"alias"			=>"order",
					"type"			=> "int(2)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
			),
			'primary_key'=>'',
			'charset'=>'utf8',
			"indexes" => array(
			)
		),
		
		'object_deleted' => array(
			"fields" => array(
				"object_id"=>array(
					"xml"			=>"value",
					"alias"			=>"object_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
					"extra" 		=> "auto_increment",
				),
				"object_typeid"=>array(
					"xml"			=>"value",
					"alias"			=>"object_typeid",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"object_parent"=>array(
					"xml"			=>"value",
					"alias"			=>"object_parent",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"object_title"=>array(
					"xml"			=>"value",
					"alias"			=>"object_title",
					"type"			=> "varchar(500)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"object_shorttitle"=>array(
					"xml"			=>"value",
					"alias"			=>"object_shorttitle",
					"type"			=> "varchar(255)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"object_content"=>array(
					"xml"			=>"value",
					"alias"			=>"object_content",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"object_summary"=>array(
					"xml"			=>"value",
					"alias"			=>"object_summary",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"creation_date"=>array(
					"xml"			=>"value",
					"alias"			=>"object_date",
					"type"			=> "datetime",
					"null" 			=> "NOT NULL",
					"default" 		=> '0000-00-00 00:00:00',
				),
				"creation_userid"=>array(
					"xml"			=>"value",
					"alias"			=>"object_date",
					"type"			=> "int(4)",
					"null" 			=> "NOT NULL",
					"default" 		=> '0',
				),
				"creation_usertype"=>array(
					"xml"			=>"value",
					"alias"			=>"object_date",
					"type"			=> "varchar(50)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"modification_date"=>array(
					"xml"			=>"value",
					"alias"			=>"object_datemod",
					"type"			=> "datetime",
					"null" 			=> "NOT NULL",
					"default" 		=> '0000-00-00 00:00:00',
				),
				"modification_userid"=>array(
					"xml"			=>"value",
					"alias"			=>"object_date",
					"type"			=> "int(4)",
					"null" 			=> "NOT NULL",
					"default" 		=> '0',
				),
				"modification_usertype"=>array(
					"xml"			=>"value",
					"alias"			=>"object_date",
					"type"			=> "varchar(50)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"publication_date"=>array(
					"xml"			=>"value",
					"alias"			=>"object_datemod",
					"type"			=> "datetime",
					"null" 			=> "NOT NULL",
					"default" 		=> '0000-00-00 00:00:00',
				),
				"publication_userid"=>array(
					"xml"			=>"value",
					"alias"			=>"object_date",
					"type"			=> "int(4)",
					"null" 			=> "NOT NULL",
					"default" 		=> '0',
				),
				"object_state"=>array(
					"xml"			=>"value",
					"alias"			=>"object_state",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"object_custom"=>array(
					"xml"			=>"value",
					"alias"			=>"object_custom",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
			),
			'primary_key'=>'object_id',
			'charset'=>'utf8',
			"indexes" => array(
				array(
					"index_name"	=> "busqueda",
					"fields_name"	=> array('object_title', 'object_content', 'object_custom'),
					"index_type"	=> "FULLTEXT"
				),
			)
		),
	);

	/*
	public static function getFields($fields, $table){
		return parent::parseFields(self::$tables, $fields, $table);
	}

	public static function getFieldsFromObjects($objects, $table)
	{
		return parent::parseFieldsFromObjects($objects, $table, self::$tables, self::$objectFields);
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