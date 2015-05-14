<?php
class SindicatoModel extends Model
{
	public static $table = 'sindicato';

	public static $tables = array(
		'sindicato' => array(
			"fields" => array(
				"id"=>array(
					"xml"			=>"value",
					"alias"			=>"id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
					"extra" 		=> "auto_increment",
					),
				"name"=>array(
					"xml"			=>"value",
					"alias"			=>"name",
					"type"			=> "varchar(100)",
					"null" 			=> "NOT NULL",
					"default" 		=> '',
					),
				"percentage"=>array(
					"xml"			=>"value",
					"alias"			=>"percentage",
					"type"			=> "varchar(10)",
					"null" 			=> "NOT NULL",
					"default" 		=> '',
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