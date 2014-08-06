<?php
class Rubro extends Module
{
	public $content;
	public $xmlContent;
	

	// Get Entities and people related
	public static function getList($options = array())
	{
		$fields = array('*');
		$fields = Model::parseFields(RubroModel::$tables, $fields, RubroModel::$table);

		$params = array(
				'fields'  => $fields,
				'table'   => RubroModel::$table,
				'orderby' => 'title ASC',
		);

		if(isset($options['parent'])):
			$params["filters"][] = "parent_id=". $options['parent'];
		endif;

		
		$return = self::select($params,0);
		

		if(isset($options['subrubros']) && $options['subrubros'] == 1):
			foreach($return as $key=>$value)
			{
				$subRubros = self::getList(array(
					"parent"=>$value["id-att"],
					"subrubros"=>0
				));
				if(is_array($subRubros) && count($subRubros)>1){
					$return[$key]["rubros"] = $subRubros;
				}
			}
		endif;

		$return['tag'] = 'rubro';
		return $return;
	}


	public static function getListJSON($parent = false)
	{
		if(is_numeric($parent)):
			$params = array(
				'fields'=>array(
					'id as id',
					'rubro_name as name',
					'parent_id as parent'
				),
				'table'=>'rubro',
				'filters'=>array(
					'parent_id='.$parent
				),
				'orderby'=>"rubro_name ASC"
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
			$fields = Model::parseFields(RubroModel::$tables, array('*'), RubroModel::$table);

			$params = array(
					'fields'  => $fields,
					'table'   => RubroModel::$table,
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
		//cache key
		//$cacheKey = 'categories.highlight.'.$parentId;
		//$cacheFolder = "categories";

		//if(!($return = Cache::getKey($cacheKey, $cacheFolder))):
				$fields = array('*');
				$fields = Model::parseFields(RubroModel::$tables, $fields, RubroModel::$table);

				$params = array(
						'fields'  => $fields,
						'table'   => RubroModel::$table,
						'orderby' => 'rubro_name ASC',
						'filters' => array(
							"parent_id in (select id from rubro where parent_id = ".$parentId.")",
							"rubro_highlight=1"
						)
				);


				$return = self::select($params);
				
				$return['tag'] = 'rubro';
				//$expires = (86400 * 30) * 3; // 3 meses
				//Cache::setKey($cacheKey, $return, $expires, $cacheFolder);
		//endif;
		return $return;
	}


	// Get by id
	public static function getById($id=false,$parent = false){
		if($id){
			$fields = array('*');
			//$fields = RubroModel::getFields($fields, RubroModel::$table);
			$modelReflection = new ReflectionClass('RubroModel');
			$fields = Model::parseFields($modelReflection->getStaticPropertyValue('tables'), $fields, $modelReflection->getStaticPropertyValue('table'));

			$params = array(
				'fields'=>$fields,
				'table'   => RubroModel::$table,
				'filters' => array('id='.$id)
			);
			$result = self::select($params,false);
			
			if(isset($result[0])):
				$Rubro =$result[0];
				
				if($parent):
					$params['filters']=array('id='.$Rubro["parent-att"]);
					$result = self::select($params,false);
					if(isset($result[0])):
						$Rubro["parent"] = $result[0];
					endif;
				endif;

				return $Rubro;
			else:
				return false;
			endif;
		}
	}

	// Get tree
	public static function getParentsById($id, $level=false){
		if($id){
			$fields = array('*');
			//$fields = RubroModel::getFields($fields, RubroModel::$table);
			$modelReflection = new ReflectionClass('RubroModel');
			$fields = Model::parseFields($modelReflection->getStaticPropertyValue('tables'), $fields, $modelReflection->getStaticPropertyValue('table'));

			$params = array(
				'table'   => $modelReflection->getStaticPropertyValue('table'),
				'filters' => array('id='.$id), 'fields'=>$fields
			);
			$r = self::select($params);

			if(is_array($r) && !empty($r)):
				$categoria = $r[0];
				if($categoria['parent-att'] != 1 && $level != 1):
					$categoria['parent'] = self::getParentsById($categoria['parent-att'],$level-1);
				endif;			
				return $categoria;
			else:
				return false;
			endif;
			
			
		}
	}

	// Get by Url
	public static function getByUrl($url=false){
		if($url){
			$fields = array('*');
			$fields = RubroModel::getFields($fields, RubroModel::$table);
			$params = array('table'=>RubroModel::$table, 'filters'=>array('rubro_url="'.$url . '"'), 'fields'=>$fields);
			$r = self::select($params);
			if(!empty($r)){
				$categoria = $r[0];
				return $categoria;
			}else {
				return false;
			}
		} else {
			return false;
		}
	}

	// Get by Name
	public static function GetByName($name=false,$parent=false)
	{
		if($name!== false):

			$fields = Model::parseFields(RubroModel::$tables, array('*'), RubroModel::$table);

			$params = array(
				'table'   => RubroModel::$table, 
				'filters' => array("rubro_name='$name'"), 
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

	public static function getSubCategorias($categoriaId){
		$fields = array('*');
		$fields = RubroModel::parseFields(RubroModel::$tables, $fields, RubroModel::$table);
		$params = array(
					'fields'=>$fields,
					'table'=>RubroModel::$table,
					'orderby'=>'id DESC',
					'filters'=>array("parent_id=".$categoriaId)
		);
		$r = self::select($params);
		if(!empty($r)){
			foreach($r as $key=>$value)
			{
				$subCategorias = self::getSubCategorias($value["id-att"]);
				if(is_array($subCategorias)){
				$r[$key]["categorias"] = $subCategorias;
				}
			}
			$r['tag'] = 'categoria';
			return $r;
		}
		else return false;
	}




	public static function create($DTO)
	{
		$fields = array();
		$fields = RubroModel::parseInputFields(RubroModel::$tables, $DTO, RubroModel::$table, true);

		$params = array(
			'fields' => $fields,
			'table'  => RubroModel::$table
		);
		$r = self::insert($params);
		return $r;
	}


	public static function import($DTO)
	{
		echo '<p>Importing Rubro<p>';

		$rubro = self::getByName($DTO['rubro_name'],$DTO['parent_id']);

		if($rubro == false):

			$params = array(
				'fields' => array(
					'parent_id'=>$DTO['parent_id'],
					'rubro_name'=>$DTO['rubro_name']
				),
				'table'  => RubroModel::$table
			);

			Util::debug($params);
			
			$r = self::insert($params);
			return $r;
		else:
			return $rubro['id-att'];
		endif;
	}

	//Update
	public static function edit($data=array()){


		if(is_array($data))
		{
			$fields = array();
			$fields = RubroModel::parseInputFields(RubroModel::$tables, $data, RubroModel::$table, $verbose=false);
			
			$params = array(
				'fields'=>$fields,
				'table'=>RubroModel::$table,
				'filters'=>array(
					'id='.$fields['id']
				)
			);
			$return = self::update($params);

			// Borramos el cache
			/* Sin cache por ahora
			$cacheKey = 'categorias.'.$data['parent_id'];
			$cacheFolder = 'categorias';
			Cache::deleteKey($cacheKey, $cacheFolder);
			$cacheKey = 'categorias.'.$data['id'];
			$cacheFolder = 'categorias';
			Cache::deleteKey($cacheKey, $cacheFolder);
			*/

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
				'table'  => RubroModel::$table,
				'filters'=> array('id='.$id),
			));

			//Delete subrubros
			parent::delete(array(
				'table'  => RubroModel::$table,
				'filters'=> array('parent_id='.$id)
			));


			//Delete rubro from project
			parent::delete(array(
				'table'  => 'project_rubro',
				'filters'=> array('rubro_id='.$id)
			));
			
			//Delete subrubro from project
			parent::delete(array(
				'table'  => 'project_resource',
				'filters'=> array('subrubro_id='.$id)
			));


			//Delete subrubro payments
			parent::delete(array(
				'table'  => 'project_resource_payments',
				'filters'=> array('subrubro_id='.$id)
			));

			return $r;
		}
	}


}

?>