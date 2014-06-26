<?php
class PageController extends Controller implements ModuleController {


	public static function BackDisplayDefault()
	{
		$pagenumber = Util::getvalue('page', 1);
		$state      = Util::getvalue('state', false);
		$categories = Util::getvalue('categories');

		$Collection = Object::GetList(
			$options = array(
				'model'		  => 'PageModel',
				'module'		  => 'page',
				'table'		  => Page::$table,
				'type_id'	  => PageModel::$object_typeid, 
				'display'	  => 10,
				'currentPage' => $pagenumber,
				'state'		  => $state, 
				'categories'  => $categories,
				'multimedia'  => true,
				'date'		  => false, 
				'datemod'	  => false,
				'dateASC'	  => false,
				'debug'		  => false
			)
		);

		$Filter = Object::getCategoriesFilter($options);


		parent::loadAdminInterface();
		self::$template->setcontent($Collection, null, 'collection');
		self::$template->setcontent($Filter, null, 'filter');
		self::$template->setparam('state',$options['state']);
		self::$template->setparam('category_id',$options['categories']);
		self::$template->add("list.xsl");
		self::$template->display();
	}

	public static function BackDisplayAdd(){
		parent::loadAdminInterface();
		self::$template->add("add.xsl");
		self::$template->display();
	}
	
	public static function BackAdd()
	{

		$objectId  = Object::Add($options = array(
				'data'		=> $_POST,
				'model'		=> 'PageModel',
				'table' 	=> Page::$table,
				'verbose'	=> true
			)
		);

		$display = array(
			'item_id'    => $objectId,
			'module'     => 'page',
			'back'       => 0,
		);
		Application::Route($display);
	}
	

	public static function BackDisplayEdit()
	{
		$Object = Object::getById(
			$options = array(
				'model'		 => 'PageModel',
				'table'      => PageModel::$table,
				'module'     => 'page',
				'object_id'	 => Util::getvalue('id'),
				'type_id'	 => PageModel::$object_typeid,
				'state'		 => false, 
				'relations'	 => true,
				'multimedas' => true,
				'categories' => true
			)
		);


		parent::loadAdminInterface();
		self::$template->setcontent($Object, null, 'object');
		self::$template->setcontent(Category::getList($parent=1), null, 'categories');
		self::$template->setcontext(Location::getList($parent=0), null, 'locations');
		self::$template->add("edit.xsl");
		self::$template->display();
	}

	public static function BackEdit()
	{
		$objectEdited  = Object::edit(
			$options = array(
				'data'		=> $_POST,
				'model' 	=> 'PageModel',
				'table' 	=> Page::$table,
				'verbose' 	=> true
			)
		);

		$display = array(
			'item_id'    => $_POST['page_id'],
			'module'     => 'page',
			'back'       => (isset($_POST['back'])) ? 1 : 0,
		);
		Application::Route($display);

	}

	/* PUBLISH */
	public static function BackPublish()
	{
		$object_id = Util::getvalue('item_id');
		$status = Object::GetStatusById($object_id);
		
		if($status['object_state'] == 0 || $status['object_state'] == 3)
		{

			$object_typeid   = Object::getTypeByObjectId($object_id);
			$module          = ConfigurationManager::Query("/configuration/modules/module[@type_id='".$object_typeid."']");
			$moduleName      = $module->item(0)->getAttribute('name');
			$moduleModel     = $module->item(0)->getAttribute('model');
			$modelReflection = new ReflectionClass($moduleModel);

			// Publish object
			$object = Object::getById(
				$options = array(
					'object_id'	 => $object_id,
					'model'      => $moduleModel,
					'table'      => $modelReflection->getStaticPropertyValue('table'),
					'state'		 => false, 
					'relations'	 => true,
					'multimedas' => true,
					'categories' => true
				)
			);

			parent::loadAdminInterface('publish.xsl');
			self::$template->setparam('module', $modelReflection->getStaticPropertyValue('tag'));
			self::$template->setparam('tag', $moduleName);
			self::$template->setcontent($object, null, 'object');
			$xml = self::$template->returnDisplay();

			Object::Publish($object_id, $xml);

			echo '1';
			die;

		}else{
			echo "Paso algo no puedo publicar";
		}
	}

	public static function BackUnPublish()
	{
		$object_id = Util::getvalue('item_id');
		$status = Object::GetStatusById($object_id);
		
		$homes = Home::getHomesList();
		foreach($homes as $key=>$home)
		{
			if(is_numeric($key))
			{
				$objects = Home::getObjectsByHomeId($home['home_id-att']);
				if(!empty($objects)){
					foreach($objects as $index=>$object)
					{
						if(is_numeric($index))
						{
							if($object['element_id'] == $object_id){
								echo 'El elemento no se puede despublicar.<br/> Está instanciado en la home "'.$home['title'].'"<br/><br/> Para despublicarlo, es necesario eliminarlo de esa home.';
								die;
							}
						}
					}
				}
			}
		}
		

		if($status['object_state'] == 1)
		{
			$object_typeid   = Object::getTypeByObjectId($object_id);
			$module          = ConfigurationManager::Query("/configuration/modules/module[@type_id='".$object_typeid."']");
			$moduleName      = $module->item(0)->getAttribute('name');

			Object::UnPublish($object_id);
			echo self::BackChangeState($object_id, 0);
			die;

		}else{
			echo "Paso algo no puedo despublicar";
		}
	}


	public static function BackChangeState($item_id=false, $item_state=false)
	{
		$object_id = Util::getvalue('item_id', $item_id);
		$object_state  = Util::getvalue('item_state', $item_state);

		if(is_numeric($object_id) && is_numeric($object_state)):
			$options = array(
				'data' => array (
					"object_id"=> $object_id,
					"object_state"=> $object_state,
				)
			);
			$return = Object::Edit($options);
			echo $return;
		else:
			echo 0;
		endif;
	}
	

	public static function BackDisplaySearch()
	{
		$query      = Util::getvalue('q', false);
		$state      = Util::getvalue('state', false);
		$page       = Util::getvalue('page', 1);
		$categories = Util::getvalue('categories', false);

		$options = array(
			'query'       => $query,
			'module'      => 'page',
			'model'		  => 'PageModel',
			'table'		  => PageModel::$table,
			'display'     => 15,
			'currentPage' => $page,
			'type_id'	  => PageModel::$object_typeid, 
			'state'       => $state,
			'categories'  => $categories,
		);

		$CategoriesFilters = Object::getCategoriesFilter($options);

		parent::loadAdminInterface();
		self::$template->setcontent(Object::Search($options), null, 'collection');
		self::$template->setcontent($CategoriesFilters, null, 'filter');

		self::$template->setparam('query',$query);
		self::$template->setparam('state',$state);
		self::$template->setparam('category_id',$options['categories']);

		self::$template->add("list.xsl");
		self::$template->display();
	}

	public static function BackReturn()
	{
		$display['module']  = 'page';
		Application::Route($display);
	}

	
	
	
	
	
	
	
	


	/* FRONTEND METHODS*/

	public static function FrontDisplayDefault()
	{
		die();
	}



	public static function FrontDisplayModalFeedback()
	{
		$interface = SkinController::loadInterface('page/modal.feedback.xsl');
		$interface->display();
	}


	public static function FrontDisplayModalFeedbackGracias()
	{
		$Site = Session::get("site");
		
		$to 	 = $Site["feedback_email"];
		$from 	 = "no-reply@zonajobs.com";
		$subject = "ZonajobsEducacion | Feedback From " . $Site["title"];
		
		$message =  "<p>Hola ZonanajobsEducacion ".$Site["title"].",</p>".
					"<p>Nombre: ".Util::getvalue("contact_name")." ". Util::getvalue("contact_lastname")."</p>".
					"<p>Email: ".Util::getvalue("contact_email")."</p>".
					"<p>Comentario: ".Util::getvalue("contact_comment")."</p>";
		
		$headers =  'From: ' . $from . "\r\n" .
    				'Reply-To: ' . $from . "\r\n" .
    				'MIME-Version: 1.0'. "\r\n" .
    				'Content-type: text/html; charset=iso-8859-1' . "\r\n" .
    				'X-Mailer: PHP/' . phpversion();

		$ok = mail($to,$subject,$message,$headers);

	
		$interface = SkinController::loadInterface('page/modal.feedback.gracias.xsl');
		$interface->display();
	}


	
	public static function FrontDisplayPage()
	{
		$page_id = Util::getvalue('id');

		$options = array(
				'name'		 => 'page',
				'model'		 => 'pageModel',
				'object_id'	 => $page_id,
				'type_id'	 => false,
				'state'		 => 1, 
				'relations'	 => true,
				'multimedias' => true,
				'categories' => true
		);
		$Page = Object::getById($options);

		$interface = SkinController::loadInterface();
		$interface->setcontent($Page, '/xml/page', null);
		$interface->setparam('page_id', $page_id);
		$interface->add('page/page.xsl');
		$interface->display();
	}

	public static function FrontDisplayTYC()
	{
		$options = array(
			'table'=>'page',
			'state'=>1,
			'shorttitle'=>'terminos-y-condiciones',
			'debug'=> false
		);
		$Page = Object::getByShortTitle($options);

		if($Page):
			$interface = SkinController::loadInterface();
			$interface->setcontent($Page, null,'page');
			$interface->add('page/page.xsl');
			$interface->display();

		endif;
		
	}

	public static function FrontDisplayTestvocacionalHome()
	{
		

		$interface = SkinController::loadInterface('core/layout.wide.xsl');
		$interface->add('core/header.xsl');
		$interface->add('core/footer.xsl');
		$interface->add('testvocacional/home.xsl');
		$interface->setparam("eplanning_section","Home_TestVocacional");
		$interface->display();
	}


	public static function FrontDisplayTestvocacional(){

		$grupo = Util::getvalue("grupo","1");
		$paso = Util::getvalue("paso","1");
		$paso_anterior = $paso-1;

		if($paso == 1):Session::Delete("pasos");endif;

		if(isset($_POST["paso_".$paso_anterior])):
			$pasos = Session::Get("pasos");
			$pasos[$paso_anterior]=$_POST["paso_".$paso_anterior];
			Session::set("pasos",$pasos);
		endif;

		$testConfig = $_SERVER["DOCUMENT_ROOT"] . "/content/testvocacional/config.xml";
		$interface = SkinController::loadInterface('core/layout.wide.xsl');
		$interface->setcontent($testConfig, '/xml/*', 'test_vocacional');
		$interface->add("core/header.xsl");
		$interface->add("core/footer.xsl");
		$interface->add("testvocacional/test.xsl");
		$interface->setparam("paso",$paso);
		$interface->setparam("grupo",$grupo);
		$interface->display();
	}


	public static function FrontDisplayTestvocacionalResultados()
	{
		$pasos = Session::get("pasos");	
		if(!$pasos):die();endif;

		$resultados = array(
			"M"=>0,
			"A"=>0,
			"C"=>0,
			"S"=>0,
			"P"=>0,
			"D"=>0,
		);

		$resultadoFinal = array();
		$testConfig = $_SERVER["DOCUMENT_ROOT"] . "/content/testvocacional/config.xml";
		$testConfigXml = new DOMDocument('1.0', 'UTF-8');
		$testConfigXml->load($testConfig);

		

		//CALCULO EL ULTIMO PASO
		$paso_19 = $_REQUEST["paso_19"];
		
		if(!is_array($paso_19)){die();}

		$current_value = false;
		$results_paso19 = array();

		//CALCULO RESULTADOS PASO 19 CON COLUMNAS
		foreach($paso_19 as $key=>$value){
			if($key == 0) {
				$current_value = $value;
				$results_paso19[$current_value]  = 1;
			}else{
				if($value == $current_value){
					$results_paso19[$current_value]++;
				}else{
					$current_value = $value;
					$results_paso19[$value] = 1;
				}
			}
		}
		arsort($results_paso19);

		//TOMO LOS DOS VALORES CON MAS RESULTADOS
		$i = 1;
		foreach($results_paso19 as $key=>$val){
			if($i <= 2){
				$resultados[$key]++;
			}else{
				break;
			}
			$i++;
		}


		//CALCULO RESULTADOS DE LOS PASOS ANTERIORES
		foreach($pasos as $paso){
			foreach($paso as $key=>$val){
				$resultados[$val]++;
			}
		}
		arsort($resultados);

		$i = 0;
		$personalidad = '';
		foreach($resultados as $key=>$val){
			if($i < 2){
				$resultadoFinal[] = array(
					'letra'=>$key,
					'resultado'=>$val
				);
				$personalidad.=$key; 
			}
			$i++;
		}

		//OBTENGO LOS TAGS DE LAS UNIVERSIDADES
		//Util::debug($resultadoFinal);
		//echo "resultado: " . $personalidad ."<br>";
		//die;

		$tags = $testConfigXml->getElementsByTagName('tag');
		$categoryTags = "";

		foreach($tags as $keyConfig=>$val)
		{		
			$tagValue = $val->getAttribute("value");
			if($tagValue == $personalidad){
				$categoryTags =  $val->nodeValue;
			}
		}

		if($categoryTags!=''):
			$resultadoFinal['carreras'] = Carrera::SearchByTags($options = array("tags"=>$categoryTags,"debug"=>0));
		endif;

		$resultadoFinal["tag"] = "resultado";

		$interface = SkinController::loadInterface('core/layout.wide.xsl');
		$interface->add("core/header.xsl");
		$interface->add("core/footer.xsl");
		$interface->add('testvocacional/test.resultados.xsl');
		$interface->setcontent($testConfig, '/xml/*', 'test_vocacional');
		$interface->setcontent($resultadoFinal,null, 'resultado_final');
		$interface->display();
	}



	public static function FrontDisplayLanding()
	{
		$interface = SkinController::loadInterface('page/landing.form.xsl');
		$interface->display();
	}


	public static function FrontDisplayLandingThanks()
	{
		$Site = Session::get("site");

		if(is_array($Site) && isset($Site["feedback_email"]) ):

			$params = array(
				'email_template'=>'page/landing.email.xsl',
				'data'=>array(
					'nombre'		=> Util::getvalue('nombre'),
					'email'			=> Util::getvalue('email'),
					'telefono'		=> Util::getvalue('telefono'),
					'institucion'	=> Util::getvalue('institucion')
				)
			);

			$emailhtml = self::mailBody($params);
			$email = new Email();
			$email->SetFrom('consultaseducacion@zonajobs.com.ar', 'ZonajobsEducacion');
			$email->SetSubject('ZonajobsEducacion - Contacto Instituciones');
			$emailList = preg_split("/[;,]+/", $Site["feedback_email"]);

			echo $destination;
			die;
			foreach ($emailList as $destination)
			{
				$email->AddTo($destination);
			}

			$email->ClearAttachments();
			$email->ClearImages();
			$email->SetHTMLBody($emailhtml);
			$email->Send();

			$interface = SkinController::loadInterface('page/landing.thanks.xsl');
			$interface->display();
		endif;
	}


	public static function FrontDisplaySelecCountry()
	{
		$interface = SkinController::loadInterface('page/select.country.xsl');
		$interface->display();
	}


	public static function FrontDisplayPageByTitle()
	{
		$ShortTitle = Util::Getvalue('title');

		$options = array(
			'table'		 => 'page',
			'state'		 => 1,
			'shorttitle' => $ShortTitle,
			'debug'		 => false
		);

		$Page = Object::getByShortTitle($options);

		if($Page):
			$interface = SkinController::loadInterface();
			$interface->setcontent($Page, null,'page');
			$interface->add('page/page.xsl');
			$interface->display();
		endif;

	
		$interface = SkinController::loadInterface();
		$interface->setcontent($Page, null, 'page');
		$interface->add("page/page.xsl");
		$interface->display();
		
	}










	public static function FrontSendMail()
	{
		$DTO = array();
		$DTO['user']    = Util::getvalue('name');
		$DTO['friend']  = Util::getvalue('friend');
		$DTO['addr']    = Util::getvalue('email');
		$DTO['mensaje'] = Util::getvalue('mensaje');

		
		$emailhtml = self::mailBody($DTO);
		$email = new Email();
		$email->SetFrom('concurso@revistaohlala.com', 'Revista OHLALA!');
		$email->SetSubject('Concurso Natura Chronos');
		$emailList = preg_split("/[;,]+/", $DTO['addr']);

		foreach ($emailList as $destination)
		{
			$email->AddTo($destination);
		}
		$email->ClearAttachments();
		$email->ClearImages();
		$email->SetHTMLBody(utf8_encode($emailhtml));
		$email->Send();
		$interface = SkinController::loadInterface($base='modal.envio.xsl');
		$interface->setparam('enviado', 1);
		$interface->display();
	}
	
	public static function mailBody($options)
	{
		$default = array(
			'email_template'=>"page/landing.email.xsl",
			'data'=>array(
					'nombre'		=> "",
					'email'			=> "",
					'telefono'		=> "",
					'institucion'	=> ""
			)
		);
		$options = util::extend($default,$options);
		
		$body = SkinController::loadInterface($baseXsl=$options["email_template"]);
		$body->setcontent($options["data"], null, 'data');
		//$body->display();
		return $body->returnDisplay();
	}


	




}
?>