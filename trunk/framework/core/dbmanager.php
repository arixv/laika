<?php

class DBManager extends PDO
{

	public $db;
	public $debug = false;
	public static $queryStr;


	public function __construct() {
		$attrs = array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8");

		//$attrs = array();
		$configDB = ConfigurationManager::GetDatabaseConnection();

		parent::__construct($configDB['dns'], $configDB['user'], $configDB['pass'], $attrs );
		$this->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

		// Para corregir la hora de dreamhost (es en relacion al Meridiano de Greenwich, no a la hora de dreamhost)
		$this->query("SET time_zone = '-3:00'");

	}
	

	public function getDB(){
		return new DBManager();
	}
	
	public function setTable($table){
		$this->table = $table;
	}
	
	
	public function select($data) {

		$params = (object) $data;
		$orderby   =   (isset($params->orderby))?$params->orderby:false;
		$groupby   =   (isset($params->groupby))?$params->groupby:false;
		$limit     =   (isset($params->limit))?$params->limit:false;
		$exclusive =   (isset($params->exclusive))?false:true;
		$campos="SELECT ";
		if (isset($params->fields) && is_array($params->fields) && count($params->fields)) {
			foreach ($params->fields as $field) {
				$campos.=$field.", ";
		}
			$campos=substr($campos,0,strlen($campos)-strlen(", "));
		} else {
			$campos.="* ";
		}
		$campos.=" FROM $params->table ";

		if (isset($params->filters) && is_array($params->filters) && count($params->filters)) {
			$campos.=" WHERE ";
			foreach($params->filters as $filter) {
				$campos.="$filter ";
				if ($exclusive)
					$campos.="and ";
				else
					$campos.="or ";
		}
			$campos=substr($campos,0,strlen($campos)-strlen(" and"));
		}
		if ($groupby) {
			$campos.=" GROUP BY $groupby ";
		}
		if ($orderby) {
			$campos.=" ORDER BY $orderby ";
		}
		if ($limit) {
			$campos.=" LIMIT $limit";
		}

		
		if($this->debug):
			Util::debug($campos);
		endif;

		self::$queryStr = $campos;

		$str = $this->prepare($campos);
		//$str = $this->prepare("SELECT :campos");
		//$str->bindParam(":campos", $params->fields);
		//$str->bindParam(":campos", $params->fields);
		//$this->debug($str);
		$str->execute();
		return $str->fetchAll(PDO::FETCH_ASSOC);
	}


	// Nuevo Insert
	public function insert($data)
	{
		$params = (object) $data;
		$sql="insert into $params->table (";
		if (isset($params->fields) && is_array($params->fields) && count($params->fields)) {
			foreach ($params->fields as $field=>$value) {
				$sql.=$field.", ";
			}
			$sql=substr($sql,0,strlen($sql)-strlen(", "));
			$sql.=") values (";
			foreach ($params->fields as $field=>$value)
			{
				if (!(is_numeric($value)) && $value!='now()'){
					$sql.="?, ";
				}
				elseif($value==='now()'){
					$sql.="now(), ";
				}else{
					$sql.=$value.", ";
				}
			}
			//$sql=substr($sql,0,strlen($sql)-strlen(", "));
			$sql = rtrim($sql, ', ');
			$sql.=")";
		} else {
			return false;
		}

		if($this->debug) Util::debug($sql);
		self::$queryStr = $sql;

		if($sql){
			$str = $this->prepare($sql);
			//$this->query('SET NAMES utf8');
			$bind = array();
			foreach($params->fields as $field=>$value){
				if (!(is_numeric($value)) && $value!='now()'){
					$value = trim($value,"\'");
					//$str->bindValue($field, $value, PDO::PARAM_STR);
					array_push($bind, $value);
				}
			}
			$str->execute($bind);
			//$str->debugDumpParams();
			return $this->lastInsertId();
		}
	}


	public function insertupdate($data){

		$params = (object) $data;
		$sql="INSERT INTO $params->table (";
        if (isset($params->fields) && is_array($params->fields) && count($params->fields)) {
            foreach ($params->fields as $field=>$value) {
                $sql.=$field.", ";
            }
            $sql=substr($sql,0,strlen($sql)-strlen(", "));
            $sql.=") values (";
            foreach ($params->fields as $field=>$value)
            {
                if (!(is_numeric($value)) && $value!='now()')
                    $value=$this->quote($value);
                $sql.=$value.", ";
            }
            $sql=substr($sql,0,strlen($sql)-strlen(", "));
            $sql.=")";
            $sql.=" ON DUPLICATE KEY UPDATE " . $params->update;

        } else {
            return false;
        }

		if($this->debug) Util::debug($sql);

		if($sql){
			$str = $this->prepare($sql);
			$str->execute();
			return $this->lastInsertId();
		}
	}
	

	// New Update
	public function update($data)
	{
		$params = (object) $data;
		$exclusive =   (isset($params->exclusive))?false:true;
		$sql="update $params->table set ";
			if (isset($params->fields) && is_array($params->fields) && count($params->fields)) {
				foreach ($params->fields as $field=>$value)
				{
					if (!(is_numeric($value)) && $value!='now()'){
						$sql.="$field=?, ";
					}
					elseif($value==='now()'){
						$sql.="$field=now()";
					}else{
						$sql.="$field=$value, ";
					}
				}
				$sql = rtrim($sql, ', ');
			} else {
				return false;
			}
			if (isset($params->filters) && is_array($params->filters) && count($params->filters)) {
				$sql.=" where ";
				foreach($params->filters as $filter) {
					$sql.="$filter ";
					if ($exclusive)
						$sql.="and ";
					else
						$sql.="or ";
				}
				$sql=substr($sql,0,strlen($sql)-($exclusive?strlen(" and"):strlen(" or")));
			}

			if($this->debug) Util::debug($sql);
			self::$queryStr = $sql;
			
			$str = $this->prepare($sql);
			//$this->query('SET NAMES utf8');
			$bind = array();
			foreach($params->fields as $field=>$value){
				if (!(is_numeric($value)) && $value!='now()'){
					$value = trim($value,"\'");
					//$str->bindValue($field, $value, PDO::PARAM_STR);
					array_push($bind, $value);
				}
			}
			return $str->execute($bind);
	}

	public function delete($data){
		$params = (object) $data;
		$exclusive =   (isset($params->exclusive))?false:true;
		$sql="delete from $params->table ";
        if (isset($params->filters) && is_array($params->filters) && count($params->filters)) {
            $sql.=" where ";
            foreach($params->filters as $filter) {
                $sql.="$filter ";
				if ($exclusive)
                    $sql.="and ";
                else
                    $sql.="or ";
            }
            $sql=substr($sql,0,strlen($sql)-strlen(" and"));
        } else {
            //return false;
        }
		if($this->debug) Util::debug($sql);
		self::$queryStr = $sql;
		$str = $this->prepare($sql);
		return $str->execute();
	}

	public function callprocedure($name){
		/*
		$conn = ConfigurationManager::GetDatabaseConnection ();
		$conn->Begin ();

		$stmt = $conn->Prepare ( 'CALL "'.$name.'"(:titulo, :copete, :cuerpo, :privado)' );
		*/
	}

	public function customquery($sql_query,$sql_values,$debug=false)
	{
		self::$queryStr = $sql_query;
		if($debug): 
			Util::debug($sql_query);
			Util::debug($sql_values);
		endif;

		$str = $this->prepare($sql_query);
		$str->execute($sql_values);
		$return = $str->fetchAll(PDO::FETCH_ASSOC);

		return $return;

	}
	
	public function customexec($sql){
		self::$queryStr = $sql;
		if($this->debug) Util::debug($sql);
		$str = $this->prepare($sql);
		$str->execute();
		//return $str->fetchAll(PDO::FETCH_ASSOC);
	}
	
	public function customdeletequery($sql){
		self::$queryStr = $sql;
		$str = $this->prepare($sql);
		$str->execute();
	}



}

?>