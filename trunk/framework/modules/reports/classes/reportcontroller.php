<?php

class ReportController extends Controller {

	public static function BackDisplayDefault()
	{
		$Projects = Project::getList();
		$Clients = Client::getList();
		$Users = Admin::GetList($page = false);

		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("form.projects.xsl");
		self::$template->setcontent($Projects,null,'projects');
		self::$template->setcontent($Clients,null,'clients');
		self::$template->setcontent($Users,null,'users');
		self::$template->setparam("active","projects");
		self::$template->display();
	}


	

	public static function BackDisplayFormPartidas(){
		$Projects = Project::getList();
		$Users = Admin::GetList($page = false);

		self::loadAdminInterface();
		self::$template->setcontent($Projects,null,'projects');
		self::$template->setcontent($Users,null,'users');
		self::$template->add("report.templates.xsl");
		self::$template->add("form.partidas.xsl");
		self::$template->setparam("active","partidas");
		self::$template->display();
	}

	public static function BackDisplayFormFacturas(){
		$Projects = Project::getList();
		$Providers = Provider::getList();
		$Rubros = Rubro::getList(array("parent" => 0));

		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("form.facturas.xsl");
		self::$template->setcontent($Projects,null,'projects');
		self::$template->setcontent($Rubros,null,'rubros');
		self::$template->setcontent($Providers,null,'providers');
		self::$template->setparam("active","facturas");
		self::$template->display();
	}

	public static function BackDisplayFormResources(){
		$Projects = Project::getList();
		$Providers = Provider::getList();
		$Rubros = Rubro::getList(array("parent" => 0));

		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("form.resources.xsl");
		self::$template->setcontent($Projects,null,'projects');
		self::$template->setcontent($Rubros,null,'rubros');
		self::$template->setcontent($Providers,null,'providers');
		self::$template->display();
	}

	public static function BackDisplayFormProviders(){
		$Projects = Project::getList();
		$Providers = Provider::getList();
		$Rubros = Rubro::getList(array("parent" => 0));

		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("form.providers.xsl");
		self::$template->setcontent($Projects,null,'projects');
		self::$template->setcontent($Rubros,null,'rubros');
		self::$template->setcontent($Providers,null,'providers');
		self::$template->setparam("active","facturas");
		self::$template->display();
	}

	public static function BackReportFacturas(){
		$number = Util::getvalue("number",false);
		$rubro_id = Util::getvalue("rubro_id",false);
		$project_id = Util::getvalue("project_id",false);
		$provider_id = Util::getvalue("provider_id",false);
		$start_date = Util::inverseDate(Util::getvalue("start_date",false));
		$end_date = Util::inverseDate(Util::getvalue("end_date",false));
		$state = Util::getvalue("state",false);
		$type = Util::getvalue("type",false);


		$Report = Report::GetFacturasReport($options=array(
				'number'=>$number,
				'rubro_id'=>$rubro_id,
				'project_id'=>$project_id,
				'provider_id'=>$provider_id,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'state'=>$state,
				'type'=>$type
		));


		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("report.facturas.xsl");
		self::$template->setcontent($Report,null,"collection");
		self::$template->setparam("active","facturas");
		self::$template->display();

	}

	public static function BackReportProjects()
	{
		$project_id = Util::getvalue("project_id",false);
		$start_date = Util::inverseDate(Util::getvalue("start_date",false));
		$end_date = Util::inverseDate(Util::getvalue("end_date",false));
		$state = Util::getvalue("state",false);
		$type = Util::getvalue("type",false);
		$client_id = Util::getvalue("client_id",false);
		$creation_userid = Util::getvalue("creation_userid",false);
		$sort = util::getvalue('sort');

		$Report = Report::GetProjectsReport($options=array(
				'project_id'=>$project_id,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'client_id'=>$client_id,
				'creation_userid'=>$creation_userid,
				'state'=>$state,
				'type'=>$type,
				'orderby'=>$sort
		));

		$States = Project::getListStates();
		$Users = Admin::GetList($page = false);

		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("report.projects.xsl");
		self::$template->setcontent($Report,null,"collection");
		self::$template->setcontent($States,null,"states");
		self::$template->setcontent($Users,null,"users");
		self::$template->setparam("active","project");
		self::$template->setparam("sort",$sort);
		self::$template->setparam("start_date",$start_date);
		self::$template->setparam("end_date",$end_date);
		self::$template->setparam("client_id",$client_id);
		self::$template->setparam("creation_userid",$creation_userid);
		self::$template->setparam("state",$state);
		self::$template->display();

	}


	public static function BackExportProject(){
		
		$project_id = Util::getvalue("project_id",false);
		$start_date = Util::inverseDate(Util::getvalue("start_date",false));
		$end_date = Util::inverseDate(Util::getvalue("end_date",false));
		$state = Util::getvalue("state",false);
		$type = Util::getvalue("type",false);
		$client_id = Util::getvalue("client_id",false);
		$creation_userid = Util::getvalue("creation_userid",false);


		$Report = Report::GetProjectsReport($options=array(
				'project_id'=>$project_id,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'client_id'=>$client_id,
				'creation_userid'=>$creation_userid,
				'state'=>$state,
				'type'=>$type
		));

		$filename = 'reporte-proyectos-'.date('d-m-Y').'.xls';
		$xls = new ExportXLS($filename);
		$header = array(
			0=>"Título",
			1=>"Descripción",
			2=>"Tipo",
			3=>"Cliente",
			4=>"Fecha Inicio",
			5=>"Fecha Fin",
			6=>"Creado Por",
		);
		$xls->addHeader($header);

		foreach($Report as $key=>$item)
		{
			if(is_numeric($key)){
				$row = array(
					0=>$item['title'],
					1=>$item['description'],
					2=>$item['type'],
					3=>$item['client_title'],
					4=>$item['start_date'],
					5=>$item['end_date'],
					6=>$item['user_name']. ' '.$item['user_lastname'],
					
				);
				$xls->addRow($row);

			}
		}
		
		$xls->sendFile();

		//Util::debug($Report);
		// $labels = 'EmployeeID, EmployeeName'; 
		// $fields = array('id', 'title');
		// $title = 'Employees and Departments';
		// $glabel = array('Department');
		// $gfield = 'title';
		// $oPDF = new ExportPDF();
		// $oPDF->PDFExport($Report, $labels, $fields, $title, $glabel, $gfield);
	}


	public static function BackReportPartidas()
	{
		$project_id = Util::getvalue("project_id",false);
		$start_date = Util::inverseDate(Util::getvalue("start_date",false));
		$end_date = Util::inverseDate(Util::getvalue("end_date",false));
		$state = Util::getvalue("state",false);
		$creation_userid = Util::getvalue("creation_userid",false);

		$Collection = Report::GetPartidasReport($options=array(
				'project_id'=>$project_id,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'creation_userid'=>$creation_userid,
				'state'=>$state
		));

		$States = Project::getListStates();
		$Users = Admin::GetList($page = false);

		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("report.partidas.xsl");
		self::$template->setcontent($Collection,null,"collection");
		self::$template->setcontent($States,null,"states");
		self::$template->setcontent($Users,null,"users");
		self::$template->display();

	}

	public static function BackReportResources(){
		$project_id = Util::getvalue("project_id",false);
		$rubro_id = Util::getvalue("rubro_id",false);
		$start_date = Util::getvalue("start_date",false);
		$end_date = Util::getvalue("end_date",false);
		$state = Util::getvalue("state",false);
		//$creation_userid = Util::getvalue("creation_userid",false);

		$Report = Report::GetResourcesReport($options=array(
				'project_id'=>$project_id,
				'rubro_id'=>$rubro_id,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				//'creation_userid'=>$creation_userid,
				'state'=>$state
		));

		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("report.resources.xsl");
		self::$template->setcontent($Report,null,"collection");
		self::$template->display();

	}

	public static function BackReportProviders()
	{
		$project_id = Util::getvalue("project_id",false);
		$provider_id = Util::getvalue("provider_id",false);
		$rubro_id = Util::getvalue("rubro_id",false);
		$start_date = Util::inverseDate(Util::getvalue("start_date",false));
		$end_date = Util::inverseDate(Util::getvalue("end_date",false));
		$state = Util::getvalue("state",false);

		$Report = Report::GetProvidersReport($options=array(
				'project_id'=>$project_id,
				'provider_id'=>$provider_id,
				'rubro_id'=>$rubro_id,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'state'=>$state
		));

		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("report.providers.xsl");
		self::$template->setcontent($Report,null,"collection");
		self::$template->display();

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