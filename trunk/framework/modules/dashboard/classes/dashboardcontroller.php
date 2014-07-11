<?php

class DashboardController extends Controller  {
	
	static function BackDisplayDefault(){

		//********* Proveedores con Facturas impagas ******//
		$params = array(
			'fields'=>array('*'),
			'table'=>'factura left join provider on factura.provider_id = provider.id',
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
			'table'=>'project_subrubro inner join project on project_subrubro.project_id = project.id inner join rubro on project_subrubro.subrubro_id = rubro.id',
			'filters'=> array(
				'project.state=1'
			),
			'limit'=>5,
			'groupby'=>'project_subrubro.subrubro_id',
			'orderby'=>'cant desc'
		);
		$RubrosMasUtilizados = Module::select($params,$debug=false);
		$RubrosMasUtilizados['tag'] = 'object';


		/***** TOTAL DE PRESUPUESTOS *********/
		$params = array(
			'fields'=>array('count(id) as total'),
			'table'=>'project',
			'filters'=> array(
				'project.state=0'
			)
		);
		$TotalPresupuestos = Module::select($params);
		$TotalPresupuestos = $TotalPresupuestos[0];

		/****** RUBROS MAS COSTOSOS **********/
		$params = array(
			'fields'=>array('rubro.*','project_subrubro.cost'),
			'table'=>'project_subrubro inner join project on project_subrubro.project_id = project.id inner join rubro on project_subrubro.subrubro_id = rubro.id',
			'filters'=> array(
				'project.state=1',
			),
			'limit'=>5,
			'orderby'=>'project_subrubro.cost desc'
		);
		$RubrosMasCostosos = Module::select($params,$debug=false);
		$RubrosMasCostosos['tag'] = 'object';



		/***** TOTAL DE PROYECTOS *********/
		$params = array(
			'fields'=>array('count(id) as total'),
			'table'=>'project',
			'filters'=> array(
				'project.state=1'
			)
		);
		$TotalProyectos = Module::select($params);
		$TotalProyectos = $TotalProyectos[0];


		parent::loadAdminInterface();
		parent::$template->setcontent($ProveedoresImpagos,null,'proveedores_impagos');
		parent::$template->setcontent($RubrosMasUtilizados,null,'rubros_mas_utilizados');
		parent::$template->setcontent($RubrosMasCostosos,null,'rubros_mas_costosos');
		parent::$template->setcontent($TotalPresupuestos,null,'total_presupuestos');
		parent::$template->setcontent($TotalProyectos,null,'total_proyectos');
		parent::$template->add("dashboard.xsl");
		parent::$template->display();


	}
	static function FrontDisplayDefault(){


	}
}
?>