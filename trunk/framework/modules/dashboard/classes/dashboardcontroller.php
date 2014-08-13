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
			'limit'=>5
		));



		parent::loadAdminInterface();
		
		parent::$template->setcontent($ClientesConProyectos,null,'clientes_con_proyectos');
		parent::$template->setcontent($ProveedoresImpagos,null,'proveedores_impagos');
		parent::$template->setcontent($RubrosMasUtilizados,null,'rubros_mas_utilizados');
		parent::$template->setcontent($RubrosMasCostosos,null,'rubros_mas_costosos');
		parent::$template->setcontent($Totales,null,'totales');
		parent::$template->setcontent($Payments,null,'payments');
		parent::$template->add("dashboard.xsl");
		parent::$template->display();


	}
	static function FrontDisplayDefault(){


	}
}
?>