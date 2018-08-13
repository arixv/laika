<?php
class Sindicato extends Module
{
	public $content;
	public $xmlContent;
	

	// Get Entities and people related
	public static function getList($options = array())
	{
		$fields = array('*');
		$fields = Model::parseFields(SindicatoModel::$tables, $fields, SindicatoModel::$table);

		$params = array(
				'fields'  => $fields,
				'table'   => SindicatoModel::$table,
				'orderby' => 'name ASC',
		);

		if(isset($options['sort'])){
			$params['orderby']=$options['sort'].' '.$options['ordering'];
		}		

		$return = self::select($params,0);
		
		$return['tag'] = 'sindicato';
		return $return;
	}


	public static function getListJSON($parent = false)
	{
		if(is_numeric($parent)):
			$params = array(
				'fields'=>array(
					'id as id',
					'name as name',
				),
				'table'=>SindicatoModel::$table,
				'filters'=>array(),
				'orderby'=>"name ASC"
			);
			
			$result = module::select($params);
			$return["result"] = $result;
			$json = json_encode($return);
			return $json;
		endif;
	}

	public static function getListAsString($parentId = '0')
	{

			$ReturnString = $parentId.",";
			$fields = Model::parseFields(SindicatoModel::$tables, array('*'), SindicatoModel::$table);

			$params = array(
					'fields'  => $fields,
					'table'   => SindicatoModel::$table,
					'orderby' => 'id DESC',
					'filters' => array("parent_id=".$parentId)
			);
			$result = self::select($params);

			foreach($result as $key=>$val){
					$ReturnString .= $val['id-att'] . ",";	
			}
			$ReturnString = substr($ReturnString,0,strlen($ReturnString)-1);
			return $ReturnString;
	}

	public static function getStringRecursively($arr = array())
	{
		
		$ReturnString = '';

		if(is_array($arr))
		{
			if(isset($arr['id-att'])){
				$ReturnString .= $arr['id-att'] . ",";	
			}

			if (isset($arr['parent']) && is_array($arr['parent'])) 
			{
                $ReturnString .= self::getStringRecursively($arr['parent']);
        	}else {
        		$ReturnString = substr($ReturnString,0,strlen($ReturnString)-1);
        	}
			
		}
		

		return $ReturnString;
	}



	
	public static function getHighlights($parentId = '0')
	{
		$fields = array('*');
		$fields = Model::parseFields(SindicatoModel::$tables, $fields, SindicatoModel::$table);

		$params = array(
				'fields'  => $fields,
				'table'   => SindicatoModel::$table,
				'orderby' => 'name ASC',
				'filters' => array()
		);


		$return = self::select($params);
		
		$return['tag'] = 'sindicato';
		return $return;
	}


	// Get by id
	public static function getById($id=false,$parent = false){
		if($id){
			$fields = array('*');
			//$fields = SindicatoModel::getFields($fields, SindicatoModel::$table);
			$modelReflection = new ReflectionClass('SindicatoModel');
			$fields = Model::parseFields($modelReflection->getStaticPropertyValue('tables'), $fields, $modelReflection->getStaticPropertyValue('table'));

			$params = array(
				'fields'=>$fields,
				'table'   => SindicatoModel::$table,
				'filters' => array('id='.$id)
			);
			$result = self::select($params,false);
			
			if(isset($result[0])):
				$Sindicato =$result[0];
				return $Sindicato;
			else:
				return false;
			endif;
		}
	}

	// Get by Name
	public static function GetByName($name=false,$parent=false)
	{
		if($name!== false):

			$fields = Model::parseFields(SindicatoModel::$tables, array('*'), SindicatoModel::$table);

			$params = array(
				'table'   => SindicatoModel::$table, 
				'filters' => array("name='$name'"), 
				'fields'  => $fields
			);

			if($parent):
				$params['filters'][]='parent_id='.$parent;
			endif;



			$r = self::select($params,1);
			if(isset($r[0])):
				$categoria = $r[0];
				return $categoria;
			else:
				return false;
			endif;
		else:
			return false;
		endif;
	}

	

	public static function create($DTO)
	{
		$fields = array();
		$fields = SindicatoModel::parseInputFields(SindicatoModel::$tables, $DTO, SindicatoModel::$table, true);

		$params = array(
			'fields' => $fields,
			'table'  => SindicatoModel::$table
		);
		$r = self::insert($params);
		return $r;
	}


	//Update
	public static function edit($data=array()){


		if(is_array($data))
		{
			$fields = array();
			$fields = SindicatoModel::parseInputFields(SindicatoModel::$tables, $data, SindicatoModel::$table, $verbose=false);
			
			$params = array(
				'fields'=>$fields,
				'table'=>SindicatoModel::$table,
				'filters'=>array(
					'id='.$fields['id']
				)
			);
			$return = self::update($params);
			return $return;
		}
		else
		{
			return false;
		}

	}

	//Delete
	public static function remove($id=false)
	{
		if($id){

			//Delete rubro
			$r = parent::delete(array(
				'table'  => SindicatoModel::$table,
				'filters'=> array('id='.$id),
			));

			return $r;
		}
	}


}

?>