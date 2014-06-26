<?php

// Inicializar el framework
require_once ($_SERVER ['DOCUMENT_ROOT'] . "/framework/load.php");

//if(isset($_POST['databasename']) && isset($_POST['user']) && $_POST['password']):
	
	/* Script para crear las tablas desde el modelo de cada modulo */

	$dir  = PathManager::GetModulesPath();
	$handle = opendir($dir);
	while (false !== ($item = readdir($handle))):
		if($item != '.' && $item != '..'):
			$path = $dir.'/'.$item;
			if(is_dir($path.'/classes')):
				if(file_exists($path.'/classes/'.$item.'model.php')):
					//echo $path.'/classes/'.$item.'model.php', "<br/>";
					
					//$class = $item.'model';
					//$tbl = call_user_func(array($class, 'createTable'));
					//Util::debug($tbl);

					$modelReflection = new ReflectionClass($item.'model');
					$tables          = $modelReflection->getStaticPropertyValue('tables');
					Model::parsecreateTable($tables);
					
					
					//if($tbl!=''):
						//Module::exec($tbl);
					//endif;
					
				endif;
			endif;
		endif;
	endwhile;
	closedir($handle);

	//$sql = "alter table user_admin change user_alias username varchar(30)";
	//Module::custom($sql);

	//echo "tablas creadas exitosamente";
/*
else:
	
	$page = new Templates();
	$page->setBaseStylesheet("install.xsl");
	$page->display();

endif;
*/
?>