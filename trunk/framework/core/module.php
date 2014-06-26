<?php
class Module{

	protected static $db;
	public static $debug = false;

	public static function initDB()
	{
		self::$db = new DBManager();
	}

	public static function closeDB()
	{
		self::$db = null;
	}

	public static function insert($array, $debug=false)
	{
		self::initDB();
		if($debug) {
			self::$db->debug=true; 
			self::StrQuery();
		}
		$r = self::$db->insert($array);
		self::closeDB();
		return $r;
	}

	public static function insertupdate($params,$debug=false){
		self::initDB();
		if($debug): self::$db->debug=true; endif;
		$r = self::$db->insertupdate($params);
		self::closeDB();
		return $r;		
	}

	public static function select($array, $debug=false)
	{
		self::initDB();
		if($debug){
			self::$db->debug=true; 
			self::StrQuery();
		}
		$r = self::$db->select($array);
		self::closeDB();
		return $r;
	}

	public static function update($array, $debug=false)
	{
		self::initDB();
		if($debug) {
			self::$db->debug=true; 
			self::StrQuery();
		}
		$r = self::$db->update($array);
		self::closeDB();
		return $r;
	}

	public static function delete($array, $debug=false)
	{
		self::initDB();
		if($debug) {
			self::$db->debug=true; 
			self::StrQuery();
		}
		$r = self::$db->delete($array);
		self::closeDB();
		return $r;
	}

	public static function custom($string, $debug=false)
	{
		self::initDB();
		if($debug) {
			self::$db->debug=true; 
			self::StrQuery();
		}
		$r = self::$db->customquery($string);
		self::closeDB();
		return $r;
	}

	public static function exec($sql, $debug=false)
	{
		self::initDB();
		if($debug) {
			self::$db->debug=true; 
			self::StrQuery();
		}
		$r = self::$db->customexec($sql);
		self::closeDB();
	}

	public static function customdelete($string, $debug=false)
	{
		self::initDB();
		if($debug) {
			self::$db->debug=true; 
			self::StrQuery();
		}
		$r = self::$db->customdeletequery($string);
		self::closeDB();
	}

	private static function StrQuery()
	{
		$x = debug_backtrace();
		Util::debug($x[2]['class'].'::'.$x[2]['function'].' => '.$x[1]['class'].'::'.$x[1]['function']."\n");
	}




	/*
		Este metodo toma el xml de configuración
		del modulo que se está ejecuntando y retorna
		el path del repositorio xml
	*/
	public static function getRepositoryPath()
	{
		$x   = debug_backtrace();
		//$mod = ConfigurationManager::GetModuleConfiguration(basename(dirname(dirname($x[0]['file']))));
		$repositoryConfig = ConfigurationManager::Query("/configuration/modules/module[@name='".basename(dirname(dirname($x[0]['file'])))."']/options/folders/repository");
		$directory = $_SERVER['DOCUMENT_ROOT'].'/'.$repositoryConfig->item(0)->nodeValue.'/';
		return $directory;
	}
	
	/*
		Este metodo toma el xml de configuración
		del modulo que se está ejecuntando y retorna
		el path del directorio donde guardar los archivos
	*/
	public static function getFilesDir()
	{
		$x   = debug_backtrace();
		$mod = ConfigurationManager::GetModuleConfiguration(basename(dirname(dirname($x[0]['file']))));
		$repositoryConfig = ConfigurationManager::Query("/configuration/modules/module[@name='".basename(dirname(dirname($x[0]['file'])))."']/options/folders/source");
		$directory = $_SERVER['DOCUMENT_ROOT'].'/'.$repositoryConfig->item(0)->nodeValue.'/';
		return $directory;
	}

	/*
		Este metodo recibe el xml que hay que guardar
		y el path.
		Se ocupa de guardar el archivo fisico con los datos.
	*/
	public static function generateXMLFile($xml, $path)
	{
		if (!$handle = fopen($path, 'w+')) {
			echo "Cannot open file ($path)";
			exit;
		}

		// Write $somecontent to our opened file.
		if (fwrite($handle, $xml) === FALSE) {
			echo "Cannot write to file ($path)";
			exit;
		}
		fclose($handle);
	}





}