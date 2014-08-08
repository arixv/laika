<?php
class ProviderController extends ObjectController implements ModuleController {

	/**
	* Display a List of Objects
	* @return none
	**/
	public static function BackDisplayDefault()
	{	
		
		$page   = Util::getvalue('page', 1);
		$state  = Util::getvalue('state', 'false');
		$categories = Util::getvalue('categories');
		$order = util::Getvalue("order");

		$options = array(
				'module'	  => 'provider',
				'model'		  => 'ProviderModel',
				'table'		  => 'provider',
				'page' 		  => $page,
				'pagesize'	  => 10, 
				'state'		  => ($state != 'false') ? $state : false, 
				'categories'  => $categories,
				'multimedia'  => true,
				'relations'   => false,
				'orderby'	  => $order
				//'debug'     => true,
		);


		$Collection = Provider::GetList($options);
		//Util::debug($Collection);
		
		//$CategoriesFilters = Provider::getCategoriesFilter($options);
		
		self::loadAdminInterface();
		self::$template->setcontent($Collection, null, 'collection');
		//self::$template->setcontent($CategoriesFilters, null, 'filter');
		self::$template->setparam('state',$options['state']);
		self::$template->setparam('category_id',$options['categories']);
		self::$template->add("list.xsl");
		self::$template->display();
	}

	/**
	* Display View for Edit Object
	* @return display view
	**/
	public static function BackDisplayEdit()
	{
		$Object = Object_Custom::getById(
			$options = array(
				'id'	 	  => Util::getvalue('id'),
				'model'      => 'ProviderModel',
				'table'      => ProviderModel::$table,
				'tables'	 => ProviderModel::$tables,
				'module'	 => 'provider',
				'state'		 => false, 
				'relations'	 => true,
				'multimedas' => true,
				'categories' => true
			)
		);

		// $defaults = array(
		// 		'model'			=> false,
		// 		'table'     	=> false,
		// 		'tables'		=> false,
		// 		'module'		=> false,
		// 		'id'	 		=> false,
		// 		'state'		 	=> false, 
		// 		'relations'	 	=> true,
		// 		'multimedias'	=> true,
		// 		'categories' 	=> true,
		// 		'level'      	=> 3, // Arbol de categorias padre
		// 		'internalCall'	=> false,
		// 		'debug'			=> false
		// );

		if(!$Object) Application::Route(array('modulename'=>'provider'));
		

		parent::loadAdminInterface();
		self::$template->setcontent($Object, null, 'object');
		self::$template->add("edit.xsl");
		self::$template->display();
	}

	public static function BackDisplayAdd()
	{
		parent::loadAdminInterface();
		self::$template->add("add.xsl");
		self::$template->display();
	}
	
	public static function BackAdd()
	{
		$objectId  = Provider::Add($options = array(
				'fields'		=> $_POST,
				'model'		=> 'ProviderModel',
				'table' 	=> ProviderModel::$table,
			)
		);

		$display['module']  = 'provider';
		
		Application::Route($display);
	}
	
	public static function BackEdit()
	{
		$display = array();

		if(isset($_POST['id']))
		{
			$objectEdited  = Object_Custom::edit(
				$options = array(
					'fields'		=> $_POST,
					'model' 	=> 'ProviderModel',
					'table' 	=> ProviderModel::$table,
					'tables' 	=> ProviderModel::$tables,
					'verbose' 	=> true
				)
			);

			$display['back']    = (isset($_POST['back'])) ? 1 : 0;
			$display['item_id'] = $_POST['id'];
		}

		$display['module']  = 'provider';
		Application::Route($display);
	}

	public static function BackDelete(){
		$id = Util::getvalue("item_id");
		if(is_numeric($id)):
			Provider::Remove(array(
				'id'=>$id,
				'table'=>'provider',
				'debug'=>false
			));
			echo "1";
		endif;
	}


	public static function BackDisplaySearch()
	{
		$query      = Util::getvalue('q', false);
		$state      = Util::getvalue('state', false);
		$page       = Util::getvalue('page', 1);
		$categories = Util::getvalue('categories', false);

		$options = array(
			'q'       => $query,
			'module'      => 'provider',
			'model'		  => 'ProviderModel',
			'table'		  => ProviderModel::$table,
			'tables'		  => ProviderModel::$tables,
			'pagesize'     => 20,
			'page' => $page,
			'state'       => $state,
			'search_in' =>array('title')
		);
		
		$Collection = Provider::Search($options);

		// $CategoriesFilters = Provider::getCategoriesFilter($options);

		parent::loadAdminInterface();
		self::$template->setcontent($Collection, null, 'collection');
		self::$template->setparam('query',$query);
		self::$template->setparam('state',$state);
		self::$template->add("list.xsl");
		self::$template->display();
	}

	public static function BackReturn()
	{
		$display['module']  = 'provider';
		Application::Route($display);
	}














	
	/* Front end */
	
	public static function FrontDisplayDefault(){


		// $interface = SkinController::loadInterface();
		// $index = Home::getPublicationPath().'index.xml';
		// $interface->setcontent($index, '/xml/*', 'home');
		// $interface->add("provider/home.components.xsl");
		// $interface->add("provider/home.xsl");
		// $interface->display();
	}


	public static function FrontDisplayAcumulado()
	{
		$categoryId = Util::getvalue('category_id');
		$pagenumber = Util::getvalue('page',1);
 		
		$Collection = Provider::Getlist(
			$options = array(
				'module'	=> 'provider',
				'model'		=> 'ProviderModel',
				'table'		=> 'provider',
				'currentPage'=> $pagenumber,
				'display'	=> 10, 
				'state'		=> 1, 
				'categories'=> $categoryId,
				'multimedias'=> true,
				'relations' => false,
				'debug'		=> false
		));


		$interface = SkinController::loadInterface();
		$interface->setcontent($Collection, null, 'collection');

		$interface->add("provider/provider.list.xsl");

		$interface->setparam("eplanning_section","Home_Notas");
		$interface->display();
	}
	
	// public static function FrontDisplayAcumuladoByName()
	// {
	// 	$name     = Util::getvalue('category');
	// 	$name     = str_replace("-", " ", $name);
	// 	$category = Category::GetByName($name); 
	// 	$pagenumber     = Util::getvalue('page');


	// 	if($category):
	// 		$interface = SkinController::loadInterface();
	// 		$interface->setcontent(Object::getListByCategory($category['category_id-att'], $state=1, $multimedias=true, $pagenumber, $perPage=8), null, 'acumulado');
	// 		$interface->setcontent($category, null, 'categoria');
	// 		$interface->add("provider/templates.xsl");
	// 		$interface->add("provider/acumulado.xsl");
	// 		$interface->setparam("eplanning_section","Home_Notas");
	// 		$interface->display();
	// 	else:
	// 		echo "La categoría de nota no existe. <a href='javascript:history.back();'>Volver</a>";
	// 	endif;
	// }
	
	/*
	public static function FrontSearch()
	{
		
		$query = Util::getvalue('query', false);
		$page  = Util::getvalue('page', 1);

		//$queryStr = str_replace("'", "\'", $query);
		
		$options = array(
			'query'       => $query,
			'module'      => 'provider',
			'model'		  => 'ProviderModel',
			'table'		  => ProviderModel::$table,
			'display'     => 10,
			'currentPage' => $page,
			'type_id'	  => ProviderModel::$object_typeid,
			'state'       => 1,
			'categories'  => false,
		);

		return Provider::Search($options);
	}
	*/
	
	public static function FrontDisplayItem()
	{
		$providerId = Util::getvalue('id');
		$Site = Session::get('site');

		if(!is_numeric($providerId)):die("no es int");Util::redirect('/argentina/error/404');endif;

		$key = 'provider.'.$providerId;
		$folder = "providers";
		$expires = 7200;
		$site_preffix = $Site['preffix'];
		$Provider = Cache::getKey($key,$folder,$site_preffix);
		if($Provider == false):
			$options = array(
				'object_id'	 => $providerId,
				'model'      => 'ProviderModel',
				'table'      => 'provider',
				'state'		 => false, 
				'relations'	 => true,
				'multimedas' => true,
				'categories' => true
			);
			$Provider = Provider::getById($options);
			Cache::setKey($key,$Provider,$expires,$folder,$site_preffix);
		endif;

		


		if($Provider):
		
			$interface = SkinController::loadInterface();
			$interface->setcontent($Provider,null,'provider');
			$interface->add('provider/provider.xsl');
			$interface->setparam("eplanning_section","Item_nota");
			$interface->display();
		else:

			Util::redirect('/error/404/');

		endif;
	}

	public static function FrontDisplayModal()
	{
		$providerId = Util::getvalue('id');

		$options = array(
			'object_id'	 => $providerId,
			'model'      => 'ProviderModel',
			'table'      => 'provider',
			'state'		 => false, 
			'relations'	 => true,
			'multimedas' => true,
			'categories' => true
		);
		
		$Provider = Provider::getById($options);
		
		$interface = SkinController::loadInterface('provider/provider.modal.xsl');
		$interface->setcontent($Provider, mull,'provider');
		$interface->display();

	}

	
	









	public static function display_error(){
		
		$interface = SkinController::loadInterface();
		$custom = array('titulo'=>'Nota no disponible', 'resumen'=>'La nota solicitada no está disponible o la url no est&#225; bien formada.');
		$interface->setcontent($custom, null, 'provider');
		$interface->setparam('error', '1');
		$interface->add("provider/provider.xsl");
		$interface->display();
		
	}



	/* Enviar por email */
	public static function FrontDisplayEnvio()
	{
		$id = Util::getvalue('id');

		$interface = SkinController::loadInterface($baseXsl='provider/provider.envio.xsl');
		$interface->setcontent(Provider::getById($id), null, 'provider');
		
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
		$id  = Util::getvalue('id');
		$emailRCP = Util::getvalue('email');
		$mensaje  = strip_tags(Util::getvalue('mensaje'));
		$copia    = Util::getvalue('copia', false);


		$interface = SkinController::loadInterface($baseXsl='provider/provider.envio.xsl');
		$provider = Provider::getById($id);
		$provider['mensaje'] = $mensaje;
		
		$userArray = Session::getvalue('proyectounder');
		
		if($userArray):
			$provider['user'] = $userArray;
		endif;
		
		$emailhtml = self::envio_email($provider);
		$email = new Email();
		$email->SetFrom('contacto@Laika.com', 'Laika.com');
		$email->SetSubject(utf8_encode($provider['titulo']));
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
	
	
	
	public static function envio_email($Provider)
	{
		$interface = SkinController::loadInterface($baseXsl='provider/provider.envio.cuerpo.xsl');
		$interface->setcontent($Provider, null, 'provider');
		return $interface->returnDisplay();
		//$interface->display();
	}
	
	
	
	
	
	
}


?>
