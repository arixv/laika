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
		$project_id = Util::getvalue('id');

		$Object = Object_Custom::getById(
			$options = array(
				'id'	 	  => $project_id,
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
		if(!$Object) Application::Route(array('modulename'=>'project'));

		$Partidas = Project::getPartidas($options=array('project_id'=>$project_id));
		$Facturas = Project::getFacturas($options=array('project_id'=>$project_id));
		$Object['rubros'] = Project::getRubros($options=array('project_id'=>$project_id));
		$Providers = Provider::getList();
		$Clients = Client::getList();
	
		
		parent::loadAdminInterface();
		self::$template->setcontent($Object, null, 'object');
		self::$template->setcontent($Partidas, null, 'partidas');
		self::$template->setcontent($Facturas, null, 'facturas');
		self::$template->setcontent($Providers, null, 'providers');
		self::$template->setcontent($Clients, null, 'clients');
		self::$template->add("edit.xsl");
		self::$template->display();
	}

	public static function BackDisplayAdd()
	{
		$Clients = Client::getList();
		parent::loadAdminInterface();
		self::$template->setcontent($Clients, null, 'clients');
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
			'module'     => 'project',
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

	public static function BackDelete(){
		$project_id = Util::getvalue("item_id");
		if(is_numeric($project_id)):
			Project::Remove(array(
				'id'=>$project_id,
				'table'=>'project',
				'debug'=>false
			));
			echo "1";
		endif;
	}

	

	/****** PARTIDAS *****/

	/* display modal add partida */
	public static function BackDisplayAddPartida(){
		$project_id = util::getvalue("project_id");
		self::loadAdminInterface('modal.add.partida.xsl');
		self::$template->setparam('project_id',$project_id);
		self::$template->display();
	}

	/* display modal edit partida */
	public static function BackDisplayEditPartida(){
		$project_id = util::getvalue("project_id");
		$partida_id = util::getvalue("partida_id");
		$Result = Project::getPartidas(array(
			'project_id'=>$project_id,
			'partida_id'=>$partida_id
		));

		if(!empty($Result) && isset($Result[0])):
			$Partida = $Result[0];
		endif;
		
		self::loadAdminInterface('modal.edit.partida.xsl');
		self::$template->setcontent($Partida,null,'partida');
		self::$template->setparam('project_id',$project_id);
		self::$template->display();	
	}

	/* edit partida */
	public static function BackEditPartida(){
		$params = array(
			'fields'=>array(
				'description'=>$_REQUEST['description'],
				'amount'=>$_REQUEST['amount'],
				'responsable'=>$_REQUEST['responsable'],
				'date'=>$_REQUEST['date'],
			),
			'table'=>'partida',
			'filters'=>array(
				'id='.Util::getvalue("partida_id"),
				'project_id='.Util::getvalue("project_id"),
			)
		);
		$id = Project::update($params);
		Util::redirect("/admin/project/edit/".$_REQUEST['project_id']);
	}

	/* add partida */
	public static function BackAddPartida(){
		$params = array(
			'fields'=>array(
				'project_id'=>$_REQUEST['project_id'],
				'description'=>$_REQUEST['description'],
				'amount'=>$_REQUEST['amount'],
				'responsable'=>$_REQUEST['responsable'],
				'date'=>$_REQUEST['fecha'],
			),
			'table'=>'partida'
		);
		$id = Project::insert($params);
		Util::redirect("/admin/project/edit/".$_REQUEST['project_id']);
	}

	/* delete partida*/
	public static function BackDeletePartida(){
		$partida_id = Util::getvalue("partida_id");
		if(is_numeric($partida_id)):
			Project::Remove(array(
				'id'=>$partida_id,
				'table'=>'partida',
				'debug'=>false
			));
			echo "1";
		else:
			echo "0";
		endif;
	}


	/******** FACTURAS ********/

	public static function BackDisplayAddFactura(){
		$project_id = util::getvalue("project_id");

		$Partidas = Project::getPartidas(array(
			'project_id'=>$project_id
		));

		$Rubros = Project::getRubros(array(
			'project_id'=>$project_id
		));

		$Providers = Provider::getList();

		self::loadAdminInterface('modal.add.factura.xsl');
		self::$template->setcontent($Partidas,null,'partidas');
		self::$template->setcontent($Providers,null,'providers');
		self::$template->setcontent($Rubros,null,'rubros');
		self::$template->setparam('project_id',$project_id);
		self::$template->display();
	}

	public static function BackAddFactura(){

		// util::debug($_REQUEST);die;
		$params = array(
			'fields'=>array(
				'project_id'=>$_REQUEST['project_id'],
				'provider_id'=>$_REQUEST['provider_id'],
				'partida_id'=>$_REQUEST['partida_id'],
				'number'=>$_REQUEST['number'],
				'description'=>$_REQUEST['description'],
				'amount'=>$_REQUEST['amount'],
				'type'=>$_REQUEST['type'],
				'state'=>$_REQUEST['state'],
				'date'=>$_REQUEST['date'],
			),
			'table'=>'factura'
		);
		$id = Project::insert($params);
		Util::redirect("/admin/project/edit/".$_REQUEST['project_id']);
	}

	/* DISPLAY MODAL EDIT FACTURA */
	public static function BackDisplayEditFactura()
	{
		$project_id = util::getvalue("project_id");
		$factura_id = util::getvalue("factura_id");


		$Result = Project::getFacturas(array(
			'project_id'=>$project_id,
			'factura_id'=>$factura_id
		));
		if(!empty($Result) && isset($Result[0]) ):
			$Factura = $Result[0];
		else:
			$Factura = false;
		endif;

		$Partidas = Project::getPartidas(array(
			'project_id'=>$project_id
		));

		$Rubros = Project::getRubros(array(
			'project_id'=>$project_id
		));

		$Providers = Provider::getList();

		self::loadAdminInterface('modal.edit.factura.xsl');
		self::$template->setcontent($Factura,null,'factura');
		self::$template->setcontent($Partidas,null,'partidas');
		self::$template->setcontent($Providers,null,'providers');
		self::$template->setcontent($Rubros,null,'rubros');
		self::$template->setparam('project_id',$project_id);
		self::$template->display();
	}

	public static function BackEditFactura(){

	}

	public static function BackDisplayDeleteFactura(){
		$factura_id = Util::getvalue("factura_id");
		if(is_numeric($factura_id)):
			Project::Remove(array(
				'id'=>$factura_id,
				'table'=>'factura',
				'debug'=>false
			));
			echo "1";
		else:
			echo "0";
		endif;
	}


	/****** RUBROS *******/
	public static function BackDisplayAddRubro(){
		$project_id = util::getvalue("project_id");
		$Rubros = Rubro::getList(array(
			'parent'=>'0',
			'subrubros'=>0
		));
		self::loadAdminInterface('modal.add.rubro.xsl');
		self::$template->setcontent($Rubros, null, 'rubros');
		self::$template->setparam('project_id',$project_id);
		self::$template->display();
	}

	public static function BackAddRubro(){
		Project::insert(array(
			'fields'=>array(
				'project_id'=>Util::getvalue("project_id"),
				'rubro_id'=>Util::getvalue("rubro_id"),
			),
			'table'=>'project_rubro'
		));
		Util::redirect("/admin/project/edit/".$_REQUEST['project_id']);
	}

	public static function BackDisplayAddSubRubro()
	{
		$project_id = Util::getvalue("project_id");
		$rubro_id = Util::getvalue("rubro_id");
		$SubRubros = Rubro::getList(array(
			'parent'=>$rubro_id,
			'subrubros'=> 0
		));
		self::loadAdminInterface('modal.add.subrubro.xsl');
		self::$template->setcontent($SubRubros, null, 'subrubros');
		self::$template->setparam('project_id',$project_id);
		self::$template->setparam('rubro_id',$rubro_id);
		self::$template->display();
	}

	public static function BackAddSubRubro()
	{
		// util::debug($_REQUEST);
		Project::insert(array(
			'fields'=>array(
				'project_id'=>Util::getvalue("project_id"),
				'rubro_id'=>Util::getvalue("rubro_id"),
				'subrubro_id'=>Util::getvalue("subrubro_id"),
				'quantity'=>Util::getvalue("quantity"),
				'description'=>Util::getvalue("description"),
				'concept'=>Util::getvalue("concept"),
				'cost'=>Util::getvalue("cost"),
				'state'=>0
			),
			'table'=>'project_subrubro'
		),
		$debug=false);
		Util::redirect("/admin/project/edit/".$_REQUEST['project_id']);
	}

	public static function BackDisplayRubrosJson() {
		$parent_id = Util::getvalue("parent");
		$Rubros = Rubro::select(array(
			'fields'=>array("*"),
			'table'=>'rubro',
			'filters'=>array('parent_id='.$parent_id)
		));
		if(is_array($Rubros)):
			$Result['result'] = $Rubros;
			$Result = json_encode($Result);
			echo $Result;
		endif;
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
