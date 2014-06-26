<?php
class Location extends Module
{
	public $content;
	public $xmlContent;
	

	// Get Entities and people related
	public static function getList($parentId = '0',$getSubcategories = true,$orderby = false,$debug=false)
	{
		//cache key
		$cacheKey = 'locations.parent.'.$parentId;
		$cacheFolder = "locations";

		//if(!($return = Cache::getKey($cacheKey, $cacheFolder))):
				$fields = array('*');
				$fields = Model::parseFields(LocationModel::$tables, $fields, LocationModel::$table);

				$params = array(
						'fields'  => $fields,
						'table'   => LocationModel::$table,
						'orderby' => ($orderby!=false)?$orderby:'location_id DESC',
						'filters' => array("location_parent=".$parentId)
				);
				$return = self::select($params);
				
				if($getSubcategories):
					foreach($return as $key=>$value):
						$subCategorias = self::getList($value["id-att"],$getSubcategories,$orderby);
						if(is_array($subCategorias) && count($subCategorias)>1):
							$return[$key]["locations"] = $subCategorias;
						endif;
					endforeach;
				endif;
				
				$return['tag'] = 'location';
				//$expires = (86400 * 30) * 3; // 3 meses
				//Cache::setKey($cacheKey, $return, $expires, $cacheFolder);
		//endif;
		return $return;
	}


	// Get by id
	public static function getById($id=false){
		if($id){
			$fields = array('*');
			//$fields = LocationModel::getFields($fields, LocationModel::$table);
			$modelReflection = new ReflectionClass('LocationModel');
			$fields = Model::parseFields($modelReflection->getStaticPropertyValue('tables'), $fields, $modelReflection->getStaticPropertyValue('table'));

			$params = array(
				'table'   => LocationModel::$table,
				'filters' => array('location_id='.$id),
				'fields'=>$fields
			);
			$r = self::select($params);
			if(isset($r[0])):
				$location = $r[0];
				return $location;
			else:
				return false;
			endif;
		}
	}

	// Get tree
	public static function getParentsById($id, $level=false){
		if($id){
			$fields = array('*');
			//$fields = LocationModel::getFields($fields, LocationModel::$table);
			$modelReflection = new ReflectionClass('LocationModel');
			$fields = Model::parseFields($modelReflection->getStaticPropertyValue('tables'), $fields, $modelReflection->getStaticPropertyValue('table'));

			$params = array(
				'table'   => $modelReflection->getStaticPropertyValue('table'),
				'filters' => array('location_id='.$id), 'fields'=>$fields
			);
			$r = self::select($params);
			$location = $r[0];

			if($location['parent-att'] != 1 && $level != 1):
				$location['parent'] = self::getParentsById($location['parent-att'],$level-1);
			endif;			
			return $location;
		}
	}

	// Get by Url
	public static function getByUrl($url=false){
		if($url){
			$fields = array('*');
			$fields = LocationModel::getFields($fields, LocationModel::$table);
			$params = array('table'=>LocationModel::$table, 'filters'=>array('location_url="'.$url . '"'), 'fields'=>$fields);
			$r = self::select($params);
			if(!empty($r)){
				$location = $r[0];
				return $location;
			}else {
				return false;
			}
		} else {
			return false;
		}
	}

	// Get by Name
	public static function GetByName($name)
	{
		$fields = array('*');
		$fields = LocationModel::getFields($fields, LocationModel::$table);
		$params = array(
			'table'   => LocationModel::$table, 
			'filters' => array("location_name like '%$name%'"), 
			'fields'  => $fields
		);
		$r = self::select($params);
		if(isset($r[0])):
			$location = $r[0];
			return $location;
		else:
			return false;
		endif;
	}

	public static function getSubCategorias($locationId){
		$fields = array('*');
		$fields = LocationModel::getFields($fields, LocationModel::$table);
		$params = array(
					'fields'=>$fields,
					'table'=>LocationModel::$table,
					'orderby'=>'location_id DESC',
					'filters'=>array("location_parent=".$locationId)
		);
		$r = self::select($params);
		if(!empty($r)){
			foreach($r as $key=>$value)
			{
				$subCategorias = self::getSubCategorias($value["id-att"]);
				if(is_array($subCategorias)){
				$r[$key]["locations"] = $subCategorias;
				}
			}
			$r['tag'] = 'location';
			return $r;
		}
		else return false;
	}




	public static function create($DTO)
	{
		$fields = array();
		$fields = LocationModel::parseInputFields(LocationModel::$tables, $DTO, LocationModel::$table, true);

		$params = array(
			'fields' => $fields,
			'table'  => LocationModel::$table
		);
		$r = self::insert($params);
		return $r;
	}

	//Update
	public static function edit($data=array()){

		//util::debug($data);
		//die;

		if(is_array($data))
		{
			$fields = array();
			$fields = LocationModel::parseInputFields(LocationModel::$tables, $data, LocationModel::$table, $verbose=false);
			

			$params = array(
				'fields'=>$fields,
				'filters'=>array(
					'location_id='.$data['id']
				),
				'table'=>LocationModel::$table
			);

			
			$return = self::update($params);
			



			// Borramos el cache
			/* Sin cache por ahora
			$cacheKey = 'locations.'.$data['location_parent'];
			$cacheFolder = 'locations';
			Cache::deleteKey($cacheKey, $cacheFolder);
			$cacheKey = 'locations.'.$data['location_id'];
			$cacheFolder = 'locations';
			Cache::deleteKey($cacheKey, $cacheFolder);
			*/

			return $return[0];
		}
		else
		{
			return false;
		}

	}

	//Delete
	public static function Remove($id=false)
	{
		if($id){

			//Delete Locations Childs
			$params1 = array(
				'table'  => 'location',
				'filters'=> array('location_parent='.$id)
			);
			parent::delete($params1);

			//Delete Location
			$params = array(
				'table'=> 'location', 
				'filters'=> array('location_id='.$id
			));
			$r = parent::delete($params);
			return $r;
		}
	}


}

?>