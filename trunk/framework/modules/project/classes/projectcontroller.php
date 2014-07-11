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


		//Estados
		$States = Project::getListStates();

		
		self::loadAdminInterface();
		self::$template->setcontent($Collection, null, 'collection');
		self::$template->setcontent($States, null, 'states');
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

		//Estados
		$States = Project::getListStates();

		//Partidas
		$Partidas = array();
		$Partidas['total-att']= Project::getPartidasTotal(array('project_id'=>$project_id));
		$Partidas['amount-att']= Project::getPartidasAmount(array('project_id'=>$project_id));

		//$Facturas 
		$Facturas = array();
		$Facturas['total-att']= Project::getFacturasTotal(array('project_id'=>$project_id));
		$Facturas['pendientes-att'] = Project::getFacturasTotal(array('project_id'=>$project_id,'state'=>0));
		$Facturas['pagas-att'] = Project::getFacturasTotal(array('project_id'=>$project_id,'state'=>1));
		$Facturas['amount-att']= Project::getFacturasAmount(array('project_id'=>$project_id));

		//Clientes
		$Clients = Client::getlist();

		parent::loadAdminInterface();
		self::$template->setcontent($States, null, 'states');
		self::$template->setcontent($Object, null, 'object');
		self::$template->setcontent($Partidas, null, 'partidas');
		self::$template->setcontent($Facturas, null, 'facturas');
		self::$template->setcontent($Clients, null, 'clients');
		self::$template->add("project.templates.xsl");
		self::$template->add("edit.xsl");
		self::$template->setparam("active",'info');
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

	/* list partidas for a project*/
	public static function BackDisplayListPartida(){
		$project_id = Util::getvalue("project_id");

		$Project = Object_Custom::getById(
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
		if(!$Project) Application::Route(array('modulename'=>'project'));

		$Partidas = Project::getPartidas(array(
			'project_id'=>$project_id
		));

		parent::loadAdminInterface();
		self::$template->setcontent($Project, null, 'object');
		self::$template->setcontent($Partidas, null, 'partidas');
		self::$template->add("list.partida.xsl");
		self::$template->add("project.templates.xsl");
		self::$template->display();
	
	}

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
		Util::redirect("/admin/project/list_partida/".$_REQUEST['project_id']);
	}

	/* add partida */
	public static function BackAddPartida(){
		$params = array(
			'fields'=>array(
				'project_id'=>$_REQUEST['project_id'],
				'description'=>$_REQUEST['description'],
				'amount'=>$_REQUEST['amount'],
				'responsable'=>$_REQUEST['responsable'],
				'date'=>$_REQUEST['date'],
			),
			'table'=>'partida'
		);
		$id = Project::insert($params);
		Util::redirect("/admin/project/list_partida/".$_REQUEST['project_id']);
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

	/* list partidas for a project*/
	public static function BackDisplayListFactura(){
		$project_id = Util::getvalue("project_id");

		$Project = Object_Custom::getById(
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
		if(!$Project) Application::Route(array('modulename'=>'project'));

		$Facturas = Project::getFacturas($options=array('project_id'=>$project_id));

		parent::loadAdminInterface();
		self::$template->setcontent($Project, null, 'object');
		self::$template->setcontent($Facturas, null, 'facturas');
		self::$template->add("list.factura.xsl");
		self::$template->add("project.templates.xsl");
		self::$template->display();
	
	}

	public static function BackDisplayAddFactura(){
		$project_id = util::getvalue("project_id");

		$Partidas = Project::getPartidas(array(
			'project_id'=>$project_id
		));

		$Rubros = Project::getRubros(array(
			'project_id'=>$project_id
		));

		//util::debug($Rubros);die;

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
				'subrubro_id'=>$_REQUEST['subrubro_id'],
				'number'=>$_REQUEST['number'],
				'description'=>$_REQUEST['description'],
				'amount'=>$_REQUEST['amount'],
				'type'=>$_REQUEST['type'],
				'state'=>$_REQUEST['state'],
				'date'=>$_REQUEST['date'],
			),
			'table'=>'factura'
		);
		// util::debug($params);
		$id = Project::insert($params,$debug=0);
		Util::redirect("/admin/project/list_factura/".$_REQUEST['project_id']);
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

		// util::debug($Rubros);die;

		self::loadAdminInterface('modal.edit.factura.xsl');
		self::$template->setcontent($Factura,null,'factura');
		self::$template->setcontent($Partidas,null,'partidas');
		self::$template->setcontent($Providers,null,'providers');
		self::$template->setcontent($Rubros,null,'rubros');
		self::$template->setparam('project_id',$project_id);
		self::$template->display();
	}

	public static function BackEditFactura(){
		$factura_id = Util::getvalue("factura_id");
		$project_id = Util::getvalue("project_id");

		if(is_numeric($factura_id)){
			$params = array(
				'fields'=>array(
					'number'=>Util::Getvalue("number"),
					'description'=>Util::Getvalue("description"),
					'amount'=>Util::Getvalue('amount'),
					'partida_id'=>Util::Getvalue('partida_id'),
					'type'=>Util::Getvalue('type'),
					'state'=>Util::Getvalue('state'),
					'subrubro_id'=>Util::Getvalue('subrubro_id'),
					'date'=>Util::Getvalue('date'),
				),
				'table'=>'factura',
				'filters'=>array(
					'id='.$factura_id,
					'project_id='.$project_id,
				)
			);
			$id = Project::update($params,$debug=false);
			

		}
		Util::redirect("/admin/project/list_factura/".$project_id);
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

	public static function BackDisplayListRubro(){
		$project_id = Util::getvalue("project_id");

		$Project = Object_Custom::getById(
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
		if(!$Project) Application::Route(array('modulename'=>'project'));

		$Rubros = Project::getRubros($options=array('project_id'=>$project_id));


		parent::loadAdminInterface();
		self::$template->setcontent($Project, null, 'object');
		self::$template->setcontent($Rubros, null, 'rubros');
		self::$template->add("list.rubro.xsl");
		self::$template->add("project.templates.xsl");
		self::$template->display();
	}
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
		Util::redirect("/admin/project/list_rubro/".$_REQUEST['project_id']);
	}

	public static function BackDisplayAddSubRubro()
	{
		$project_id = Util::getvalue("project_id");
		//$rubro_id = Util::getvalue("rubro_id",false);
		$Rubros = Rubro::getList(array(
			'parent'=>0,
			'subrubros'=> 1
		));
		//util::debug($Rubros);die;
		// $SubRubros = Rubro::getList(array(
		// 	//'parent'=>$rubro_id,
		// 	'subrubros'=> 0
		// ));
		self::loadAdminInterface('modal.add.subrubro.xsl');
		self::$template->setcontent($Rubros, null, 'rubros');
		//self::$template->setcontent($SubRubros, null, 'subrubros');
		self::$template->setparam('project_id',$project_id);
		//self::$template->setparam('rubro_id',$rubro_id);
		self::$template->display();
	}

	public static function BackDisplayEditSubRubro(){
		$project_id = util::getvalue("project_id");
		$subrubro_id = util::getvalue("subrubro_id");

		$Subrubro = Project::getSubrubro(array(
			'project_id'=>$project_id,
			'subrubro_id'=>$subrubro_id,
		));

		//util::debug($Subrubro);die;
		self::loadAdminInterface('modal.edit.subrubro.xsl');
		self::$template->setcontent($Subrubro, null, 'subrubro');
		self::$template->setparam('project_id',$project_id);
		self::$template->display();

	}

	public static function BackEditSubRubro(){
			
		$params = array(
			'fields'=>array(
				'concept'=>util::getvalue('concept'),
				'description'=>util::getvalue('description'),
				'quantity'=>util::getvalue('quantity'),
				'start_date'=>util::getvalue('start_date'),
				'end_date'=>util::getvalue('end_date'),
				'payments'=>util::getvalue('payments'),
				'payment_type'=>util::getvalue('payment_type'),
			),
			'table'=>'project_subrubro',
			'filters'=>array(
				'project_id='.util::Getvalue("project_id"),
				'rubro_id='.util::Getvalue("rubro_id"),
				'subrubro_id='.util::Getvalue("subrubro_id"),

			)
		);

		Project::update($params);

		Util::redirect("/admin/project/list_rubro/".$_REQUEST['project_id']);
	}

	public static function BackAddSubRubro()
	{
		$subrubro_id = Util::getvalue("subrubro_id");
		$project_id = Util::getvalue("project_id");

		//SubRubro Item
		$SubRubro = Project::select(array(
			'fields' =>array("*"),
			'table' => 'rubro',
			'filters'=>array(
				'id='.$subrubro_id
			)
		),$debug=false);

		$rubro_id = $SubRubro[0]['parent_id'];

		//Check if RubroParent is Asociated to the Project
		$Result = Project::select(array(
			'fields' =>array("*"),
			'table' => 'project_rubro',
			'filters'=>array(
				'rubro_id='.$rubro_id,
				'project_id='.$project_id
			)
		));

		//If not Result Insert RubroParent Relation with project
		if(empty($Result)):
			$Result = Project::insert(array(
				'fields' =>array("project_id"=>$project_id,"rubro_id"=>$rubro_id,"state"=>0),
				'table' => 'project_rubro'
			));
		endif;

		Project::insert(array(
			'fields'=>array(
				'project_id'=> $project_id,
				'rubro_id'=> $rubro_id,
				'subrubro_id'=> $subrubro_id,
				'quantity'=> Util::getvalue("quantity"),
				'description'=> Util::getvalue("description"),
				'concept'=> Util::getvalue("concept"),
				'start_date'=> Util::getvalue("start_date"),
				'end_date'=> Util::getvalue("end_date"),
				'cost'=> Util::getvalue("cost"),
				'payments'=>Util::getvalue("payments"),
				'payment_type'=>Util::getvalue("payment_type"),
				'state'=> 0
			),
			'table'=>'project_subrubro'
		),
		$debug=0);
		Util::redirect("/admin/project/list_rubro/".$_REQUEST['project_id']);
	}


	/* delete Rubro */
	public static function BackDeleteRubro(){
		$project_id = Util::getvalue("project_id");
		$rubro_id = Util::getvalue("rubro_id");

		if(is_numeric($project_id) && is_numeric($rubro_id)):
			//Delete Rubro
			Project::delete(
				array(
					'table'=>'project_rubro',
					'filters'=>array(
						'rubro_id='.$rubro_id,
						'project_id='.$project_id,
					)			
			));

			//Delete All Subrubros
			Project::delete(
				array(
					'table'=>'project_subrubro',
					'filters'=>array(
						'rubro_id='.$rubro_id,
						'project_id='.$project_id,
					)			
			));

			echo "1";
		else:
			echo "0";
		endif;
	}

	/* delete subrubro */
	public static function BackDeleteSubrubro(){
		$project_id = Util::getvalue("project_id");
		$subrubro_id = Util::getvalue("subrubro_id");
		if(is_numeric($project_id) && is_numeric($subrubro_id)):
			Project::delete(
				array(
					'table'=>'project_subrubro',
					'filters'=>array(
						'subrubro_id='.$subrubro_id,
						'project_id='.$project_id,
					)
				),
				$debug=0
			);
			echo "1";
		else:
			echo "0";
		endif;
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
	
	public static function FrontDisplayDefault(){}

	




}


?>
