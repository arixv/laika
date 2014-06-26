<?php
class Model{
	
	static $tag = 'object';

	public static function getTag(){
		return self::$tag;
	}

	public static function parseFields($structure, $fields, $table){
		self::table_exists($structure, $table);

		if(is_array($fields) && count($fields)):
			if(count($fields)==1 && $fields[0]=='*'):
				// Esta pidiendo todos los campos de la tabla
				$fields = array();
				foreach($structure[$table]['fields'] as $name=>$arr):
					array_push($fields, $name);
				endforeach;
			endif;
			$colector = array();

			foreach($fields as $pos=>$name):
				//echo 'name: ' . $name . '<br/>';
				//$data = ($structure[$table]['fields'][$name]['xml']=='attribute') ? $table.'.'.$name.' as "' . $structure[$table]['fields'][$name]['alias'].'-att"' : $table.'.'.$name.' as ' . $structure[$table]['fields'][$name]['alias'];

				switch ($structure[$table]['fields'][$name]['xml']):
					case "attribute":
						$data = $table.'.'.$name.' as "' . $structure[$table]['fields'][$name]['alias'].'-att"';
						break;
					case "nodes":
						$data = $table.'.'.$name.' as "' . $structure[$table]['fields'][$name]['alias'].'-xml"';
						break;
					default:
						$data = $table.'.'.$name.' as ' . $structure[$table]['fields'][$name]['alias'];
						break;
				endswitch;
				array_push($colector,$data);
			endforeach;
			return $colector;
		endif;
	}

	public static function parseCustomField($structure, $field, $table){
		self::table_exists($structure, $table);
		foreach($structure[$table]['fields'] as $name=>$arr):
			if($name == $field):
				$data = ($structure[$table]['fields'][$name]['xml']=='attribute') ? $structure[$table]['fields'][$name]['alias'].'-att' : $structure[$table]['fields'][$name]['alias'];
			endif;
		endforeach;
		return $data;
	}

	public static function parsePrimaryKeyAlias($structure, $table){
		self::table_exists($structure, $table);
		$key = $structure[$table]['primary_key'];
		if($structure[$table]["fields"][$structure[$table]["primary_key"]]['xml']=='attribute'){
			return $structure[$table]["fields"][$key]["alias"].'-att';
		}
		else{
			return $key;
		}
	}

	public static function parsePrimaryKey($structure, $table){
		self::table_exists($structure, $table);
		if(isset($structure[$table]['primary_key'])):
			return $structure[$table]['primary_key'];
		else:
			return false;
		endif;
	}

	public static function parseInputFields($structure, $fields, $table, $verbose=false, $customField=false)
	{
		if(isset($fields['back'])): unset($fields['back']); endif;

		$returnFields = array();
		// Si la tabla solicitada existe
		if(array_key_exists($table, $structure)):
			
			/*
				Recorremos todos los campos del listado recibido
				y solo validamos los que pertenecen a la tabla
				solicitada
			*/
			foreach($fields as $key=>$value):
				if(array_key_exists($key, $structure[$table]['fields'])):
					if(!$customField):
						$returnFields[$key] = self::validateField($structure, $key, $value, $table);
					else:
						$returnFields[$key] = self::validateCustomField($structure, $key, $value, $table);
					endif;
				else:
					if($verbose):
						die('El campo "'.$key.'" no existe en la db');
					endif;
				endif;
			endforeach;

			//Los campos que no vinieron editados, los completamos con los default
			//$returnFields = self::autoCompleteFields($structure, $returnFields, $table);
			return $returnFields;
		else:
			die("La tabla: '".$table."' no existe");
			return false;
		endif;
	}

	/*
		validateFields retorna el campo validado
		El llamado a este metodo se hace una vez validado el campo y la tabla
		Si no se corresponde con el tipo de datos arroja una excepcion
	*/
	public static function validateField($structure, $key, $value, $table)
	{
		// Tipo de dato
		$type    = $structure[$table]['fields'][$key]['type'];
		$null    = $structure[$table]['fields'][$key]['null'];
		$default = $structure[$table]['fields'][$key]['default'];
		
		// Si el tipo de datos contiene el largo lo separamos
		$pos = strpos($type,'(');
		if($pos === false):
			$typeName = $type;
			$length   = 0;
		else:
			$typeName = substr($type, 0, strpos($type,'('));
			$length   = substr($type, (strpos($type,'(') + 1), -1);
		endif;

		// Si el tipo de dato no es valido para el campo, retornamos falso
		switch($typeName){
			case "int":
				// strlen funciona bien para contar la cantidad de caracteres aunque sean numeros
				if(is_numeric($value) && strlen($value)<=$length): 
					return $value;
				elseif($null == 'NULL'):
					return $default;
				endif;
				// Si no valido el tipo y largo retornamos falso
				Error::Alert('El campo '.$key.' no es valido. Se esperaba un '.$type);
				return false;
			break;
			case "tinyint":
				// strlen funciona bien para contar la cantidad de caracteres aunque sean numeros
				if(is_numeric($value) && strlen($value)<=$length): 
					return $value;
				endif;
				// Si no valido el tipo y largo retornamos falso
				Error::Alert('El campo '.$key.' no es valido. Se esperaba un '.$type);
				return false;
			break;
			case "varchar":
				if(is_string($value) && strlen($value)<=$length):
					if($null == 'NOT NULL' && strlen($value)!=0):
						return Util::quote($value);
					elseif($null == 'NULL'):
						return Util::quote($value);
					endif;
				endif;
				Error::Alert('El campo '.$key.' no es valido. Se esperaba un '.$type);
				return false;
			break;
			/* 
				IMPORTANTE!
				El tipo url no es valido de MySQL, es un varchar
				Utilizamos este tipo para generar url amistosas
				reemplazando espacios y caracteres raros
			*/
			case "url":
				if(is_string($value) && strlen($value)<=$length):
					if($null == 'NOT NULL' && strlen($value)!=0):
						return Util::quote(Util::friendlyURL(utf8_encode($value)));
					elseif($null == 'NULL'):
						return Util::quote(Util::friendlyURL(utf8_encode($value)));
					endif;
				endif;
				Error::Alert('El campo '.$key.' no es valido. Se esperaba un '.$type);
				return false;
			break;
			case "text":
				if(is_string($value)):
					if($null == 'NOT NULL' && strlen($value)!=0):
						return Util::quote($value);
					elseif($null == 'NULL'):
						return Util::quote($value);
					endif;
				endif;
				Error::Alert('El campo '.$key.' no es valido. Se esperaba un '.$type);
				return false;
			break;
			case "datetime":
				return Util::quote($value);
			break;
			case "date":
				return Util::quote($value);
			break;
			case "time":
				return Util::quote($value);
			break;
			case "password":
				return Util::quote(Admin::encrypt($value));
			break;
			default:
				return false;
			break;
			// Agregar mas tipos, solo dejo los que mas usamos
		}
	}
	
	
	/*
		validateFields retorna el campo validado
		El llamado a este metodo se hace una vez validado el campo y la tabla
		Si no se corresponde con el tipo de datos arroja una excepcion
	*/
	public static function validateCustomField($structure, $key, $value, $table)
	{
		// Tipo de dato
		$type    = $structure[$table]['fields'][$key]['type'];
		$null    = $structure[$table]['fields'][$key]['null'];
		$default = $structure[$table]['fields'][$key]['default'];
		
		// Si el tipo de datos contiene el largo lo separamos
		$pos = strpos($type,'(');
		if($pos === false):
			$typeName = $type;
			$length   = 0;
		else:
			$typeName = substr($type, 0, strpos($type,'('));
			$length   = substr($type, (strpos($type,'(') + 1), -1);
		endif;

		// Si el tipo de dato no es valido para el campo, retornamos falso
		switch($typeName){
			case "int":
				// strlen funciona bien para contar la cantidad de caracteres aunque sean numeros
				if(is_numeric($value) && strlen($value)<=$length): 
					return $value;
				elseif($null == 'NULL'):
					return $default;
				endif;
				// Si no valido el tipo y largo retornamos falso
				Error::Alert('El campo '.$key.' no es valido. Se esperaba un '.$type);
				return false;
			break;
			case "tinyint":
				// strlen funciona bien para contar la cantidad de caracteres aunque sean numeros
				if(is_numeric($value) && strlen($value)<=$length): 
					return $value;
				endif;
				// Si no valido el tipo y largo retornamos falso
				Error::Alert('El campo '.$key.' no es valido. Se esperaba un '.$type);
				return false;
			break;
			case "varchar":
				if(is_string($value) && strlen($value)<=$length):
					if($null == 'NOT NULL' && strlen($value)!=0):
						return $value;
					elseif($null == 'NULL'):
						return $value;
					endif;
				endif;
				Error::Alert('El campo '.$key.' no es valido. Se esperaba un '.$type);
				return false;
			break;
			/* 
				IMPORTANTE!
				El tipo url no es valido de MySQL, es un varchar
				Utilizamos este tipo para generar url amistosas
				reemplazando espacios y caracteres raros
			*/
			case "url":
				if(is_string($value) && strlen($value)<=$length):
					if($null == 'NOT NULL' && strlen($value)!=0):
						return Util::friendlyURL(utf8_encode($value));
					elseif($null == 'NULL'):
						return Util::friendlyURL(utf8_encode($value));
					endif;
				endif;
				Error::Alert('El campo '.$key.' no es valido. Se esperaba un '.$type);
				return false;
			break;
			case "text":
				if(is_string($value)):
					if($null == 'NOT NULL' && strlen($value)!=0):
						return $value;
					elseif($null == 'NULL'):
						return $value;
					endif;
				endif;
				Error::Alert('El campo '.$key.' no es valido. Se esperaba un '.$type);
				return false;
			break;
			case "datetime":
				return $value;
			break;
			case "date":
				return $value;
			break;
			case "time":
				return $value;
			break;
			default:
				return false;
			break;
			// Agregar mas tipos, solo dejo los que mas usamos
		}
	}
	
	/*
		NO SE USA
		autoCompleteFields retorna un array con todos los campos de un registro
		se completan los que faltan con los default de la base
	*/
	public static function autoCompleteFields($structure, $fields, $table)
	{
		$return = array();
		$tableFields = $structure[$table]['fields'];
		foreach($tableFields as $key=>$value):
			if(array_key_exists($key, $fields)):
				$return[$key] = $fields[$key];
			else:
				$return[$key] = self::validateField($structure, $key, $value['default'], $table);
			endif;
		endforeach;
		return $return;
	}
	
	




	/* FUNCTION CREATE TABLE */
	public static function parsecreateTable($structure)
	{
		//self::table_exists($structure, $table);
		$sql = '';
		foreach($structure as $tableName=>$table):
			if(isset($table['virtual']) && $table['virtual']==1):
				continue;
			endif;
			if(!self::tableExists($tableName)):
				$primary_key = self::parsePrimaryKey($structure, $tableName);
				$sql =" CREATE TABLE `".$tableName."` (" . "\n";
				foreach($table["fields"] as $key=>$value):
					if(strpos($value["type"],'url')!==false):
						$type = 'varchar'.substr($value['type'],3,5);
					elseif(strpos($value["type"],'password')!==false):
						$type = 'varchar'.substr($value['type'],8,5);
					else:
						$type = $value['type'];
					endif;

					$sql.="`".$key."` " . $type . " ";
					$sql.= $value["null"] ." ";
		
					/*
					if(is_numeric($value["default"])):
						$sql.= " default ".$value["default"]." ";
					elseif($value["default"]!==false):
						$sql.= " default '".$value["default"]."' ";
					endif;
					*/
					if($key != $primary_key):
						$sql.= (($value["default"]!==false)? " default '".$value["default"]."' ":'') . " ";
					endif;
					$sql.= ((isset($value["extra"]))?$value["extra"]:"") . ", " . "\n";
				endforeach;
				if($primary_key):
					$sql.= "PRIMARY KEY (`".$primary_key."`)";
				else:
					$sql = substr($sql, 0, strlen($sql)-3);
				endif;
		
				// Indices
				if(is_array($table['indexes']) && isset($table['indexes'][0]['index_name'])):
					$sql .= ", \n";
					foreach($table['indexes'] as $index):
						$sql .= $index['index_type']. " KEY `".$index['index_name']."` (";
						foreach($index['fields_name'] as $fieldname):
							$sql .= "`".$fieldname."`,";
						endforeach;
						$sql = substr($sql, 0, strlen($sql)-1);
						$sql .= "), \n";
					endforeach;
					$sql = substr($sql, 0, strlen($sql)-3) . " \n";
				else:
					$sql .= "\n";
				endif;
				$sql.=") ENGINE = MYISAM DEFAULT CHARSET=".$table['charset']."; ";
			
				Module::exec($sql);
			endif;
		endforeach;
	}


	public static function tableExists($table){
		try{
			$sql = "SELECT * FROM ".$table." LIMIT 1";
			Module::custom($sql);
			echo "tabla: '".$table."' existe.<br/>";
			return true;
		}
		catch(Exception $e){
			return false;
		}
	}

	public static function table_exists($structure, $table){
		//echo $table;
		//if(!array_key_exists($table, $structure)): Error::Alert('The table '.$table.' is not valid'); endif;

		if(!array_key_exists($table, $structure)): 
			return false;
		else:
			return true;
		endif;
	}



	/* Nuevos metodos para uso de objetos genericos */
	public static function parseFieldsFromObjects($objects, $table, $struture, $objectFields)
	{
		self::object_walk_recursive($objects, $table, $struture, $objectFields);

		$local = array();
		//util::debug($objects);
		//die();
		
			foreach($objects as $object){
				if(!empty($object['object_custom'])){
					
					$cus = $object['object_custom'];
					$arr = unserialize($cus);
					$arr = str_replace("<1>", "'", $arr);
					$arr = str_replace('<2>', '"', $arr);


					foreach($arr as $objkey=>$objvalue){
						$object[$objkey] = $objvalue;
					}
					unset($object['object_custom']);
				}
				array_push($local, $object);
			}

		//self::object_walk_recursive($local, $table, $struture, $objectFields);
		return $local;
	}

	public static function replace_keys(&$value, &$key, $table, $struture, $objectFields)
	{
		foreach($objectFields as $objectKey=>$itemKey):
			if($objectKey==$key):
				//$key = ($struture[$table]["fields"][$itemKey]['xml']=='attribute') ? $struture[$table]["fields"][$itemKey]['alias'].'-att' : $struture[$table]["fields"][$itemKey]['alias'];
				
				switch($struture[$table]["fields"][$itemKey]['xml']):
					case "attribute":
						$key = $struture[$table]["fields"][$itemKey]['alias'].'-att';
						break;
					case "nodes":
						$key = $struture[$table]["fields"][$itemKey]['alias'].'-xml';
						break;
					default:
						$key = $struture[$table]["fields"][$itemKey]['alias'];
						break;
				endswitch;
			endif;
		endforeach;
	}

	private static function object_walk_recursive(&$input, $table, $struture, $objectFields)
	{
		foreach ($input as $key => $value):
			if (is_array($input[$key])):
				self::object_walk_recursive($input[$key], $table, $struture, $objectFields);
			else:
				$saved_value = $value;
				$saved_key = $key;
				self::replace_keys($value, $key, $table, $struture, $objectFields);
				if($value !== $saved_value || $saved_key !== $key):
					unset($input[$saved_key]);
					$input[$key] = $value;
				endif;
			endif;
		endforeach;
		return true;
	}
	
	public static function serialize($array)
	{
		$return = array();
		foreach($array as $key=>$value):
			$newvalue = stripslashes($value);
			$newvalue = str_replace('"', '<2>', $newvalue);
			$newvalue = str_replace("'", "<1>", $newvalue);
			$return[$key] = $newvalue;
		endforeach;
		return serialize($return);
	}

	//public static function inputObjectFields($fields, $table, $tables, $object_typeid=false, $objectFields, $verbose=false)
	public static function inputObjectFields($options)
	{
		$defaults = array(
			'fields'        => false, 
			'table'         => false, 
			'tables'        => false,
			'object_typeid' => false, 
			'objectFields'       => false,
			'multimedia_typeid'  => false,
			'verbose'       => false
		);

		$options = Util::extend($defaults,$options);
		
		unset($options['fields']['modToken']);//remove generated security form token

		$object = array();
		$custom = array();

		foreach($options['fields'] as $key=>$value):
			if(in_array($key, $options['objectFields'])):
				$objectField = array_search($key, $options['objectFields']);
				$object[$objectField] = $value;
			else:
				$custom[$key] = $value;
			endif;
		endforeach;

		$custom = self::parseInputFields($options['tables'], $custom, $options['table'], $options['verbose'], $custom=true);

		$customArray  = array();
		foreach($custom as $customKey=>$customValue):
			$customField = self::parseCustomField($options['tables'], $customKey, $options['table']); //self::getCustomField($customKey, $table);
			$customArray[$customField] = $customValue;
		endforeach;
		
		if($options['object_typeid'] !== false):
			$object['object_typeid'] = $options['object_typeid'];
		endif;

		if($options['multimedia_typeid'] !== false):
			$object['multimedia_typeid'] = $options['multimedia_typeid'];
		endif;

		if(!empty($customArray)):
			$object['object_custom'] = self::serialize($customArray);
		endif;

		
		return $object;
		//return self::parseInputFields($options['tables'], $object, 'object', $options['verbose'], $custom=false);
	}

	public static function inputFields($tables, $fields, $table, $verbose)
	{
		return self::parseInputFields($tables, $fields, $table, $verbose, $custom=false);
	}


}

?>
