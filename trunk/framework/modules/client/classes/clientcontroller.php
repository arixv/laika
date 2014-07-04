<?php
class ClientController extends ObjectController implements ModuleController {

	/**
	* Display a List of Objects
	* @return none
	**/
	public static function BackDisplayDefault()
	{	
		
		$page   = Util::getvalue('page', 1);
		$state  = Util::getvalue('state', 'false');
		$categories = (Util::getvalue('categories')) ? implode(',', Util::getvalue('categories')) : false;


		$options = array(
			'page' => $page,
			'display'	  => 15, 
			'state'		  => ($state != 'false') ? $state : false, 
			'categories'  => $categories,
			'multimedia'  => true,
			'relations'   => false,
			'startdate'   => Util::getvalue('startdate'),
			'enddate'     => Util::getvalue('enddate'),
			//'debug'     => false,
		);


		$Collection = Client::GetList($options);
		
		
		//$CategoriesFilters = Client::getCategoriesFilter($options);
		
		self::loadAdminInterface();
		self::$template->setcontent($Collection, null, 'collection');
		//self::$template->setcontent($CategoriesFilters, null, 'filter');
		self::$template->setparam('state',$options['state']);
		self::$template->setparam('category_id',$options['categories']);
		self::$template->setparam('startdate', $options['startdate']);
		self::$template->setparam('enddate',$options['enddate']);
		self::$template->add("client.list.xsl");
		self::$template->display();
	}

	/**
	* Display View for Edit Object
	* @return display view
	**/
	public static function BackDisplayEdit()
	{
		$id = Util::getvalue('id');
		$Object = Client::getById(array('id' => $id));

		if(!$Object) Application::Route(array('modulename'=>'client'));
		
		parent::loadAdminInterface();
		self::$template->setcontent($Object, null, 'object');
		self::$template->add("client.edit.xsl");
		self::$template->display();
	}

	public static function BackDisplayAdd()
	{
		parent::loadAdminInterface();
		self::$template->add("client.add.xsl");
		self::$template->display();
	}
	
	public static function BackAdd()
	{
		$objectId  = Client::Add($options = array(
				'fields'		=> $_POST,
				'model'		=> 'clientModel',
				'table' 	=> clientModel::$table,
			)
		);

		$display = array(
			'item_id'    => $objectId,
			'module'     => 'client',
			'back'       => 0,
		);
		
		Application::Route($display);
	}
	

	public static function BackDelete()
	{
		$id = util::Getvalue("item_id");
		
		if(is_numeric($id)):

			$object = Client::getbyid(array("id"=>$id));
			Object_Custom::UnPublish(array(
				"object"=> $object,
				'module'=> 'client',
				'model'=> "ClientModel",
				"table"	=> ClientModel::$table,
				"publication_path"=>"",
				'publication_type'=>'json'
			));

			Object_Custom::Remove(array(
				'id'=>$id,
				'table'=>ClientModel::$table,
				'debug'=>0
			));


			echo "1";
		endif;
	}


	public static function BackEdit()
	{
		$display = array();
		//Util::debug($_POST);die;
		if(isset($_POST['id'])){
			$objectEdited  = Client::Edit(
				$options = array(
					'fields'	=> $_POST,
					'model' 	=> 'clientModel',
					'table' 	=> clientModel::$table,
					'verbose' 	=> true
				)
			);

			$display['back']    = (isset($_POST['back'])) ? 1 : 0;
			$display['item_id'] = $_POST['id'];
		}
		$display['module']  = 'client';
		Application::Route($display);
	}

	public static function BackPublish($id=false, $internalCall=false)
	{
		$object_id = Util::getvalue('item_id', $id);
		$status = Object_Custom::GetState(array(
			'id'=> $object_id,
			'table'=>ClientModel::$table,
			'debug'=>false
			));
		
		if($status['state'] == 0 || $status['state'] == 3)
		{

			// $object_typeid   = Object::getTypeByObjectId($object_id);
			// $module          = ConfigurationManager::Query("/configuration/modules/module[@type_id='".$object_typeid."']");
			// $moduleName      = $module->item(0)->getAttribute('name');
			// $moduleModel     = $module->item(0)->getAttribute('model');
			// $modelReflection = new ReflectionClass($moduleModel);

			//Object::updatePublicationUser($object_id);

			//Publish object
			$object = Client::getById($options = array('id'	 => $object_id));
			
			// parent::loadAdminInterface('publish.xsl', $internalCall=true);
			// self::$template->setparam('module', $modelReflection->getStaticPropertyValue('tag'));
			// self::$template->setparam('tag', $moduleName);
			// self::$template->setcontent($object, null, 'object');
			// $xml = self::$template->returnDisplay();

			Object_Custom::Publish(array(
				"object"	=> $object,
				"module"	=> 'client',
				"model"		=> 'ClientModel',
				"table"		=> "client",
				"publication_path" => $_SERVER["DOCUMENT_ROOT"]."/plan/content/cache/client",
				'publication_type'=>'json' //json|xml
			));
			// Object::ClearList($moduleName);

			echo '1';
			//die;

		}else{
			echo "Paso algo no puedo publicar";
		}
	}

	public static function BackUnpublish(){
		$id = util::getvalue("item_id");

		$fields = array(
			'id'=>$id,
			'state'=> 0
		);
		$objectEdited  = Client::Edit(
				$options = array(
					'fields'	=> $fields,
					'model' 	=> 'clientModel',
					'table' 	=> clientModel::$table,
					'verbose' 	=> true
				)
			);

		echo 1;

	}



	public static function BackDisplaySearch()
	{
		$query      = Util::getvalue('q', false);
		$state      = Util::getvalue('state', false);
		$page       = Util::getvalue('page', 1);
		$categories = (Util::getvalue('categories')) ? implode(',', Util::getvalue('categories')) : false;

		$options = array(
			'q'   		    => $query,
			'module'      => 'client',
			'model'		  => 'clientModel',
			'table'		  => ClientModel::$table,
			'tag'			=> 'object',
			'display'     => 20,
			'currentPage' => $page,
			'state'       => $state,
			'categories'  => $categories,
			'debug'		  => true,
			'search_in'	  => array('title'),
			'startdate'   => Util::getvalue('startdate'),
			'enddate'     => Util::getvalue('enddate'),
		);

		//$CategoriesFilters = Client::getCategoriesFilter($options);

		parent::loadAdminInterface();
		self::$template->setcontent(Client::Search($options), null, 'collection');
		//self::$template->setcontent($CategoriesFilters, null, 'filter');

		self::$template->setparam('query',$query);
		self::$template->setparam('state',$state);
		self::$template->setparam('category_id',$options['categories']);
		self::$template->setparam('startdate', $options['startdate']);
		self::$template->setparam('enddate',$options['enddate']);

		self::$template->add("client.list.xsl");
		self::$template->display();
	}

	public static function BackReturn()
	{
		$display['module']  = 'client';
		Application::Route($display);
	}

	public static function BackDisplayPreview()
	{
		$Object = Object::getById(
			$options = array(
				'object_id'	 => Util::getvalue('id'),
				'model'      => 'clientModel',
				'table'      => clientModel::$table,
				'state'		 => false, 
				'relations'	 => true,
				'multimedas' => true,
				'categories' => true
			)
		);

		if(!$Object) Application::Route(array('modulename'=>'client'));

		
		$interface = SkinController::loadInterface();

		//Contenido de la nota
		$interface->setcontent($Object, null, 'client');
		$interface->add('client/client.xsl');
		$interface->display();
	}













	
	/* Front end */
	
	public static function FrontDisplayDefault(){
	}


	public static function FrontDisplayList()
	{

	}
	
	public static function FrontDisplayAcumuladoByName()
	{
	}
	
	
	public static function FrontDisplayItem()
	{
	}
	
}


?>
