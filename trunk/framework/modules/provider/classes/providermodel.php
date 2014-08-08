<?php
class ProviderModel extends Model {
	
	public static $table = 'provider';
	public static $tag   = 'provider';


	static $tables = array(
		'virtual' => 0,
		'provider' => array(
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
				"phone"=>array(
					"xml"			=>"value",
					"alias"			=>"phone",
					"type"			=> "varchar(100)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"address"=>array(
					"xml"			=>"value",
					"alias"			=>"address",
					"type"			=> "varchar(100)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"email"=>array(
					"xml"			=>"value",
					"alias"			=>"email",
					"type"			=> "varchar(100)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"website"=>array(
					"xml"			=>"value",
					"alias"			=>"website",
					"type"			=> "varchar(100)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"cuit"=>array(
					"xml"			=>"value",
					"alias"			=>"cuit",
					"type"			=> "varchar(100)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"creation_date"=>array(
					"xml"			=>"value",
					"alias"			=>"creation_date",
					"type"			=> "date",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"state"=>array(
					"xml"			=>"attribute",
					"alias"			=>"state",
					"type"			=> "int(1)",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				)
			),
			'primary_key'=>'provider_id',
			'charset'=>'utf8',
			"indexes" => array(
				array(
					"index_name"	=> "busqueda",
					"fields_name"	=> array('project_header', 'project_titulo', 'project_summary', 'project_content', 'project_tags'),
					"index_type"	=> "FULLTEXT"
				)
			),
			
		),
	);

	public static function getFields($fields, $table){
		return parent::parseFields(self::$tables, $fields, $table);
	}

}
?>