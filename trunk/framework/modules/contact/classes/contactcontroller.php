<?php
class ContactController extends Controller implements ModuleController {

	public static function BackDisplayDefault()
	{
		$filter 	= Util::getvalue('filter');
		$paginado 	= Util::getvalue('page');
		$university = Util::getvalue('university');
		$start_date = Util::getvalue('start_date');
		$end_date 	= Util::getvalue('end_date');
		$page 		= (!empty($paginado))?$paginado:1;
		

		$collection = Contact::getList($options =array(
				'university'	=>	$university,
				'start_date'	=>	$start_date,
				'end_date'		=>	$end_date,		
				'page'			=>	$page,
				'pagesize'		=>	10,
			)
		);



		$locations = Location::getlist();

		$Universidades = Universidad::GetList($options = array(
			'multimedias'=>false,
			'relations'=>false,
		));


		// $Carreras = Carrera::GetList($options = array(
		// 	'multimedias'=>false,
		// 	'get_universidad'=> false,
		// 	'relations'=>false,
		// ));
		parent::loadAdminInterface();
		//self::$template->setcontext($Carreras, null, 'carreras');
		self::$template->setcontent($collection, null, 'collection');
		self::$template->setcontext($locations, null, 'locations');
		self::$template->setcontext($Universidades, null, 'universidades');
		
		self::$template->setparam('university', $university); // Filtro de lo que se muestra
		self::$template->setparam('start_date', $start_date); // Filtro de lo que se muestra
		self::$template->setparam('end_date', $end_date); // Filtro de lo que se muestra

		self::$template->add("list.xsl");
		self::$template->display();
	} 

	public static function BackDisplayEdit()
	{
		$id = Util::getvalue('id');

		$Contact = Contact::getById($id);
		
		if($Contact["location"]):
			$Location = Location::getById($Contact["location"]);
			$Contact["location"] = $Location;
		endif;
		if($Contact["sublocation"]):
			$Location = Location::getById($Contact["sublocation"]);
			$Contact["sublocation"] = $Location;
		endif;

		parent::loadAdminInterface();
		self::$template->setcontent($Contact, null, 'object');
		self::$template->add("edit.xsl");
		self::$template->display();
	}


	public static function BackDelete()
	{
		$object_id = Util::getvalue('item_id');
		if(is_numeric($object_id)):
			Contact::Remove($object_id);
			echo "1";
		else:
			echo "0";
		endif;
	}

	public static function BackDeleteGroup()
	{
		$list = Util::getvalue('list');
		$arr  = explode(',', $list);
		if(is_array($arr) && !empty($arr)){
			foreach($arr as $key=>$object_id){
				Contact::Remove($object_id);
			}
		}
		echo "1";
		die;
	}

	public static function BackReturn()
	{
		$display['module']  = 'contact';
		Application::Route($display);
	}
	
	

	public static function BackDisplaySearch()
	{
		$query      = Util::getvalue('q', false);
		$page       = Util::getvalue('page', 1);


		$options = array(
			'query'       => $query,
			'display'     => 20,
			'currentPage' => $page,
		);

		$Result = Contact::Search($options);

		Util::Debug($Result);
		die;

		// parent::loadAdminInterface();
		// self::$template->setcontent(Contact::Search($options), null, 'collection');
		// //self::$template->setcontent($CategoriesFilters, null, 'filter');

		// self::$template->setparam('query',$query);
		// self::$template->setparam('state',$state);
		// self::$template->setparam('category_id',$options['categories']);

		// self::$template->add("article.list.xsl");
		// self::$template->display();
	}


	/* Front end */
	public static function FrontDisplayDefault()
	{
		$LocationId 	= 116; // GBA Zona Norte
		$SubLocationId 	= 232; // Tigre
		$CarreraId 		= 3428;
		$Site 			= Session::get("site");

		$Carrera 	= Carrera::getById(array(
			'id'=>$CarreraId,
			'get_modalidad'=>true,
			'get_type'=>true,
			'get_location'=>true
		));
		$Location 	= Location::getById($LocationId);

		$contactSession = array(
				'contact_name'			=> "Ariel",
				'contact_lastname'		=> "Velaz",
				'contact_email'			=> "ariel@frooit.com",
				'contact_phone'			=> "155754548",
				'contact_location'		=> $LocationId,
				'contact_sublocation'	=> $SubLocationId,
				'contact_location_name'	=> "Tigre",
				'recibir_newsletter'	=> 1,
				'contact_comment'		=> "Este es el comentario que envío",
		);


		contact::sendUserEmail($defaults = array(
			'to'			=> "ariel@frooit.com",
			'from'			=> "ZonaJobs Educacion <no-reply@zonajobs.com>",
			'subject'		=> "Solicitaste información a la siguiente carrera",
			'contact'		=> $contactSession,
			'site'			=> $Site,
			'carrera'		=> $Carrera,
			'universidad'	=> $Carrera['universidad']
		));

		// exit();
	}

}
?>