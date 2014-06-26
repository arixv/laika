<?php
class Category extends Module
{
	public $content;
	public $xmlContent;
	

	// Get Entities and people related
	public static function getList($parentId = '0',$orderby=false)
	{
		//cache key
		$cacheKey = 'categories.parent.'.$parentId;
		$cacheFolder = "categories";

		//if(!($return = Cache::getKey($cacheKey, $cacheFolder))):
				$fields = array('*');
				$fields = Model::parseFields(CategoryModel::$tables, $fields, CategoryModel::$table);

				$params = array(
						'fields'  => $fields,
						'table'   => CategoryModel::$table,
						'orderby' => ($orderby!==false)?$orderby:'category_id DESC',
						'filters' => array("category_parent=".$parentId)
				);
				$return = self::select($params);

				foreach($return as $key=>$value)
				{
					$subCategorias = self::getList($value["category_id-att"]);
					if(is_array($subCategorias) && count($subCategorias)>1){
						$return[$key]["categories"] = $subCategorias;
					}
				}
				$return['tag'] = 'category';
				//$expires = (86400 * 30) * 3; // 3 meses
				//Cache::setKey($cacheKey, $return, $expires, $cacheFolder);
		//endif;
		return $return;
	}


	public static function getListJSON($parent = false)
	{
		if(is_numeric($parent)):
			$params = array(
				'fields'=>array(
					'category_id as id',
					'category_name as name',
					'category_parent as parent'
				),
				'table'=>'category',
				'filters'=>array(
					'category_parent='.$parent
				),
				'orderby'=>"category_name ASC"
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
			$fields = Model::parseFields(CategoryModel::$tables, array('*'), CategoryModel::$table);

			$params = array(
					'fields'  => $fields,
					'table'   => CategoryModel::$table,
					'orderby' => 'category_id DESC',
					'filters' => array("category_parent=".$parentId)
			);
			$result = self::select($params);

			foreach($result as $key=>$val){
					$ReturnString .= $val['category_id-att'] . ",";	
			}
			$ReturnString = substr($ReturnString,0,strlen($ReturnString)-1);
			return $ReturnString;
	}

	public static function getStringRecursively($arr = array())
	{
		
		$ReturnString = '';

		if(is_array($arr))
		{
			if(isset($arr['category_id-att'])){
				$ReturnString .= $arr['category_id-att'] . ",";	
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
				$fields = Model::parseFields(CategoryModel::$tables, $fields, CategoryModel::$table);

				$params = array(
						'fields'  => $fields,
						'table'   => CategoryModel::$table,
						'orderby' => 'category_name ASC',
						'filters' => array(
							"category_parent in (select category_id from category where category_parent = ".$parentId.")",
							"category_highlight=1"
						)
				);


				$return = self::select($params);
				
				$return['tag'] = 'category';
				//$expires = (86400 * 30) * 3; // 3 meses
				//Cache::setKey($cacheKey, $return, $expires, $cacheFolder);
		//endif;
		return $return;
	}


	// Get by id
	public static function getById($id=false,$parent = false){
		if($id){
			$fields = array('*');
			//$fields = CategoryModel::getFields($fields, CategoryModel::$table);
			$modelReflection = new ReflectionClass('CategoryModel');
			$fields = Model::parseFields($modelReflection->getStaticPropertyValue('tables'), $fields, $modelReflection->getStaticPropertyValue('table'));

			$params = array(
				'fields'=>$fields,
				'table'   => CategoryModel::$table,
				'filters' => array('category_id='.$id)
			);
			$result = self::select($params,false);
			
			if(isset($result[0])):
				$Category =$result[0];
				
				if($parent):
					$params['filters']=array('category_id='.$Category["parent-att"]);
					$result = self::select($params,false);
					if(isset($result[0])):
						$Category["parent"] = $result[0];
					endif;
				endif;

				return $Category;
			else:
				return false;
			endif;
		}
	}

	// Get tree
	public static function getParentsById($id, $level=false){
		if($id){
			$fields = array('*');
			//$fields = CategoryModel::getFields($fields, CategoryModel::$table);
			$modelReflection = new ReflectionClass('CategoryModel');
			$fields = Model::parseFields($modelReflection->getStaticPropertyValue('tables'), $fields, $modelReflection->getStaticPropertyValue('table'));

			$params = array(
				'table'   => $modelReflection->getStaticPropertyValue('table'),
				'filters' => array('category_id='.$id), 'fields'=>$fields
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
			$fields = CategoryModel::getFields($fields, CategoryModel::$table);
			$params = array('table'=>CategoryModel::$table, 'filters'=>array('category_url="'.$url . '"'), 'fields'=>$fields);
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

			$fields = Model::parseFields(CategoryModel::$tables, array('*'), CategoryModel::$table);

			$params = array(
				'table'   => CategoryModel::$table, 
				'filters' => array("category_name='$name'"), 
				'fields'  => $fields
			);

			if($parent):
				$params['filters'][]='category_parent='.$parent;
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
		$fields = CategoryModel::parseFields(CategoryModel::$tables, $fields, CategoryModel::$table);
		$params = array(
					'fields'=>$fields,
					'table'=>CategoryModel::$table,
					'orderby'=>'category_id DESC',
					'filters'=>array("category_parent=".$categoriaId)
		);
		$r = self::select($params);
		if(!empty($r)){
			foreach($r as $key=>$value)
			{
				$subCategorias = self::getSubCategorias($value["category_id-att"]);
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
		$fields = CategoryModel::parseInputFields(CategoryModel::$tables, $DTO, CategoryModel::$table, true);

		$params = array(
			'fields' => $fields,
			'table'  => CategoryModel::$table
		);
		$r = self::insert($params);
		return $r;
	}


	public static function import($DTO)
	{
		echo '<p>Importing Category<p>';

		$category = self::getByName($DTO['category_name'],$DTO['category_parent']);

		if($category == false):

			$params = array(
				'fields' => array(
					'category_parent'=>$DTO['category_parent'],
					'category_name'=>$DTO['category_name']
				),
				'table'  => CategoryModel::$table
			);

			Util::debug($params);
			
			$r = self::insert($params);
			return $r;
		else:
			return $category['category_id-att'];
		endif;
	}

	//Update
	public static function edit($data=array()){


		if(is_array($data))
		{
			$fields = array();
			$fields = CategoryModel::parseInputFields(CategoryModel::$tables, $data, CategoryModel::$table, $verbose=false);
			
			$params = array(
				'fields'=>$fields,
				'filters'=>array(
					'category_id='.$fields['category_id']
				),
				'table'=>CategoryModel::$table
			);
			$return = self::update($params);

			// Borramos el cache
			/* Sin cache por ahora
			$cacheKey = 'categorias.'.$data['category_parent'];
			$cacheFolder = 'categorias';
			Cache::deleteKey($cacheKey, $cacheFolder);
			$cacheKey = 'categorias.'.$data['category_id'];
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

			//Delete category from parent field
			$params12 = array(
				'table'  => CategoryModel::$objectCategoryTable,
				'filters'=> array('category_parentid='.$id),
				'fields' => array('category_parentid' => 1),
			);
			parent::update($params12);

			//Delete category from objects
			$params1 = array(
				'table'  => CategoryModel::$objectCategoryTable,
				'filters'=> array('category_id='.$id)
			);
			parent::delete($params1);


			//Delete category from parent field
			$params22 = array(
				'table'  => CategoryModel::$multimediaTable,
				'filters'=> array('category_parentid='.$id),
				'fields' => array('category_parentid' => 1),
			);
			parent::update($params22);
			
			//Delete category from multimedia
			$params2 = array(
				'table'  => CategoryModel::$multimediaTable,
				'filters'=> array('category_id='.$id)
			);
			parent::delete($params2);



			$params = array('table'=>CategoryModel::$table, 'filters'=>array('category_id='.$id));
			$r = self::delete($params);
			return $r;
		}
	}


}

?>