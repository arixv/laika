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
		$sort = Util::getvalue("sort","project.id DESC");
	

		$User = Admin::IsLoguedIn();

		$options = array(
				'module'	  => 'project',
				'model'		  => 'ProjectModel',
				'table'		  => 'project',
				'currentPage' => $page,
				'pagesize'	  => 10, 
				'state'		  => ($state != 'false') ? $state : false, 
				'orderby'	  => $sort,
				'page'		  => $page,
				'categories'  => $categories,
				'multimedia'  => true,
				'relations'   => false,
				'user_logged' => $User
		);
		$Collection = Project::GetList($options);

		//Estados
		$States = Project::getListStates();
		
		self::loadAdminInterface();
		/*
		self::$template->showError = true;
		self::$template->debug = true;
		*/

		// Util::debug($options);
		// Util::debug($Collection);
		// Util::debug($States);
		// Util::debug($sort);
		self::$template->setcontent($Collection, null, 'collection');
		self::$template->setcontent($States, null, 'states');
		self::$template->setparam('state',$options['state']);
		self::$template->setparam('category_id',$options['categories']);
		self::$template->setparam('sort',$sort);
		self::$template->add("list.xsl");
		self::$template->display();
	}

	public static function BackDisplayDashboard( $params ){
		$User = Admin::IsLoguedIn();
		$project_id = Util::getvalue('project_id');

		$Object = Project::getById(
			$options = array(
				'id' => $project_id,
				'user_logged'=>$User
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
			
		//All Payments
		$EstimatedPaymentCalendar = Project::getEstimatedPaymentCalendar(array(
			'project_id'=>$project_id,
		));

		//PaymentCalendar 
		$PaymentCalendar = Project::getPaymentCalendar(array(
			'project_id'=>$project_id,
		));
	

		//FuturePayments
		$FuturePayments = Project::getListPayment(array(
			'project_id'=>$project_id,
			'start_date'=>date('Y-m-d'),
			'get_resources'=>true
		));

		//COBROS
		$Cobros = Cobro::getList(array(
			'start_date'=>date('Y-m-d'),
			'project_id'=>$project_id,
			'page'=>1,
			'pagesize'=>5,
			'sort'=>'date',
			'ordering'=>'asc'
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
		
		//Calculos
		$total_estimate = $TotalEstimate['total'];
		$total_imprevistos = ceil($total_estimate * $Object['imprevistos'] / 100);
		$total_ganancia = ceil(($total_estimate + $total_imprevistos) * $Object['ganancia'] / 100);
		$total_impuestos = ceil((($total_ganancia + $total_imprevistos + $total_estimate) * $Object['impuestos']) / 100);
		$subtotal_neto = $total_estimate + $total_imprevistos + $total_ganancia + $total_impuestos;
		$iva = ceil($subtotal_neto * $Object['iva'] / 100);
		$costo_proyecto = $subtotal_neto + $iva;
		
		// echo '<p>total estimate: ' . $total_estimate;
		// echo '<p>total_imprevistos: ' . $total_imprevistos;
		// echo '<p>total_ganancia: ' . $total_ganancia;
		// echo '<p>total_impuestos: ' . $total_impuestos;
		// echo '<p>subtotal_neto: ' . $subtotal_neto;
		// echo '<p>iva: ' . $iva;
		// echo '<p>Total: ' . $costo_proyecto;


		//Calculo  de Indice
		$tipo_facturacion = settings::get('tipo_facturacion');
		$facturacion_anual = settings::get('facturacion_anual');
		$costo_operativo = CostoOperativo::getTotal();
	
		$start_date = new DateTime($Object['start_date-att']);
		$end_date = new DateTime($Object['end_date-att']);
		$interval = date_diff($start_date, $end_date);
		$meses = 0;
		$days = number_format($interval->d / 30,2);
		
		$meses = $start_date->diff($end_date)->m + ($start_date->diff($end_date)->y*12); // int(8)
		
		$duracion_meses = $meses + $days;
		
		$porcentaje_costo = $costo_proyecto / $facturacion_anual['setting_value'];

		$indice = round( $costo_operativo * $porcentaje_costo * $duracion_meses, $precision = 0);
		
		// util::debug("calculation: costo_operativo * porcentaje_costo * duracion_meses");
		// util::debug('costo proyecto: $' . $costo_proyecto);
		// util::debug('costo_operativo: $' . $costo_operativo);
		// util::debug('facturacion_anual: $' . $facturacion_anual['setting_value']);
		// util::debug('porcentaje_costo: ' . $porcentaje_costo );
		// util::debug('duracion_meses: $' . $duracion_meses);
		// util::debug('indice: $' . $indice);
		

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
		self::$template->setcontent($PaymentCalendar, null, 'payment_calendar');
		self::$template->setcontent($EstimatedPaymentCalendar, null, 'estimated_payment_calendar');
		self::$template->setcontent($FuturePayments, null, 'future_payments');
		self::$template->setcontent($Cobros, null, 'cobros');
		self::$template->setparam('total_estimate',$total_estimate);
		self::$template->setparam('total_imprevistos',$total_imprevistos);
		self::$template->setparam('total_ganancia',$total_ganancia);
		self::$template->setparam('total_impuestos',$total_impuestos);
		self::$template->setparam('subtotal_neto',$subtotal_neto);
		self::$template->setparam('iva',$iva);
		self::$template->setparam('costo_proyecto',$costo_proyecto);
		self::$template->setparam('indice', $indice);

		self::$template->add("project.templates.xsl");
		self::$template->add("dashboard.xsl");
		self::$template->display();
	}

	public static function BackDisplayPrintPartidas(){
		$project_id = Util::getvalue('project_id');
		$User = Admin::IsLoguedIn();
		
		
		if($User){
			$Project = Project::getById(array(
				'id' => $project_id,
			));

			$Partidas = Project::getPartidas(array(
				'project_id'=> $project_id
			));

			parent::loadAdminInterface();
			self::$template->setcontent($Project, null, 'object');
			self::$template->setcontent($Partidas,null,'partidas');
			self::$template->add("print.partidas.xsl");
			self::$template->display();

		}
	}

	public static function BackDisplayPrintPartidaSingle(){
		
		$User = Admin::IsLoguedIn();
		$project_id = Util::getvalue('project_id');
		$partida_id = Util::getvalue('partida_id');

		if($User):

			$Project = Project::getById(array(
				'id'=>$project_id,
				'user_logged'=>$User
			));
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
			self::$template->add("print.partida.single.xsl");
			self::$template->display();

		endif;

	}


	public static function BackDisplayPrint(){
		$print_type = util::Getvalue('type');
		$project_id = Util::getvalue('project_id');
		$User = Admin::IsLoguedIn();
		
		
		if($User){
			$options = array(
				'id' => $project_id,
			);

			//Content
			$Object = Project::getById($options);
			$Client = Client::getById(array('id'=>$Object['client_id']));
			$States = Project::getListStates();
			$ProjectOwner = Admin::getById($Object['creation_userid']);
			$Resources = Project::getRubros($options=array('project_id'=>$project_id));
			$Providers = Provider::getList();
			
			$TotalEstimate = Project::getEstimate(array('project_id'=>$project_id));
			$TotalReal = Project::getReal(array('project_id'=>$project_id));



			parent::loadAdminInterface();
			self::$template->setcontent($States, null, 'states');
			self::$template->setcontent($Object, null, 'object');
			self::$template->setcontent($TotalEstimate, null, 'estimate');
			self::$template->setcontent($TotalReal, null, 'real');
			// self::$template->setcontent($Progress, null, 'progress');
			self::$template->setcontent($ProjectOwner, null, 'project_owner');
			// self::$template->setcontent($Partidas, null, 'partidas');
			// self::$template->setcontent($Facturas, null, 'facturas');
			self::$template->setcontent($Resources,null,'resources');
			self::$template->setcontent($Providers,null,'providers');
			self::$template->setcontent($Client, null, 'client');
			self::$template->setparam('print_type',$print_type);
			self::$template->add("project.templates.xsl");
			self::$template->add("print.xsl");
			self::$template->display();
		}
	}

	/**
	* Display View for Edit Object
	* @return display view
	**/
	public static function BackDisplayEdit(){

		$project_id = Util::getvalue('id');
		$User = Admin::IsLoguedIn();
		
		$options = array(
			'id' => $project_id,
			'user_logged'=>$User
		);

		$Object = Project::getById($options);
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
		$costo_operativo = CostoOperativo::getTotal();

		parent::loadAdminInterface();
		self::$template->setcontent($Clients, null, 'clients');
		self::$template->setparam('costo_operativo',$costo_operativo );
		self::$template->add("add.xsl");
		self::$template->display();
	}
	
public static function BackAdd()
	{
		$post = $_POST;

		$post['start_date'] = Util::inverseDate($post['start_date']);
		$post['end_date'] = Util::inverseDate($post['end_date']);

		$objectId  = Project::Add($options = array(
				'fields'		=> $post,
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
		$post = $_POST;
		$post['costo_operativo'] = util::getcurrency('costo_operativo');

		if ( isset($post['id'] ) ) {
			$post['start_date'] = Util::inverseDate($post['start_date']);
			$post['end_date'] = Util::inverseDate($post['end_date']);

			$objectEdited  = Object_Custom::edit(
				$options = array(
					'fields'		=> $post,
					'model' 	=> 'ProjectModel',
					'table' 	=> ProjectModel::$table,
					'tables' 	=> ProjectModel::$tables,
					'verbose' 	=> true
				)
			);

			// Update Indice.
			Project::saveIndiceEPL( $post['id'] );

			$display['back']    = ( isset($post['back']) ) ? 1 : 0;
			$display['item_id'] = $post['id'];
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
				'description'	=>	util::getvalue('description'),
				'amount'		=> 	util::getcurrency('amount'),
				'responsable'	=>	util::getvalue('responsable'),
				'date'			=> 	util::inverseDate(util::getvalue('date')),
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
				'amount'=>util::getcurrency('amount'),
				'responsable'=>$_REQUEST['responsable'],
				'date'=> util::inverseDate(util::getvalue('date')),
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

	/**  Payments **/

	public static function BackDisplayListPayments(){
		$project_id = Util::getvalue("project_id");
		$sort = Util::getvalue("sort",'date');
		
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

		$Payments = Project::getListPayment(array(
			'project_id'=>$project_id,
			'get_resources'=>true
		));

		parent::loadAdminInterface();
		self::$template->setcontent($Project, null, 'object');
		self::$template->setcontent($Payments, null, 'payments');
		self::$template->add("list.payments.xsl");
		self::$template->add("project.templates.xsl");
		self::$template->setparam("sort",$sort);
		self::$template->display();

	}


	/******** FACTURAS ********/

	/* list partidas for a project*/
	public static function BackDisplayListFactura()
	{
		$project_id = Util::getvalue("project_id");
		$sort = Util::getvalue("sort",'factura.id');


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

		$Facturas = Project::getFacturas(array(
			'project_id' => $project_id,
			'orderby'	 => $sort
		));

		parent::loadAdminInterface();
		self::$template->setcontent($Project, null, 'object');
		self::$template->setcontent($Facturas, null, 'facturas');
		self::$template->add("list.factura.xsl");
		self::$template->add("project.templates.xsl");
		self::$template->setparam("sort",$sort);
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
		$resource_id = util::getvalue('resource_id',false);
		$partida_id = util::getvalue('partida_id',false);
		$redirect = util::getvalue('redirect');

		
		$params = array(
			'fields' => array(
				'project_id' => $project_id,
				'partida_id' => $partida_id,
				'number' => util::getvalue('number'),
				'description' => util::getvalue('description'),
				'amount' => util::getcurrency('amount'),
				'type' => util::getvalue('type'),
				'state' => util::getvalue('state'),
				'date' => util::inversedate(util::getvalue('date')),
				'creation_userid' => $User['user_id-att'],
			),
			'table' => 'factura'
		);
	
		if( $resource_id !== false ) :
			$Resource = Project::getResource( array(
				'project_id' => $project_id,
				'resource_id' => $resource_id
			));
			$params['fields']['resource_id'] = $resource_id;
			$params['fields']['subrubro_id'] = $Resource['subrubro_id'];
			$params['fields']['provider_id'] = $Resource['provider_id'];
		endif;

		$id = Project::insert( $params, $debug =  false );
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


		$Partidas = Project::getPartidas( array(
			'project_id' => $project_id
		));

		$Rubros = Project::getRubros( array(
			'project_id' => $project_id
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
					'amount'=>util::getcurrency('amount'),
					'partida_id'=>Util::Getvalue('partida_id'),
					'resource_id'=> $resource_id,
					'provider_id'=> $Resource['provider_id'],
					'subrubro_id'=> $Resource['subrubro_id'],
					'type'=>Util::Getvalue('type'),
					'state' => Util::Getvalue('state'),
					'payment_date' => util::inverseDate( Util::Getvalue('payment_date') ),
					'payment_format' => Util::Getvalue('payment_format'),
					'date' => util::inverseDate( Util::Getvalue('date') ),
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

	public static function BackSortResources(){
		$data = $_POST['data'];
		$json = json_decode($data);
		
		if($json->project_id){
			if(is_array($json->objects)){
			foreach($json->objects as $obj){
				$id = str_replace('rubro_','', $obj->id);
				$order = $obj->order;
				Project::update(array(
					'table'=>'project_rubro',
					'fields'=>array(
						'position'=>$order
					),
					'filters'=>array(
						'project_id='.$json->project_id,
						'rubro_id='.$id
					)
				));
			}
		}
		}
		
	}

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

		$Rubros = Project::getRubros(array('project_id'=>$project_id));
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
			$params['fields']['estimate_cost'] = util::getcurrency('estimate_cost');
			$params['fields']['units'] = util::getvalue('estimate_units');
			$params['fields']['quantity'] = util::getvalue('estimate_quantity');
			$params['fields']['cost'] = util::getvalue('estimate_cost');
		else:
			$params['fields']['units'] = util::getvalue('units');
			$params['fields']['quantity'] = util::getvalue('quantity');
			$params['fields']['cost'] = util::getcurrency('cost');
		endif;	

		Project::update($params);


		//INSERT SUBRUBRO PAYMENT CALENDAR
		$payments_values = Util::getvalue("payments_values");
		$payments_days = Util::getvalue("payments_days");

		if(is_array($payments_values)):
			foreach($payments_values as $key=>$payment_value){
				$params = array(
					'fields'=>array(
						'project_id'=> $project_id,
						'resource_id'=> $resource_id,
						'date'=> util::inverseDate($payments_days[$key]),
						'value'=>$payment_value
					),
					'table'=>'project_resource_payments'
				);
				Module::insert($params,$debug=false);
			}
		endif;


		Util::redirect("/admin/project/list_resources/".$_REQUEST['project_id']);
	}

	public static function BackAddResource() {
		$User = Admin::IsLoguedIn();
		$subrubro_id = Util::getvalue("subrubro_id");
		$project_id = Util::getvalue("project_id");

		$Project = Project::getById(array(
			'id'  => $project_id,
		));

		if($subrubro_id == ''):
			die("Por favor seleccione un SubRubro");
		endif;

		//SubRubro Item
		$ResultSubRubro = Project::select(array(
			'fields' =>array(
				"rubro.id as rubro_id",
				"rubro.parent_id as rubro_parent_id",
				"rubro.sindicato_id as rubro_sindicato_id",
				"rubro.title as rubro_title",
				"sindicato.id as sindicato_id",
				"sindicato.name as sindicato_name", 
				"sindicato.percentage as sindicato_percentage", 
			),
			'table' => 'rubro left join sindicato on rubro.sindicato_id = sindicato.id',
			'filters'=>array(
				'rubro.id=' . $subrubro_id
			)
		),$debug = false );

		if ( ! isset( $ResultSubRubro[0] ) ) {
			die("No existe el subrubro");
		}
		$SubRubro = $ResultSubRubro[0];

		//Check if RubroParent is Asociated to the Project
		$Result = Project::select( array(
			'fields' =>array("*"),
			'table' => 'project_rubro',
			'filters'=>array(
				'rubro_id=' . $SubRubro['rubro_parent_id'],
				'project_id=' . $project_id
			)
		));

		//If not Result Insert RubroParent Relation with project
		if ( empty( $Result ) ) {
			$Result = Project::insert(array(
				'fields' =>array(
					"project_id" => $project_id,
					"rubro_id" => $SubRubro['rubro_parent_id'],
					"state" => 0
				),
				'table' => 'project_rubro'
			));
		}

		//INSERT RESOURCE 
		$estimate_units = Util::getvalue("estimate_units");
		$estimate_quantity = Util::getvalue("estimate_quantity");
 		$estimate_cost = Util::getcurrency("estimate_cost");

		$real_units = ($Project['state-att'] == 0)?$estimate_units:Util::getvalue("units");
		$real_quantity = ($Project['state-att'] == 0)?$estimate_quantity:Util::getvalue("quantity");
		$real_cost = ($Project['state-att'] == 0)?$estimate_cost:Util::getcurrency("cost");

		$params = array(
			'fields'=>array(
				'project_id'=> $project_id,
				'rubro_id'=> $SubRubro['rubro_parent_id'],
				'subrubro_id'=> $SubRubro['rubro_id'],
				'provider_id'=> Util::getvalue("provider_id"),
				'description'=> Util::getvalue('description'),
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
		if ( isset( $SubRubro['sindicato_percentage'] ) && '' != $SubRubro['sindicato_percentage'] ) {
			$params['fields']['sindicato_percentage'] = $SubRubro['sindicato_percentage'];
		}

		Module::insert($params,$debug = false );

		// Update Indice.
		Project::saveIndiceEPL( $project_id );


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

			// Update Indice.
			Project::saveIndiceEPL( $project_id );

			echo "1";
		else:
			echo "0";
		endif;
	}

	/* delete payment date */
	public static function BackDeletePayment(){
		$payment_id = Util::getvalue("id");
		$project_id = Util::getvalue("project_id");
		// $resource_id = Util::getvalue("resource_id");
		
		echo Module::delete(
			array(
				'table' => 'project_resource_payments',
				'filters' => array(
					'id=' . $payment_id,
					'project_id=' . $project_id
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
