<?php

class Report {

	public static function Contacts($options)
	{
		$Report = array();

		$defaults = array(
			'universidad_id'=>false,
			'from_date'=>false,
			'to_date'=>false
		);
		$options = util::extend($defaults,$options);

			$params = array(
				'fields'=>array(
					"contact.*",
					"location.location_name as location_name",
					"sublocation.location_name AS sublocation_name"
				),
				'table'=>"contact LEFT JOIN location ON contact.contact_location = location.location_id LEFT JOIN location AS sublocation ON contact.contact_sublocation = sublocation.location_id ",
				'filters'=>array(),
				//'groupby'=>"orderitem.beer_id"
			);
			if($options["universidad_id"]):$params["filters"][]="contact.universidad_id=".$options["universidad_id"];endif;
			if($options["from_date"]):$params["filters"][]="contact.contact_date>='".$options["from_date"]." 00:00:00'";endif;
			if($options["to_date"]):$params["filters"][]="contact.contact_date<='".$options["to_date"]." 24:00:00'";endif;
			
			$Report = Module::select($params);		
			return $Report;
	}

}


?>