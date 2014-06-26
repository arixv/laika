<?php
class SiteController extends ObjectController implements ModuleController {

	/**
	* Display a List of Objects
	* @return none
	**/
	public static function BackDisplayDefault()
	{	
		
		$page   = Util::getvalue('page', 1);
		$state  = Util::getvalue('state', 'false');
		$categories = Util::getvalue('categories');

		$options = array(
				'page' => $page,
				'pagesize'	  => 10, 
				'state'		  => ($state != 'false') ? $state : false, 
				'multimedia'  => false,
		);

		$Collection = Site::GetList($options);
			
		self::loadAdminInterface();
		self::$template->setcontent($Collection, null, 'collection');
		self::$template->setparam('state',$options['state']);
		self::$template->add("site.list.xsl");
		self::$template->display();
	}

	/**
	* Display View for Edit Object
	* @return display view
	**/
	public static function BackDisplayEdit()
	{
		$Object = Object::getById(
			$options = array(
				'object_id'	 => Util::getvalue('id'),
				'model'      => 'SiteModel',
				'table'      => SiteModel::$table,
				'state'		 => false, 
				'relations'	 => true,
				'multimedas' => true,
				'categories' => true
			)
		);

		if(!$Object) Application::Route(array('modulename'=>'country'));

		parent::loadAdminInterface();
		self::$template->setcontent($Object, null, 'object');

		self::$template->add("country.edit.xsl");
		self::$template->display();
	}

	public static function BackDisplayAdd()
	{
		parent::loadAdminInterface();
		self::$template->add("country.add.xsl");
		self::$template->display();
	}
	
	public static function BackAdd()
	{
		$objectId  = Country::Add($options = array(
				'data'		=> $_POST,
				'model'		=> 'SiteModel',
				'table' 	=> SiteModel::$table,
				'verbose'	=> true
			)
		);

		$display = array(
			'item_id'    => $objectId,
			'module'     => 'country',
			'back'       => 0,
		);
		
		Application::Route($display);
	}
	
	public static function BackEdit()
	{
		$display = array();
		if(isset($_POST['country_id'])){
			$objectEdited  = Object::edit(
				$options = array(
					'data'		=> $_POST,
					'model' 	=> 'SiteModel',
					'table' 	=> SiteModel::$table,
					'verbose' 	=> true
				)
			);

			$display['back']    = (isset($_POST['back'])) ? 1 : 0;
			$display['item_id'] = $_POST['country_id'];
		}
		$display['module']  = 'country';
		Application::Route($display);
	}

	public static function BackDisplaySearch()
	{
		$query      = Util::getvalue('q', false);
		$state      = Util::getvalue('state', false);
		$page       = Util::getvalue('page', 1);
		$categories = Util::getvalue('categories', false);

		$options = array(
			'query'       => $query,
			'module'      => 'country',
			'model'		  => 'SiteModel',
			'table'		  => SiteModel::$table,
			'display'     => 20,
			'currentPage' => $page,
			'type_id'	  => SiteModel::$object_typeid, 
			'state'       => $state,
			'categories'  => $categories,
		);

		$CategoriesFilters = Country::getCategoriesFilter($options);

		parent::loadAdminInterface();
		self::$template->setcontent(Country::Search($options), null, 'collection');
		self::$template->setcontent($CategoriesFilters, null, 'filter');

		self::$template->setparam('query',$query);
		self::$template->setparam('state',$state);
		self::$template->setparam('category_id',$options['categories']);

		self::$template->add("country.list.xsl");
		self::$template->display();
	}

	public static function BackReturn()
	{
		$display['module']  = 'country';
		Application::Route($display);
	}














	
	/* Front end */
	
	public static function FrontDisplayDefault(){


		$interface = SkinController::loadInterface();
		$index = Home::getPublicationPath().'index.xml';
		$interface->setcontent($index, '/xml/*', 'home');
		$interface->add("country/home.components.xsl");
		$interface->add("country/home.xsl");
		$interface->display();
	}


	public static function FrontDisplayAcumulado()
	{
		$category_id = Util::getvalue('category_id');
		$pagenumber  = Util::getvalue('page',1);

		
		$Collection = Country::Getlist(
			$options = array(
				'module'	=> 'country',
				'model'		=> 'SiteModel',
				'table'		=> 'country',
				'type_id'	=> SiteModel::$object_typeid, 
				'currentPage'=> $pagenumber,
				'display'	=> 10, 
				'state'		=> 1, 
				'categories'=> $category_id,
				'multimedias'=> true,
				'relations' => false,
		));
		$interface = SkinController::loadInterface();
		$interface->setcontent($Collection, null, 'collection');

		$interface->add("country/country.list.xsl");
		$interface->display();
	}
	
	public static function FrontDisplayAcumuladoByName()
	{
		$name     = Util::getvalue('category');
		$name     = str_replace("-", " ", $name);
		$category = Category::GetByName($name); 
		$pagenumber     = Util::getvalue('page');


		if($category):
			$interface = SkinController::loadInterface();
			$interface->setcontent(Object::getListByCategory($category['category_id-att'], $state=1, $multimedias=true, $pagenumber, $perPage=8), null, 'acumulado');
			$interface->setcontent($category, null, 'categoria');
			$interface->add("country/templates.xsl");
			$interface->add("country/acumulado.xsl");
			$interface->display();
		else:
			echo "La categoría de nota no existe. <a href='javascript:history.back();'>Volver</a>";
		endif;
	}
	
	/*
	public static function FrontSearch()
	{
		
		$query = Util::getvalue('query', false);
		$page  = Util::getvalue('page', 1);

		//$queryStr = str_replace("'", "\'", $query);
		
		$options = array(
			'query'       => $query,
			'module'      => 'country',
			'model'		  => 'SiteModel',
			'table'		  => SiteModel::$table,
			'display'     => 10,
			'currentPage' => $page,
			'type_id'	  => SiteModel::$object_typeid,
			'state'       => 1,
			'categories'  => false,
		);

		return Country::Search($options);
	}
	*/
	
	public static function FrontDisplayItem()
	{
		$countryId = Util::getvalue('id');

		$options = array(
			'object_id'	 => $countryId,
			'model'      => 'SiteModel',
			'table'      => 'country',
			'state'		 => false, 
			'relations'	 => true,
			'multimedas' => true,
			'categories' => true
		);
		
		$Country = Country::getById($options);

		if($Country):
		
			$interface = SkinController::loadInterface();

			//Contenido de la nota
			$interface->setcontent($Country, '/xml/country', null);
			$interface->add('country/country.xsl');
			$interface->display();
		else:

			Util::redirect('/error/404/');

		endif;
	}

	public static function FrontDisplayModal()
	{
		$countryId = Util::getvalue('id');

		$options = array(
			'object_id'	 => $countryId,
			'model'      => 'SiteModel',
			'table'      => 'country',
			'state'		 => false, 
			'relations'	 => true,
			'multimedas' => true,
			'categories' => true
		);
		
		$Country = Country::getById($options);
		
		$interface = SkinController::loadInterface('country/country.modal.xsl');
		$interface->setcontent($Country, '/xml/country', null);
		$interface->display();

	}

	
	









	public static function display_error(){
		
		$interface = SkinController::loadInterface();
		$custom = array('titulo'=>'Nota no disponible', 'resumen'=>'La nota solicitada no está disponible o la url no est&#225; bien formada.');
		$interface->setcontent($custom, null, 'country');
		$interface->setparam('error', '1');
		$interface->add("country/country.xsl");
		$interface->display();
		
	}



	/* Enviar por email */
	public static function FrontDisplayEnvio()
	{
		$country_id = Util::getvalue('country_id');

		$interface = SkinController::loadInterface($baseXsl='country/country.envio.xsl');
		$interface->setcontent(Country::getById($country_id), null, 'country');
		
		//Random numbers para el captcha
		$interface->setparam('nr1',rand(1,36));
		$interface->setparam('nr2',rand(1,36));
		$interface->setparam('nr3',rand(1,36));
		$interface->setparam('nr4',rand(1,36));
		$interface->setparam('nr5',rand(1,36));
		
		$interface->display();
	}
	
	/* Enviar por email */
	public static function FrontEnvio()
	{
		$country_id  = Util::getvalue('country_id');
		$emailRCP = Util::getvalue('email');
		$mensaje  = strip_tags(Util::getvalue('mensaje'));
		$copia    = Util::getvalue('copia', false);


		$interface = SkinController::loadInterface($baseXsl='country/country.envio.xsl');
		$country = Country::getById($country_id);
		$country['mensaje'] = $mensaje;
		
		$userArray = Session::getvalue('proyectounder');
		
		if($userArray):
			$country['user'] = $userArray;
		endif;
		
		$emailhtml = self::envio_email($country);
		$email = new Email();
		$email->SetFrom('contacto@proyectounder.com', 'Proyectounder.com');
		$email->SetSubject(utf8_encode($country['titulo']));
		$emailList = preg_split("/[;,]+/", $emailRCP);

		foreach ($emailList as $destination)
		{
			$email->AddTo($destination);
		}
		if($copia):
			$email->AddCC($userArray['email']);
		endif;

		
		$email->ClearAttachments();
		$email->ClearImages();
		$email->SetHTMLBody(utf8_encode($emailhtml));
		$email->Send();
		
		
		$interface->setparam('enviado', 1);
		$interface->display();
	}
	
	
	
	public static function envio_email($Country)
	{
		$interface = SkinController::loadInterface($baseXsl='country/country.envio.cuerpo.xsl');
		$interface->setcontent($Country, null, 'country');
		return $interface->returnDisplay();
		//$interface->display();
	}
	
	
	
	
	
	
}


?>
