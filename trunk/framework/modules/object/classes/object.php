<?php
class Object extends Module
{
	/**
	*	List of Objects
	*	@return objects
	**/
	public static function GetList($options = array())
	{
	

		$defaults = array(
			'model'			=> 'ObjectModel',
			'module'        => 'object',
			'table'			=> 'object',
			'currentPage'	=> 1,
			'display'		=> 10, 
			'state'			=> false,
			'type_id'		=> false,
			'categories'    => false,
			'sort'          => 'creation_date',
			'order'         => 'DESC',
			'multimedias' 	=> true,
			'relations'		=> true,
			'startdate'     => false,
			'enddate'       => false,
			'fields'		=> false,
			'exclude'		=> false,
			'debug'			=> false
		);



		$options = Util::extend(
			$defaults,
			$options
		);

		$module = ConfigurationManager::GetModuleConfiguration(
			$options['module']
		);

		//Get Fields and Unset the Content Field for Performance
		$fields = array('*');
		$fields = Model::parseFields(ObjectModel::$tables, $fields, ObjectModel::$table);
		$index = array_search('object.object_content as object_content', $fields);

		if($index !== false) unset($fields[$index]);

		//Util::debug($options);
		//DB Query
		$params = array(
			'fields'	=> $fields,
			'table'		=> ObjectModel::$table,
			'filters'	=> array(),
			'limit'     => (($options['currentPage']-1) * $options['display']).','.$options['display'],
			'orderby'   => $options['sort'].' '.$options['order'],
		);
		
		if($options['state'] !== false): 
			array_push($params['filters'], 'object_state='.$options['state']);
		endif;

		if($options['type_id']):
			array_push($params['filters'], 'object_typeid='.$options['type_id']);
		endif;

		// if($options['site']):
		// 	array_push($params['filters'], 'site_id='.$options['site']);
		// endif;
		
		if($options['startdate']):
			array_push($params['filters'], 'creation_date>='.$options['startdate']);
		endif;

		if($options['enddate']):
			array_push($params['filters'], 'creation_date<='.$options['enddate']);
		endif;

		
		if($options['exclude']):
			array_push($params['filters'], 'object_id not in ('.$options['exclude'] . ')');
		endif;

		$objects = array();
		

		if(isset($options['categories']) && $options['categories']!= false):

			$objects = Object::getObjectsByCategoryId($options);
			if(!$objects) return false;

			$count   = $objects['total'];
			unset($objects['total']);

		else:

			$objects = parent::select($params,$options['debug']);
			if(!$objects) return false;

			$params['fields'] = array('count(object_id) as total');
			unset($params['limit']);
			$total = parent::select($params, $options['debug']);
			$count = $total[0]['total'];
		endif;


				
		$returnObjects = self::ParseObjects($options, $objects);
		$returnObjects['total-att'] = $count;

		$moduleSession = array();
		$moduleSession['currentPage'] = ($options['currentPage']) ? $options['currentPage'] : 1;
		$moduleSession['categories']  = ($options['categories']) ? $options['categories'] : '';
		$moduleSession['state']       = ($options['state'] !== false) ? $options['state'] : '';

		Session::Set($options['module'], $moduleSession);

		return $returnObjects;
	}



	public static function ParseObjects($options, $objects)
	{
		$defaults = array(
			'model'			=> 'ObjectModel',
			'module'        => 'object',
			'table'			=> 'object',
			'currentPage'	=> false,
			'display'		=> false, 
			'state'			=> false,
			'type_id'		=> false, 
			'multimedias' 	=> true,
			'relations'		=> true,
		);

		$options = Util::extend(
			$defaults,
			$options
		);
		
		$modelReflection = new ReflectionClass($options['model']);

		$parsedObjects  = call_user_func_array(
			array(
				'Model', 
				'parseFieldsFromObjects'
			), 
			array(
				$objects,
				$options['table'],
				$modelReflection->getStaticPropertyValue('tables'), 
				$modelReflection->getStaticPropertyValue('objectFields'),
				$verbose=true
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
						'parsePrimaryKeyAlias'), 
					array(
						$modelReflection->getStaticPropertyValue('tables'), 
						$options['table']
					)
			);

			
			foreach($parsedObjects as $key=>$object):

				$returnObjects[$key] = $object;
				
				$creation_userid = (isset($object['creation_userid-att'])) ? $object['creation_userid-att'] : $object['creation_userid'];
				if($creation_userid != 0):
					if($creation_userid == -1):
						$returnObjects[$key]['createdby'] = 'Importación automática';
					else:	
						$ownerUser = Admin::getById($creation_userid);
						$returnObjects[$key]['createdby'] = $ownerUser['name'].' '.$ownerUser['lastname'];
					endif;
				endif;
				
				$modification_userid = (isset($object['modification_userid-att'])) ? $object['modification_userid-att'] : $object['modification_userid'];
				if($modification_userid != 0):
					$editedUser = Admin::getById($object['modification_userid-att']);
					$returnObjects[$key]['modifiedby'] = $editedUser['name'].' '.$editedUser['lastname'];;
				endif;

				if(isset($object['publication_userid'])):
					$publication_userid = $object['publication_userid'];
					if($publication_userid != 0):
						$publishUser = Admin::getById($object['publication_userid']);
						$returnObjects[$key]['publishedby'] = $publishUser['name'].' '.$publishUser['lastname'];;
					endif;
				endif;

				$returnObjects[$key]['categories'] 	= self::getCategoriesByObjectId(
					array('object_id' => $object[$primayKey])
				);

				$options['object_id'] = $object[$primayKey];

				if($options['relations'] !== false):

					$returnObjects[$key]['relations']  	= self::getRelatedObjects($options);
				else:
				
					$returnObjects[$key]['relations']  	= self::getRelatedObjectsCount($options);
				endif;

				
				if($options['multimedias']):
					$returnObjects[$key]['multimedias']	= Multimedia::getMultimediasByObjectId(
						array(
							'object_id' => $object[$primayKey],
							'module'    => $options['module'],
						)
					);
				endif;
			endforeach;

			return $returnObjects;
		else:
			return false;
		endif;


	}


	/** 
	*	Function: Add Object
	*	Params: Object
	*	@return: inserted ID
	**/

	public static function Add($options = array())
	{
		//validateToken
		Application::validateToken();

		//$options
		$defaultOptions = array(
			'model'		=> 'ObjectModel',
			'data'		=> false,
			'table'		=> 'object', 
			'verbose'   => true,
			'user_type' => 'backend',
			'debug'		=> false
		);

		$options = Util::extend($defaultOptions,$options);


		$modelReflection = new ReflectionClass($options['model']);


		$object = call_user_func_array(
			array(
				'Model', 
				'inputObjectFields')
			, 
			array(
				array(
					'fields'        => $options['data'],
					'table'         => $options['table'],
					'tables'        => $modelReflection->getStaticPropertyValue('tables'),
					'object_typeid' => $modelReflection->getStaticPropertyValue('object_typeid'),
					'objectFields'  => $modelReflection->getStaticPropertyValue('objectFields'),
					'verbose'       => $options['verbose']
				)
			)
		);
		
		$user = Admin::IsLoguedIn();


		if(!isset($options['data']['creation_date']))     $object['creation_date']     = date('Y-m-d H:i:s');
		if(!isset($options['data']['creation_userid']))   $object['creation_userid'] = $user['user_id-att'];
		if(!isset($options['data']['creation_usertype'])) $object['creation_usertype'] = $options['user_type'];

		
		if(isset($object['object_title'])):
			$object['object_shorttitle'] = Util::quote(Util::friendlyURL($object['object_title']));
		endif;
		
		// Once the data has a object structure, we need to parse and check its fields 
		$object = call_user_func_array(
			array(
				'Model', 
				'inputFields')
			, 
			array(
				ObjectModel::$tables,
				$object,
				ObjectModel::$table,
				$options['verbose']
			)
		);

		
		return parent::insert(
			array(
				'fields' => $object,
				'table'  => ObjectModel::$table
			)
		);
	}

	/** 
	*	Function: Edit Object
	*	Params: Object, Options
	*	@return true or false
	**/
	public static function Edit($options = array())
	{
		//validateToken
		Application::validateToken();
		
		$defaults = array(
				'data'		=> $_POST,
				'model' 	=> 'ObjectModel',
				'table' 	=> ObjectModel::$table,
				'user_type' => 'backend',
				'user_id'   => false,
				'verbose' 	=> true
		);

		$options = Util::extend($defaults,$options);
	
		$user = Admin::IsLoguedIn();

		$options['data']['modification_date']     = date('Y-m-d H:i:s');
		$options['data']['modification_userid']   = ($options['user_id'] !== false) ? $options['user_id'] : $user['user_id-att'];
		$options['data']['modification_usertype'] = $options['user_type'];
				
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
					'objectFields'  => $modelReflection->getStaticPropertyValue('objectFields'),
					'verbose'       => $options['verbose']
				)
			)
		);

		$tables = $modelReflection->getStaticPropertyValue('tables');
		$table  = $modelReflection->getStaticPropertyValue('table');

		$primayKey = $tables[$table]['primary_key'];
		if(isset($fields['object_shorttitle'])):
			$fields['object_shorttitle'] = Util::friendlyURL($fields['object_shorttitle']);
		elseif(isset($fields['object_title'])):
			$fields['object_shorttitle'] = Util::friendlyURL($fields['object_title']);
		endif;

		$status = Object::GetStatusById($fields['object_id']);
		if($status['object_state'] == 1 && !isset($fields['object_state'])){
			$fields['object_state'] = 3;
		}

		$fields = Model::parseInputFields(ObjectModel::$tables, $fields, ObjectModel::$table, $options['verbose']);

		$params = array(
			'fields'  => $fields,
			'table'   => ObjectModel::$table,
			'filters' => array('object_id='.$fields['object_id']),
		);
		return parent::update($params);
	}

	public static function Duplicate($object_id)
	{

		$params = array(
			'table'     => ObjectModel::$table,
			'filters'   => array(
				'object_id='.$object_id
			)
		);
		$old_item   = parent::select($params);		


		$new_item = $old_item[0];
		$user = Admin::IsLoguedIn();

		unset($new_item['object_id']);
		unset($new_item['modification_date']);
		unset($new_item['modification_userid']);
		unset($new_item['modification_usertype']);
		unset($new_item['publication_date']);
		unset($new_item['publication_userid']);

		$new_item['object_title']          = "Copia de: ".$old_item[0]['object_title'];
		$new_item['creation_date']         = date('Y-m-d H:i:s');
		$new_item['creation_userid']       = $user['user_id-att'];
		$new_item['creation_usertype']     = 'backend';
		$new_item['modification_userid']   = 0;
		$new_item['modification_usertype'] = '';
		$new_item['object_state']          = 0;

		$newParams = array(
			'table'  => ObjectModel::$table,
			'fields' => $new_item,
		);
		$new_id = parent::insert($newParams);

		// Duplicate Categories
		$categories = self::getCategoriesByObjectId(array('object_id' => $object_id,));
		if(isset($categories[0]))
		{
			$newCategories = array();
			foreach($categories as $key=>$category)
			{
				if(is_numeric($key))
				{
					array_push($newCategories, $category['category_id-att']);
				}
			}
			$dto = array(
				'object_id'  => $new_id,
				'categories' => $newCategories,
			);
			self::setCategoriesByObjectId($dto);
		}
		

		// Duplicate Multimedias
		$multimediaQuery = array(
			'table'   => 'multimedia_object',
			'filters' => array('object_id='.$object_id),
		);
		$multimedias = parent::select($multimediaQuery);
		
		if(isset($multimedias[0]))
		{
			foreach($multimedias as $multimedia)
			{
				$newRecord = $multimedia;
				unset($newRecord['relation_oder']);
				$newRecord['object_id'] = $new_id;
				$newRecordSql = array(
					'table'  => 'multimedia_object',
					'fields' => $newRecord,
				); 
				parent::insert($newRecordSql);
			}
		}
		return;
	}

	/**
	*	Function: Remove Object
	*	Params: Object Id
	*	@return: true or false
	**/
	public static function Remove($object_id)
	{

		if(is_numeric($object_id)){
			$query = "INSERT INTO object_deleted SELECT * FROM object WHERE object_id=".$object_id;
			parent::customdelete($query);
			
			// Lo borro si existe en las categorias
			$params1 = array(
				'table'  => ObjectModel::$objectCategoryTable,
				'filters'=> array('object_id='.$object_id)
			);
			parent::delete($params1);
			
			// Lo borro si esta relacionado a un objeto
			$params2 = array(
				'table'  => ObjectModel::$objectRelarionTable,
				'filters'=> array('object_id='.$object_id.' or object_relationid='.$object_id)
			);
			parent::delete($params2);

			$params = array(
				'table'  => ObjectModel::$table,
				'filters'=> array('object_id='.$object_id)
			);
			return parent::delete($params);
		}
	}



	public static function getById($options)
	{ 

		$defaults = array(
				'model'		 => 'ObjectModel',
				'table'      => 'object',
				'module'	 => 'object',
				'object_id'	 => false,
				'type_id'	 => false,
				'state'		 => false, 
				'relations'	 => true,
				'multimedias' => true,
				'categories' => true,
				'debug'		 => false,
				'level'      => 3 // Arbol de categorias padre
		);

		$options = Util::extend($defaults,$options);

		if(!$options['object_id']) return false;

		// Added for frontend
		// if(Application::isFrontend())
		// {
		// 	return self::GetByIdPublished($options);
		// 	die;
		// }

		//Query
		$params = array(
			'table'     => ObjectModel::$table,
			'filters'   => array(
				'object_id='.$options['object_id']
			)
		);



		$result = parent::select($params);

		if(!isset($result[0])):
			return false;
		endif;


		$moduleConfig = ConfigurationManager::GetModuleConfigurationByType($result[0]['object_typeid']);

		$options['model']   = $moduleConfig->getAttribute('model');
		$options['module']  = $moduleConfig->getAttribute('name');
		$options['type_id'] = $result[0]['object_typeid'];

		$returnObjects = self::ParseObjects($options, $result);
		
		unset($returnObjects['name-att']);
		unset($returnObjects['type-att']);

		return $returnObjects[0];
	}



	public static function getByShortTitle($options)
	{ 

		$defaults = array(
				'model'				=> 'ObjectModel',
				'table'      		=> 'object',
				'module'	 		=> 'object',
				'shorttitle'		=> false,
				'type_id'	 		=> false,
				'state'		 		=> false, 
				'relations'	 		=> false,
				'multimedias' 		=> false,
				'categories' 		=> false,
				'debug'		 		=> false,
				'level'      		=> 3 // Arbol de categorias padre
		);

		$options = Util::extend($defaults,$options);

		
		
		if(!$options['shorttitle']) return false;

		//Query
		$params = array(
			'table'     => ObjectModel::$table,
			'filters'   => array(
				'object_shorttitle="'.$options['shorttitle'].'"'
			)
		);


		$result = parent::select($params,$options['debug']);

		if(!isset($result[0])):
			return false;
		endif;



		$Object=$result[0];


		$moduleConfig = ConfigurationManager::GetModuleConfigurationByType($Object['object_typeid']);

		$options['model']   = $moduleConfig->getAttribute('model');
		$options['module']  = $moduleConfig->getAttribute('name');
		$options['type_id'] = $result[0]['object_typeid'];

		$returnObjects = self::ParseObjects($options, $result);

		unset($returnObjects['name-att']);
		unset($returnObjects['type-att']);
		return $returnObjects[0];
	}


	public static function getByTypeId($options)
	{
		$defaults = array(
			 'type_id'	=>false,
			 'state'	=>false,
			 'table'	=> ObjectModel::$table, 
			 'limit'	=> 30,
			 'orderby'	=> 'object_id DESC'
		);

		$options = Util::extend($defaults,$options);

		$params = array(
			'table'     => $options['table'],
			'orderby'   => $options['orderby'],
			'limit'     => $options['limit'],
		);

		if($options['state']):
			$params['filters'] = array('object_typeid='.$options['type_id'], 'object_state='.$options['state']);
		else:
			$params['filters'] = array('object_typeid='.$options['type_id']);
		endif;
		$return = parent::select($params);


		if(isset($return[0])):
			$return['tag'] = 'object';
			return $return;
		else:
			return false;
		endif;
	}


	public static function Search($options)
	{
		$defaults = array(
			'query'			=> '',
			'type_id'		=> false,
			'currentPage'   => 1,
			'display'       => 20,
			'model'	        => 'ObjectModel',
			'table'         => ObjectModel::$table,
			'state'         => false,
			'categories'    => false,
			'multimedias' 	=> true,
			'relations'		=> false,
			'debug'			=> false,
			'parent'        => false,
			'fromToday'     => false,
			'debug'			=> false
		);

		$options = util::extend(
			$defaults,
			$options
		);

		if($options['query']!=''){

			$query = str_replace("'", "\'", $options['query']);
			
			if($options['categories']){
				$collection = self::SearchInCategories($options);
			}else{
				$collection = self::SearchSimple($options);
			}

			$modelReflection               = new ReflectionClass($options['model']);
			$collection['tag']             = $modelReflection->getStaticPropertyValue('tag');
			$collection['type-att']        = $options['type_id'];
			$collection['display-att']     = $options['display'];
			$collection['currentPage-att'] = $options['currentPage'];

			return $collection;
		}

	}

	private static function SearchSimple($options)
	{
		/* 
			Repetir el array con valores por default no es necesario,
			Al ser un metodo privado, solo será llamado desde @Search 
			que ya tiene un array de defaults
		*/

		$range = ($options['currentPage'] - 1) * $options['display'];

		$params = array(
			'table'     => ObjectModel::$table,
			'limit'     => $range.', '.$options['display'],
			'orderby'   => 'object_id DESC',
		);

		
		$params['filters'] = array(
			"(object_title like '%".$options['query']."%' or object_tags like '%".$options['query']."%' or creation_date like '%".$options['query']."%')",
			'object_typeid='.$options['type_id']
		);

		if($options['state'] !== false)
		{
			array_push($params['filters'], 'object_state='.$options['state']);
		}

		$objects = parent::select($params,$options['debug']);
		if(!$objects) return false;

		$returnObjects = self::ParseObjects($options, $objects);

		//getMultimedias
		if($options['multimedias']):
			foreach($objects as $key => $object):
				$returnObjects[$key]['multimedias']	= Multimedia::getMultimediasByObjectId(
					array(
						'object_id' => $object['object_id'],
						'module'    => $options['module'],
						'debug'		=> false
					)
				);
			endforeach;
		endif;

		//getRelations
		// if($options['relations'] !== false):
		// 	foreach($returnObjects as $key => $object):
		// 		$relationsOptions['object_id'] = $object['id-att'];
		// 		//$relationsOptions['debug'] = true;
		// 		//$relations 	= self::getRelatedObjects($relationsOptions);
		// 		//$returnObjects[$key]['relations'] = $relations;
		// 	endforeach;
		// endif;


		
		unset($params['limit']);
		$count = parent::select($params);
		$returnObjects['total-att'] = count($count);
			
		return $returnObjects;
		
	}

	private static function SearchInCategories($options)
	{
		/* 
			Repetir el array con valores por default no es necesario,
			Al ser un metodo privado, solo será llamado desde @Search 
			que ya tiene un array de defaults
		*/
		$range = ($options['currentPage'] - 1) * $options['display'];

		$params = array(
			'fields'    => array('object.*'),
			'table'     => ObjectModel::$table.' as object inner join '.ObjectModel::$objectCategoryTable.' as cat on object.object_id=cat.object_id',
			'limit'     => $range.', '.$options['display'],
			'orderby'   => 'object.object_id DESC',
		);

		if(!$options['parent']):
			$params['filters'] = array('cat.category_id in ('.$options['categories'].')');
		else:
			$params['filters'] = array('cat.category_parentid='.$options['categories']);
		endif;

		if($options['state'] !== false):
			array_push($params['filters'], 'object.object_state='.$options['state']);
		endif;

		array_push($params['filters'], 'object.object_typeid='.$options['type_id']);
		array_push($params['filters'], "(object.object_title like '%".$options['query']."%' or object.object_content like '%".$options['query']."%' or object.object_summary like '%".$options['query']."%' or object.object_custom like '%".$options['query']."%' or creation_date like '%".$options['query']."%')");

		if($options['fromToday']):
			$today = date('Y-m-d');
			$datetime = $today.' 00:00:00';
			array_push($params['filters'], "object.creation_date >='".$datetime."'");
		endif;

		$objects = parent::select($params, $options['debug']);
		if(!$objects) return false;

		$returnObjects = self::ParseObjects($options, $objects);

		
		unset($params['limit']);
		$count = parent::select($params);
		$returnObjects['total-att'] = count($count);
			
		return $returnObjects;

	}


	public static function getHeadersById($options)
	{
		$defaults = array(
			'object_id'	=>false,
			'table'		=> ObjectModel::$table,
			'type_id'	=> false
		);

		$options = Util::extend($defaults,$options);

		if($options['object_id']== false && $options['type_id'] == false):
			return false;
		endif;

		$params = array(
			'fields' => array(
				'object_id', 
				'object_title',
				'object_summary',
				'object_parent',
				'creation_date', 
				'modification_date', 
				'object_state', 
				'creation_userid', 
				'object_custom'
			),
			'table'  => $options['table'],
			'filters'=> array(
				'object_id='.$options['object_id'], 
				'object_typeid='.$options['type_id']
			),
		);

		$return = parent::select($params);
		
		if(isset($return[0])):
			$return[0]['object_summary'] = str_replace("<![CDATA[","",$return[0]['object_summary']);
			$return[0]['object_summary'] = str_replace("]]>","",$return[0]['object_summary']);
			return $return;
		else:
			return false;
		endif;
	}


	
	
	/**
	* get Objects by category
	**/
	public static function getObjectsByCategoryId($options)
	{
		$defaults = array(
			'categories' => false,
			'type_id'	 => false, 
			'state'		 => false, 
			'parent'	 => false,
			'limit'		 => false,
			'display'	 => 10,
			'currentPage' => 1, 
			'fromToday'  => false,
			'exclude'	 => false,
			'debug'      => false
		);

		$options = util::extend($defaults,$options);


		$params = array(
			'fields' => array(
				'DISTINCT(object.object_id)', // When listing two o more categories, avoid repeated items 
				'object.object_typeid', 
				'object.object_title', 
				'object.object_summary', 
				'object.object_state', 
				'object.object_custom', 
				'object.creation_date',
				'object.creation_userid',
				'object.modification_date',
				'object.modification_userid',
				'object.location_id',
			),
			'table'   => ObjectModel::$table.' as object inner join '.ObjectModel::$objectCategoryTable.' as object_cat on object.object_id=object_cat.object_id left join category on object_cat.category_id = category.category_id',
			'orderby' => 'object.creation_date DESC',
			'limit'   => (($options['currentPage']-1) * $options['display']).','.$options['display'],
		);

		if(!$options['parent']):
			$params['filters'] = array('object_cat.category_id in ('.$options['categories'].')');
		else:
			$params['filters'] = array('category.category_parent='.$options['parent']);
		endif;

		if($options['state'] !== false):
			array_push($params['filters'], 'object.object_state='.$options['state']);
		endif;

		if($options['exclude'] !== false):
			array_push($params['filters'], 'object.object_id not in ('.$options['exclude'].')');
		endif;

		array_push($params['filters'], 'object.object_typeid='.$options['type_id']);

		if($options['fromToday']):
			$today = date('Y-m-d');
			$datetime = $today.' 00:00:00';
			array_push($params['filters'], "object.creation_date >='".$datetime."'");
		endif;

		$objects = parent::select($params, $options['debug']);

		// if there's no content for this category, get childs categories content
		if(empty($objects) && !$options['parent']){
			$options['parent'] = $options['categories'];
			return self::getObjectsByCategoryId($options);
		}		

		$params['fields'] = array('count(object.object_id) as total');
		unset($params['limit']);
		$count = parent::select($params, $options['debug']);
		$objects['total'] = $count[0]['total'];

		if(count($objects)):
			return $objects;
		else:
			return false;
		endif;
	}

	
	/* Metodos llamados por otros modulos para obtener categorias de los objetos */

	public static function getCategoriesByObjectId($options)
	{
		$defaults = array(
			'object_id'	=> false, 
			'parent' 	=> false,
			'level' 	=> 0,
			'debug'     => false,
		);

		$options = util::extend($defaults,$options);

		if($options['object_id'] === false): 
			return false; 
		endif;

		$params = array(
			'fields' => array('*'),
			'table'  => ObjectModel::$objectCategoryTable,
			'orderby' => 'category_parentid ASC',
		);

		if($options['parent'] === false):
			$params['filters'] = array(
				'object_id='.$options['object_id']
			);
		else:
			$params['filters'] = array(
				'object_id='.$options['object_id'], 
				'category_parentid='.$options['parent']
			);
		endif;

		$categories = parent::select($params, $options['debug']);
		if(count($categories)):
			$list = array();
			$parentsArr = array();
			foreach($categories as $category):

				if($category['category_parentid']!==0):
					/*
					if(!in_array($category['category_parentid'], $parentsArr)):
						$parentCat = Category::getById($category['category_parentid']);
						array_push($parentsArr, $category['category_parentid']);
						array_push($list, $parentCat);
					endif;
					*/


					$item = Category::getParentsById($category['category_id'], $options['level']);
					$item['order-att'] = $category['category_order'];

					//$item = Category::getById($category['category_id']);
					//$item['order-att'] = $category['category_order'];
				endif;
				array_push($list, $item);
			endforeach;
			$list['tag'] = 'category';
			$list['object_id-att'] = $options['object_id'];
			return $list;
		else:
			return false;
		endif;
	}

	public static function setCategoriesByObjectId($DTO)
	{

		$object_id = $DTO['object_id'];
		if(!empty($DTO['categories'])):
			foreach($DTO['categories'] as $key=>$categoryid):

				if(!self::hasCategory($categoryid, $object_id))
				{
					//echo "Voy a agregar la categoria: ".$categoryid."\n";
					
					// Tomo el parent automaticamente
					$category  = Category::getParentsById($categoryid, $level=2);
					$parent_id = (isset($category['parent'])) ? $category['parent']['category_id-att'] : 0;

					$params = array(
						'table'  => ObjectModel::$objectCategoryTable,
						'fields' => array('object_id'=>$object_id, 'category_parentid'=>$parent_id, 'category_id'=>$categoryid),
					);
					parent::insert($params);
				}
			endforeach;
		endif;
		return;
	}

	private static function hasCategory($category_id, $object_id)
	{
		$ObjectCategories = self::getCategoriesByObjectId($options = array('object_id'=>$object_id));

		if($ObjectCategories)
		{
			foreach($ObjectCategories as $objectCategory){
				if($objectCategory['category_id-att'] == $category_id)
				{
					//echo "la categoria: ".$category_id." ya existe\n";
					return true;		
				}
			}
			return false;
		}
	}

	public static function deleteCategory($object_id, $category_id)
	{

		$params = array(
			'table'  => ObjectModel::$objectCategoryTable,
			'filters' => array('object_id='.$object_id, 'category_id='.$category_id),
		);
		parent::delete($params);
		return 1;
	}

	public static function setCategoriesOrder($DTO)
	{
		if(isset($DTO['order']) && count($DTO['order'])):
			

			$categories = self::getCategoriesByObjectId($options = array('object_id'=>$DTO['object_id']));

			$fields = array('*');
			$fields = Model::parseFields(ObjectModel::$tables, $fields, ObjectModel::$objectCategoryTable);
			$params = array(
				'table'     => ObjectModel::$objectCategoryTable,
				'fields'    => $fields,
				'filters'   => array('object_id='.$DTO['object_id']),
			);
			$categories = parent::select($params);
			
			foreach($categories as $category):
				if($category['object_id']==$DTO['object_id']):
				
					if(in_array($category['category_id'], $DTO['order'])):
						$position = array_search($category['category_id'], $DTO['order']);
						$params = array(
							'table' => ObjectModel::$objectCategoryTable,
							'filters' => array('object_id='.$category['object_id'], 'category_id='.$category['category_id']),
							'fields' => array('category_order'=>($position+1)),
						);
						parent::update($params);
					endif;
				endif;
			endforeach;
			die();
			return $categories;
		endif;
	}





	/* Metodos llamados por todos los modulos para obtener relaciones */

	public static function getRelatedObjects($options)
	{
		$defaults = array(
			'object_id' => false,
			'module'    => 'object',
			'model'     => 'ObjectModel',
			'table'     => 'object',
			'debug'		=> false
		);
		$options = Util::extend($defaults,$options);


		$RelationsConfig = ConfigurationManager::Query("/configuration/modules/module[@name='".$options['module']."']/options/group[@name='relations']/option");

		$returnObjects = array();

		if(isset($RelationsConfig) && !empty($RelationsConfig)):

			foreach($RelationsConfig as $relation):

				$moduleRelationConfig = ConfigurationManager::GetModuleConfiguration($relation->getAttribute('name'));

				//Configuration				
				$getMultimedias 	= (int)$relation->getAttribute('multimedias');
				$getSubRelations	= (int)$relation->getAttribute('subrelations');
				$subRelationsTypeId = (int)$relation->getAttribute('subrelation_typeid');
				$subRelationsMultimedias = (int)$relation->getAttribute('subrelation_multimedias');


				//Relation Object Data
				$relationTypeId 	= (int)$moduleRelationConfig->getAttribute('type_id');
				$relationModel 		= (string)$moduleRelationConfig->getAttribute('model');
				$relationName		= (string)$moduleRelationConfig->getAttribute('name');
				$relationParentName	= (string)$moduleRelationConfig->getAttribute('parent_name');

				//get Related Objects
				$objectsRelated = Object::getRelations(
					array(
						'object_id'=>$options['object_id'],
						'relation_typeid'=>$relationTypeId,
						'debug'=>$options['debug']
					)
				);

				
				//if get Objects
				if($objectsRelated):

					$modelReflection = new ReflectionClass($options['model']);
					$method = ($options['model'] == 'ObjectModel') ? 'parseFields' : 'parseFieldsFromObjects';

					$parsedObjects = call_user_func_array(
								array(
									'Model', 
									$method
								), 
								array(
									$objectsRelated,
									$options['table'],
									$modelReflection->getStaticPropertyValue('tables'),
									$modelReflection->getStaticPropertyValue('objectFields'),
								)
					);

					$returnObjects[$relationParentName] = $parsedObjects;



					/* getMultimedias */
					if($getMultimedias):
						$id = call_user_func_array(
								array(
									'Model', 
									'parsePrimaryKeyAlias'), 
								array(
									$modelReflection->getStaticPropertyValue('tables'), 
									$options['table']
								)
						);
						foreach($parsedObjects as $i=>$parsedObject):
							//$options['object_id'] = $parsedObject[$id];
							$returnObjects[$relationParentName][$i]['multimedias'] = Multimedia::getMultimediasByObjectId(array('object_id'=>$parsedObject[$id]));
						endforeach;
					endif;




					/*  getSubRelations */
					if($getSubRelations):

						$SubRelationConfig = ConfigurationManager::Query("/configuration/modules/module[@type_id='".$subRelationsTypeId."']");
						
						$Model = (string)$SubRelationConfig->item(0)->getAttribute('model');
						
						$modelReflection = new ReflectionClass($Model);
						$modelTable = $modelReflection->getStaticPropertyValue('table');
						$modelName = $SubRelationConfig->item(0)->getAttribute('name');
						//echo $modelName;
						//echo $modelReflection->$table;
						//die;

						//GetObjects
						$SubrelationObjects = Object::getRelations(
							array(
								'object_id'=>$parsedObject[$id],
								'relation_typeid'=>$subRelationsTypeId
							)
						);

				

						//ParseObjects
						if($SubrelationObjects):
							$subobjects  = call_user_func_array(
									array(
										$Model, 
										'parseFieldsFromObjects'
									), 
									array(
										$SubrelationObjects,
										$modelName,
										$modelReflection->getStaticPropertyValue('tables'),
										$modelReflection->getStaticPropertyValue('objectFields'),
										$verbose=true
									)
							);

							if($subRelationsMultimedias):
								foreach($subobjects as $key=>$sub):
									$subobjects[$key]['multimedias'] = Multimedia::getMultimediasByObjectId(array('object_id'=>$sub['id-att']));
								endforeach;
							endif;
							$returnObjects[$relationParentName][$i]['subrelations'] = $subobjects;
							$returnObjects[$relationParentName][$i]['subrelations']['tag'] = (string)$SubRelationConfig->item(0)->getAttribute('name');
						
						endif;
						
					endif;
					
					$returnObjects[$relationParentName]['tag'] = $relationName;
				endif;
			endforeach;
			return $returnObjects;
		//else:
		//	echo "El archivo <b>". basename($x[0]['file']) ."</b> está pidiendo <b>relaciones de objetos</b>, pero no tiene bien configurado el xml para ellos";
		//	die();
		endif;
	}

	public static function getRelatedObjectsCount($options = array())
	{
		$defaults = array(
			'object_id'=> false,
			'name'	=> 'object'
		);
		$options = util::extend($defaults,$options);

		//$x   			= debug_backtrace();
		$moduleName		= $options['name'];
		$moduleConfig 	= ConfigurationManager::GetModuleConfiguration($moduleName);
		$relations 		= ConfigurationManager::Query("relations/object",$moduleConfig);


		$objects = array();

		if(isset($relations) && !empty($relations)):
				foreach($relations as $relation):
					$typeId = (int)$relation->getAttribute('type_id');
					$name = (string)$relation->getAttribute('name');

					$params = array(
						'table'     => ObjectModel::$objectRelarionTable,
						'fields'    => array('*'),
						'filters'   => array('object_id='.$options['object_id'].' and object_relation_typeid='.$typeId, 'object_relationid='.$options['object_id'].' and object_typeid='.$typeId),
						'exclusive' => false
					);
					$relations = parent::select($params);

					$item = array();
					$item['name-att'] = (string)$relation->getAttribute('name');
					$item['count-att'] = count($relations);
					array_push($objects, $item);

				endforeach;
				$objects['tag'] = 'relation';
		endif;


		return $objects;
	}

	public static function getRelations($options)
	{
		$defaults = array(
			'object_id'	=> false,
			'relation_typeid' => false,
			'debug'	=>false
		);
		$options = util::extend($defaults,$options);


		$fields = array('*');
		$fields = Model::parseFields(ObjectModel::$tables, $fields, ObjectModel::$objectRelarionTable);
		$params = array(
			'fields'    => $fields,
			'table'     => ObjectModel::$objectRelarionTable,
			'filters'   => array(
				'object_id='.$options['object_id'].' and object_relation_typeid='.$options['relation_typeid'], 
				'object_relationid='.$options['object_id'].' and object_typeid='.$options['relation_typeid']
				),
			'exclusive' => false,
		);

		$list = parent::select($params,$options['debug']);
		
		if(!empty($list)):
			$objects = array();
			foreach($list as $item):
				if($options['object_id'] == $item['object_id']):
					$object = self::getHeadersById(array('object_id'=>$item['relation_id'],'type_id'=>$item['relation_type_id']));
					$object[0]['order-att'] = $item['relation_order1'];
				else:
					$object = self::getHeadersById(array('object_id'=>$item['object_id'],'type_id'=>$item['type_id']));
					$object[0]['order-att'] = $item['relation_order2'];
				endif;
				array_push($objects, $object[0]);
			endforeach;
			return $objects;
		else:
			return false;
		endif;

	}

	public static function setRelationsByObjectId($DTO)
	{
		$object_id = $DTO['object_id'];
		$relation_typeid = $DTO['type_id'];
		$object_typeid = self::getTypeByObjectId($object_id);

		$params = array(
			'table'  => ObjectModel::$objectRelarionTable,
			'filters' => array('object_id='.$object_id, 'object_relation_typeid='.$relation_typeid),
		);
		parent::delete($params);

		$inverse = self::getRelations(
			array(
				'object_id'=>$object_id,
				'relation_typeid'=>$relation_typeid
			)
		);
		$idsArr = array();

		if($inverse):
			foreach($inverse as $relation):
				array_push($idsArr, $relation['object_id']);
				/*
				$params = array(
					'table'  => ObjectModel::$objectRelarionTable,
					'filters' => array('object_id'=>$relation['object_id'], 'object_typeid'=>$relation_typeid, 'object_relationid='.$object_id, 'object_relation_typeid='.$object_typeid),
				);
				parent::delete($params);
				*/
			endforeach;
		endif;


		
		if(!empty($DTO['objects'])):
			foreach($DTO['objects'] as $key=>$object):
				if(!in_array($object, $idsArr)):
					$params = array(
						'table'  => ObjectModel::$objectRelarionTable,
						'fields' => array('object_id'=>$object_id, 'object_typeid'=>$object_typeid, 'object_relationid'=>$object, 'object_relation_typeid'=>$relation_typeid, 'object_relation_date'=>date('Y-m-d H:i:s')),
					);
					parent::insert($params);
				endif;
			endforeach;
		endif;
		return;
	}

	public static function setRelationOrder($DTO)
	{
		if(isset($DTO['order']) && count($DTO['order'])):

			$fields = array('*');
			$fields = Model::parseFields(ObjectModel::$tables, $fields, ObjectModel::$objectRelarionTable);
			$params = array(
				'table'     => ObjectModel::$objectRelarionTable,
				'fields'    => $fields,
				'filters'   => array('object_id='.$DTO['object_id'].' and object_relation_typeid='.$DTO['relation_typeid'], 'object_relationid='.$DTO['object_id'].' and object_typeid='.$DTO['relation_typeid']),
				'exclusive' => false,
			);
			$relations = parent::select($params);
			foreach($relations as $relation):
				if($relation['object_id']==$DTO['object_id']):
					$position = array_search($relation['relation_id'], $DTO['order']);
					$params = array(
						'table' => ObjectModel::$objectRelarionTable,
						'filters' => array('object_id='.$relation['object_id'], 'object_relationid='.$relation['relation_id']),
						'fields' => array('object_relation_order1'=>($position+1)),
					);
					parent::update($params);
				else:
					$position = array_search($relation['object_id'], $DTO['order']);
					$params = array(
						'table' => ObjectModel::$objectRelarionTable,
						'filters' => array('object_id='.$relation['object_id'], 'object_relationid='.$relation['relation_id']),
						'fields' => array('object_relation_order2'=>($position+1)),
					);
					parent::update($params);
				endif;
			endforeach;
			die();
			return $relations;
		endif;
	}

	public static function getRelationsByRelationId($object_id, $type_id)
	{
		$params = array(
			'table' => ObjectModel::$objectRelarionTable,
			'filters' => array('object_relationid='.$object_id, 'object_typeid='.$type_id),
		);
		$result = parent::select($params);
		return $result;
	}

	public static function getTypeByObjectId($object_id)
	{
		$params = array(
			'table' => ObjectModel::$table,
			'filters' => array('object_id='.$object_id),
		);
		$result = parent::select($params,false);

		if(is_array($result) && !empty($result)):
			return $result[0]['object_typeid'];
		else:
			return false;
		endif;
	}

	public static function deleteRelation($object_id, $relation_id)
	{
		$params = array(
			'table'  => ObjectModel::$objectRelarionTable,
			'filters' => array('object_id='.$object_id.' and object_relationid='.$relation_id, 'object_relationid='.$object_id.' and object_id='.$relation_id),
			'exclusive' => false,
		);
		parent::delete($params);

	}
	
	public static function getCategoriesFilter($options = false){
	
		$defaults = array(
			'module' => 'object'
		);		
		$options = util::extend(
			$defaults,
			$options
		);

		$moduleCategories = ConfigurationManager::Query("/configuration/modules/module[@name='".$options['module']."']/options/group[@name='categories']/option");

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








	// Publish methods
	public static function GetStatusById($object_id)
	{
		$params = array(
			'table'   => ObjectModel::$table,
			'fields'  => array('object_id', 'object_state'),
			'filters' => array('object_id='.$object_id),
		);

		$response = parent::select($params);

		if(isset($response[0]))
		{
			return $response[0];
		}
		else
		{
			return false;
		}
	}

	public static function Publish($object_id, $xml)
	{

		$filename = self::getPublicationFilePath($object_id);

		$doc = new DOMDocument('1.0', "UTF-8");
		$doc->loadXML($xml);
		$doc->save($filename);
		chmod($filename, 0775);
		
		$user = Admin::IsLoguedIn();
		$fields = array(
			'publication_date'   => date('Y-m-d H:i:s'),
			'publication_userid' => $user['user_id-att'],
			'object_state'       => 1,
		);

		$params = array(
			'table'   => ObjectModel::$table,
			'fields'  => $fields,
			'filters' => array('object_id='.$object_id),
		);
		parent::update($params);

		return true;
	}

	public static function UnPublish($object_id)
	{
		$filename = self::getPublicationFilePath($object_id);

		@unlink($filename);
		return true;
	}


	// Get Published By ID
	public static function GetByIdPublished($options)
	{
		$file = self::getPublicationFilePath($options['object_id']);


		if(file_exists($file))
		{
			return file_get_contents($file);
		}
		else
		{
			return false;
		}
	}

	public static function getPublicationFilePath($object_id)
	{
		$Site = Session::get('backend_site');

		$realPath = PathManager::
						GetContentTargetPath(
							array(
								'module' => 'object',
								'folderoption' => 'target',
								'site_preffix' => $Site['preffix']
							)
						);

		$folder   = PathManager::GetDirectoryFromId($realPath, $object_id);
		return $folder.'/'.$object_id.'.xml';	
	}

}
?>