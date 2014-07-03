<?php
class RubroModel extends Model
{
	public static $table = 'rubro';

	public static $tables = array(
		'rubro' => array(
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
					"null" 			=> "NOT NULL",
					"default" 		=> '',
					),
				"parent_id"=>array(
					"xml"			=>"attribute",
					"alias"			=>"parent_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
					),
				),
			'primary_key'=>'id',
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

}

?>