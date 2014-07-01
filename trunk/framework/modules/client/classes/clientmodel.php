<?php
class ClientModel extends Model {
	static $table = 'client';
	static $tag   = 'client';

	static $tables = array(
		'client' => array(
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
					"type"			=> "varchar(350)",
					"null" 			=> "NULL",
					"default" 		=> "",
				),

				"cuit"=>array(
					"xml"			=>"value",
					"alias"			=>"cuit",
					"type"			=> "varchar(100)",
					"null" 			=> "NULL",
					"default" 		=> "",
				),
				"email"=>array(
					"xml"			=>"value",
					"alias"			=>"email",
					"type"			=> "varchar(100)",
					"null" 			=> "NULL",
					"default" 		=> "",
				),
				"phone"=>array(
					"xml"			=>"value",
					"alias"			=>"phone",
					"type"			=> "vachar(100)",
					"null" 			=> "NULL",
					"default" 		=> "",
				),
				"address"=>array(
					"xml"			=>"value",
					"alias"			=>"address",
					"type"			=> "vachar(100)",
					"null" 			=> "NULL",
					"default" 		=> "",
				),
				"website"=>array(
					"xml"			=>"value",
					"alias"			=>"website",
					"type"			=> "vachar(255)",
					"null" 			=> "NULL",
					"default" 		=> "",
				),

				"creation_date"=>array(
					"xml"			=> "attribute",
					"alias"			=> "creation_date",
					"type"			=> "datetime",
					"null" 			=> "NOT NULL",
					"default" 		=> '0000-00-00 00:00:00',
				),
				"creation_userid"=>array(
					"xml"			=>"attribute",
					"alias"			=>"creation_userid",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
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
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				// "publication_date"=>array(
				// 	"xml"			=>"value",
				// 	"alias"			=>"publication_date",
				// 	"type"			=> "datetime",
				// 	"null" 			=> "NOT NULL",
				// 	"default" 		=> '0000-00-00 00:00:00',
				// ),
				"state"=>array(
					"xml"			=>"attribute",
					"alias"			=>"state",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
			),
			'primary_key'=>'id',
			'charset'=>'utf8',
			"indexes" => array(),
			'virtual' => 0,
		),
	);

}
?>