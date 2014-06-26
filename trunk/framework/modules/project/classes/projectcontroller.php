<?php
class ProjectController extends ObjectController implements ModuleController {

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
				'module'	  => 'article',
				'model'		  => 'ArticleModel',
				'table'		  => 'article',
				'type_id'	  => ArticleModel::$object_typeid, 
				'currentPage' => $page,
				'display'	  => 10, 
				'state'		  => ($state != 'false') ? $state : false, 
				'categories'  => $categories,
				'multimedia'  => true,
				'relations'   => false,
				//'debug'     => true,
		);


		$Collection = Article::GetList($options);
		//Util::debug($Collection);
		
		$CategoriesFilters = Article::getCategoriesFilter($options);
		
		self::loadAdminInterface();
		self::$template->setcontent($Collection, null, 'collection');
		self::$template->setcontent($CategoriesFilters, null, 'filter');
		self::$template->setparam('state',$options['state']);
		self::$template->setparam('category_id',$options['categories']);
		self::$template->add("article.list.xsl");
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
				'model'      => 'ArticleModel',
				'table'      => ArticleModel::$table,
				'state'		 => false, 
				'relations'	 => true,
				'multimedas' => true,
				'categories' => true
			)
		);

		if(!$Object) Application::Route(array('modulename'=>'article'));
		
		$Locations = Location::getList($parent=0);

		parent::loadAdminInterface();
		self::$template->setcontent($Object, null, 'object');
		self::$template->setcontext($Locations, null, 'locations');
		self::$template->add("article.templates.xsl");
		self::$template->add("article.edit.xsl");
		self::$template->display();
	}

	public static function BackDisplayAdd()
	{
		parent::loadAdminInterface();
		self::$template->add("article.add.xsl");
		self::$template->display();
	}
	
	public static function BackAdd()
	{
		$objectId  = Article::Add($options = array(
				'data'		=> $_POST,
				'model'		=> 'ArticleModel',
				'table' 	=> ArticleModel::$table,
				'verbose'	=> true
			)
		);

		$display = array(
			'item_id'    => $objectId,
			'module'     => 'article',
			'back'       => 0,
		);
		
		Application::Route($display);
	}
	
	public static function BackEdit()
	{
		$display = array();
		if(isset($_POST['article_id'])){
			$objectEdited  = Object::edit(
				$options = array(
					'data'		=> $_POST,
					'model' 	=> 'ArticleModel',
					'table' 	=> ArticleModel::$table,
					'verbose' 	=> true
				)
			);

			$display['back']    = (isset($_POST['back'])) ? 1 : 0;
			$display['item_id'] = $_POST['article_id'];
		}
		$display['module']  = 'article';
		Application::Route($display);
	}

	public static function BackClearCacheObject()
	{
		$Site = Session::get('site');
		$articleId = Util::getvalue("id");
		$key = 'article.'.$articleId;
		$folder = "articles";
		$site_preffix = $Site['preffix'];

		$Result = Cache::deleteKey($key,$folder,$site_preffix);
		
		Application::Route(array(
			'back'=> 0,
			'module' => 'article',
			'item_id'=>$articleId
		));

	}

	public static function BackDisplaySearch()
	{
		$query      = Util::getvalue('q', false);
		$state      = Util::getvalue('state', false);
		$page       = Util::getvalue('page', 1);
		$categories = Util::getvalue('categories', false);

		$options = array(
			'query'       => $query,
			'module'      => 'article',
			'model'		  => 'ArticleModel',
			'table'		  => ArticleModel::$table,
			'display'     => 20,
			'currentPage' => $page,
			'type_id'	  => ArticleModel::$object_typeid, 
			'state'       => $state,
			'categories'  => $categories,
		);

		$CategoriesFilters = Article::getCategoriesFilter($options);

		parent::loadAdminInterface();
		self::$template->setcontent(Article::Search($options), null, 'collection');
		self::$template->setcontent($CategoriesFilters, null, 'filter');

		self::$template->setparam('query',$query);
		self::$template->setparam('state',$state);
		self::$template->setparam('category_id',$options['categories']);

		self::$template->add("article.list.xsl");
		self::$template->display();
	}

	public static function BackReturn()
	{
		$display['module']  = 'article';
		Application::Route($display);
	}














	
	/* Front end */
	
	public static function FrontDisplayDefault(){


		// $interface = SkinController::loadInterface();
		// $index = Home::getPublicationPath().'index.xml';
		// $interface->setcontent($index, '/xml/*', 'home');
		// $interface->add("article/home.components.xsl");
		// $interface->add("article/home.xsl");
		// $interface->display();
	}


	public static function FrontDisplayAcumulado()
	{
		$categoryId = Util::getvalue('category_id');
		$pagenumber = Util::getvalue('page',1);
 		
		$Collection = Article::Getlist(
			$options = array(
				'module'	=> 'article',
				'model'		=> 'ArticleModel',
				'table'		=> 'article',
				'type_id'	=> ArticleModel::$object_typeid, 
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

		$interface->add("article/article.list.xsl");

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
	// 		$interface->add("article/templates.xsl");
	// 		$interface->add("article/acumulado.xsl");
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
			'module'      => 'article',
			'model'		  => 'ArticleModel',
			'table'		  => ArticleModel::$table,
			'display'     => 10,
			'currentPage' => $page,
			'type_id'	  => ArticleModel::$object_typeid,
			'state'       => 1,
			'categories'  => false,
		);

		return Article::Search($options);
	}
	*/
	
	public static function FrontDisplayItem()
	{
		$articleId = Util::getvalue('id');
		$Site = Session::get('site');

		if(!is_numeric($articleId)):die("no es int");Util::redirect('/argentina/error/404');endif;

		$key = 'article.'.$articleId;
		$folder = "articles";
		$expires = 7200;
		$site_preffix = $Site['preffix'];
		$Article = Cache::getKey($key,$folder,$site_preffix);
		if($Article == false):
			$options = array(
				'object_id'	 => $articleId,
				'model'      => 'ArticleModel',
				'table'      => 'article',
				'state'		 => false, 
				'relations'	 => true,
				'multimedas' => true,
				'categories' => true
			);
			$Article = Article::getById($options);
			Cache::setKey($key,$Article,$expires,$folder,$site_preffix);
		endif;

		


		if($Article):
		
			$interface = SkinController::loadInterface();
			$interface->setcontent($Article,null,'article');
			$interface->add('article/article.xsl');
			$interface->setparam("eplanning_section","Item_nota");
			$interface->display();
		else:

			Util::redirect('/error/404/');

		endif;
	}

	public static function FrontDisplayModal()
	{
		$articleId = Util::getvalue('id');

		$options = array(
			'object_id'	 => $articleId,
			'model'      => 'ArticleModel',
			'table'      => 'article',
			'state'		 => false, 
			'relations'	 => true,
			'multimedas' => true,
			'categories' => true
		);
		
		$Article = Article::getById($options);
		
		$interface = SkinController::loadInterface('article/article.modal.xsl');
		$interface->setcontent($Article, mull,'article');
		$interface->display();

	}

	
	









	public static function display_error(){
		
		$interface = SkinController::loadInterface();
		$custom = array('titulo'=>'Nota no disponible', 'resumen'=>'La nota solicitada no está disponible o la url no est&#225; bien formada.');
		$interface->setcontent($custom, null, 'article');
		$interface->setparam('error', '1');
		$interface->add("article/article.xsl");
		$interface->display();
		
	}



	/* Enviar por email */
	public static function FrontDisplayEnvio()
	{
		$article_id = Util::getvalue('article_id');

		$interface = SkinController::loadInterface($baseXsl='article/article.envio.xsl');
		$interface->setcontent(Article::getById($article_id), null, 'article');
		
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
		$article_id  = Util::getvalue('article_id');
		$emailRCP = Util::getvalue('email');
		$mensaje  = strip_tags(Util::getvalue('mensaje'));
		$copia    = Util::getvalue('copia', false);


		$interface = SkinController::loadInterface($baseXsl='article/article.envio.xsl');
		$article = Article::getById($article_id);
		$article['mensaje'] = $mensaje;
		
		$userArray = Session::getvalue('proyectounder');
		
		if($userArray):
			$article['user'] = $userArray;
		endif;
		
		$emailhtml = self::envio_email($article);
		$email = new Email();
		$email->SetFrom('contacto@proyectounder.com', 'Proyectounder.com');
		$email->SetSubject(utf8_encode($article['titulo']));
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
	
	
	
	public static function envio_email($Article)
	{
		$interface = SkinController::loadInterface($baseXsl='article/article.envio.cuerpo.xsl');
		$interface->setcontent($Article, null, 'article');
		return $interface->returnDisplay();
		//$interface->display();
	}
	
	
	
	
	
	
}


?>
