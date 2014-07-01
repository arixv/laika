<?php

class Object_Custom extends Module
{
	/*
	* List Custom Objects
	*/
	public static function getList($options = array()){

		$defaults = array(
			'page'			=> 1,
			'display'		=> -1, 
			'table'			=> false,
			'state'			=> false,
			'categories'    => false,
			'sort'          => 'creation_date',
			'order'         => 'DESC',
			'multimedias' 	=> true,
			'fields'		=> false,
			'user_id'       => false,
			'user_type'     => false,
			'debug'			=> false,
			'internalCall'	=> false,
			'tag'			=> 'object',
			'custom_filters' => array()
		);

		$options = Util::extend(
			$defaults,
			$options
		);

		// $module = ConfigurationManager::GetModuleConfiguration(
		// 	$options['module']
		// );

		// Added for frontend
		// if(Application::isFrontend() && $options['internalCall'] === false)
		// {
		// 	return self::GetListPublished($options);
		// 	die;
		// }

		//Get Fields and Unset the Content Field for Performance
		$fields = array('*');
		$fields = Model::parseFields($options['tables'], $fields, $options['table']);
		//$fields = Model::parseFields(ObjectModel::$tables, $fields, ObjectModel::$table);
		//$index = array_search('object.object_content as object_content', $fields);
		//if($index !== false) unset($fields[$index]);

		//Util::debug($options);
		//DB Query
		$params = array(
			'fields'	=> $fields,
			'table'		=> $options['table'],
			'filters'	=> array(),
			'orderby'   => $options['sort'].' '.$options['order'],
		);

		if($options['display'] != -1):
			$params['limit']  = (($options['page']-1) * $options['display']).','.$options['display'];
		endif;

		if($options['state'] !== false):
			if($options['state'] != ''):
				array_push($params['filters'], 'state in ('.$options['state'].')');
			endif;
		endif;


		if($options['startdate']):
			array_push($params['filters'], 'creation_date>='.Util::quote($options['startdate']));
		endif;

		if($options['enddate']):
			array_push($params['filters'], 'creation_date<='.Util::quote($options['enddate']));
		endif;

		if($options['user_id'] && $options['user_type']):
			array_push($params['filters'], 'creation_userid='.$options['user_id'].' and creation_usertype='.Util::quote($options['user_type']));
		endif;

		if(!empty($options['custom_filters'])){
			foreach($options['custom_filters'] as $key=>$filter)
			{
				$params['filters'][]=$filter['field'] . $filter['operation'] . $filter['value'];
			}
		}

		$returnObjects = parent::select($params,$options['debug']);
		if(!$returnObjects) return false;

		$params['fields'] = array('count(*) as total');
		unset($params['limit']);
		$total = parent::select($params, $options['debug']);
		$count = $total[0]['total'];

		$Response = $returnObjects;
		$Response['total-att'] = $count;
		$Response['page-att'] = $options['page'];
		$Response['pagesize-att'] = $options['display'];
		$Response['tag'] = $options['tag'];
	

		// $moduleSession = array();
		// $moduleSession['page'] = ($options['page']) ? $options['page'] : 1;
		// $moduleSession['categories']  = ($options['categories']) ? $options['categories'] : '';
		// $moduleSession['state']       = ($options['state'] !== false) ? $options['state'] : '';
		// $moduleSession['startdate']   = ($options['startdate'] !== false) ? $options['startdate'] : '';
		// $moduleSession['enddate']     = ($options['enddate'] !== false) ? $options['enddate'] : '';

		//Session::Set($options['module'], $moduleSession);

		return $Response;
	}

	public static function getById($options = array())
	{ 

		$defaults = array(
				'model'			=> false,
				'table'     	=> false,
				'tables'		=> false,
				'module'		=> false,
				'id'	 		=> false,
				'state'		 	=> false, 
				'relations'	 	=> true,
				'multimedias'	=> true,
				'categories' 	=> true,
				'level'      	=> 3, // Arbol de categorias padre
				'internalCall'	=> false,
				'debug'			=> false
		);

		$options = Util::extend($defaults,$options);

		if(!$options['id']) return false;

		// Added for frontend
		// if(Application::isFrontend() && $options['internalCall'] === false)
		// {
		// 	return self::GetByIdPublished($options);
		// 	die;
		// }

		$fields = array("*");
		$fields = Model::parseFields($options['tables'], $fields, $options['table']);

		//Query
		$params = array(
			'fields'	=> $fields,
			'table'     => $options['table'],
			'filters'   => array(
				'id='.$options['id']
			)
		);


		$result = parent::select($params,$options['debug']);

		if(!isset($result[0])):
			return false;
		endif;

		return $result[0];
	}


	/*
	*	Add Custom Object
	*/
	 public static function Add($options)
	{
		$defaults = array(
			'fields'=>array(),
			'table'=>'',
			'debug'=>0
		);
		$options = util::extend($defaults,$options);
		$options['fields']['creation_date'] = 'now()';
		unset($options['fields']['modToken']);
		
		if(isset($options['fields']['title'])):
			$options['fields']['shorttitle'] = Util::quote(Util::friendlyURL($options['fields']['title']));
		endif;
		
		
		$params = array(
			'fields'=>$options['fields'],
			'table'=> $options['table']
		);

		

		$result =  parent::insert($params,$options['debug']);
		return $result;
	}

	/*
	*	Edit Object
	*/
	public static function Edit($options)
	{
		$defaults = array(
			'fields'=>array(),
			'table'=>'',
			'debug'=>0
		);
		$options = util::extend($defaults,$options);

		if(isset($options['fields']['modToken'])):
			unset($options['fields']['modToken']);
		endif;

		if(isset($options['fields']['shorttitle']) && $options['fields']['shorttitle']!=''):
			$options['fields']['shorttitle'] = Util::quote(Util::friendlyURL($options['fields']['shorttitle']));
		elseif(isset($options['fields']['title'])):
			$options['fields']['shorttitle'] = Util::quote(Util::friendlyURL($options['fields']['title']));
		endif;

		$status = self::GetState(
			array(
				'id'=> $options["fields"]['id'],
				'table'=>$options["table"]
			)
		);

		if($status['state'] == 1 && !isset($options["fields"]['state'])){
		 	$options['fields']['state'] = 3;

		}

		$params = array(
			'fields'  => $options["fields"],
			'table'   => $options["table"],
			'filters' => array(
				'id='.$options["fields"]["id"]
			)
		);
		$response = parent::update($params);
		return $response;
	}

	/*
	* GetStatus
	*/
	public static function GetState($options){
		$defaults = array(
			'id'=> false,
			'table'=>'',
			'debug'=>false
		);
		$options = util::extend($defaults,$options);

		$params = array(
			'fields'  => array('id','state'),
			'table'   => $options['table'],
			'filters' => array('id='.$options['id']),
		);

		$response = parent::select($params);

		return (isset($response[0]))?$response[0]:false;

	}


	/*
	* Update State
	*/
	public static function UpdateState($options){
		$defaults = array(
			'id'=> false,
			'table'=>'',
			'state'=>false,
			'debug'=>false
		);
		$options = util::extend($defaults,$options);

		$params = array(
			'fields'  => array(
				'state'=>$options['state']
			),
			'table'   => $options['table'],
			'filters' => array('id='.$options['id']),
		);

		$response = parent::update($params);

		return (isset($response[0]))?$response[0]:false;

	}


	/* 
	Function Remove 
	*/
	public static function Remove($options)
	{
		$defaults = array(
			'id'=>false,
			'table'=>false,
			'debug'=>false
		);
		$options = util::extend($defaults,$options);

		$params = array(
			'table'   => $options['table'],
			'filters' => array('id='.$options['id']),
		);

		$response = parent::delete($params,$options['debug']);

		return $response;
	}


	public static function Publish($options)
	{
		$defaults = array(
			"object"=> array(),
			"module"=>false,
			"model"=>false,
			"table"	=> "",
			"publication_path"=>"",
			'publication_type'=>'json' //json|xml
		);
		$options = util::extend($defaults,$options);
		$User = Admin::IsLoguedIn();
		$Object = $options["object"];

		if($User['access_level-att'] > 2)
		{
			echo "El nivel de acceso de tu usuario no permite publicación";
			return false;
		}

		if($Object['state-att'] == 0 || $Object['state-att'] == 3)
		{
			$json_object = json_encode($Object);
			$handle = fopen($options["publication_path"],"w+");
			fwrite ($handle,$json_object);
			fclose($handle);
			chmod($options["publication_path"], 0775);

			$response = Object_Custom::updatePublication(array(
				"id"=>(isset($Object["id-att"]))?$Object["id-att"]:$Object["id"],
				"table"=>$options["table"],
				"user_id"=>$User['user_id-att']
			));
			return 1;
		}else{
			echo "El objeto ya esta publicado";
			return false;
		}
	}

	public static function unpublish($options){

		$defaults = array(
				"object"=> array(),
				'module'=>false,
				'model'=>"",
				"table"	=> "",
				"publication_path"=>"",
				'publication_type'=>'json'
		);
		$options = util::extend($defaults,$options);
		$User = Admin::IsLoguedIn();
		$Object = $options["object"];

		if($User['access_level-att'] > 2)
		{
			echo "El nivel de acceso de tu usuario no permite publicación";
			return 0;
		}


		if($Object['state-att'] == 1)
		{
			
			self::Edit(array(
				"fields"=> array("id"=>$Object["id-att"],"state"=>0),
				"table"=>$options["table"],
			));

			if(is_file($options["publication_path"])){
				@unlink($options["publication_path"]);
				
			}

			return 1;
		}
	}



	public static function updatePublication($options)
	{
		$defaults = array(
			'id'=>false,
			'table'=>false,
			'user_id'=>false
		);

		$options = util::extend($defaults,$options);
		
		if($options["id"] && $options["table"] && $options["user_id"]):


			return parent::update(
				array(
					'fields'  => array(
						'publication_date'   => date('Y-m-d H:i:s'),
						'publication_userid' => $options["user_id"],
						'state'       => 1,
					),
					'table'   => $options["table"],
					'filters' => array('id='.$options["id"]),
				)
			);	
		else:
			return false;
		endif;

	}


	public static function Search($options = array())
	{
		$default = array(
			'q'=>'',
			'fields'=>'*',
			'search_in'=>array(),
			'table'=>'',
			'state'=>false,
			'page'=>1,
			'pagesize'=>10,
			'order'=>'creation_date DESC',
			'tag'=>'',
			'debug'=>false
		);
		$options = util::extend($default,$options);

		$sql_values = array();

		$query = str_replace("'", "\'", $options["q"]);
		$query = "%".$query."%";

		//SQL STRING
		$select = "SELECT ".$options["fields"];
		$from 	= " FROM " . $options['table'];
		$where 	= " WHERE (";

		foreach($options['search_in'] as $field)
		{
			$where.= " " .$field. " like ? or ";
			$sql_values[]=$query;
		}
		$where = substr($where,0,strlen($where)-strlen("or "));
		$where.=")";

		if($options['state']): $where.= " and state=?"; endif;

		$orderby = " ORDER BY ".$options['order'];

		$limit = " LIMIT ".(($options['page']-1) * $options['pagesize']).','.$options['pagesize'];

		$sql_query = $select.$from.$where.$orderby.$limit;

		if($options['state']): $sql_values[]= $options['state'];endif;

		$Result = parent::custom($sql_query,$sql_values,$options["debug"]);

	

		if(isset($Result[0])):

			//foreach($return as $key=>$value){
				//$return[$key]["categories"] = Normativa::getCategoriesByObjectId($value["id-att"]);
			//}

			$Result['tag'] = $options['tag'];
			// Util::debug($Result);die;
			return $Result;
		else:
			return false;
		endif;
	}


}
?>