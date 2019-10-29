<?php
// Inicializar el framework
require_once ("../framework/load.php");

$default = ConfigurationManager::query('/configuration/defaultModule');
$params = array(
		'module'=>Util::getvalue('m', $default->item(0)->nodeValue),
		'action'=>Util::getvalue('action', 'BackDisplayDefault')
	);
Application::BackendHandler( $params );

?>