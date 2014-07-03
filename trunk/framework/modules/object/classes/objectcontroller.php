<?php
class ObjectController extends Controller implements ModuleController {

	public static function BackDisplayDefault(){}
	public static function FrontDisplayDefault(){}

	/* Categorizar */

	public static function BackDisplayCategoryModal()
	{
		$object_id = Util::getvalue('object_id');
		$parent_id = Util::getvalue('parent_id');
		$parent = Util::getvalue('parent', false);

		
		if($object_id):
			
			$Object 	= Object::getCategoriesByObjectId(array('object_id'=>$object_id));
			$Categories = Category::getList($parent_id);

			parent::loadAdminInterface($base='modal.categories.xsl');
			self::$template->setcontent($Object, null, 'object');
			self::$template->setcontent($Categories, null, 'categories');
			self::$template->setparam('object_id', $object_id);
			self::$template->setparam('parent', $parent_id);
			self::$template->display();
		endif;
	}

	public static function BackObjectCategory()
	{
		$DTO = array();
		$DTO['object_id'] = Util::getvalue('object_id');
		$DTO['parent_id'] = Util::getvalue('parent_id');
		$DTO['categories'] = Util::getvalue('categories');
		Object::setCategoriesByObjectId($DTO);

	}

	public static function BackRefreshCategories()
	{
		$object_id = Util::getvalue('object_id');
		

		$Categories = Object::getCategoriesByObjectId(array('object_id'=>$object_id));

		parent::loadAdminInterface($base='ajax.manager.xsl');
		self::$template->setcontent($Categories, null, 'object');
		self::$template->setparam('call', 'categories');
		self::$template->setparam('object_id', $object_id);
		self::$template->display();
	}

	public static function BackDisplayGroupCategoryModal()
	{
		$module     = Util::getvalue('module');
		$list       = Util::getvalue('list');
		$arr        = explode(',', $list);
		$categories = ConfigurationManager::Query("/configuration/modules/module[@name='".$module."']/options/group[@name='categories']/option");

		parent::loadAdminInterface($base='modal.categories.group.xsl');
		$arr['tag'] = 'id';
		self::$template->setcontent($arr, null, 'ids');

		$container = array();
		if($categories)
		{
			foreach($categories as $category){
				if($category->getAttribute('type') == 'parent')
				{
					$list = Category::getList($category->getAttribute('value'));
					array_push($container, $list);
				}
			}
			$container['tag'] = 'group';
			self::$template->setcontent($container, null, 'categories');
		}
		self::$template->display();
	}

	public static function BackSetCategoriesGroup()
	{
		$objects    = Util::getvalue('objects');
		$categories = Util::getvalue('categories');
		
		if(is_array($objects))
		{
			foreach($objects as $key=>$object_id)
			{
				$dto = array(
					'object_id'  => $object_id,
					'categories' => $categories
				);
				Object::setCategoriesByObjectId($dto);
			}
		}
		Util::debug($categories);
		Util::debug($objects);
		die;
	}

	public static function BackDeleteCategoryRelation()
	{
		$object_id   = Util::getvalue('object_id');
		$category_id = Util::getvalue('category_id');
		Object::deleteCategory($object_id, $category_id);
		echo "1";
	}

	/* Ordenar Categorias */
	
	public static function BackDisplayCategoryOrder()
	{
		$object_id = Util::getvalue('object_id');
		$parent_id = Util::getvalue('parent_id');
		$parent = Util::getvalue('parent', false);
		
		if($object_id):
			$Categories = Object::getCategoriesByObjectId(array('object_id'=>$object_id,'parent'=>$parent));

			parent::loadAdminInterface($base='modal.categories.order.xsl');
			self::$template->setcontent($Categories, null, 'categories');
			self::$template->setparam('object_id', $object_id);
			self::$template->setparam('parent', $parent_id);
			self::$template->display();
		endif;
	}

	public static function BackObjectCategoriesOrder()
	{
		$DTO = array();
		$DTO['object_id'] = Util::getvalue('object_id');
		$DTO['order'] = Util::getvalue('order');

		object::setCategoriesOrder($DTO);
		Util::debug($DTO);
	}




	/* Relaciones  */

	public static function BackDisplayRelationModal()
	{
		$object_id   = Util::getvalue('object_id');
		$type_id     = Util::getvalue('type_id');
		$categories  = Util::getvalue('categories',false);
		$parent      = Util::getvalue('category_parentid',false);


		if($object_id && $type_id):

			$options = array(
				'categories' => $categories,
				'type_id'	 => $type_id,
				'state'		 => 1,
				'parent'	 => $parent,
				'limit'		 => false,
				'debug'      => false,
			);

			if($options['categories'] || $options['parent']):
				$objects = Object::getObjectsByCategoryId($options);
				$objects['tag'] = 'object';
			else:
				$objects = Object::getByTypeId(
					$options = array(
					 'type_id'	=> $type_id,
					 'state'	=> 1
				));
			endif;
			
			$relations = Object::getRelations(array("object_id"=>$object_id,"relation_typeid"=>$type_id));
			
			$relations['tag'] = 'object';

			parent::loadAdminInterface($base='modal.relations.xsl');
			parent::$template->setcontent($relations, null, 'relations');
			parent::$template->setcontent($objects, null, 'objetos');
			parent::$template->setparam('object_id', $object_id);
			parent::$template->setparam('type_id', $type_id);
			parent::$template->display();
		else:
			echo '<div class="error"><p>ERROR: ObjectId or TypeId expected</p></div>';
		endif;
	}

	public static function BackObjectRelations()
	{
		$DTO = array();
		$DTO['object_id'] = Util::getvalue('object_id');
		$DTO['type_id'] = Util::getvalue('type_id');
		$DTO['objects'] = Util::getvalue('objects');
		Object::setRelationsByObjectId($DTO);
		Util::debug($DTO);
	}

	public static function BackRefreshRelations()
	{
		$object_id = Util::getvalue('object_id');
		$type_id = Util::getvalue('type_id');

		$relations = Object::getRelations(array('object_id'=>$object_id,'relation_typeid'=>$type_id));
		$relations['tag'] = 'object';

		parent::loadAdminInterface($base='ajax.manager.xsl');
		self::$template->setcontent($relations, null, 'relations');
		self::$template->setparam('call', 'relations');
		self::$template->setparam('object_id', $object_id);
		self::$template->display();
	}
	
	public static function BackDisplayModalSearch()
	{
		$object_id = Util::getvalue('object_id');
		$type_id   = Util::getvalue('type_id');
		$query   = Util::getvalue('q');

		parent::loadAdminInterface($base='modal.relations.xsl');
		if($object_id && $type_id):
			$relations = Object::getRelations(array('object_id'=>$object_id,'relation_typeid'=>$type_id));
			$relations['tag'] = 'object';
			self::$template->setcontent($relations, null, 'relations');

			$options = array(
				'query'			=> $query,
				'type_id'		=> $type_id,
				'currentPage'   => 1,
				'display'       => 20,
				'model'	        => 'ObjectModel',
				'table'         => ObjectModel::$table,
				'state'         => 1,
				'categories'    => false,
				'multimedias' 	=> false,
				'relations'		=> false,
				'debug'			=> false,
				'parent'        => false,
				'fromToday'     => false
			);

			self::$template->setcontent(Object::Search($options), null, 'objetos');
			self::$template->setparam('object_id', $object_id);
			self::$template->setparam('type_id', $type_id);
			self::$template->setparam('query', $query);
			self::$template->display();
		endif;
	}
	
	
	

	/* Ordenar Relaciones */
	
	public static function BackDisplayRelationOrderModal()
	{
		$object_id = Util::getvalue('object_id');
		$type_id   = Util::getvalue('type_id');

		parent::loadAdminInterface($base='modal.relations.order.xsl');
		if($object_id && $type_id):
			$options = array(
				'object_id'	=> $object_id,
				'relation_typeid' => $type_id
			);
			$relations = Object::getRelations($options);
			$relations['tag'] = 'object';
			self::$template->setcontent($relations, null, 'relations');
			//self::$template->setcontent(Object::getByTypeId($type_id, $state=1), null, 'objetos');
			self::$template->setparam('object_id', $object_id);
			self::$template->setparam('type_id', $type_id);
			self::$template->display();
		endif;
	}
	
	public static function BackObjectRelationsOrder()
	{
		$DTO = array();
		$DTO['object_id'] = Util::getvalue('object_id');
		$DTO['relation_typeid'] = Util::getvalue('type_id');
		$DTO['order'] = Util::getvalue('order');

		object::setRelationOrder($DTO);
		Util::debug($DTO);
	}


	public static function BackChangeState($item_id=false, $item_state=false)
	{
		$object_id = Util::getvalue('item_id', $item_id);
		$object_state  = Util::getvalue('item_state', $item_state);

		if(is_numeric($object_id) && is_numeric($object_state)):
			$options = array(
				'data' => array (
					"object_id"=> $object_id,
					"object_state"=> $object_state,
				)
			);
			$return = Object::Edit($options);
			echo $return;
		else:
			echo 0;
		endif;
	}

	public static function BackDeleteRelation()
	{
		$object_id   = Util::getvalue('object_id');
		$relation_id = Util::getvalue('relation_id');
		if(is_numeric($object_id) && is_numeric($relation_id)):
			Object::deleteRelation($object_id, $relation_id);
			echo "1";
		endif;
	}

	public static function BackDelete()
	{
		$object_id = Util::getvalue('item_id');

		if(is_numeric($object_id)):
			Object::Remove($object_id);
			echo "1";
		endif;
	}

	public static function BackDeleteGroup()
	{
		$list = Util::getvalue('list');
		$arr  = explode(',', $list);
		if(is_array($arr) && !empty($arr)){
			foreach($arr as $key=>$object_id){
				Object::Remove($object_id);
			}
		}
		echo "1";
		die;
	}

	public static function BackDuplicate()
	{
		$list = Util::getvalue('list');
		$arr  = explode(',', $list);
		if(is_array($arr) && !empty($arr)){
			foreach($arr as $key=>$object_id){
				// Duplicate each item
				Object::Duplicate($object_id);
			}
		}
		echo "1";
		die;
	}

	public static function BackPublish()
	{
		$object_id = Util::getvalue('item_id');
		$status = Object::GetStatusById($object_id);
		
		if($status['object_state'] == 0 || $status['object_state'] == 3)
		{

			$object_typeid   = Object::getTypeByObjectId($object_id);
			$module          = ConfigurationManager::Query("/configuration/modules/module[@type_id='".$object_typeid."']");
			$moduleName      = $module->item(0)->getAttribute('name');
			$moduleModel     = $module->item(0)->getAttribute('model');
			$modelReflection = new ReflectionClass($moduleModel);

			// Publish object
			$object = Object::getById(
				$options = array(
					'object_id'	 => $object_id,
					'model'      => $moduleModel,
					'table'      => $modelReflection->getStaticPropertyValue('table'),
					'state'		 => false, 
					'relations'	 => true,
					'multimedas' => true,
					'categories' => true
				)
			);

			parent::loadAdminInterface('publish.xsl');
			self::$template->setparam('module', $modelReflection->getStaticPropertyValue('tag'));
			self::$template->setparam('tag', $moduleName);
			self::$template->setcontent($object, null, 'object');
			$xml = self::$template->returnDisplay();

			Object::Publish($object_id, $xml);

			echo '1';
			die;

		}else{
			echo "Paso algo no puedo publicar";
		}
	}

	public static function BackUnPublish()
	{
		$object_id = Util::getvalue('item_id');
		$status = Object::GetStatusById($object_id);
		
		$homes = Home::getHomesList();
		foreach($homes as $key=>$home)
		{
			if(is_numeric($key))
			{
				$objects = Home::getObjectsByHomeId($home['home_id-att']);
				if(!empty($objects)){
					foreach($objects as $index=>$object)
					{
						if(is_numeric($index))
						{
							if($object['element_id'] == $object_id){
								echo 'El elemento no se puede despublicar.<br/> Está instanciado en la home "'.$home['title'].'"<br/><br/> Para despublicarlo, es necesario eliminarlo de esa home.';
								die;
							}
						}
					}
				}
			}
		}
		

		if($status['object_state'] == 1)
		{
			$object_typeid   = Object::getTypeByObjectId($object_id);
			$module          = ConfigurationManager::Query("/configuration/modules/module[@type_id='".$object_typeid."']");
			$moduleName      = $module->item(0)->getAttribute('name');

			Object::UnPublish($object_id);
			echo self::BackChangeState($object_id, 0);
			die;

		}else{
			echo "Paso algo no puedo despublicar";
		}
	}


}
?>