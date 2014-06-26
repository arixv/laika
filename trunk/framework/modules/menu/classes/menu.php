<?php
class Menu extends Module {

	protected static $cacheFolder = 'menu';
	
	// Get Entities and relateds
	public static function getList($parentId='0',$state=false)
	{
		//$cacheKey = 'menu_parent_'.$parentId;
		//$expires  = '86400'; // 1 dia
		
		//if(!($return = Cache::getKey($cacheKey, self::$cacheFolder))):

			$fields = array('*');
			$fields = MenuModel::getFields($fields, MenuModel::$table);
			$params = array(
						'fields'=>$fields,
						'table'=>MenuModel::$table,
						'orderby'=>'menu_id DESC',
						'filters'=>array("menu_parent=".$parentId)
			);

			if($state!==false):
				//$params['filters']['menu_state='.$state];
				array_push($params["filters"],"menu_state=".$state);
			endif;


			$return = self::select($params);

			foreach($return as $key=>$value)
			{
				$subMenus = self::getList($value["menu_id-att"],$state);
				if(is_array($subMenus) && count($subMenus)>1)
				{
					$return[$key]["menus"] = $subMenus;
				}
			}
			$return['tag'] = 'menu';

		//	Cache::setKey($cacheKey, $return, $expires, self::$cacheFolder);
		//endif;

		return $return;
	}

	// Get by id
	public static function getById($id=false){
		if($id){
			$fields = array('*');
			$fields = MenuModel::getFields($fields, MenuModel::$table);
			$params = array('table'=>MenuModel::$table, 'filters'=>array('menu_id='.$id), 'fields'=>$fields);
			$r = self::select($params);
			if(isset($r[0])):
				$menu = $r[0];
				return $menu;
			else:
				return false;
			endif;
		}
	}

	// Get by url
	public static function getByUrl($url=false){
		if($url){
			$fields = array('*');
			$fields = MenuModel::getFields($fields, MenuModel::$table);
			$params = array('table'=>MenuModel::$table, 'filters'=>array('menu_url="'.$url . '"'), 'fields'=>$fields);
			$r = self::select($params);
			if(!empty($r)){
				$menu = $r[0];
				return $menu;
			}else {
				return false;
			}
		} else {
			return false;
		}
	}

	// Get sub items
	public static function getSubMenus($menuId){
		$fields = array('*');
		$fields = MenuModel::getFields($fields, MenuModel::$table);
		$params = array(
					'fields'=>$fields,
					'table'=>MenuModel::$table,
					'orderby'=>'menu_id DESC',
					'filters'=>array("menu_parent=".$menuId)
		);
		$r = self::select($params);
		if(!empty($r)){
			foreach($r as $key=>$value){
				$subMenus = self::getSubMenus($value["menu_id-att"]);
				if(is_array($subMenus)){
				$r[$key]["menus"] = $subMenus;
				}
			}
			$r['tag'] = 'menu';
			return $r;
		}
		else return false;
	}

	// Create
	public static function create($DTO){
		$fields = array();
		$fields = MenuModel::parseInputFields(MenuModel::$tables, $DTO, MenuModel::$table, $verbose=true);

		$params = array(
			'fields'=>$fields,
			'table'=>MenuModel::$table
		);
		$r = self::insert($params);
		return $r;
	}

	// Update
	public static function edit($data=array()){

		if(is_array($data)){
			$fields = array();

			$fields = MenuModel::parseInputFields(MenuModel::$tables, $data, MenuModel::$table, $verbose=true);

			$params = array(
				'fields'=>$fields,
				'filters'=>array(
					'menu_id='.$fields['menu_id']
				),
				'table'=>MenuModel::$table
			);
			$return = self::update($params);

			return $return[0];
		}else{
			return false;
		}

	}

	// Delete
	public static function remove($id=false){
		if($id){
			$params = array('table'=>MenuModel::$table, 'filters'=>array('menu_id='.$id));
			$r = self::delete($params);
			return $r;
		}else{
			return false;
		}
	}

}

?>