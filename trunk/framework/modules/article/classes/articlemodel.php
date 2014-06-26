<?php
class ArticleModel extends Model {
	
	static $object_typeid = 1;
	static $table = 'article';
	static $tag   = 'object';

	static $objectFields = array(
		'object_id'         => 'article_id',
		'object_typeid'     => 'article_objecttypeid',
		'object_parent'     => 'article_parent',
		'creation_date'     => 'creation_date',
		'creation_userid'       => 'creation_userid',
		'creation_usertype'     => 'creation_usertype',
		'modification_date'     => 'modification_date',
		'modification_userid'   => 'modification_userid',
		'modification_usertype' => 'modification_usertype',
		'object_title'      => 'article_title',
		'object_content'    => 'article_content',
		'object_summary'    => 'article_summary',
		'object_state'      => 'article_state',
		'object_tags'      => 'article_tags',
		'site_id'      => 'site_id',
	);


	static $tables = array(
		'article' => array(
			"fields" => array(
				"article_id"=>array(
					"xml"			=>"attribute",
					"alias"			=>"id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
					"extra" 		=> "auto_increment",
				),
				"article_header"=>array(
					"xml"			=>"value",
					"alias"			=>"header",
					"type"			=> "varchar(250)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"article_title"=>array(
					"xml"			=>"value",
					"alias"			=>"title",
					"type"			=> "varchar(350)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"article_summary"=>array(
					"xml"			=>"nodes",
					"alias"			=>"summary",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"article_content"=>array(
					"xml"			=>"nodes",
					"alias"			=>"content",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"article_metatitle"=>array(
					"xml"			=>"value",
					"alias"			=>"metatitle",
					"type"			=> "varchar(200)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"article_metadescription"=>array(
					"xml"			=>"value",
					"alias"			=>"metadescription",
					"type"			=> "varchar(250)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
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
				"article_tags"=>array(
					"xml"			=>"value",
					"alias"			=>"tags",
					"type"			=> "varchar(200)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"article_comments"=>array(
					"xml"			=>"attribute",
					"alias"			=>"comments",
					"type"			=> "tinyint(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"article_state"=>array(
					"xml"			=>"attribute",
					"alias"			=>"state",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"article_objecttypeid"=>array(
					"xml"			=>"attribute",
					"alias"			=>"typeid",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"article_parent"=>array(
					"xml"			=>"attribute",
					"alias"			=>"parent",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"article_externallink"=>array(
					"xml"			=>"value",
					"alias"			=>"externallink",
					"type"			=> "varchar(255)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"site_id"=>array(
					"xml"			=>"attribute",
					"alias"			=>"site_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),

			),
			'primary_key'=>'article_id',
			'charset'=>'utf8',
			"indexes" => array(
				array(
					"index_name"	=> "busqueda",
					"fields_name"	=> array('article_header', 'article_titulo', 'article_summary', 'article_content', 'article_tags'),
					"index_type"	=> "FULLTEXT"
				),
				array(
					"index_name"	=> "puntuacion",
					"fields_name"	=> array('article_titulo', 'article_tags'),
					"index_type"	=> "FULLTEXT"
				),
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