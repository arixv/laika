<?php
class ProjectController extends ObjectController implements ModuleController {

	/**
	* Display a List of Objects
	* @return none
	**/
	public static function BackDisplayDefault()
	{	
		
		$page   = Util::getvalue('page', 1);
		$state  = Util::getvalue('state', 'false');
		$categories = Util::getvalue('categories');

		$options = array(
				'module'	  => 'project',
				'model'		  => 'ProjectModel',
				'table'		  => 'project',
				'currentPage' => $page,
				'display'	  => 10, 
				'state'		  => ($state != 'false') ? $state : false, 
				'categories'  => $categories,
				'multimedia'  => true,
				'relations'   => false,
				//'debug'     => true,
		);


		$Collection = Project::GetList($options);
		//Util::debug($Collection);
		
		//$CategoriesFilters = Project::getCategoriesFilter($options);
		
		self::loadAdminInterface();
		self::$template->setcontent($Collection, null, 'collection');
		//self::$template->setcontent($CategoriesFilters, null, 'filter');
		self::$template->setparam('state',$options['state']);
		self::$template->setparam('category_id',$options['categories']);
		self::$template->add("list.xsl");
		self::$template->display();
	}

	/**
	* Display View for Edit Object
	* @return display view
	**/
	public static function BackDisplayEdit()
	{
		$Object = Object_Custom::getById(
			$options = array(
				'id'	 	  => Util::getvalue('id'),
				'model'      => 'ProjectModel',
				'table'      => ProjectModel::$table,
				'tables'	 => ProjectModel::$tables,
				'module'	 => 'project',
				'state'		 => false, 
				'relations'	 => true,
				'multimedas' => true,
				'categories' => true
			)
		);

		// $defaults = array(
		// 		'model'			=> false,
		// 		'table'     	=> false,
		// 		'tables'		=> false,
		// 		'module'		=> false,
		// 		'id'	 		=> false,
		// 		'state'		 	=> false, 
		// 		'relations'	 	=> true,
		// 		'multimedias'	=> true,
		// 		'categories' 	=> true,
		// 		'level'      	=> 3, // Arbol de categorias padre
		// 		'internalCall'	=> false,
		// 		'debug'			=> false
		// );

		if(!$Object) Application::Route(array('modulename'=>'project'));
		
		$Locations = Location::getList($parent=0);

		parent::loadAdminInterface();
		self::$template->setcontent($Object, null, 'object');
		self::$template->setcontext($Locations, null, 'locations');
		self::$template->add("edit.xsl");
		self::$template->display();
	}

	public static function BackDisplayAdd()
	{
		parent::loadAdminInterface();
		self::$template->add("add.xsl");
		self::$template->display();
	}
	
public static function BackAdd()
	{
		$objectId  = Project::Add($options = array(
				'fields'		=> $_POST,
				'model'		=> 'ProjectModel',
				'table' 	=> ProjectModel::$table,
			)
		);

		$display = array(
			'item_id'    => $objectId,
			'module'     => 'planes',
			'back'       => 0,
		);
		
		Application::Route($display);
	}
	
	public static function BackEdit()
	{
		$display = array();

		if(isset($_POST['id']))
		{
			$objectEdited  = Object_Custom::edit(
				$options = array(
					'fields'		=> $_POST,
					'model' 	=> 'ProjectModel',
					'table' 	=> ProjectModel::$table,
					'tables' 	=> ProjectModel::$tables,
					'verbose' 	=> true
				)
			);

			$display['back']    = (isset($_POST['back'])) ? 1 : 0;
			$display['item_id'] = $_POST['id'];
		}

		$display['module']  = 'project';
		Application::Route($display);
	}

	public static function BackClearCacheObject()
	{
		$Site = Session::get('site');
		$projectId = Util::getvalue("id");
		$key = 'project.'.$projectId;
		$folder = "projects";
		$site_preffix = $Site['preffix'];

		$Result = Cache::deleteKey($key,$folder,$site_preffix);
		
		Application::Route(array(
			'back'=> 0,
			'module' => 'project',
			'item_id'=>$projectId
		));

	}

	public static function BackDisplaySearch()
	{
		$query      = Util::getvalue('q', false);
		$state      = Util::getvalue('state', false);
		$page       = Util::getvalue('page', 1);
		$categories = Util::getvalue('categories', false);

		$options = array(
			'query'       => $query,
			'module'      => 'project',
			'model'		  => 'ProjectModel',
			'table'		  => ProjectModel::$table,
			'display'     => 20,
			'currentPage' => $page,
			'type_id'	  => ProjectModel::$object_typeid, 
			'state'       => $state,
			'categories'  => $categories,
		);

		$CategoriesFilters = Project::getCategoriesFilter($options);

		parent::loadAdminInterface();
		self::$template->setcontent(Project::Search($options), null, 'collection');
		self::$template->setcontent($CategoriesFilters, null, 'filter');

		self::$template->setparam('query',$query);
		self::$template->setparam('state',$state);
		self::$template->setparam('category_id',$options['categories']);

		self::$template->add("project.list.xsl");
		self::$template->display();
	}

	public static function BackReturn()
	{
		$display['module']  = 'project';
		Application::Route($display);
	}














	
	/* Front end */
	
	public static function FrontDisplayDefault(){


		// $interface = SkinController::loadInterface();
		// $index = Home::getPublicationPath().'index.xml';
		// $interface->setcontent($index, '/xml/*', 'home');
		// $interface->add("project/home.components.xsl");
		// $interface->add("project/home.xsl");
		// $interface->display();
	}


	public static function FrontDisplayAcumulado()
	{
		$categoryId = Util::getvalue('category_id');
		$pagenumber = Util::getvalue('page',1);
 		
		$Collection = Project::Getlist(
			$options = array(
				'module'	=> 'project',
				'model'		=> 'ProjectModel',
				'table'		=> 'project',
				'currentPage'=> $pagenumber,
				'display'	=> 10, 
				'state'		=> 1, 
				'categories'=> $categoryId,
				'multimedias'=> true,
				'relations' => false,
				'debug'		=> false
		));


		$interface = SkinController::loadInterface();
		$interface->setcontent($Collection, null, 'collection');

		$interface->add("project/project.list.xsl");

		$interface->setparam("eplanning_section","Home_Notas");
		$interface->display();
	}
	
	// public static function FrontDisplayAcumuladoByName()
	// {
	// 	$name     = Util::getvalue('category');
	// 	$name     = str_replace("-", " ", $name);
	// 	$category = Category::GetByName($name); 
	// 	$pagenumber     = Util::getvalue('page');


	// 	if($category):
	// 		$interface = SkinController::loadInterface();
	// 		$interface->setcontent(Object::getListByCategory($category['category_id-att'], $state=1, $multimedias=true, $pagenumber, $perPage=8), null, 'acumulado');
	// 		$interface->setcontent($category, null, 'categoria');
	// 		$interface->add("project/templates.xsl");
	// 		$interface->add("project/acumulado.xsl");
	// 		$interface->setparam("eplanning_section","Home_Notas");
	// 		$interface->display();
	// 	else:
	// 		echo "La categoría de nota no existe. <a href='javascript:history.back();'>Volver</a>";
	// 	endif;
	// }
	
	/*
	public static function FrontSearch()
	{
		
		$query = Util::getvalue('query', false);
		$page  = Util::getvalue('page', 1);

		//$queryStr = str_replace("'", "\'", $query);
		
		$options = array(
			'query'       => $query,
			'module'      => 'project',
			'model'		  => 'ProjectModel',
			'table'		  => ProjectModel::$table,
			'display'     => 10,
			'currentPage' => $page,
			'type_id'	  => ProjectModel::$object_typeid,
			'state'       => 1,
			'categories'  => false,
		);

		return Project::Search($options);
	}
	*/
	
	public static function FrontDisplayItem()
	{
		$projectId = Util::getvalue('id');
		$Site = Session::get('site');

		if(!is_numeric($projectId)):die("no es int");Util::redirect('/argentina/error/404');endif;

		$key = 'project.'.$projectId;
		$folder = "projects";
		$expires = 7200;
		$site_preffix = $Site['preffix'];
		$Project = Cache::getKey($key,$folder,$site_preffix);
		if($Project == false):
			$options = array(
				'object_id'	 => $projectId,
				'model'      => 'ProjectModel',
				'table'      => 'project',
				'state'		 => false, 
				'relations'	 => true,
				'multimedas' => true,
				'categories' => true
			);
			$Project = Project::getById($options);
			Cache::setKey($key,$Project,$expires,$folder,$site_preffix);
		endif;

		


		if($Project):
		
			$interface = SkinController::loadInterface();
			$interface->setcontent($Project,null,'project');
			$interface->add('project/project.xsl');
			$interface->setparam("eplanning_section","Item_nota");
			$interface->display();
		else:

			Util::redirect('/error/404/');

		endif;
	}

	public static function FrontDisplayModal()
	{
		$projectId = Util::getvalue('id');

		$options = array(
			'object_id'	 => $projectId,
			'model'      => 'ProjectModel',
			'table'      => 'project',
			'state'		 => false, 
			'relations'	 => true,
			'multimedas' => true,
			'categories' => true
		);
		
		$Project = Project::getById($options);
		
		$interface = SkinController::loadInterface('project/project.modal.xsl');
		$interface->setcontent($Project, mull,'project');
		$interface->display();

	}

	
	









	public static function display_error(){
		
		$interface = SkinController::loadInterface();
		$custom = array('titulo'=>'Nota no disponible', 'resumen'=>'La nota solicitada no está disponible o la url no est&#225; bien formada.');
		$interface->setcontent($custom, null, 'project');
		$interface->setparam('error', '1');
		$interface->add("project/project.xsl");
		$interface->display();
		
	}



	/* Enviar por email */
	public static function FrontDisplayEnvio()
	{
		$id = Util::getvalue('id');

		$interface = SkinController::loadInterface($baseXsl='project/project.envio.xsl');
		$interface->setcontent(Project::getById($id), null, 'project');
		
		//Random numbers para el captcha
		$interface->setparam('nr1',rand(1,36));
		$interface->setparam('nr2',rand(1,36));
		$interface->setparam('nr3',rand(1,36));
		$interface->setparam('nr4',rand(1,36));
		$interface->setparam('nr5',rand(1,36));
		
		$interface->display();
	}
	
	/* Enviar por email */
	public static function FrontEnvio()
	{
		$id  = Util::getvalue('id');
		$emailRCP = Util::getvalue('email');
		$mensaje  = strip_tags(Util::getvalue('mensaje'));
		$copia    = Util::getvalue('copia', false);


		$interface = SkinController::loadInterface($baseXsl='project/project.envio.xsl');
		$project = Project::getById($id);
		$project['mensaje'] = $mensaje;
		
		$userArray = Session::getvalue('proyectounder');
		
		if($userArray):
			$project['user'] = $userArray;
		endif;
		
		$emailhtml = self::envio_email($project);
		$email = new Email();
		$email->SetFrom('contacto@Laika.com', 'Laika.com');
		$email->SetSubject(utf8_encode($project['titulo']));
		$emailList = preg_split("/[;,]+/", $emailRCP);

		foreach ($emailList as $destination)
		{
			$email->AddTo($destination);
		}
		if($copia):
			$email->AddCC($userArray['email']);
		endif;

		
		$email->ClearAttachments();
		$email->ClearImages();
		$email->SetHTMLBody(utf8_encode($emailhtml));
		$email->Send();
		
		
		$interface->setparam('enviado', 1);
		$interface->display();
	}
	
	
	
	public static function envio_email($Project)
	{
		$interface = SkinController::loadInterface($baseXsl='project/project.envio.cuerpo.xsl');
		$interface->setcontent($Project, null, 'project');
		return $interface->returnDisplay();
		//$interface->display();
	}
	
	
	
	
	
	
}


?>
