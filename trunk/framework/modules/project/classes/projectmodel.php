<?php
class ProjectModel extends Model {
	
	public static $table = 'project';
	public static $tag   = 'project';


	static $tables = array(
		'virtual' => 0,
		'project' => array(
			"fields" => array(
				"id"=>array(
					"xml"			=>"attribute",
					"alias"			=>"id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
					"extra" 		=> "auto_increment",
				),

				"title"=>array(
					"xml"			=>"value",
					"alias"			=>"title",
					"type"			=> "varchar(100)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"description"=>array(
					"xml"			=>"value",
					"alias"			=>"description",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				)
			),
			'primary_key'=>'project_id',
			'charset'=>'utf8',
			"indexes" => array(
				array(
					"index_name"	=> "busqueda",
					"fields_name"	=> array('project_header', 'project_titulo', 'project_summary', 'project_content', 'project_tags'),
					"index_type"	=> "FULLTEXT"
				),
				array(
					"index_name"	=> "puntuacion",
					"fields_name"	=> array('project_titulo', 'project_tags'),
					"index_type"	=> "FULLTEXT"
				),
			),
			
		),
	);

	public static function getFields($fields, $table){
		return parent::parseFields(self::$tables, $fields, $table);
	}

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