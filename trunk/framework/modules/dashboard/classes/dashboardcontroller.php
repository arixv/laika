<?php

class DashboardController extends Controller  {
	
	static function BackDisplayDefault(){




		/****** clientes con proyectos  *****/
		$params = array(
			'fields'=>array(
				'count(*) as total',
			),
			'table'=>'client inner join project on client.id = project.client_id',
			'filters'=> array(
				'project.state=1'
			)
		);
		$result = Module::select($params);

		$ClientesConProyectos = $result[0];
		$ClientesConProyectos['tag'] = 'object';


		//********* Proveedores con Facturas impagas ******//
		$params = array(
			'fields'=>array(
				'factura.*',
				'provider.*',
				'project.title as project_title'
			),
			'table'=>'factura left join provider on factura.provider_id = provider.id left join project on factura.project_id = project.id',
			'filters'=> array(
				'factura.state=0',
				'provider_id!=0'
			),
			'limit'=>5
		);
		$ProveedoresImpagos = Module::select($params);
		$ProveedoresImpagos['tag'] = 'object';

		//************ Rubros Más Utilizados ************/
		$params = array(
			'fields'=>array('distinct(subrubro_id)','count(subrubro_id) as cant','rubro.*'),
			'table'=>'project_resource inner join project on project_resource.project_id = project.id inner join rubro on project_resource.subrubro_id = rubro.id',
			'filters'=> array(
				'project.state=1'
			),
			'limit'=>5,
			'groupby'=>'project_resource.subrubro_id',
			'orderby'=>'cant desc'
		);
		$RubrosMasUtilizados = Module::select($params,$debug=false);
		$RubrosMasUtilizados['tag'] = 'object';


		/****** RUBROS MAS COSTOSOS **********/
		$params = array(
			'fields'=>array('rubro.*','project_resource.cost'),
			'table'=>'project_resource inner join project on project_resource.project_id = project.id inner join rubro on project_resource.subrubro_id = rubro.id',
			'filters'=> array(
				'project.state=1',
			),
			'limit'=>5,
			'orderby'=>'project_resource.cost desc'
		);
		$RubrosMasCostosos = Module::select($params,$debug=false);
		$RubrosMasCostosos['tag'] = 'object';
		$Totales = array('tag'=>'totales');

		/***** TOTAL DE PROYECTOS *********/
		$TotalProyectos = Module::select(array(
			'fields'=>array('count(id) as total'),
			'table'=>'project',
			'filters'=> array()
		));
		$Totales['projectos'] = $TotalProyectos[0];


		/***** TOTAL DE PRESUPUESTOS *********/
		$TotalPresupuestos = Module::select(array(
			'fields'=>array('count(id) as total'),
			'table'=>'project',
			'filters'=> array('project.state=0')
		));
		$Totales['presupuestos'] = $TotalPresupuestos[0];

		/***** TOTAL DE PROYECTOS EN CURSO *********/
		$TotalCancelados = Module::select(array(
			'fields'=>array('count(id) as total'),
			'table'=>'project',
			'filters'=> array('project.state=1')
		));
		$Totales['encurso'] = $TotalCancelados[0];

		/***** TOTAL DE PROYECTOS TERMINADOS *********/
		$return = Module::select(array(
			'fields'=>array('count(id) as total'),
			'table'=>'project',
			'filters'=> array('project.state=2')
		));
		$Totales['terminados'] = $return[0];

		/***** TOTAL DE PROYECTOS CANCELADOS *********/
		$return = Module::select(array(
			'fields'=>array('count(id) as total'),
			'table'=>'project',
			'filters'=> array('project.state=3')
		));
		$Totales['cancelados'] = $return[0];


		/***** TOTAL DE PROYECTOS EXCEDIDOS *********/
		$return = Module::select(array(
			'fields'=>array('count(id) as total'),
			'table'=>'project',
			'filters'=> array('project.state=4')
		));
		$Totales['excedidos'] = $return[0];

		
		//Payments
		$Payments = Project::getListPayment(array(
			'start_date'=>date('Y-m-d'),
			'get_resources'=>true,
			'limit'=>5,
		));

		//COBROS
		$Cobros = Cobro::getList(array(
			'start_date'=>date('Y-m-d'),
			'page'=>1,
			'pagesize'=>5,
			'sort'=>'date',
			'ordering'=>'asc'

		));


		//All Payments
		$six_month = strtotime('-6 month');
		$start_date= date('Y-m-d',$six_month);
		$end_date= date('Y-m-d',strtotime('+6 month'));

		$EstimatedPaymentCalendar = Project::getEstimatedPaymentCalendar(array(
			'start_date'=>$start_date,
			'end_date'=>$end_date
		));
		
		$PaymentCalendar = Project::getPaymentCalendar(array(
			'start_date'=>$start_date,
			'end_date'=>$end_date
		));
		

		// ** Usuarios con mas proyectos activos ** //
		$return = Module::select(array(
			'fields'=>array(
				'user_admin.user_id',
				'user_admin.username',
				'user_admin.user_name',
				'user_admin.user_lastname',
				'count(project.id) as total_project'
			),
			'table'=>'user_admin LEFT JOIN user_level ON user_admin.access_level = user_level.user_level_id INNER JOIN project ON user_admin.user_id = project.creation_userid',
			'filters'=> array(
				//'user_level.user_level_name = 'productor''
				'project.state = 1'
			),
			'groupby' => 'user_admin.user_id',
			'orderby' => 'total_project DESC',
			'limit'=>'0,5'
		),$debug=false);
		$return['tag']='user';
		$UsersTopFive = $return;

		$return = Module::select(array(
			'fields'=>array(
				'project.id',
				'sum(units * quantity * cost) as real_cost',
				'sum(estimate_units * estimate_quantity * estimate_cost) as estimated_cost',
				'sum(units * quantity * cost) - sum(estimate_units * estimate_quantity * estimate_cost) as result',
				'project.title'
			),
			'table'=>'project_resource LEFT JOIN project ON project_resource.project_id = project.id',
			'filters'=>array(
				'project.state = 2',
			),
			'groupby'=>'project_resource.project_id',
			'orderby'=> 'result ASC',
			'limit'=>'0,5'
		));
		$return['tag'] = 'object';
		$RentabilidadTopFive = $return;
		

		$return = Module::select(array(
			'fields'=>array(
				'client.*',
				'count(*) as total_project',
			),
			'table'=>'project LEFT JOIN client ON project.client_id = client.id',
			// 'filters'=>array(
			// 	'project.state >= 1',
			// 	'project.state != 4'
			// ),
			'groupby'=>'project.client_id',
			'orderby'=> 'total_project DESC',
			'limit'=>'0,5'
		),$debug=false);
		$return['tag'] = 'object';
		$BestClients = $return;
		
		// SELECT client.*, count(project.id) as total_project FROM client INNER JOIN project ON client.id = project.client_id  WHERE project.state >= 1  GROUP BY project.id  ORDER BY total_project DESC  LIMIT 0,5




		parent::loadAdminInterface();
		
		parent::$template->setcontent($ClientesConProyectos,null,'clientes_con_proyectos');
		parent::$template->setcontent($ProveedoresImpagos,null,'proveedores_impagos');
		parent::$template->setcontent($RubrosMasUtilizados,null,'rubros_mas_utilizados');
		parent::$template->setcontent($RubrosMasCostosos,null,'rubros_mas_costosos');
		parent::$template->setcontent($Totales,null,'totales');
		parent::$template->setcontent($Payments,null,'payments');
		parent::$template->setcontent($Cobros,null,'cobros');
		parent::$template->setcontent($PaymentCalendar, null, 'payment_calendar');
		parent::$template->setcontent($EstimatedPaymentCalendar, null, 'estimated_payment_calendar');
		parent::$template->setcontent($UsersTopFive, null, 'users_topfive');
		parent::$template->setcontent($RentabilidadTopFive,null,'rentabilidad');
		parent::$template->setcontent($BestClients,null,'best_clients');
		parent::$template->add("dashboard.xsl");
		parent::$template->display();


	}
	static function FrontDisplayDefault(){


	}
}
?>