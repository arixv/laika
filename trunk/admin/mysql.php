<?php
	require_once ($_SERVER ['DOCUMENT_ROOT'] . "/framework/load.php");

	
	$table      = 'object'; 
	//$table      = 'home_object';
	//$table      = 'home_object_temp';
	//$table      = 'object_deleted';
	$primaryKey = 'object_id';

	//$table      = 'multimedia';
	//$table      = 'multimedia_deleted';
	//$primaryKey = 'multimedia_id';

	// DB UTF
	$db = new DBManager();

	$params = array(
		'table'   => $table,
		'fields'  => array('*')
	);
	
	$objects = $db->select($params);

	ob_start();

	foreach($objects as $object):

		$object_id     = $object[$primaryKey];
		$object_custom = $object['object_custom'];


		$data = array(
			'table'   => $table,
			'fields'  => array(
				'object_custom' => preg_replace('!s:(\d+):"(.*?)";!se', "'s:'.strlen('$2').':\"$2\";'", $object_custom),
			),
			'filters' => array($primaryKey.'='.$object_id)
		);
		$db->update($data);

		echo "Actualizando object_id: ".$object_id." <br/>";

		ob_flush();
		flush();

	endforeach;
	
	echo "<br/><br/>Finalizado";

	ob_flush();
	flush();
	
	$db = null;



?>