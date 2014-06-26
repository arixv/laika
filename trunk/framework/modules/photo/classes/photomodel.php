<?php
class PhotoModel extends Model {
	
	static $multimedia_typeid = 1;
	static $table = 'photo';
	static $tag   = 'photo';


	static $multimediaFields = array(
		'multimedia_id'      => 'photo_id',
		'multimedia_typeid'  => 'photo_objecttypeid',
		'multimedia_source'  => 'photo_type',
		'multimedia_parent'  => 'photo_parent',
		'multimedia_userid'  => 'photo_userid',
		'creation_date'      => 'creation_date',
		'creation_userid'       => 'creation_userid',
		'creation_usertype'     => 'creation_usertype',
		'modification_date'     => 'modification_date',
		'modification_userid'   => 'modification_userid',
		'modification_usertype' => 'modification_usertype',
		'multimedia_title'   => 'photo_title',
		'multimedia_content' => 'photo_summary',
		'multimedia_state'   => 'photo_state',
		'multimedia_weight'   => 'photo_weight',
	);
	
	static $tables = array(

		'photo'=> array(
			'fields' => array(
				"photo_id" => array(
					"xml"			=>"attribute",
					"alias"			=>"photo_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> false,
					"extra" 		=> "auto_increment",
				),
				"photo_title"=>array(
					"xml"			=>"value",
					"alias"			=>"title",
					"type"			=> "varchar(100)",
					"null" 			=> "NULL",
					"default" 		=> false,
				),
				"photo_summary"=>array(
					"xml"			=>"value",
					"alias"			=>"summary",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> false,
				),
				"photo_type"=>array(
					"xml"			=>"attribute",
					"alias"			=>"type",
					"type"			=> "varchar(10)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"creation_date"=>array(
					"xml"			=>"attribute",
					"alias"			=>"creation_date",
					"type"			=> "datetime",
					"null" 			=> "NOT NULL",
					"default" 		=> '0000-00-00 00:00:00',
				),
				"creation_userid"=>array(
					"xml"			=>"attribute",
					"alias"			=>"creation_userid",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> '0',
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
					"type"			=> "datetime",
					"null" 			=> "NOT NULL",
					"default" 		=> '0000-00-00 00:00:00',
				),
				"modification_userid"=>array(
					"xml"			=>"attribute",
					"alias"			=>"modification_userid",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> '0',
				),
				"modification_usertype"=>array(
					"xml"			=>"attribute",
					"alias"			=>"modification_usertype",
					"type"			=> "varchar(50)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"photo_state"=>array(
					"xml"			=>"attribute",
					"alias"			=>"state",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"photo_objecttypeid"=>array(
					"xml"			=>"attribute",
					"alias"			=>"type_id",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"photo_parent"=>array(
					"xml"			=>"attribute",
					"alias"			=>"parent",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"photo_userid"=>array(
					"xml"			=>"attribute",
					"alias"			=>"user_id",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"photo_width"=>array(
					"xml"			=>"attribute",
					"alias"			=>"width",
					"type"			=> "int(5)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"photo_height"=>array(
					"xml"			=>"attribute",
					"alias"			=>"height",
					"type"			=> "int(5)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"photo_weight"=>array(
					"xml"			=>"attribute",
					"alias"			=>"weight",
					"type"			=> "int(30)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"photo_preview"=>array(
					"xml"			=>"attribute",
					"alias"			=>"preview",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"photo_tags"=>array(
					"xml"			=>"value",
					"alias"			=>"tags",
					"type"			=> "varchar(100)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"photo_weight"=>array(
					"xml"			=>"attribute",
					"alias"			=>"weight",
					"type"			=> "int(15)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
			),
			'primary_key'=>'photo_id',
			"indexes" => array(
				"index_name"	=>	"",
				"fields_name"	=>	"",
				"index_type"	=>	""
			),
			'virtual' => 1,
		),

		
	);

	/*
	public static function getFields($fields, $table){
		return parent::parseFields(self::$tables, $fields, $table);
	}
	
	public static function getFieldsFromObjects($objects, $table)
	{
		return parent::parseFieldsFromObjects($objects, $table, self::$tables, self::$multimediaFields);
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
	
	public static function inputFields($fields, $table, $verbose=false, $isMultimedia=true)
	{
		if($isMultimedia):
			$object = array();
			$custom = array();

			foreach($fields as $key=>$value):
				if(in_array($key, self::$multimediaFields)):
					$multimediaField = array_search($key, self::$multimediaFields);
					$object[$multimediaField] = $value;
				else:
					$custom[$key] = $value;
				endif;
			endforeach;

			$custom = parent::parseInputFields(self::$tables, $custom, $table, $verbose, $custom=true);

			$customArray  = array();
			foreach($custom as $customKey=>$customValue):
				$customField = self::getCustomField($customKey, $table);
				$customArray[$customField] = $customValue;
			endforeach;

		
			$object['multimedia_typeid'] = self::$multimedia_typeid;
			if(!empty($customArray)):
				$object['object_custom'] = parent::serialize($customArray);
			endif;
			return $object;
		else:
			return parent::parseInputFields(self::$tables, $fields, $table, $verbose, $custom=false);
		endif;
	}

	public static function getCustomField($fields, $table){
		return parent::parseCustomField(self::$tables, $fields, $table);
	}
	*/
	

}

?>