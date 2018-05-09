<?php
// Cargar la configuracion del sistema
// Es necesario inicializar estas clases antes del framework para poder tomar la configuracion xml
require('core/util.php');
require('core/configurationmanager.php');
require('core/pathmanager.php');
require('core/application.php');


/*
	Agrando la memoria para poder trabajar con arrays muy grandes y transformarlos en xml.
	Sirve para las busquedas y para el manejo de imagenes
*/
ini_set("memory_limit","128M");

spl_autoload_extensions('.php');
spl_autoload_register();
error_reporting(E_STRICT | E_ALL);

//Init Application
Application::Initialize('development');

// set_error_handler(array('Error', 'ErrorHandler'));
// set_exception_handler(array('Error', 'ExceptionHandler'));


date_default_timezone_set(ConfigurationManager::Query('/configuration/timezone')->item(0)->nodeValue);
session_set_cookie_params(0, '/', '', 0, 1);
Session::Start();
