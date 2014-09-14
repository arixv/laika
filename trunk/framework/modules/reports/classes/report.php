<?php

class Report {

	public static function GetProjectsReport($options)
	{
		$Report = array();

		$defaults = array(
			'type'=>false,
			'start_date'=>false,
			'end_date'=>false,
			'client_id'=>false,
			'project_id'=>false,
			'state'=>false,
			'creation_userid' =>false,
			'orderby' => false,
			'ordering'=> 'ASC'
		);
		$options = util::extend($defaults,$options);

			$params = array(
				'fields'=>array(
					"project.*",
					'client.title as client_title',
					'user_admin.username',
					'user_admin.user_name as user_name',
					'user_admin.user_lastname as user_lastname',
				),
				'table'=>"project LEFT JOIN client ON project.client_id = client.id LEFT JOIN user_admin ON project.creation_userid = user_admin.user_id" ,
				'filters'=>array(),
			);
			if($options["project_id"]):$params["filters"][]="project.id=".$options["project_id"];endif;
			if($options["start_date"]):$params["filters"][]="project.start_date>='".$options["start_date"]." 00:00:00'";endif;
			if($options["end_date"]):$params["filters"][]="project.end_date<='".$options["end_date"]." 24:00:00'";endif;
			if($options["state"]!== false):$params["filters"][]="project.state=".$options["state"];endif;
			if($options["type"]):$params["filters"][]="project.type='".$options["type"]."'";endif;
			if($options["client_id"]):$params["filters"][]="project.client_id=".$options["client_id"];endif;
			if($options["creation_userid"]):$params["filters"][]="project.creation_userid=".$options["creation_userid"];endif;
			if($options['orderby'] !== false) $params['orderby'] = $options['orderby'] . ' ' . $options['ordering'];
			
			$Report = Module::select($params,false);	
			$Report['tag'] = 'object';

			return $Report;
	}



	public static function GetPartidasReport($options)
	{
		$Report = array();

		$defaults = array(
			'start_date'=>false,
			'end_date'=>false,
			'project_id'=>false,
			'state'=>false,
			'creation_userid' =>false,
			'orderby' => false,
			'ordering'=> 'ASC',
			'debug'=>false
		);
		$options = util::extend($defaults,$options);

			$params = array(
				'fields'=>array(
					"partida.*",
					'project.title as project_title',
					'user_admin.username',
					'user_admin.user_name as user_name',
					'user_admin.user_lastname as user_lastname',
				),
				'table'=>"partida LEFT JOIN project ON partida.project_id = project.id LEFT JOIN user_admin ON partida.creation_userid = user_admin.user_id" ,
				'filters'=>array(),
				'orderby'=>'partida.date ASC'
			);
			if($options["project_id"]):$params["filters"][]="partida.project_id=".$options["project_id"];endif;
			if($options["start_date"]):$params["filters"][]="partida.date>='".$options["start_date"]." 00:00:00'";endif;
			if($options["end_date"]):$params["filters"][]="partida.date<='".$options["end_date"]." 24:00:00'";endif;
			//if($options["state"]!== false):$params["filters"][]="partida.state=".$options["state"];endif;
			if($options["creation_userid"]):$params["filters"][]="partida.creation_userid=".$options["creation_userid"];endif;
			if($options['orderby'] !== false) $params['orderby'] = $options['orderby'] . ' ' . $options['ordering'];

			$Report = Module::select($params,$options['debug']);	
			$Report['tag'] = 'object';

			return $Report;
	}


	public static function GetResourcesReport($options)
	{
		$Report = array();

		$defaults = array(
			'start_date'=>false,
			'end_date'=>false,
			'project_id'=>false,
			'state'=>false,
			'min_cost'=>false,
			'max_cost'=>false,
			'creation_userid' =>false,
			'orderby' => false,
			'ordering'=> 'ASC',
			'debug'=>false
		);
		$options = util::extend($defaults,$options);

			$params = array(
				'fields'=>array(
					"project_resource.*",
					'project.title as project_title',
					'rubro.title as rubro_title',
					'subrubro.title as subrubro_title',
					'user_admin.username',
					'user_admin.user_name as user_name',
					'user_admin.user_lastname as user_lastname',
				),
				'table'=>"project_resource LEFT JOIN project ON project_resource.project_id = project.id  LEFT JOIN rubro ON project_resource.rubro_id = rubro.id  LEFT JOIN rubro as subrubro ON project_resource.subrubro_id = subrubro.id  LEFT JOIN user_admin ON project_resource.creation_userid = user_admin.user_id" ,
				'filters'=>array(),
				'orderby'=>'project_resource.start_date ASC'
			);
			if($options["project_id"]):$params["filters"][]="project_resource.project_id=".$options["project_id"];endif;
			if($options["start_date"]):$params["filters"][]="project_resource.start_date>='".$options["start_date"]." 00:00:00'";endif;
			if($options["end_date"]):$params["filters"][]="project_resource.end_date<='".$options["end_date"]." 24:00:00'";endif;
			if($options["state"]!== false):$params["filters"][]="project_resource.state=".$options["state"];endif;
			if($options["creation_userid"]):$params["filters"][]="project_resource.creation_userid=".$options["creation_userid"];endif;
			if($options["min_cost"] !== false):$params["filters"][]="project_resource.cost>=".$options["min_cost"];endif;
			if($options["max_cost"] !== false):$params["filters"][]="project_resource.cost<=".$options["max_cost"];endif;
			if($options['orderby'] !== false) $params['orderby'] = $options['orderby'] . ' ' . $options['ordering'];
			
			$Report = Module::select($params,$options['debug']);	
			$Report['tag'] = 'object';

			return $Report;
	}


	public static function GetFacturasReport($options){
		$Report = array();

		$defaults = array(
			'number'=>false,
			'partida_id'=>false,
			'min_amount'=>false,
			'max_amount'=>false,
			'resource_id'=>false,
			'rubro_id'=>false,
			'subrubro_id'=>false,
			'start_date'=>false,
			'end_date'=>false,
			'project_id'=>false,
			'provider_id'=>false,
			'state'=>false,
			'type'=>false,
			'creation_userid'=>false,
			'orderby' => false,
			'ordering'=> 'ASC',
			'debug'=>false
		);

		$options = util::extend($defaults,$options);

		$params = array(
			'fields'=>array(
				"factura.*",
				'project.title as project_title',
				'provider.title as provider_title',
				'rubro.title as subrubro_title',
				'user_admin.username',
				'user_admin.user_name as user_name',
				'user_admin.user_lastname as user_lastname',
			),
			'table'=>
				"factura LEFT JOIN project ON factura.project_id = project.id LEFT JOIN rubro ON factura.subrubro_id = rubro.id LEFT JOIN user_admin ON factura.creation_userid = user_admin.user_id LEFT JOIN provider ON factura.provider_id = provider.id" ,
			'filters'=>array(),
			'orderby'=>'factura.date ASC'
		);

		if($options["number"]):$params["filters"][]="factura.number='".$options["number"]."'";endif;
		if($options["type"]):$params["filters"][]="factura.type='".$options["type"]."'";endif;
		if($options["min_amount"]):$params["filters"][]="factura.amount>=".$options["min_amount"];endif;
		if($options["max_amount"]):$params["filters"][]="factura.amount<=".$options["max_amount"];endif;
		if($options["project_id"]):$params["filters"][]="factura.project_id=".$options["project_id"];endif;
		if($options["provider_id"]):$params["filters"][]="factura.provider_id=".$options["provider_id"];endif;
		if($options["start_date"]):$params["filters"][]="factura.date>='".$options["start_date"]." 00:00:00'";endif;
		if($options["end_date"]):$params["filters"][]="factura.date<='".$options["end_date"]." 24:00:00'";endif;
		if($options["state"]!== false):$params["filters"][]="factura.state=".$options["state"];endif;
		if($options["creation_userid"]):$params["filters"][]="factura.creation_userid=".$options["creation_userid"];endif;
		
		if($options['orderby'] !== false) $params['orderby'] = $options['orderby'] . ' ' . $options['ordering'];

		$Report = Module::select($params,$options['debug']);	
		$Report['tag'] = 'object';

		return $Report;
	}



	public static function GetProvidersReport($options){
		$Report = array();

		$defaults = array(
			'rubro_id'=>false,
			'subrubro_id'=>false,
			'start_date'=>false,
			'end_date'=>false,
			'project_id'=>false,
			'provider_id'=>false,
			'state'=>false,
			'type'=>false,
			'orderby' => false,
			'ordering'=> 'ASC',
			'debug'=>false
		);

		$options = util::extend($defaults,$options);

		$params = array(
			'fields'=>array(
				"provider.*",
				"factura.*",
				"sum(factura.amount) as total_facturado",
				"project.title as project_title"
			),
			'table'=>"provider LEFT JOIN factura ON provider.id = factura.provider_id LEFT JOIN project ON factura.project_id = project.id" ,
			'filters'=>array('factura.state=1'),
			'orderby'=>'factura.date ASC',
			'groupby'=>'provider.id'
		);

		if($options["project_id"]):$params["filters"][]="factura.project_id=".$options["project_id"];endif;
		if($options["provider_id"]):$params["filters"][]="provider.id=".$options["provider_id"];endif;
		if($options["start_date"]):$params["filters"][]="factura.date>='".$options["start_date"]." 00:00:00'";endif;
		if($options["end_date"]):$params["filters"][]="factura.date<='".$options["end_date"]." 24:00:00'";endif;
		if($options['orderby'] !== false) $params['orderby'] = $options['orderby'] . ' ' . $options['ordering'];

		$Report = Module::select($params,false);	
		$Report['total'] = 0;
		if(is_array($Report)){
			foreach($Report as $item){
				$Report['total'] += $item['amount'];
			}
		}
		$Report['tag'] = 'object';

		return $Report;
	}

}


?>