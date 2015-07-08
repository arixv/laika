<?php
class CobroModel extends Model
{
	public static $table = 'cobro';

	public static $tables = array(
		'cobro' => array(
			"fields" => array(
				"id"=>array(
					"xml"			=>"value",
					"alias"			=>"id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
					"extra" 		=> "auto_increment",
					),
				"number"=>array(
					"xml"			=>"value",
					"alias"			=>"number",
					"type"			=> "varchar(100)",
					"null" 			=> "NULL",
					"default" 		=> '',
					),
				"date"=>array(
					"xml"			=>"value",
					"alias"			=>"date",
					"type"			=> "date",
					"null" 			=> "NULL",
					"default" 		=> '',
					),
				"type"=>array(
					"xml"			=>"value",
					"alias"			=>"type",
					"type"			=> "varchar(10)",
					"null" 			=> "NULL",
					"default" 		=> '',
					),
				"amount"=>array(
					"xml"			=>"value",
					"alias"			=>"amount",
					"type"			=> "decimal(10,2)",
					"null" 			=> "NULL",
					"default" 		=> '',
					),
				"description"=>array(
					"xml"			=>"value",
					"alias"			=>"description",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> NULL,
				),
				"state"=>array(
					"xml"			=>"value",
					"alias"			=>"state",
					"type"			=> "int(1)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				'provider_id'=>array(
					"xml"			=>"value",
					"alias"			=>"provider_id",
					"type"			=> "int(11)",
					"null" 			=> "0",
					"default" 		=> '',
				),
				'creation_userid'=>array(
					"xml"			=>"value",
					"alias"			=>"creation_userid",
					"type"			=> "int(11)",
					"null" 			=> "NULL",
					"default" 		=> '',
				)
			),
			'primary_key'=>'id',
			'charset'=>'utf8',
			"indexes" => array()
			),
	);

}

?>