<?php

class Report {

	public static function GetProjectsReport($options)
	{
		$Report = array();

		$defaults = array(
			'type'=>false,
			'start_date'=>false,
			'end_date'=>false,
			'clients'=>false,
			'projects'=>false,
			'states'=>false,
			'creation_userid' =>false,
			'orderby' => false,
			'ordering'=> 'ASC'
		);
		$options = util::extend($defaults,$options);

		if(is_array($options['projects'])) $options['projects'] = implode(',',$options['projects']);
		if(is_array($options['clients'])) $options['clients'] = implode(',',$options['clients']);
		if(is_array($options['states'])) $options['states'] = implode(',',$options['states']);
		if(is_array($options['types'])) $options['types'] = implode("','",$options['types']);


			$params = array(
				'fields'=>array(
					"project.*",
					'client.title as client_title',
					'user_admin.user_id',
					'user_admin.username',
					'user_admin.user_name as user_name',
					'user_admin.user_lastname as user_lastname',
				),
				'table'=>"project LEFT JOIN client ON project.client_id = client.id LEFT JOIN user_admin ON project.creation_userid = user_admin.user_id" ,
				'filters'=>array(),
			);
			if($options["projects"]):$params["filters"][]="project.id IN (".$options["projects"]. ")";endif;
			if($options["start_date"]):$params["filters"][]="project.start_date>='".$options["start_date"]." 00:00:00'";endif;
			if($options["end_date"]):$params["filters"][]="project.end_date<='".$options["end_date"]." 24:00:00'";endif;
			if($options["states"]!== false):$params["filters"][]="project.state IN (".$options["states"].')';endif;
			if($options["types"]):$params["filters"][]="project.type  IN ('".$options["types"]."')";endif;
			if($options["clients"]):$params["filters"][]="project.client_id IN (".$options["clients"]. ')';endif;
			
			//FILTER BY USER
			if($options["creation_userid"]):
				$params["filters"][]="project.creation_userid=".$options["creation_userid"];
			endif;
			if(isset($options['user_logged']) && $options['user_logged']['role']['user_level_name'] == 'responsable'):
				$params["filters"][]="project.creation_userid=".$options['user_logged']['user_id-att'];
			endif;
			
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
			'projects'=>false,
			'min_cost' => false,
			'max_cost' => false,
			'creation_userid' =>false,
			'orderby' => false,
			'responsable' => false,
			'ordering'=> 'ASC',
			'debug'=>false
		);
		$options = util::extend($defaults,$options);
		
		if(is_array($options['projects'])) $options['projects'] = implode(',',$options['projects']);

			$params = array(
				'fields'=>array(
					"partida.*",
					'project.title as project_title',
					'user_admin.user_id',
					'user_admin.username',
					'user_admin.user_name as user_name',
					'user_admin.user_lastname as user_lastname',
				),
				'table'=>"partida LEFT JOIN project ON partida.project_id = project.id LEFT JOIN user_admin ON partida.creation_userid = user_admin.user_id" ,
				'filters'=>array(),
				'orderby'=>'partida.date ASC'
			);
			if($options["projects"]):$params["filters"][]="partida.project_id IN (".$options["projects"].')';endif;
			if($options["start_date"]):$params["filters"][]="partida.date>='".$options["start_date"]." 00:00:00'";endif;
			if($options["end_date"]):$params["filters"][]="partida.date<='".$options["end_date"]." 24:00:00'";endif;
			if($options['min_cost']):$params['filters'][]="amount>=" . $options['min_cost'];endif;
			if($options['max_cost']):$params['filters'][]="amount<=" . $options['max_cost'];endif;
			if($options['responsable']):$params['filters'][]= 'responsable LIKE "%' . $options['responsable'] . '%" ';endif;

			//FILTER BY USER
			if($options["creation_userid"]):
				$params["filters"][]="project.creation_userid=".$options["creation_userid"];
			endif;
			if(isset($options['user_logged']) && $options['user_logged']['role']['user_level_name'] == 'responsable'):
				$params["filters"][]="project.creation_userid=".$options['user_logged']['user_id-att'];
			endif;

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
			'projects'=>false,
			'providers'=>false,
			'subrubros'=>false,
			'sindicatos'=>false,
			'state'=>false,
			'min_cost'=>false,
			'max_cost'=>false,
			'orderby' => false,
			'concept' => false,
			'ordering'=> 'ASC',
			'debug'=>false
		);
		$options = util::extend($defaults,$options);

		if(is_array($options['subrubros'])) $options['subrubros'] = implode(',',$options['subrubros']);
		if(is_array($options['providers'])) $options['providers'] = implode(',',$options['providers']);
		if(is_array($options['projects'])) $options['projects'] = implode(',',$options['projects']);
		if(is_array($options['sindicatos'])) $options['sindicatos'] = implode(',',$options['sindicatos']);

			$params = array(
				'fields'=>array(
					"project_resource.*",
					'project.title as project_title',
					'rubro.title as rubro_title',
					'subrubro.title as subrubro_title',
					'provider.title as provider_title',
					'user_admin.username',
					'user_admin.user_name as user_name',
					'user_admin.user_lastname as user_lastname',
					'sindicato.id as sindicato_id',
					'sindicato.name as sindicato_name',
					'sindicato.percentage as sindicato_percentage',
				),
				'table'=>"project_resource LEFT JOIN provider ON project_resource.provider_id = provider.id LEFT JOIN project ON project_resource.project_id = project.id  LEFT JOIN rubro ON project_resource.rubro_id = rubro.id  LEFT JOIN rubro as subrubro ON project_resource.subrubro_id = subrubro.id LEFT JOIN sindicato ON subrubro.sindicato_id = sindicato.id  LEFT JOIN user_admin ON project_resource.creation_userid = user_admin.user_id" ,
				'filters'=>array(),
				'orderby'=>'project_resource.start_date ASC'
			);
			if($options["projects"]):$params["filters"][]="project_resource.project_id IN (".$options["projects"] . ')';endif;
			if($options["start_date"]):$params["filters"][]="project_resource.start_date>='".$options["start_date"]." 00:00:00'";endif;
			if($options["end_date"]):$params["filters"][]="project_resource.end_date<='".$options["end_date"]." 24:00:00'";endif;
			if($options["state"]):$params["filters"][]="project_resource.state=".$options["state"];endif;
			if($options["min_cost"]):$params["filters"][]="project_resource.cost>=".$options["min_cost"];endif;
			if($options["max_cost"]):$params["filters"][]="project_resource.cost<=".$options["max_cost"];endif;
			if($options["providers"]):$params["filters"][]="project_resource.provider_id IN (".$options["providers"] . ")";endif;
			if($options["subrubros"]):$params["filters"][]="project_resource.subrubro_id IN (".$options['subrubros'].")";endif;
			if($options["sindicatos"]):$params["filters"][]="subrubro.sindicato_id IN (".$options['sindicatos'].")";endif;
			if($options["concept"]):$params["filters"][]="project_resource.concept='".$options["concept"]."'";endif;
			
			//FILTER BY USER
			if(isset($options["creation_userid"]) && $options["creation_userid"]!=false ):
				$params["filters"][]="project.creation_userid=".$options["creation_userid"];
			endif;
			if(isset($options['user_logged']) && $options['user_logged']['role']['user_level_name'] == 'responsable'):
				$params["filters"][]="project.creation_userid=".$options['user_logged']['user_id-att'];
			endif;

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
			'start_date'=>false,
			'end_date'=>false,
			'projects'=>false,
			'provider_id'=>false,
			'subrubros'=>false,
			'state'=>false,
			'type'=>false,
			'creation_userid'=>false,
			'orderby' => false,
			'ordering'=> 'ASC',
			'debug'=>false
		);

		$options = util::extend($defaults,$options);

		if(is_array($options['subrubros'])) $options['subrubros'] = implode(',',$options['subrubros']);
		if(is_array($options['projects'])) $options['projects'] = implode(',',$options['projects']);

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
		if($options["projects"]):$params["filters"][]="factura.project_id IN (".$options["projects"].')';endif;
		if($options["provider_id"]):$params["filters"][]="factura.provider_id=".$options["provider_id"];endif;
		if($options["subrubros"]):$params["filters"][]="factura.subrubro_id IN (".$options["subrubros"].')';endif;
		if($options["start_date"]):$params["filters"][]="factura.date>='".$options["start_date"]." 00:00:00'";endif;
		if($options["end_date"]):$params["filters"][]="factura.date<='".$options["end_date"]." 24:00:00'";endif;
		if($options["state"]):$params["filters"][]="factura.state=".$options["state"];endif;
		
		//FILTER BY USER
		if(isset($options["creation_userid"]) && $options["creation_userid"]!=false ):
			$params["filters"][]="project.creation_userid=".$options["creation_userid"];
		endif;
		if(isset($options['user_logged']) && $options['user_logged']['role']['user_level_name'] == 'responsable'):
			$params["filters"][]="project.creation_userid=".$options['user_logged']['user_id-att'];
		endif;
			
		
		if($options['orderby'] !== false) $params['orderby'] = $options['orderby'] . ' ' . $options['ordering'];

		$Report = Module::select($params,$options['debug']);	
		$Report['tag'] = 'object';

		return $Report;
	}

	public static function GetCobrosReport($options){
		$Report = array();

		$defaults = array(
			'number'=>false,
			'min_amount'=>false,
			'max_amount'=>false,
			'start_date'=>false,
			'end_date'=>false,
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
				CobroModel::$table.".*",
				// 'provider.title as provider_name',
				'user_admin.username',
				'user_admin.user_name as user_name',
				'user_admin.user_lastname as user_lastname',
			),
			'table'=>
				CobroModel::$table." LEFT JOIN project ON cobro.project_id = project.id LEFT JOIN user_admin ON ".CobroModel::$table.".creation_userid = user_admin.user_id" ,
			'filters'=>array(),
			'orderby'=> CobroModel::$table.'.date ASC'
		);

		if($options["number"]):$params["filters"][]= CobroModel::$table.".number='".$options["number"]."'";endif;
		if($options["type"]):$params["filters"][]= CobroModel::$table.".type='".$options["type"]."'";endif;
		if($options["min_amount"]):$params["filters"][]=CobroModel::$table.".amount>=".$options["min_amount"];endif;
		if($options["max_amount"]):$params["filters"][]=CobroModel::$table.".amount<=".$options["max_amount"];endif;
		if($options["start_date"]):$params["filters"][]= CobroModel::$table.".date>='".$options["start_date"]." 00:00:00'";endif;
		if($options["end_date"]):$params["filters"][]= CobroModel::$table.".date<='".$options["end_date"]." 24:00:00'";endif;
		if($options["state"]):$params["filters"][]= CobroModel::$table.".state=".$options["state"];endif;
		
		//FILTER BY USER
		if($options["creation_userid"]):
			$params["filters"][]="project.creation_userid=".$options["creation_userid"];
		endif;
		if($options['user_logged'] && $options['user_logged']['role']['user_level_name'] == 'responsable'):
			$params["filters"][]="project.creation_userid=".$options['user_logged']['user_id-att'];
		endif;

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
			'provider'=>false,
			'state'=>false,
			'type'=>false,
			'orderby' => false,
			'ordering'=> 'ASC',
			'debug'=>false
		);

		$options = util::extend($defaults,$options);

		if(is_array($options['provider'])) $options['provider'] = implode(',',$options['provider']);

		$params = array(
			'fields'=>array(
				"provider.*",
				"factura.*",
				"sum(factura.amount) as total_facturado",
				"project.title as project_title"
			),
			'table'=>"provider LEFT JOIN factura ON provider.id = factura.provider_id LEFT JOIN project ON factura.project_id = project.id" ,
			//'filters'=>array('factura.state=1'),
			'orderby'=>'factura.date ASC',
			'groupby'=>'provider.id'
		);

		if($options["project_id"]):$params["filters"][]="factura.project_id=".$options["project_id"];endif;
		if($options["provider"]):$params["filters"][]="provider.id IN (".$options["provider"]. ")";endif;
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