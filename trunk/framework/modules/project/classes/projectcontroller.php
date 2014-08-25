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
		$order = Util::getvalue("order","project.id desc");

		$options = array(
				'module'	  => 'project',
				'model'		  => 'ProjectModel',
				'table'		  => 'project',
				'currentPage' => $page,
				'pagesize'	  => 10, 
				'state'		  => ($state != 'false') ? $state : false, 
				'orderby'	  => $order,
				'page'		  => $page,
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

	public static function BackDisplayDashboard(){

		$project_id = Util::getvalue('project_id');
		$Object = Project::getById(
			$options = array(
				'id'	 	  => $project_id,
			)
		);
		if(!$Object) Application::Route(array('modulename'=>'project'));

		if($Object['creation_userid']!=0):
			$ProjectOwner = Admin::getById($Object['creation_userid']);
		else:
			$ProjectOwner = false;
		endif;

		//Estados
		$States = Project::getListStates();

		//Partidas
		$Partidas = array();
		$Partidas['total-att']= Project::getPartidasTotal(array('project_id'=>$project_id));
		$Partidas['amount-att']= Project::getPartidasAmount(array('project_id'=>$project_id));
		
		//Payments
		$Payments = Project::getListPayment(array(
			'project_id'=>$project_id,
			'start_date'=>date('Y-m-d'),
			'get_resources'=>true
		));
		
		//$Facturas 
		$Facturas = array();
		$Facturas['total-att']= Project::getFacturasTotal(array('project_id'=>$project_id));
		$Facturas['pendientes-att'] = Project::getFacturasTotal(array('project_id'=>$project_id,'state'=>0));
		$Facturas['pagas-att'] = Project::getFacturasTotal(array('project_id'=>$project_id,'state'=>1));
		$Facturas['amount-att']= Project::getFacturasAmount(array('project_id'=>$project_id));
		$Facturas['paid-amount-att']= Project::getFacturasAmount(array('project_id'=>$project_id,'state'=>1));
		$Facturas['paid-amount-withno-partida-att']= Project::getFacturasAmount(array(
			'project_id'=>$project_id,
			'state'=>1,
			'partida_id'=>0
		));

		//Total Estimate
		$TotalEstimate = Project::getEstimate(array('project_id'=>$project_id));

		//Total Real
		$TotalReal = Project::getReal(array('project_id'=>$project_id));

		//Progress
		if($TotalReal['total'] > 0):
			$Progress['value'] = round ($Facturas['paid-amount-att'] * 100 / $TotalReal['total'] , $precision = 0);
		else:
			$Progress['value'] = 0;
		endif;

		parent::loadAdminInterface();
		self::$template->setcontent($States, null, 'states');
		self::$template->setcontent($Object, null, 'object');
		self::$template->setcontent($TotalEstimate, null, 'estimate');
		self::$template->setcontent($TotalReal, null, 'real');
		self::$template->setcontent($Progress, null, 'progress');
		self::$template->setcontent($ProjectOwner, null, 'project_owner');
		self::$template->setcontent($Partidas, null, 'partidas');
		self::$template->setcontent($Facturas, null, 'facturas');
		self::$template->setcontent($Payments, null, 'payments');
		self::$template->add("project.templates.xsl");
		self::$template->add("dashboard.xsl");
		self::$template->display();
	}

	/**
	* Display View for Edit Object
	* @return display view
	**/
	public static function BackDisplayEdit()
	{
		$project_id = Util::getvalue('id');

		$Object = Project::getById(
			$options = array(
				'id'	 	  => $project_id,
			)
		);
		if(!$Object) Application::Route(array('modulename'=>'project'));

		if($Object['creation_userid']!=0):
			$ProjectOwner = Admin::getById($Object['creation_userid']);
		else:
			$ProjectOwner = false;
		endif;

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
		$Facturas['paid-amount-att']= Project::getFacturasAmount(array('project_id'=>$project_id,'state'=>1));

		//Total Estimate
		$TotalEstimate = Project::getEstimate(array('project_id'=>$project_id));
		//Total Real
		$TotalReal = Project::getReal(array('project_id'=>$project_id));

		//Progress
		if($TotalReal['total'] > 0):
			$Progress['value'] = round ($Facturas['paid-amount-att'] * 100 / $TotalReal['total'] , $precision = 0);
		else:
			$Progress['value'] = 0;
		endif;

	

		//Clientes
		$Clients = Client::getlist();

		parent::loadAdminInterface();
		self::$template->setcontent($States, null, 'states');
		self::$template->setcontent($Object, null, 'object');
		self::$template->setcontent($TotalEstimate, null, 'estimate');
		self::$template->setcontent($TotalReal, null, 'real');
		self::$template->setcontent($Progress, null, 'progress');
		self::$template->setcontent($ProjectOwner, null, 'project_owner');
		self::$template->setcontent($Partidas, null, 'partidas');
		self::$template->setcontent($Facturas, null, 'facturas');
		self::$template->setcontent($Clients, null, 'clients');
		self::$template->add("project.templates.xsl");
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

			//Delete Rubros 

			//Delete Subrubros Asociados

			//Delete Facturas

			//Delete Partidas

			echo "1";
		endif;
	}

	public static function BackDuplicate(){
		$project_id = util::getvalue("project_id");
		Project::Duplicate($project_id);
		Util::redirect("/admin/project/");
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

		$States = Project::getListStates();

		parent::loadAdminInterface();
		self::$template->setcontent($Project, null, 'object');
		self::$template->setcontent($Partidas, null, 'partidas');
		self::$template->setcontent($States, null, 'states');
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


	/* display view partida */
	public static function BackDisplayViewPartida()
	{
		$project_id = util::getvalue("project_id");
		$partida_id = util::getvalue("partida_id");
		
		/* PROJECT */
		$Project = Project::getById(
			$options = array(
				'id'  => $project_id,
			)
		);

		/* PARTIDA */
		$Partida = Project::getPartidas(array(
			'project_id'=>$project_id,
			'partida_id'=>$partida_id
		));
		if(!empty($Partida) && isset($Partida[0])):$Partida = $Partida[0];endif;

		/* FACTURAS */
		$Facturas = Project::getFacturas(array(
			'project_id'=>$project_id,
			'partida_id'=>$partida_id,
		));
		
		self::loadAdminInterface();
		self::$template->setcontent($Partida,null,'partida');
		self::$template->setcontent($Project,null,'object');
		self::$template->setcontent($Facturas,null,'facturas');
		self::$template->setparam('project_id',$project_id);
		self::$template->add("project.templates.xsl");
		self::$template->add("view.partida.xsl");
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
		$User = Admin::IsLoguedIn();
		$params = array(
			'fields'=>array(
				'project_id'=>$_REQUEST['project_id'],
				'description'=>$_REQUEST['description'],
				'amount'=>$_REQUEST['amount'],
				'responsable'=>$_REQUEST['responsable'],
				'date'=>$_REQUEST['date'],
				'creation_userid' => $User['user_id-att']
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
		$partida_id = util::getvalue("partida_id");	
		$redirect = util::getvalue("redirect");	

		$Partidas = Project::getPartidas(array(
			'project_id'=>$project_id
		));

		$Rubros = Project::getRubros(array(
			'project_id'=>$project_id
		));

		//util::debug($Resources);die;

		$Providers = Provider::getList();

		self::loadAdminInterface('modal.add.factura.xsl');
		self::$template->setcontent($Partidas,null,'partidas');
		self::$template->setcontent($Providers,null,'providers');
		self::$template->setcontent($Rubros,null,'rubros');
		self::$template->setparam('project_id',$project_id);
		self::$template->setparam('partida_id',$partida_id);
		self::$template->setparam('redirect',$redirect);
		self::$template->display();
	}

	public static function BackAddFactura(){
		$User = Admin::IsLoguedIn();
		$project_id = util::getvalue('project_id');
		$resource_id = util::getvalue('resource_id');
		$redirect= util::getvalue('redirect');

		$Resource = Project::getResource( array(
			'project_id' => $project_id,
			'resource_id' => $resource_id
		));

		$provider_id = $Resource['provider_id'];

		$params = array(
			'fields'=>array(
				'project_id'=>$project_id,
				'provider_id'=>$provider_id,
				'resource_id'=>$resource_id,
				'subrubro_id'=>$Resource['subrubro_id'],
				'partida_id'=>util::getvalue('partida_id'),
				'number'=>util::getvalue('number'),
				'description'=> util::getvalue('description'),
				'amount'=>util::getvalue('amount'),
				'type'=>util::getvalue('type'),
				'state'=>util::getvalue('state'),
				'date'=>util::inversedate(util::getvalue('date')),
				'creation_userid'=>$User['user_id-att'],
			),
			'table'=>'factura'
		);
		// util::debug($params);
		$id = Project::insert($params,$debug=0);
		Util::redirect($redirect);
	}

	/* DISPLAY MODAL EDIT FACTURA */
	public static function BackDisplayEditFactura()
	{
		$project_id = util::getvalue("project_id");
		$factura_id = util::getvalue("factura_id");

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

		self::loadAdminInterface();
		self::$template->add('edit.factura.xsl');
		self::$template->add('project.templates.xsl');
		self::$template->setcontent($Project,null,'object');
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
		$resource_id = util::getvalue('resource_id');

		$Resource = Project::getResource( array(
			'project_id' => $project_id,
			'resource_id' => $resource_id
		));

		$provider_id = $Resource['provider_id'];



		if(is_numeric($factura_id)){
			$params = array(
				'fields'=>array(
					'number'=>Util::Getvalue("number"),
					'description'=>Util::Getvalue("description"),
					'amount'=>Util::Getvalue('amount'),
					'partida_id'=>Util::Getvalue('partida_id'),
					'resource_id'=> $resource_id,
					'provider_id'=> $Resource['provider_id'],
					'subrubro_id'=> $Resource['subrubro_id'],
					'type'=>Util::Getvalue('type'),
					'state'=>Util::Getvalue('state'),
					'date'=>util::inverseDate(Util::Getvalue('date')),
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


	/****** Resources *******/

	public static function BackDisplayListResources()
	{

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
		$States = Project::getListStates();
		$Providers = Provider::getList();


		parent::loadAdminInterface();
		self::$template->setcontent($Project, null, 'object');
		self::$template->setcontent($Rubros, null, 'rubros');
		self::$template->setcontent($Providers, null, 'providers');
		self::$template->setcontent($States, null, 'states');
		self::$template->add("list.resources.xsl");
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
		Util::redirect("/admin/project/list_resources/".$_REQUEST['project_id']);
	}

	public static function BackDisplayAddResource()
	{
		$project_id = Util::getvalue("project_id");
		
		$Project = Project::getbyid(array(
			'id'=>$project_id
		));

		$Rubros = Rubro::getList(array(
			'parent'=>0,
			'subrubros'=> 1
		));

		$Providers = Provider::getList();

		//util::debug($Rubros);die;
		// $SubRubros = Rubro::getList(array(
		// 	//'parent'=>$rubro_id,
		// 	'subrubros'=> 0
		// ));
		self::loadAdminInterface('modal.add.resource.xsl');
		self::$template->setcontent($Rubros, null, 'rubros');
		self::$template->setcontent($Providers, null, 'providers');
		self::$template->setcontent($Project, null, 'project');
		self::$template->setparam('project_id',$project_id);
		//self::$template->setparam('rubro_id',$rubro_id);
		self::$template->display();
	}

	public static function BackDisplayEditResource()
	{
		$project_id = util::getvalue("project_id");
		$resource_id = util::getvalue("resource_id");

		$Project = Project::getbyid(array(
			'id'=>$project_id
		));

		$Resource = Project::getResource(array(
			'resource_id'	=> $resource_id,
			'project_id'	=> $project_id,
		));



		$Providers = Provider::getList();

		// util::debug($Project);die;
		//util::debug($Subrubro);die;
		self::loadAdminInterface('modal.edit.resource.xsl');
		self::$template->setcontent($Project, null, 'project');
		self::$template->setcontent($Resource, null, 'resource');
		self::$template->setcontent($Providers, null, 'providers');
		self::$template->setparam('project_id',$project_id);
		self::$template->display();

	}

	public static function BackEditResource(){
		
		$resource_id 	= Util::getvalue("resource_id");
		$project_id 	= Util::getvalue("project_id");
		$rubro_id 		= Util::getvalue("rubro_id");
		$subrubro_id 	= Util::getvalue("subrubro_id");

		$Project = Project::getbyid(array('id'=>$project_id));



		$params = array(
			'fields'=>array(
				'provider_id'=>util::getvalue('provider_id'),
				'concept'=>util::getvalue('concept'),
				'description'=>util::getvalue('description'),
				// 'estimate_quantity'=>	$estimate_quantity,
				// 'estimate_cost'=>	$estimate_cost,
				// 'quantity'=>	$real_quantity,
				// 'cost'=>	$real_cost,
				'start_date'=>util::inverseDate(util::getvalue('start_date')),
				'end_date'=>util::inverseDate(util::getvalue('end_date')),
				'payments'=>util::getvalue('payments'),
				'payment_type'=>util::getvalue('payment_type'),
			),
			'table'=>'project_resource',
			'filters'=>array(
				'resource_id='.$resource_id,
				'project_id='.$project_id,
				'rubro_id='.$rubro_id,
				'subrubro_id='.$subrubro_id,
			)
		);

		//If state is 0 the value of estimate and real is the same
		if($Project['state-att'] == 0):
			$params['fields']['estimate_quantity'] = util::getvalue('estimate_quantity');
			$params['fields']['estimate_units'] = util::getvalue('estimate_units');
			$params['fields']['estimate_cost'] = util::getvalue('estimate_cost');
			$params['fields']['units'] = util::getvalue('estimate_units');
			$params['fields']['quantity'] = util::getvalue('estimate_quantity');
			$params['fields']['cost'] = util::getvalue('estimate_cost');
		else:
			$params['fields']['units'] = util::getvalue('units');
			$params['fields']['quantity'] = util::getvalue('quantity');
			$params['fields']['cost'] = util::getvalue('cost');
		endif;	

		Project::update($params);


		//INSERT SUBRUBRO PAYMENT CALENDAR
		$payments_values = Util::getvalue("payments_values");
		$payments_days = Util::getvalue("payments_days");

		// util::debug($payments_values);
		// util::debug($payments_days);


		if(is_array($payments_values)):
			foreach($payments_values as $key=>$payment_value){
				$params = array(
					'fields'=>array(
						'project_id'=> $project_id,
						'resource_id'=> $resource_id,
						'date'=> $payments_days[$key],
						'value'=>$payment_value
					),
					'table'=>'project_resource_payments'
				);
				Module::insert($params,$debug=false);
			}
		endif;


		Util::redirect("/admin/project/list_resources/".$_REQUEST['project_id']);
	}

	public static function BackAddResource()
	{
		$User = Admin::IsLoguedIn();
		$subrubro_id = Util::getvalue("subrubro_id");
		$project_id = Util::getvalue("project_id");

		$Project = Project::getById(array(
			'id'  => $project_id,
		));

		if($subrubro_id == ''):
			die("Por favor seleccione un Rubro");
		endif;

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

		//INSERT RESOURCE 
		$estimate_units = Util::getvalue("estimate_units");
		$estimate_quantity = Util::getvalue("estimate_quantity");
 		$estimate_cost = Util::getvalue("estimate_cost");

		$real_units = ($Project['state-att'] == 0)?$estimate_units:Util::getvalue("units");
		$real_quantity = ($Project['state-att'] == 0)?$estimate_quantity:Util::getvalue("quantity");
		$real_cost = ($Project['state-att'] == 0)?$estimate_cost:Util::getvalue("cost");

		$params = array(
			'fields'=>array(
				'project_id'=> $project_id,
				'rubro_id'=> $rubro_id,
				'subrubro_id'=> $subrubro_id,
				'provider_id'=> Util::getvalue("provider_id"),
				'estimate_units'=> $estimate_units,
				'estimate_quantity'=> $estimate_quantity,
				'estimate_cost'=> $estimate_cost,
				'units'=> $real_units,
				'quantity'=> $real_quantity,
				'cost'=> $real_cost,
				'description'=> Util::getvalue("description"),
				'concept'=> Util::getvalue("concept"),
				'start_date'=> util::inverseDate(Util::getvalue("start_date")),
				'end_date'=> util::inverseDate(Util::getvalue("end_date")),
				'payments'=>Util::getvalue("payments"),
				'payment_type'=>Util::getvalue("payment_type"),
				'state'=> 0,
				'creation_userid'=> $User['user_id-att'],
			),
			'table'=>'project_resource'
		);
		Module::insert($params,$debug=false);



		Util::redirect("/admin/project/list_resources/".$_REQUEST['project_id']);
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
					'table'=>'project_resource',
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

	/* delete Resource */
	public static function BackDeleteResource()
	{
		$project_id = Util::getvalue("project_id");
		$resource_id = Util::getvalue("resource_id");

		if(is_numeric($project_id) && is_numeric($resource_id)):
			Project::delete(
				array(
					'table'=>'project_resource',
					'filters'=>array(
						'project_id='.$project_id,
						'resource_id='.$resource_id,
					)
				),
				$debug=0
			);
			echo "1";
		else:
			echo "0";
		endif;
	}

	/* delete payment date */
	public static function BackDeletePayment(){
		$payment_id = Util::getvalue("id");
		$project_id = Util::getvalue("project_id");
		$resource_id = Util::getvalue("resource_id");
		
		echo Module::delete(
			array(
				'table'=>'project_resource_payments',
				'filters'=>array(
					'id='.$payment_id,
					'project_id='.$project_id,
					'resource_id='.$resource_id
				)
			)
		);

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
			'q'       => $query,
			'module'      => 'project',
			'model'		  => 'ProjectModel',
			'table'		  => ProjectModel::$table,
			'tables'		  => ProjectModel::$tables,
			'pagesize'     => 20,
			'page' => $page,
			'state'       => $state,
			'categories'  => $categories,
			'search_in' =>array('title')
		);

		$Collection = Project::Search($options);

		$States = Project::getListStates();


		parent::loadAdminInterface();
		self::$template->setcontent($Collection, null, 'collection');
		self::$template->setcontent($States, null, 'states');
		self::$template->setparam('query',$query);
		self::$template->setparam('state',$state);
		self::$template->add("list.xsl");
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
