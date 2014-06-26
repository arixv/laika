<?php

class ReportController extends Controller {

	public static function BackDisplayDefault()
	{
		self::loadAdminInterface();
		self::$template->add("default.xsl");
		self::$template->display();
	}

	public static function BackDisplayContactsReport()
	{
		$search = Util::getvalue("search",false);
		$universidad_id = Util::getvalue("universidad",false);
		$from_date = Util::getvalue("from_date",false);
		$to_date = Util::getvalue("to_date",false);
		$Result = array();
		$Total = 0;

		$Report = array();

		if($search)
		{
			$Report = Report::Contacts($options=array(
				'universidad_id'=>$universidad_id,
				'from_date'=>$from_date,
				'to_date'=>$to_date
			));
			$Report["tag"]="item";
		}


		self::loadAdminInterface();
		self::$template->add("report.contacts.xsl");
		self::$template->setcontent(Universidad::getlist(),null,"universities");
		self::$template->setcontent($Report,null,"report");
		self::$template->setparam("universidad_id",$universidad_id);
		self::$template->setparam("from_date",$from_date);
		self::$template->setparam("to_date",$to_date);
		self::$template->display();
	}	




	public static function BackDisplayContactsReportDownload()
	{
		$universidad_id = Util::getvalue("universidad",false);
		$from_date = Util::getvalue("from_date",false);
		$to_date = Util::getvalue("to_date",false);

		$Report = Report::Contacts($options=array(
			'universidad_id'=>$universidad_id,
			'from_date'=>$from_date,
			'to_date'=>$to_date
		));


		//Util::debug($Report);
		//die;
		
		$filename = 'Reporte de contactos.xls';

		$xls = new ExportXLS($filename);
		$header = array(
			0=>"Nombre",
			1=>"Apellido",
			2=>"Email",
			3=>"Telefono",
			4=>"Ubicación",
			5=>"Comentario",
			6=>"Newsletter",
			7=>"Carrera",
			8=>"Universidad",
			9=>"Fecha",
		);
		$xls->addHeader($header);

		foreach($Report as $key=>$item)
		{
			$row = array(
				0=>$item['contact_name'],
				1=>$item['contact_lastname'],
				2=>$item['contact_email'],
				3=>$item['contact_phone'],
				4=>$item['sublocation_name'],
				5=>$item['location_name'],
				6=>$item['contact_comment'],
				7=>$item['recibir_newsletter'],
				8=>$item['carrera_title'],
				9=>$item['universidad_title'],
				10=>$item['contact_date'],
			);
			//util::debug($row);
			$xls->addRow($row);
		}
		
		$xls->sendFile();

	}


	public static function BackExportXLS()
	{
		$filename = 'test.xls'; // The file name you want any resulting file to be called.

		#create an instance of the class
		$xls = new ExportXLS($filename);


		#lets set some headers for top of the spreadsheet
		#

		$header = "Test Spreadsheet"; // single first col text
		$xls->addHeader($header);

		#add blank line
		$header = null;
		$xls->addHeader($header);

		#add 2nd header as an array of 3 columns
		$header[] = "Name";
		$header[] = "Age";
		$header[] = "Height";

		$xls->addHeader($header);


		# Lets add some sample data
		#
		# Of course this can be from a SQL query or anyother data source
		#

		#first line
		$row[] = "Jack";
		$row[] = "24";
		$row[] = "6ft 5";
		$xls->addRow($row);

		#second line
		$row = array();
		$row[] = "Jim";
		$row[] = "22";
		$row[] = "5ft 5";
		$xls->addRow($row);

		#add a multi dimension array
		$row = array();
		$row[] = array(0 =>'Jess', 1=>'54', 2=>'4ft');
		$row[] = array(0 =>'Luke', 1=>'6', 2=>'2ft');
		$xls->addRow($row);


		# You can return the xls as a variable to use with;
		# $sheet = $xls->returnSheet();
		#
		# OR
		#
		# You can send the sheet directly to the browser as a file 
		#
		$xls->sendFile();

	}


	public static function FrontDisplayDefault(){}

}

?>