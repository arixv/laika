<?php
class Multimedia extends Module
{
	/**
	*	List of Objects
	*	@return objects
	**/
	public static function GetList($options = array()){
		
		$defaults = array(
			'model'			=> 'MultimediaModel',
			'module'        => 'multimedia',
			'table'			=> MultimediaModel::$table,
			'type_id'		=> false, 
			'display'		=> 10,
			'currentPage'   => 1,
			'state'			=> false, 
			'categories'    => false,
			'sort'          => 'creation_date',
			'order'  		=> 'DESC',
			'startdate'     => false,
			'enddate'       => false,
			'relations'     => false,
			'debug'			=> false
		);
		$options = Util::extend(
			$defaults,
			$options
		);

		$module = ConfigurationManager::GetModuleConfiguration(
			$options['module']
		);

		//DB Query
		$params = array(
			'fields'	=> array('*'),
			'table'		=> MultimediaModel::$table,
			'filters'	=> array(),
			'limit'     => (($options['currentPage']-1) * $options['display']).','.$options['display'],
			'orderby'   => $options['sort'].' '.$options['order'],
		);

		if($options['state'] !== false): 
			array_push($params['filters'], 'multimedia_state='.$options['state']);
		endif;
		
		if($options['type_id']):
			array_push($params['filters'], 'multimedia_typeid='.$options['type_id']);
		endif;

		if($options['startdate']):
			array_push($params['filters'], 'creation_date>='.$options['startdate']);
		endif;

		if($options['enddate']):
			array_push($params['filters'], 'creation_date<='.$options['enddate']);
		endif;

		$objects = array();

		if(isset($options['categories']) && $options['categories']!= false):
			$objects = Multimedia::GetListByCategoryId($options);
			if(!$objects) return false;

			$count   = $objects['total'];
			unset($objects['total']);
		else:
			$objects = parent::select($params,$options['debug']);
			if(!$objects) return false;

			$params['fields'] = array('count(multimedia_id) as total');
			unset($params['limit']);
			$total = parent::select($params, $options['debug']);
			$count = $total[0]['total'];
		endif;

		if(!$objects) return false;
		
		$returnObjects = self::ParseMultimedias($options, $objects);
		$returnObjects['total-att'] = $count;

		$moduleSession = array();
		$moduleSession['currentPage'] = ($options['currentPage']) ? $options['currentPage'] : 1;
		$moduleSession['categories']  = ($options['categories']) ? $options['categories'] : '';
		$moduleSession['state']       = ($options['state'] !== false) ? $options['state'] : '';
		
		Session::Set($options['module'], $moduleSession);
		
		return $returnObjects;
		
	}


	private static function ParseMultimedias($options, $objects)
	{
		$defaults = array(
			'model'			=> 'MultimediaModel',
			'module'        => 'multimedia',
			'table'			=> MultimediaModel::$table,
			'currentPage'	=> 1,
			'display'		=> 10, 
			'state'			=> false,
			'type_id'		=> 1,
			'relations'		=> false,
		);

		$options = Util::extend(
			$defaults,
			$options
		);



		$modelReflection = new ReflectionClass($options['model']);

		$method = ($options['model'] == 'MultimediaModel') ? 'getFields' : 'parseFieldsFromObjects';

		$parsedObjects  = call_user_func_array(
			array(
				'Model', 
				$method), 
			array(
				$objects,
				$options['table'],
				$modelReflection->getStaticPropertyValue('tables'), 
				$modelReflection->getStaticPropertyValue('multimediaFields')
			)
		);



		$returnObjects = array(
			'tag' 			 => $modelReflection->getStaticPropertyValue('tag'),
			'name-att'		 => $options['module'],
			'type-att'		 => $options['type_id'],
		);

		if($options['currentPage']) $returnObjects['currentPage-att'] = $options['currentPage'];
		if($options['display'])     $returnObjects['display-att'] = $options['display'];

		if(!empty($parsedObjects)):

			$primayKey = call_user_func_array(
				array(
					'Model', 
					'parsePrimaryKeyAlias'
				), 
				array(
					$modelReflection->getStaticPropertyValue('tables'),
					$options['table']
				)
			);

			foreach($parsedObjects as $key=>$object):

				$returnObjects[$key] = $object;

				$creation_userid = (isset($object['creation_userid-att'])) ? $object['creation_userid-att'] : $object['creation_userid'];
				if($creation_userid != 0):
					$ownerUser = Admin::getById($creation_userid);
					$returnObjects[$key]['createdby'] = $ownerUser['name'].' '.$ownerUser['lastname'];
				endif;
				
				$modification_userid = (isset($object['modification_userid-att'])) ? $object['modification_userid-att'] : $object['modification_userid'];
				if($modification_userid != 0):
					$editedUser = Admin::getById($object['modification_userid-att']);
					$returnObjects[$key]['modifiedby'] = $editedUser['name'].' '.$editedUser['lastname'];;
				endif;

				$returnObjects[$key]['categories'] = self::GetCategoriesByMultimediaId(
					array(
						'multimedia_id' => $object[$primayKey],
						'debug'         => $options['debug'],
					)
				);

				$relationsOptions = array(
					'multimedia_id' => $object[$primayKey],
					'debug'         => $options['debug'],
				);


				if(!$options['relations']):
					$relationsOptions['count'] = true;
				endif;
				$returnObjects[$key]['relations'] = self::getRelatedObjects($relationsOptions);
			endforeach;
			return $returnObjects;
		else:
			return false;
		endif;


	}

	/**
	*	Get multimedias by category
	*	@return total
	**/
	private static function GetListByCategoryId($options)
	{
		$defaults = array(
			'categories'  => false,
			'type_id'	  => false,
			'state'		  => false,
			'parent'	  => false,
			'limit'		  => false,
			'fromToday'   => false,
			'currentPage' => 1,
			'display'     => 10,
		);

		$options = util::extend(
			$defaults,
			$options
		);

		$range = ($options['currentPage'] - 1) * $options['display'];

		$params = array(
			'fields' => array('*'),
			'table'  => MultimediaModel::$table.' as multimedia inner join '.MultimediaModel::$categoryTable.' as cat on multimedia.multimedia_id=cat.multimedia_id',
			'orderby'   => 'multimedia.multimedia_id DESC',
			'limit'     => $range.', '.$options['display'],
		);

		if($options['limit'] !== false): 
			$params['limit'] = $options['limit']; 
		endif;

		if(!$options['parent']):
			$params['filters'] = array('cat.category_id in ('.$options['categories'].')');
		else:
			$params['filters'] = array('cat.category_parentid='.$options['parent']);
		endif;

		if($options['state'] !== false):
			array_push($params['filters'], 'multimedia.multimedia_state='.$options['state']);
		endif;

		array_push($params['filters'], 'multimedia.multimedia_typeid='.$options['type_id']);

		if($options['fromToday']):
			$today = date('Y-m-d');
			$datetime = $today.' 00:00:00';
			array_push($params['filters'], "multimedia.creation_date >='".$datetime."'");
		endif;

		$objects = parent::select($params, $options['debug']);
		
		$params['fields'] = array('count(multimedia.multimedia_id) as total');
		unset($params['limit']);
		$count = parent::select($params, $options['debug']);
		$objects['total'] = $count[0]['total'];

		if(count($objects)):
			return $objects;
		else:
			return false;
		endif;
	}


	/**
	*	Get objtets related
	*	@return total
	**/
	private static function GetRelatedObjects($options)
	{
		$defaults = array(
			'multimedia_id' => false,
			'count'         => false,
			'debug'   	    => false
		);

		$options = Util::extend(
			$defaults,
			$options
		);


		if(!$options['multimedia_id']) return false;

		$params = array(
			'table' => MultimediaModel::$relationTable,
			'filters' => array('multimedia_id='.$options['multimedia_id']),
		);

		$objects = parent::select($params, $options['debug']);
		if($options['count']){
			return count($objects);
		}else{
			return $objects;
		}
	}

	/*
	@deprecated
	private static function GetCount($options)
	{
		$defaults = array(
			'query'      => null,
			'type_id'    => false, 
			'state'      => false,
			'categories' => false
		);

		$options = util::extend(
			$defaults,
			$options
		);

		if($options['categories'])
		{
			$total = self::CountInCategories($options);
		}
		else
		{
			$total = self::CountSimple($options);
		}
		return $total;
	}

	private static function CountSimple($options)
	{
		$defaults = array(
			'type_id'    => false, 
			'state'      => false,
		);

		$options = util::extend(
			$defaults,
			$options
		);

		$params = array(
			'fields'	=> array('distinct(multimedia_id)'),
			'table'		=> MultimediaModel::$table,
			'filters'	=> array()
		);

		if($options['state'] !== false):
			$params['filters'] = array('multimedia_typeid='.$options['type_id'], 'multimedia_state='.$options['state']);
		else:
			$params['filters'] = array('multimedia_typeid='.$options['type_id']);
		endif;

		$total = parent::select($params);
		return count($total);
	}

	private static function CountInCategories($options)
	{

		$defaults = array(
			'type_id'    => 1,
			'categories' => false,
			'parent'     => false,
			'state'      => false,
		);

		$options = util::extend(
			$defaults,
			$options
		);

		$params = array(
			'fields'	=> array('distinct(multimedia.multimedia_id)'),
			'table'     => MultimediaModel::$table.' as multimedia inner join '.MultimediaModel::$categoryTable.' as cat on multimedia.multimedia_id=cat.multimedia_id',
		);

		if(!$options['parent']):
			$params['filters'] = array('cat.category_id in ('.$options['categories'].')');
		else:
			$params['filters'] = array('cat.category_parentid='.$options['parent']);
		endif;

		if($options['state'] !== false):
			array_push($params['filters'], 'multimedia.multimedia_state='.$options['state']);
		endif;

		array_push($params['filters'], 'multimedia.multimedia_typeid='.$options['type_id']);

		$total = parent::select($params);
		return count($total);
	}
	*/

	/**
	*	List of Objects
	*	@return objects
	*/
	public static function GetCategoriesByMultimediaId($options)
	{
		$defaults = array(
			'multimedia_id' => false,
			'parent' 	    => false,
			'level' 	    => 0
		);

		$options = util::extend(
			$defaults,
			$options
		);

		if($options['multimedia_id'] === false): 
			return false; 
		endif;

		$params = array(
			'fields' => array('*'),
			'table'  => MultimediaModel::$categoryTable,
			'orderby' => 'category_id ASC',
		);

		if($options['parent'] === false):
			$params['filters'] = array(
				'multimedia_id='.$options['multimedia_id']
			);
		else:
			$params['filters'] = array(
				'multimedia_id='.$options['multimedia_id'], 
				'category_parentid='.$options['parent']
			);
		endif;

		$categories = parent::select($params);
		
		if(count($categories)):
			$list = array();
			$parentsArr = array();
			foreach($categories as $category):
				if($category['category_parentid']!==0):
					$item = Category::getParentsById($category['category_id'], $options['level']);
					//$item['order-att'] = $category['category_order'];
				endif;
				array_push($list, $item);
			endforeach;
			$list['tag'] = 'category';
			$list['multimedia_id-att'] = $options['multimedia_id'];
			return $list;
		else:
			return false;
		endif;
	}



	/**
	* Get categories from configuration for filters
	*/
	public static function GetCategoriesFilter($options = false)
	{
	
		$defaults = array(
			'module' => 'multimedia'
		);
		$options = util::extend(
			$defaults,
			$options
		);

		$moduleConfiguration = ConfigurationManager::GetModuleConfiguration($options['module']);
		$moduleCategories    = ConfigurationManager::Query(
			"/module/options/group[@name='categories']/option[@type='parent']",
			$moduleConfiguration
		);

		$returnFilters = array();

		if($moduleCategories){
			foreach($moduleCategories as $category){
				$categoryParentId = $category->getAttribute('value');
				$categoriesTitle  = $category->getAttribute('display');
				$list = Category::GetList($parent=$categoryParentId);
				$list['name-att'] = $categoriesTitle;
				array_push($returnFilters, $list);
			}
			$returnFilters['tag'] = 'group';
			return $returnFilters;
		}else{
			return false;
		}
	}



	/**
	*	Get Multimedia by ID
	*	@return object
	*/
	public static function getById($options)
	{ 
		$defaults = array(
			'model'         => 'MultimediaModel',
			'module'        => 'multimedia',
			'multimedia_id' => false,
			'type_id'       => false,
			'state'         => false, 
			'relations'     => false,
			'multimedias'   => true,
			'categories'    => true,
			'level'         => 3, // Arbol de categorias padre
			'debug'         => false,
		);

		$options = Util::extend(
			$defaults,
			$options
		);

		if(!$options['multimedia_id']) return false;

		//Query
		$params = array(
			'table'     => MultimediaModel::$table,
			'filters'   => array(
				'multimedia_id='.$options['multimedia_id']
			)
		);

		$result = parent::select($params, $options['debug']);

		if(!isset($result[0])) return false;

		$returnObjects = self::ParseMultimedias($options, $result);

		return $returnObjects[0];

	}



	/** 
	*	Function: Add Multimedia
	*	Params: Object
	*	@return: inserted ID
	**/

	public static function Add($options = array())
	{
		//$options
		$defaultOptions = array(
				'model'		=> 'MultimediaModel',
				'data'		=> false,
				'table'		=> MultimediaModel::$table,
				'verbose'   => false,
				'debug'		=>false
		);

		$options = Util::extend(
			$defaultOptions,
			$options
		);

		$modelReflection = new ReflectionClass($options['model']);
		if($options['model'] == 'MultimediaModel'):

			$object = call_user_func_array(
				array(
					'Model', 
					'parseInputFields')
				, 
				array(
					$modelReflection->getStaticPropertyValue('tables'),
					$options['data'],
					$options['table'],
					$options['verbose'],
				)
			);
		else:
			$object = call_user_func_array(
				array(
					'Model', 
					'inputObjectFields')
				, 
				array(
					array(
						'fields' => $options['data'],
						'tables' => $modelReflection->getStaticPropertyValue('tables'),
						'table'  => $options['table'],
						'objectFields' => $modelReflection->getStaticPropertyValue('multimediaFields'),
						'multimedia_typeid' => $modelReflection->getStaticPropertyValue('multimedia_typeid'),
						'verbose' => $options['verbose'],
					),
				)
			);
		endif;

		return parent::insert(
			array(
				'fields'=>$object,
				'table'=>MultimediaModel::$table
			)
		);
	}


	/** 
	*	Function: Edit Object
	*	Params: Object, Options
	*	@return boolean
	**/
	public static function Edit($options = array())
	{
		$defaults = array(
				'data'		=> $_POST,
				'model' 	=> 'MultimediaModel',
				'table' 	=> MultimediaModel::$table,
				'verbose' 	=> true
		);

		$options = Util::extend(
			$defaults,
			$options
		);

		$modelReflection = new ReflectionClass($options['model']);


		$fields = call_user_func_array(
			array(
				'Model', 
				'inputObjectFields')
			, 
			array(
				array(
					'fields'        => $options['data'],
					'table'         => $options['table'],
					'tables'        => $modelReflection->getStaticPropertyValue('tables'),
					'objectFields'  => $modelReflection->getStaticPropertyValue('multimediaFields'),
					'verbose'       => $options['verbose']
				)
			)
		);
		
		$params = array(
			'fields'  => $fields,
			'table'   => MultimediaModel::$table,
			'filters' => array('multimedia_id='.$fields['multimedia_id']),
		);
		return parent::update($params);
	}


	public static function Remove($m_id)
	{
		if(is_numeric($m_id)){

			$query = "INSERT INTO multimedia_deleted SELECT * FROM multimedia WHERE multimedia_id=".$m_id;
			parent::customdelete($query);

			// Lo borro si existe en las categorias
			$params1 = array(
				'table'  => MultimediaModel::$categoryTable,
				'filters'=> array('multimedia_id='.$m_id)
			);
			parent::delete($params1);
			
			// Lo borro si esta relacionado a un objeto
			$params2 = array(
				'table'  => MultimediaModel::$relationTable,
				'filters'=> array('multimedia_id='.$m_id)
			);
			parent::delete($params2);
			
			$params = array(
				'table'  => MultimediaModel::$table,
				'filters'=> array('multimedia_id='.$m_id)
			);
			return parent::delete($params);
		}
	}


	public static function getByTypeId($type_id, $limit=10)
	{
		$params = array(
			'table'     =>MultimediaModel::$table,
			'filters'   => array('multimedia_typeid='.$type_id),
			'orderby'   => 'multimedia_id DESC',
			'limit'     => $limit,
		);
		$return = parent::select($params);
		if(isset($return[0])):
			$return['tag'] = 'object';
			return $return;
		else:
			return false;
		endif;
	}


	public static function search($options)
	{
		$defaults = array(
			'query'       => '',
			'type_id'     => 1,
			'currentPage' => 1,
			'display'     => 20,
			'model'       => 'MultimediaModel',
			'table'       => MultimediaModel::$table,
			'state'       => false,
			'categories'  => false
		);


		$options = Util::extend($defaults,$options);

		if($options['query']!=''){

			$options['query'] = str_replace("'", "\'", $options['query']);
			

			if($options['categories']){
				$collection = self::SearchInCategories($options);
			}else{
				$collection = self::SearchSimple($options);
			}

			$modelReflection   = new ReflectionClass($options['model']);
			$collection['tag'] = $modelReflection->getStaticPropertyValue('tag');
			$collection['type-att']    = $options['type_id'];
			$collection['display-att'] = $options['display'];
			$collection['currentPage-att'] = $options['currentPage'];
			
			return $collection;
		}
		return false;
	}

	
	private static function SearchSimple($options)
	{
		$defaults = array(
			'query'       => '',
			'type_id'     => 1,
			'currentPage' => 1,
			'display'     => 20,
			'model'       => 'MultimediaModel',
			'table'       => MultimediaModel::$table,
			'state'       => false,
		);

		$options = Util::extend($defaults,$options);

		$range = ($options['currentPage'] - 1) * $options['display'];

		$params = array(

			'table'     => MultimediaModel::$table,
			'limit'     => $range.', '.$options['display'],
			'orderby'   => 'multimedia_id DESC',
		);

		$params['filters'] = array(
								"(multimedia_title like '%".$options['query']."%' or multimedia_content like '%".$options['query']."%' or object_custom like '%".$options['query']."%')",
								'multimedia_typeid='.$options['type_id'], 
							);

		if($options['state'] !== false):
			array_push($params['filters'], 'multimedia.multimedia_state='.$options['state']);
		endif;

		$return = parent::select($params);
		

		$list = array();
		foreach($return as $key=>$element):
			$options['multimedia_id'] = $element['multimedia_id'];
			$multimedia = self::getById($options);
			array_push($list, $multimedia);
		endforeach;

		unset($params['limit']);
		$count = parent::select($params);
		$list['total-att'] = count($count);

		return $list;
	}

	private static function SearchInCategories($options)
	{
		$defaults = array(
			'query'       => '',
			'type_id'     => 1,
			'currentPage' => 1,
			'display'     => 20,
			'model'       => 'MultimediaModel',
			'table'       => MultimediaModel::$table,
			'state'       => false,
			'categories'  => false
		);

		$options = Util::extend($defaults,$options);

		$range = ($options['currentPage'] - 1) * $options['display'];

		$params = array(
			'fields'    => array('distinct(multimedia.multimedia_id) as multimedia_id', 'multimedia_typeid', 'category_id'),
			'table'     => 'multimedia inner join multimedia_category on multimedia.multimedia_id = multimedia_category.multimedia_id',
			'limit'     => $range.', '.$options['display'],
			'orderby'   => 'multimedia_id DESC',
		);

		$params['filters'] = array(
			"(multimedia_title like '%".$options['query']."%' or multimedia_content like '%".$options['query']."%' or object_custom like '%".$options['query']."%')", 
			'multimedia.multimedia_typeid='.$options['type_id'],
			'multimedia_category.category_id in ('.$options['categories'].')',
		);

		if($options['state'] !== false):
			array_push($params['filters'], 'multimedia.multimedia_typeid='.$options['type_id']);
		endif;

		$return = parent::select($params);
		
		$list = array();
		foreach($return as $key=>$element):
			$options['multimedia_id'] = $element['multimedia_id'];
			$multimedia = self::getById($options);
			array_push($list, $multimedia);
		endforeach;

		//Aprovechamos la consulta y obtenemos el total para el paginado
		unset($params['limit']);
		$count = parent::select($params);

		$list['total-att'] = count($count);
		
		return $list;
	}


	
	public static function setCategoriesByMultimediaId($DTO)
	{
		$multimedia_id = $DTO['multimedia_id'];

		
		if(!empty($DTO['categories'])):
			foreach($DTO['categories'] as $key=>$category_id):

				if(!self::hasCategory($category_id, $multimedia_id))
				{
					// Tomo el parent automaticamente
					$category  = Category::getParentsById($category_id, $level=2);
					$parent_id = (isset($category['parent'])) ? $category['parent']['category_id-att'] : 0;
					
					$params = array(
						'table'  => MultimediaModel::$categoryTable,
						'fields' => array('multimedia_id'=>$multimedia_id, 'category_parentid'=>$parent_id, 'category_id'=>$category_id),
					);
					parent::insert($params);
				}
			endforeach;
		endif;
		return;
	}
	
	private static function hasCategory($category_id, $multimedia_id)
	{
		$multimediaCategories = self::GetCategoriesByMultimediaId($options = array('multimedia_id'=>$multimedia_id));

		if($multimediaCategories)
		{
			foreach($multimediaCategories as $multimediaCategory){
				if($multimediaCategory['category_id-att'] == $category_id)
				{
					//echo "la categoria: ".$category_id." ya existe\n";
					return true;
				}
			}
			return false;
		}
	}

	public static function setCategoryByMultimediaId($DTO)
	{
		$multimedia_id = $DTO['multimedia_id'];
		$category_id   = $DTO['category_id'];

		// Tomo el parent automaticamente
		$category  = Category::getParentsById($category_id, $level=2);
		$parent_id = (isset($category['parent'])) ? $category['parent']['category_id-att'] : 0;

		$params = array(
			'table'  => MultimediaModel::$categoryTable,
			'fields' => array('multimedia_id'=>$multimedia_id, 'category_parentid'=>$parent_id, 'category_id'=>$category_id),
		);
		parent::insert($params);
		return;
	}

	public static function deleteCategory($mid, $category_id)
	{
		$params = array(
			'table'  => MultimediaModel::$categoryTable,
			'filters' => array('multimedia_id='.$mid, 'category_id='.$category_id),
		);
		parent::delete($params);
		return 1;
	}



	public static function getMultimediasByObjectId($options)
	{
		$defaults = array(
			'object_id' => false,
			'module'    => 'multimedia',
			'debug'		=> false
		);
		$options = util::extend($defaults,$options);

		if($options['object_id'] === false): 
			return false;
		endif;

		$type_id = Object::getTypeByObjectId($options['object_id']);
		$module  = ConfigurationManager::GetModuleConfigurationByType($type_id);

		$options['module'] = $module->getAttribute('name');

		$moduleMultimediaConfig = ConfigurationManager::Query("/configuration/modules/module[@name='".$options['module']."']/options/group[@name='multimedias']/option");

		$returnMultimedia = array();

		if($moduleMultimediaConfig):

			foreach($moduleMultimediaConfig as $multimedia):

				$multimediaTypeid	= $multimedia->getAttribute('type_id');
				$multimediaName		= $multimedia->getAttribute('name');


				
				$multimediaConfig 	= ConfigurationManager::GetModuleConfiguration($multimediaName);
				$multimediaModel 	= (string)$multimediaConfig->getAttribute('model');

				$modelReflection    = new ReflectionClass($multimediaModel);
				$multimediaTable    = $modelReflection->getStaticPropertyValue('table');
				$multimediaTypeId   = $modelReflection->getStaticPropertyValue('multimedia_typeid');

				$options['type_id'] = $multimediaTypeid;
				$options['model']   = $multimediaModel;
				$options['table']   = $multimediaTable;
				$options['type_id'] = $multimediaTypeId;

				$relations = self::GetlistByObjectId($options);

				if($relations):
					$modelReflection = new ReflectionClass($options['model']);

					$method = ($options['model'] == 'MultimediaModel') ? 'getFields' : 'parseFieldsFromObjects';
					$parsedObject = call_user_func_array(
								array(
									'Model', 
									$method
								), 
								array(
									$relations,
									$modelReflection->getStaticPropertyValue('table'),
									$modelReflection->getStaticPropertyValue('tables'),
									$modelReflection->getStaticPropertyValue('multimediaFields')
								)
					);

					//$relations  = call_user_func_array(array($multimediaModel, 'getFieldsFromObjects'), array($relations,$multimediaTable/*,$isMultimedia=true*/));
					$key = $multimediaName.'s';

					$returnMultimedia[$key] = $relations;
					$returnMultimedia[$key]['tag'] = $multimediaName;
				endif;
			endforeach;

			
			return $returnMultimedia;
		else:
			$msg = "El módulo <b>". $module ."</b> está pidiendo <b>multimedias</b>, pero no está correctamente configurado";
			Error::Alert($msg);
			die();
		endif;
	}


	public static function GetlistByObjectId($options)
	{
		$defaults = array(
			'object_id' => false,
			'type_id'   => 1,
			'model'     => 'MultimediaModel',
			'table'     => 'multimedia',
			'debug'		=> false
		);
		$options = util::extend($defaults,$options);

		$fields = array('*');
		$MultimediaModelReflection = new ReflectionClass('MultimediaModel');
		$fields = Model::parseFields(
			$MultimediaModelReflection->getStaticPropertyValue('tables'), 
			$fields, 
			$MultimediaModelReflection->getStaticPropertyValue('relationTable')
		);

		$params = array(
			'table'     => MultimediaModel::$relationTable,
			'fields'    => $fields,
			'filters'   => array('object_id='.$options['object_id'], 'multimedia_typeid='.$options['type_id']),
			'orderby'   => 'relation_order'
		);

		$list = parent::select($params,$options['debug']);

		if(count($list)):
			$objects = array();
			foreach($list as $item):
				$object = self::getById(
					array(
						'multimedia_id' => $item['multimedia_id'],
						'type_id'       => $options['type_id'],
						'model'         => $options['model'],
						'table'         => $options['table']
					)
				);

				if($object):
					$object['order-att'] = $item['relation_order'];
					array_push($objects, $object);
				endif;
			endforeach;
			//Util::debug($objects);
			//die();
			return $objects;
		else:
			return false;
		endif;

	}


	public static function setMultimediaByObjectId($options)
	{
		$defaults = array(
			'multimedia_id' => false,
			'object_id'     => false,
		);
		$options = util::extend($defaults,$options);

		if($options['object_id'] && $options['multimedia_id']){

			$object_typeid     = Object::getTypeByObjectId($options['object_id']);
			$multimedia_typeid = self::getTypeByMultimediaId($options['multimedia_id']);	
			$params = array(
				'table'  => MultimediaModel::$relationTable,
				'fields' => array(
					'object_id'         => $options['object_id'], 
					'multimedia_id'     => $options['multimedia_id'], 
					'object_typeid'     => $object_typeid,
					'multimedia_typeid' => $multimedia_typeid
				),
			);
			parent::insert($params);
			return;
		}else{
			return false;
		}
	}

	public static function setMultimediaOrderByObjectId($object_id, $mid, $order)
	{
		$params = array(
			'table'  => MultimediaModel::$relationTable,
			'fields' => array('relation_order'=>$order),
			'filters' => array('object_id='.$object_id, 'multimedia_id='.$mid),
		);
		return parent::update($params);
	}

	public static function setRelationOrder($DTO)
	{
		if(isset($DTO['order']) && count($DTO['order']) && $DTO['order']!=''):
			foreach($DTO['order'] as $order=>$mid):
				self::setMultimediaOrderByObjectId($DTO['object_id'], $mid, ($order + 1));
			endforeach;
			return;
		endif;
	}


	public static function getRelatedMultimediaCount($options)
	{
		$defaults = array(
			'multimedia_id' => false,
			'name'		=> 'object'
		);
		$options = util::extend($defaults,$options);


		$ModuleConfiguration = ConfigurationManager::GetModuleConfiguration($options['name']);
		$MultimediaConfiguration = ConfigurationManager::Query('multimedias/multimedia',$ModuleConfiguration);

		$objects = array();

		foreach($MultimediaConfiguration as $relation):
			
			$type_id = (int)$relation->getAttribute('type_id');

			$params = array(
				'fields'    => array('*'),
				'table'     => MultimediaModel::$relationTable,
				'filters'   => array('multimedia_id='.$options['multimedia_id']),
				'exclusive' => false
			);
			$relations = parent::select($params);

			$item = array();
			$item['name-att'] = (string)$relation->getAttribute('node_name');
			$item['count-att'] = count($relations);
			array_push($objects, $item);

		endforeach;
		$objects['tag'] = 'multimedia';
		return $objects;
	}

	
	public static function getRelationsByRelationId($multimedia_id, $type_id)
	{
		$params = array(
			'table' => self::$objectRelarionTable,
			'filters' => array('multimedia_relationid='.$multimedia_id, 'multimedia_typeid='.$type_id),
		);
		$result = parent::select($params);
		return $result;
	}

	public static function getTypeByMultimediaId($multimedia_id)
	{
		$params = array(
			'table' => MultimediaModel::$table,
			'filters' => array('multimedia_id='.$multimedia_id),
		);
		$result = parent::select($params);
		return $result[0]['multimedia_typeid'];
	}

	public static function deleteRelation($object_id, $mid)
	{
		$params = array(
			'table'  => MultimediaModel::$relationTable,
			'filters' => array('object_id='.$object_id, 'multimedia_id='.$mid),
		);
		parent::delete($params);
	}
}
?>