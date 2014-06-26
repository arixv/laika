<?php

class DashboardController extends Controller  {
	
	static function BackDisplayDefault(){
		parent::loadAdminInterface();
		parent::$template->add("dashboard.xsl");
		parent::$template->display();


	}
	static function FrontDisplayDefault(){


	}
}
?>