<?php
class SiteModel extends Model 
{

	static $table = 'site';
	static $tag   = 'site';




	static $tables = array(
		'site' => array(
			"fields" => array(
				"id"=>array(
					"xml"			=>"value",
					"alias"			=>"id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
					"extra" 		=> "auto_increment",
				),
				"title"=>array(
					"xml"			=>"value",
					"alias"			=>"title",
					"type"			=> "varchar(250)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"preffix"=>array(
					"xml"			=>"value",
					"alias"			=>"preffix",
					"type"			=> "varchar(3)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"analytics"=>array(
					"xml"			=>"value",
					"alias"			=>"analytics",
					"type"			=> "varchar(350)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"eplanning"=>array(
					"xml"			=>"value",
					"alias"			=>"eplanning",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				)
			),
			'primary_key'=>'id',
			'charset'=>'utf8',
			'virtual' => false,
		),
	);

	public static function getFields($fields, $table){
		return parent::parseFields(self::$tables, $fields, $table);
	}
}
?>