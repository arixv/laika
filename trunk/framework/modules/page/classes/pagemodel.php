<?php
class PageModel extends Model {

	static $object_typeid = 3;
	static $table = 'page';
	static $tag   = 'object';
	
	static $objectFields = array(
		'object_id'      => 'page_id',
		'object_typeid'  => 'page_objecttypeid',
		'object_parent'  => 'page_parent',
		'creation_date'    => 'creation_date',
		'creation_userid'       => 'creation_userid',
		'creation_usertype'     => 'creation_usertype',
		'modification_date'     => 'modification_date',
		'modification_userid'   => 'modification_userid',
		'modification_usertype' => 'modification_usertype',
		'object_title'   => 'page_title',
		'object_shorttitle'   => 'page_shorttitle',
		'object_content' => 'page_content',
		'object_summary' => 'page_summary',
		'object_state'   => 'page_state',
	);
	
	
	static $tables = array(
		'page' => array(
			"fields" => array(
				"page_id"=>array(
					"xml"			=>"attribute",
					"alias"			=>"id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
					"extra" 		=> "auto_increment",
				),
				"page_title"=>array(
					"xml"			=>"value",
					"alias"			=>"title",
					"type"			=> "varchar(255)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"page_shorttitle"=>array(
					"xml"			=>"value",
					"alias"			=>"shorttitle",
					"type"			=> "varchar(255)",
					"null" 			=> "NULL",
					"default" 		=> "",
				),
				"page_tags"=>array(
					"xml"			=>"value",
					"alias"			=>"tags",
					"type"			=> "varchar(255)",
					"null" 			=> "NULL",
					"default" 		=> "",
				),
				"page_content"=>array(
					"xml"			=>"value",
					"alias"			=>"content",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"page_summary"=>array(
					"xml"			=>"value",
					"alias"			=>"summary",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"page_metatitle"=>array(
					"xml"			=>"value",
					"alias"			=>"metatitle",
					"type"			=> "varchar(200)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"page_metadescription"=>array(
					"xml"			=>"value",
					"alias"			=>"metadescription",
					"type"			=> "varchar(255)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"page_datemod"=>array(
					"xml"			=>"attribute",
					"alias"			=>"datemod",
					"type"			=> "datetime",
					"null" 			=> "NOT NULL",
					"default" 		=> "0000-00-00 00:00:00",
				),
				"page_date"=>array(
					"xml"			=>"attribute",
					"alias"			=>"date",
					"type"			=> "datetime",
					"null" 			=> "NOT NULL",
					"default" 		=> "0000-00-00 00:00:00",
				),
				"page_objecttypeid"=>array(
					"xml"			=>"attribute",
					"alias"			=>"typeid",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"page_parent"=>array(
					"xml"			=>"attribute",
					"alias"			=>"object_parent",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"creation_date"=>array(
					"xml"			=> "attribute",
					"alias"			=> "creation_date",
					"type"			=> "date",
					"null" 			=> "NOT NULL",
					"default" 		=> '0000-00-00',
				),
				"creation_userid"=>array(
					"xml"			=>"attribute",
					"alias"			=>"creation_userid",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"creation_usertype"=>array(
					"xml"			=>"attribute",
					"alias"			=>"creation_usertype",
					"type"			=> "varchar(50)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"modification_date"=>array(
					"xml"			=>"attribute",
					"alias"			=>"modification_date",
					"type"			=> "date",
					"null" 			=> "NOT NULL",
					"default" 		=> '0000-00-00',
				),
				"modification_userid"=>array(
					"xml"			=>"attribute",
					"alias"			=>"modification_userid",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"modification_usertype"=>array(
					"xml"			=>"attribute",
					"alias"			=>"modification_usertype",
					"type"			=> "varchar(50)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"page_state"=>array(
					"xml"			=>"attribute",
					"alias"			=>"state",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
			),
			'primary_key'=>'page_id',
			"indexes" => array(
			),
			'virtual' => 1,
			),
		);


	// public static function getFields($fields, $table){
	// 	return parent::parseFields(self::$tables, $fields, $table);
	// }
	
	// public static function getFieldsFromObjects($objects, $table)
	// {
	// 	return parent::parseFieldsFromObjects($objects, $table, self::$tables, self::$objectFields);
	// }

	// public static function getPrimaryKeyAlias($table){
	// 	return parent::parsePrimaryKeyAlias(self::$tables, $table);
	// }

	// public static function getPrimaryKeyTable($table){
	// 	return parent::parsePrimaryKey(self::$tables, $table);
	// }

	// public static function createTable(){
	// 	return parent::parsecreateTable(self::$tables);
	// }
	
	// public static function inputFields($fields, $table, $verbose=false, $isObject=true)
	// {
	// 	if($isObject):
	// 		$object = array();
	// 		$custom = array();

	// 		foreach($fields as $key=>$value):
	// 			if(in_array($key, self::$objectFields)):
	// 				$objectField = array_search($key, self::$objectFields);
	// 				$object[$objectField] = $value;
	// 			else:
	// 				$custom[$key] = $value;
	// 			endif;
	// 		endforeach;

	// 		$custom = parent::parseInputFields(self::$tables, $custom, $table, $verbose, $custom=true);

	// 		$customArray  = array();
	// 		foreach($custom as $customKey=>$customValue):
	// 			$customField = self::getCustomField($customKey, $table);
	// 			$customArray[$customField] = $customValue;
	// 		endforeach;

		
	// 		$object['object_typeid'] = self::$object_typeid;
			
	// 		if(!empty($customArray)):
	// 			$object['object_custom'] = parent::serialize($customArray);
	// 		endif;

	// 		return $object;
	// 	else:
	// 		return parent::parseInputFields(self::$tables, $fields, $table, $verbose, $custom=false);
	// 	endif;
	// }

	// public static function getCustomField($fields, $table){
	// 	return parent::parseCustomField(self::$tables, $fields, $table);
	// }


}

?>