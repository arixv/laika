<?php
class DocumentModel extends Model {
	
	static $multimedia_typeid = 3;
	static $table = 'document';
	static $tag   = 'document';

	static $multimediaFields = array(
		'multimedia_id'      => 'document_id',
		'multimedia_typeid'  => 'document_objecttypeid',
		'multimedia_source'  => 'document_type',
		'multimedia_parent'  => 'document_parent',
		'creation_date'      => 'creation_date',
		'creation_userid'       => 'creation_userid',
		'creation_usertype'     => 'creation_usertype',
		'modification_date'     => 'modification_date',
		'modification_userid'   => 'modification_userid',
		'modification_usertype' => 'modification_usertype',

		'multimedia_title'   => 'document_title',
		'multimedia_content' => 'document_content',
		'multimedia_state'   => 'document_state',
		'multimedia_weight'  => 'document_weight',
	);
	
	

	static $tables = array(

		'document'=> array(
			'fields' => array(
				"document_id" => array(
					"xml"			=>"attribute",
					"alias"			=>"document_id",
					"type"			=> "int(11)",
					"null" 			=> "NOT NULL",
					"default" 		=> false,
					"extra" 		=> "auto_increment",
				),
				"document_title"=>array(
					"xml"			=>"value",
					"alias"			=>"title",
					"type"			=> "varchar(100)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"document_content"=>array(
					"xml"			=>"value",
					"alias"			=>"content",
					"type"			=> "text",
					"null" 			=> "NULL",
					"default" 		=> false,
				),
				"document_type"=>array(
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
				"document_state"=>array(
					"xml"			=>"attribute",
					"alias"			=>"state",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"document_objecttypeid"=>array(
					"xml"			=>"attribute",
					"alias"			=>"type_id",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),
				"document_parent"=>array(
					"xml"			=>"attribute",
					"alias"			=>"object_parent",
					"type"			=> "int(1)",
					"null" 			=> "NOT NULL",
					"default" 		=> 0,
				),

				"document_tags"=>array(
					"xml"			=>"value",
					"alias"			=>"tags",
					"type"			=> "varchar(100)",
					"null" 			=> "NULL",
					"default" 		=> '',
				),
				"document_weight"=>array(
					"xml"			=>"attribute",
					"alias"			=>"weight",
					"type"			=> "int(15)",
					"null" 			=> "NULL",
					"default" 		=> 0,
				),
			),
			'primary_key'=>'document_id',
			"indexes" => array(),
			'virtual' => 1,
		),
	);


}

?>