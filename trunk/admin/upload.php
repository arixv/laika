<?php


if(isset($_POST['m']) && isset($_POST['action']) && isset($_FILES['Filedata'])){
	
	// Inicializar el framework
	require_once ($_SERVER['DOCUMENT_ROOT'] . "/framework/load.php");

	$mod = $_REQUEST['m'];

	if (! empty ( $mod )) {
		$modDir = PathManager::GetFrameworkPath () . '/modules/' . $mod;

		if (is_dir ( $modDir )) {

			$conf = ConfigurationManager::query("/configuration/modules/module[@name='".$mod."']");

			// Get action to execute
			$action = $_REQUEST['action'];

			if (! empty ( $action )) :

				$delimiter = strpos ( $action, '|' );
				if ($delimiter === false) :
					$method = ($action != '') ? $action : false;
				 else :

					$params = explode( '\|', $action );

					// El primer item es el valor del action solamente
					$method = $params [0];

					/*
						Remuevo el primer parametro que es solo el valor del action
						para que quede bien armado el array de post con el formato Array( nombre => valor )
					*/
					array_shift ( $params );

					foreach ( $params as $param ) :
						$_POST [substr ( $param, 0, strpos ( $param, '=' ) )] = substr ( $param, strpos ( $param, '=' ) + 1, strlen ( $param ) );
					endforeach;
				endif;


			// Agregado para poder pasar paramentros por url, desde el xml de configuracion de los modulos
			else :
				$method = false;
			endif;
			$controller = $conf->item(0)->getAttribute('controller');

			if (is_callable (array((string)$controller, $method)) && $method) {
				call_user_func (array((string)$controller, $method));
			} else {
				// If the action received does not exists call default view
				call_user_func (array((string)$controller, 'BackDisplayDefault'));
			}
			exit ();
		}

	// Else, The module called is not valid. Let them pass to dashboard.
	}
	
	
}else{
	?>
	<!DOCTYPE HTML >
	<html><head>
	<title>401 Authorization Required</title>
	</head><body>
	<h1>Authorization Required</h1>
	<p>This server could not verify that you
	are authorized to access the document
	requested.  Either you supplied the wrong
	credentials (e.g., bad password), or your
	browser doesn't understand how to supply
	the credentials required.</p>
	<p>Additionally, a 404 Not Found
	error was encountered while trying to use an ErrorDocument to handle the request.</p>
	</body></html>
	<?php
}

?>