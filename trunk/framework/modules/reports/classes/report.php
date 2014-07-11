<?php

class Report {

	public static function GetProjectsReport($options)
	{
		$Report = array();

		$defaults = array(
			'universidad_id'=>false,
			'start_date'=>false,
			'end_date'=>false
		);
		$options = util::extend($defaults,$options);

			$params = array(
				'fields'=>array(
					"project.*"
				),
				'table'=>"project",
				'filters'=>array(),
			);
			if($options["project_id"]):$params["filters"][]="project.id=".$options["project_id"];endif;
			if($options["start_date"]):$params["filters"][]="project.start_date>='".$options["start_date"]." 00:00:00'";endif;
			if($options["end_date"]):$params["filters"][]="project.end_date<='".$options["end_date"]." 24:00:00'";endif;
			if($options["state"]):$params["filters"][]="project.state=".$options["state"];endif;
			
			$Report = Module::select($params);		
			return $Report;
	}

}


?>