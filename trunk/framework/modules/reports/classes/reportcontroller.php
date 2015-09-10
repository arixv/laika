<?php

class ReportController extends Controller {

	public static function BackDisplayDefault()
	{
		$UserLogged = Admin::IsLoguedIn();

		$Projects = Project::getList(array(
			'page'=>-1,
			'orderby'=>'title',
			'user_logged'=>$UserLogged
		));
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
		$UserLogged = Admin::IsLoguedIn();
		$Projects = Project::getList(array(
			'page'=>-1,
			'orderby'=>'title',
			'user_logged'=>$UserLogged
		));
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
		$UserLogged = Admin::IsLoguedIn();
		$Projects = Project::getList(array(
			'page'=>-1,
			'orderby'=>'title',
			'user_logged'=>$UserLogged
		));

		$Providers = Provider::getList();
		$Users = Admin::GetList($page = false);
		$Rubros = Rubro::getList(array(
			"parent" => 0,
			"subrubros" => 1
		));

		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("form.facturas.xsl");
		self::$template->setcontent($Projects,null,'projects');
		self::$template->setcontent($Rubros,null,'rubros');
		self::$template->setcontent($Providers,null,'providers');
		self::$template->setcontent($Users,null,'users');
		self::$template->setparam("active","facturas");
		self::$template->display();
	}

	public static function BackDisplayFormCobros(){
		$UserLogged = Admin::IsLoguedIn();
		$Users = Admin::GetList($page = false);
		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("form.cobros.xsl");
		self::$template->setcontent($Users,null,'users');
		self::$template->setparam("active","cobros");
		self::$template->display();
	}

	public static function BackDisplayFormResources(){
		$UserLogged = Admin::IsLoguedIn();
		$Projects = Project::getList(array(
			'page'=>-1,
			'orderby'=>'title',
			'user_logged'=>$UserLogged
		));
		$Providers = Provider::getList();
		$Users = Admin::GetList($page = false);
		$Rubros = Rubro::getList(array(
			"parent" => 0,
			"subrubros" => 1
		));
		$Sindicatos = Sindicato::getlist();

		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("form.resources.xsl");
		self::$template->setcontent($Projects,null,'projects');
		self::$template->setcontent($Rubros,null,'rubros');
		self::$template->setcontent($Providers,null,'providers');
		self::$template->setcontent($Sindicatos,null,'sindicatos');
		self::$template->setcontent($Users,null,'users');
		self::$template->display();
	}

	public static function BackDisplayFormProviders(){
		$UserLogged = Admin::IsLoguedIn();
		$Projects = Project::getList(array(
			'page'=>-1,
			'orderby'=>'title',
			'user_logged'=>$UserLogged
		));
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
		$UserLogged = Admin::IsLoguedIn();
		
		$number = Util::getvalue("number",false);
		$rubro_id = Util::getvalue("rubro_id",false);
		$min_amount = Util::getvalue("min_amount",false);
		$max_amount = Util::getvalue("max_amount",false);
		$projects = Util::getvalue("projects",false);
		$provider_id = Util::getvalue("provider_id",false);
		$subrubros = Util::getvalue("subrubros",false);
		$creation_userid = Util::getvalue("creation_userid",false);
		$start_date = Util::inverseDate(Util::getvalue("start_date",false));
		$end_date = Util::inverseDate(Util::getvalue("end_date",false));
		$state = Util::getvalue("state",false);
		$type = Util::getvalue("type",false);
		$sort = Util::getvalue("sort",false);


		$Report = Report::GetFacturasReport($options=array(
				'user_logged'=>$UserLogged,
				'number'=>$number,
				'rubro_id'=>$rubro_id,
				'projects'=>$projects,
				'min_amount'=>$min_amount,
				'max_amount'=>$max_amount,
				'provider_id'=>$provider_id,
				'subrubros'=>$subrubros,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'state'=>$state,
				'type'=>$type,
				'creation_userid'=>$creation_userid,
				'orderby'=>$sort,
				'debug'=>false
		));


		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("report.facturas.xsl");
		self::$template->setcontent($Report,null,"collection");
		self::$template->setparam("active","facturas");
		self::$template->setparam("sort",$sort);
		self::$template->setparam("rubro_id",$rubro_id);
		self::$template->setparam("number",$number);
		//self::$template->setparam("project_id",$project_id);
		self::$template->setparam("min_amount",$min_amount);
		self::$template->setparam("max_amount",$max_amount);
		self::$template->setparam("provider_id",$provider_id);
		//self::$template->setparam("subrubro_id",$subrubro_id);
		self::$template->setparam("start_date",$start_date);
		self::$template->setparam("end_date",$end_date);
		self::$template->setparam("state",$state);
		self::$template->setparam("type",$type);
		self::$template->setparam("creation_userid",$creation_userid);
		self::$template->display();

	}
	
	public static function BackExportFacturas(){
		$UserLogged = Admin::IsLoguedIn();
		
		$number = Util::getvalue("number",false);
		$rubro_id = Util::getvalue("rubro_id",false);
		$min_amount = Util::getvalue("min_amount",false);
		$max_amount = Util::getvalue("max_amount",false);
		$projects = Util::getvalue("projects",false);
		$provider_id = Util::getvalue("provider_id",false);
		$subrubros = Util::getvalue("subrubros",false);
		$creation_userid = Util::getvalue("creation_userid",false);
		$start_date = Util::getvalue("start_date",false);
		$end_date = Util::getvalue("end_date",false);
		$state = Util::getvalue("state",false);
		$type = Util::getvalue("type",false);
		$sort = Util::getvalue("sort",false);


		$options=array(
				'user_logged'=>$UserLogged,
				'number'=>$number,
				'rubro_id'=>$rubro_id,
				'projects'=>$projects,
				'min_amount'=>$min_amount,
				'max_amount'=>$max_amount,
				'provider_id'=>$provider_id,
				'subrubros'=>$subrubros,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'state'=>$state,
				'type'=>$type,
				'creation_userid'=>$creation_userid,
				'orderby'=>$sort,
				'debug'=>false
		);
		
		$Report = Report::GetFacturasReport($options);

		$filename = 'reporte-facturas-'.date('d-m-Y').'.xls';
		$header = array();
		foreach($Report[0] as $key=>$val){
			$header[] = $key;
		}
		$xls = new ExportXLS($filename);
		$xls->addHeader($header);

		foreach($Report as $key=>$item)
		{
			if(is_numeric($key)){
				$row=array();
				foreach($item as $key_item=>$val_item){
					$row[] = $val_item;
				}
				$xls->addRow($row);

			}
		}
		$xls->sendFile();

	}


	public static function BackReportCobros(){
		$UserLogged = Admin::IsLoguedIn();

		$number = Util::getvalue("number",false);
		$min_amount = Util::getvalue("min_amount",false);
		$max_amount = Util::getvalue("max_amount",false);
		$creation_userid = Util::getvalue("creation_userid",false);
		$start_date = Util::inverseDate(Util::getvalue("start_date",false));
		$end_date = Util::inverseDate(Util::getvalue("end_date",false));
		$state = Util::getvalue("state",false);
		$type = Util::getvalue("type",false);
		$sort = Util::getvalue("sort",false);

		$Report = Report::GetCobrosReport($options=array(
				'user_logged'=>$UserLogged,
				'number'=>$number,
				'min_amount'=>$min_amount,
				'max_amount'=>$max_amount,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'state'=>$state,
				'type'=>$type,
				'creation_userid'=>$creation_userid,
				'orderby'=>$sort,
				'debug'=>false
		));


		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("report.cobros.xsl");
		self::$template->setcontent($Report,null,"collection");
		self::$template->setparam("active","cobros");
		self::$template->setparam("sort",$sort);
		self::$template->setparam("number",$number);
		self::$template->setparam("min_amount",$min_amount);
		self::$template->setparam("max_amount",$max_amount);
		self::$template->setparam("start_date",$start_date);
		self::$template->setparam("end_date",$end_date);
		self::$template->setparam("state",$state);
		self::$template->setparam("type",$type);
		self::$template->setparam("creation_userid",$creation_userid);
		self::$template->display();

	}

	public static function BackExportCobros(){
		$UserLogged = Admin::IsLoguedIn();

		$number = Util::getvalue("number",false);
		$min_amount = Util::getvalue("min_amount",false);
		$max_amount = Util::getvalue("max_amount",false);
		$creation_userid = Util::getvalue("creation_userid",false);
		$start_date = Util::getvalue("start_date",false);
		$end_date = Util::getvalue("end_date",false);
		$state = Util::getvalue("state",false);
		$type = Util::getvalue("type",false);
		$sort = Util::getvalue("sort",false);

		$Report = Report::GetCobrosReport($options=array(
				'user_logged'=>$UserLogged,
				'number'=>$number,
				'min_amount'=>$min_amount,
				'max_amount'=>$max_amount,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'state'=>$state,
				'type'=>$type,
				'creation_userid'=>$creation_userid,
				'orderby'=>$sort,
				'debug'=>false
		));
		
		$filename = 'reporte-cobros-'.date('d-m-Y').'.xls';
		$xls = new ExportXLS($filename);
		$header = array(
			0=>"Número",
			1=>"Tipo",
			2=>"Descripción",
			3=>"Monto",
			4=>"Fecha",
			5=>"Proveedor",
		);
		$xls->addHeader($header);

		foreach($Report as $key=>$item)
		{
			if(is_numeric($key)){
				$row = array(
					0=>$item['number'],
					1=>$item['type'],
					2=>$item['description'],
					3=>$item['amount'],
					4=>Util::inverseDate($item['date']),
					5=>$item['provider_name'],
					6=>$item['user_name']. ' '.$item['user_lastname'],
					
				);
				$xls->addRow($row);

			}
		}
		
		$xls->sendFile();

	}

	public static function BackReportProjects()
	
		{$UserLogged = Admin::IsLoguedIn();
		$projects = Util::getvalue("projects",false);
		$start_date = Util::inverseDate(Util::getvalue("start_date",false));
		$end_date = Util::inverseDate(Util::getvalue("end_date",false));
		$states = Util::getvalue("states",false);
		$types = Util::getvalue("types",false);
		$clients = Util::getvalue("clients",false);
		$creation_userid = Util::getvalue("creation_userid",false);
		$sort = util::getvalue('sort');

		

		$Report = Report::GetProjectsReport($options=array(
				'user_logged'=>$UserLogged,
				'projects'=>$projects,
				'clients'=>$clients,
				'states'=>$states,
				'types'=>$types,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'creation_userid'=>$creation_userid,
				'orderby'=>$sort
		));

		$StatesObjects = Project::getListStates();
		$Users = Admin::GetList($page = false);

		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("report.projects.xsl");
		self::$template->setcontent($Report,null,"collection");
		self::$template->setcontent($StatesObjects,null,"states");
		self::$template->setcontent($Users,null,"users");
		self::$template->setparam("active","project");
		self::$template->setparam("sort",$sort);
		//self::$template->setparam("start_date",$start_date);
		//self::$template->setparam("end_date",$end_date);
		//self::$template->setparam("clients",$clients);
		self::$template->setparam("creation_userid",$creation_userid);
		//self::$template->setparam("states",$states);
		self::$template->display();

	}


	public static function BackExportProject(){
		$UserLogged = Admin::IsLoguedIn();
		$project_id = Util::getvalue("project_id",false);
		$start_date = Util::inverseDate(Util::getvalue("start_date",false));
		$end_date = Util::inverseDate(Util::getvalue("end_date",false));
		$state = Util::getvalue("state",false);
		$types = Util::getvalue("types",false);
		$client_id = Util::getvalue("client_id",false);
		$creation_userid = Util::getvalue("creation_userid",false);


		$Report = Report::GetProjectsReport($options=array(
				'user_logged'=>$UserLogged,
				'project_id'=>$project_id,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'client_id'=>$client_id,
				'creation_userid'=>$creation_userid,
				'state'=>$state,
				'types'=>$types
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
	}


	public static function BackReportPartidas()
	{
		$UserLogged = Admin::IsLoguedIn();
		$projects = Util::getvalue("projects",false);
		$start_date = Util::inverseDate(Util::getvalue("start_date",false));
		$end_date = Util::inverseDate(Util::getvalue("end_date",false));
		$creation_userid = Util::getvalue("creation_userid",false);
		$sort = Util::getvalue("sort",false);

		$Collection = Report::GetPartidasReport($options=array(
				'user_logged'=>$UserLogged,
				'projects'=>$projects,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'creation_userid'=>$creation_userid,
				'orderby'=>$sort,
				'debug'=>false
		));

		$Users = Admin::GetList($page = false);

		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("report.partidas.xsl");
		self::$template->setcontent($Collection,null,"collection");
		self::$template->setcontent($Users,null,"users");
		self::$template->setparam('sort',$sort);
		self::$template->setparam('start_date',$start_date);
		self::$template->setparam('creation_userid',$creation_userid);
		self::$template->display();

	}

	public static function BackExportPartidas(){
		$UserLogged = Admin::IsLoguedIn();
		$project_id = Util::getvalue("project_id",false);
		$start_date = Util::inverseDate(Util::getvalue("start_date",false));
		$end_date = Util::inverseDate(Util::getvalue("end_date",false));
		$state = Util::getvalue("state",false);
		$creation_userid = Util::getvalue("creation_userid",false);
		$sort = Util::getvalue("sort",false);

		$Report = Report::GetPartidasReport($options=array(
				'user_logged'=>$UserLogged,
				'project_id'=>$project_id,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'creation_userid'=>$creation_userid,
				'state'=>$state,
				'orderby'=>$sort,
				'debug'=>false
		));
		
		$filename = 'reporte-partidas-'.date('d-m-Y').'.xls';
		$header = array();
		foreach($Report[0] as $key=>$val){
			$header[] = $key;
		}
		$xls = new ExportXLS($filename);
		$xls->addHeader($header);

		foreach($Report as $key=>$item)
		{
			if(is_numeric($key)){
				$row=array();
				foreach($item as $key_item=>$val_item){
					$row[] = $val_item;
				}
				$xls->addRow($row);

			}
		}
		$xls->sendFile();
	}



	public static function BackReportResources()
	{
		$UserLogged = Admin::IsLoguedIn();
		$start_date = Util::getvalue("start_date",false);
		$end_date = Util::getvalue("end_date",false);
		$min_cost = Util::getvalue("min_cost",false);
		$max_cost = Util::getvalue("max_cost",false);
		$providers = Util::getvalue("providers",false);
		$projects = Util::getvalue("projects",false);
		$subrubros = Util::getvalue("subrubros",false);
		$sindicatos = Util::getvalue("sindicatos",false);
		$state = Util::getvalue("state",false);
		$concept = Util::getvalue("concept",false);
		$sort = Util::getvalue("sort",false);

		
		

		$Report = Report::GetResourcesReport($options=array(
				'user_logged'=>$UserLogged,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'min_cost'=>$min_cost,
				'max_cost'=>$max_cost,
				'project'=>$projects,
				'providers'=>$providers,
				'subrubros'=>$subrubros,
				'sindicatos'=>$sindicatos,
				'concept'=>$concept,
				'state'=>$state,
				'orderby'=>$sort,
				'debug'=>false
		));
		

		if(is_array($subrubros)) $subrubros = implode(',',$subrubros);
		if(is_array($providers)) $providers = implode(',',$providers);
		if(is_array($projects)) $project = implode(',',$project);
		if(is_array($sindicatos)) $sindicatos = implode(',',$sindicatos);


		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("report.resources.xsl");
		self::$template->setcontent($Report,null,"collection");
		self::$template->setparam('sort',$sort);
		self::$template->setparam('projects',$projects);
		self::$template->setparam('start_date',$start_date);
		self::$template->setparam('end_date',$end_date);
		self::$template->setparam('min_cost',$min_cost);
		self::$template->setparam('max_cost',$max_cost);
		self::$template->setparam('providers',$providers);
		self::$template->setparam('subrubros',$subrubros);
		self::$template->setparam('concept',$concept);
		self::$template->setparam('state',$state);
		self::$template->display();

	}


	public static function BackExportResources(){
		$UserLogged = Admin::IsLoguedIn();
		$start_date = Util::getvalue("start_date",false);
		$end_date = Util::getvalue("end_date",false);
		$min_cost = Util::getvalue("min_cost",false);
		$max_cost = Util::getvalue("max_cost",false);
		$provider_id = Util::getvalue("provider_id",false);
		$project = Util::getvalue("project",false);
		$subrubro_id = Util::getvalue("subrubro_id",false);
		$state = Util::getvalue("state",false);
		$concept = Util::getvalue("concept",false);
		$sort = Util::getvalue("sort",false);

		$Report = Report::GetResourcesReport($options=array(
				'user_logged'=>$UserLogged,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'min_cost'=>$min_cost,
				'max_cost'=>$max_cost,
				'project'=>$project,
				'provider_id'=>$provider_id,
				'subrubro_id'=>$subrubro_id,
				'concept'=>$concept,
				'state'=>$state,
				'orderby'=>$sort,
				'debug'=>false
		));
		
		$filename = 'reporte-recursos-'.date('d-m-Y').'.xls';
		$header = array();
		foreach($Report[0] as $key=>$val){
			$header[] = $key;
		}
		$xls = new ExportXLS($filename);
		$xls->addHeader($header);

		foreach($Report as $key=>$item)
		{
			if(is_numeric($key)){
				$row=array();
				foreach($item as $key_item=>$val_item){
					$row[] = $val_item;
				}
				$xls->addRow($row);

			}
		}
		$xls->sendFile();
	}



	public static function BackReportProviders()
	{
		$UserLogged = Admin::IsLoguedIn();
		$project_id = Util::getvalue("project_id",false);
		$provider = Util::getvalue("provider",false);
		$rubro_id = Util::getvalue("rubro_id",false);
		$start_date = Util::inverseDate(Util::getvalue("start_date",false));
		$end_date = Util::inverseDate(Util::getvalue("end_date",false));
		$creation_userid = Util::getvalue("creation_userid",false);
		$state = Util::getvalue("state",false);
		$sort = Util::getvalue("sort",false);

		$Report = Report::GetProvidersReport($options=array(
				'user_logged'=>$UserLogged,
				'project_id'=>$project_id,
				'provider'=>$provider,
				'rubro_id'=>$rubro_id,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'orderby'=>$sort,
				'state'=>$state,
				'debug'=>false
		));

		self::loadAdminInterface();
		self::$template->add("report.templates.xsl");
		self::$template->add("report.providers.xsl");
		self::$template->setcontent($Report,null,"collection");
		self::$template->setparam('sort',$sort);
		self::$template->setparam('project_id',$project_id);
		self::$template->setparam('start_date',$start_date);
		self::$template->setparam('creation_userid',$creation_userid);
		self::$template->setparam('state',$state);
		self::$template->display();

	}


	public static function BackExportProviders(){
		$UserLogged = Admin::IsLoguedIn();
		$project_id = Util::getvalue("project_id",false);
		$provider_id = Util::getvalue("provider_id",false);
		$rubro_id = Util::getvalue("rubro_id",false);
		$start_date = Util::inverseDate(Util::getvalue("start_date",false));
		$end_date = Util::inverseDate(Util::getvalue("end_date",false));
		$creation_userid = Util::getvalue("creation_userid",false);
		$state = Util::getvalue("state",false);
		$sort = Util::getvalue("sort",false);

		$Report = Report::GetProvidersReport($options=array(
				'user_logged'=>$UserLogged,
				'project_id'=>$project_id,
				'provider_id'=>$provider_id,
				'rubro_id'=>$rubro_id,
				'start_date'=>$start_date,
				'end_date'=>$end_date,
				'orderby'=>$sort,
				'state'=>$state,
				'debug'=>false
		));
		
		$filename = 'reporte-proveedores-'.date('d-m-Y').'.xls';
		$header = array();
		foreach($Report[0] as $key=>$val){
			$header[] = $key;
		}
		$xls = new ExportXLS($filename);
		$xls->addHeader($header);

		foreach($Report as $key=>$item)
		{
			if(is_numeric($key)){
				$row=array();
				foreach($item as $key_item=>$val_item){
					$row[] = $val_item;
				}
				$xls->addRow($row);

			}
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