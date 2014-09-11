<?php
class AdminController extends Controller
{
	
	private static $restrictedNicks = array('admin', 'administrator', 'superadmin', 'superman');
	private static $message = false;
	private static $email   = false;
	private static $referer = false;
	
	public static function BackDisplayLogin()
	{
		parent::loadAdminInterface('user.login.xsl');
		//$ref = Util::getvalue('ref');
		$ref = false;
		if(isset($_SERVER["QUERY_STRING"])):
			$adminpath = ConfigurationManager::Query('/configuration/adminpath');
			$ref = $adminpath->item(0)->nodeValue.$_SERVER["QUERY_STRING"];
		endif;

		if($ref):
			self::$template->setparam('referer', $ref);
		elseif(self::$referer):
			self::$template->setparam('referer', self::$referer);
		else:
			$ref = getenv('HTTP_REFERER');
			self::$template->setparam('referer', $ref);
		endif;
		if(self::$message):  self::$template->setparam('message', self::$message); endif;
		if(self::$email):    self::$template->setparam('email', self::$email);     endif;
		self::$template->display();
	}

	public static function BackLogin()
	{
		$user = array();
		$user['email']    = Util::getvalue('email');
		$user['username'] = Util::getvalue('username');
		$user['password'] = Util::getvalue('password');
		 $user['referer'] = Util::getvalue('referer');
		$remember         = Util::getvalue('remember');
		$user['remember'] = (isset($remember))?$remember:0;

		self::$referer   = $user['referer'];
		self::$email   = $user['email'];


		if(strpos($user['username'], '\\') != 0 || strpos($user['username'], "'") != 0):
			self::$message = "El nombre de usuario no es correcto";
			self::BackDisplayLogin();
			die();
		endif;



		if(Admin::UsernameExists($user['username']) && $user['password']!=''):

			if(!Admin::ValidatePass($user['username'], $user['password'])):
				self::$message = "La clave que ingresaste no es correcta";
			else:
				Admin::Login($user);
				$User = Admin::IsLoguedIn();
				Util::redirect("/admin/".$User['role']['user_level_default_module']);
			endif;

		elseif($user['password']==''):
			self::$message = "No escribiste una contraseña.";
		elseif(!Admin::UsernameExists($user['username'])):
			self::$message = "El nombre de usuario ingresado no existe en el sistema.";
		else:
			self::$message = "Se ha producido un error";
		endif;
		self::BackDisplayLogin();
	}

	public static function BackDisplayLogout()
	{
		Admin::AdminLogout();
		$ref = Util::getvalue('ref');
		if($ref):
			Util::redirect($ref);
		else:
			$adminpath = ConfigurationManager::Query('/configuration/adminpath');
			Util::redirect($adminpath->item(0)->nodeValue);
		endif;
	}


	public static function BackDisplayDefault()
	{
		$page = Util::getvalue('page', 1);
		parent::loadAdminInterface();
		self::$template->setcontent(Admin::GetList($page), null, 'users');
		self::$template->setparam('page', $page);
		self::$template->add('user.admin.list.xsl');
		self::$template->display();
	}
	
	public static function BackDisplayConsole(){
		parent::loadAdminInterface();
		self::$template->add('console.xsl');
		self::$template->display();
	}

	public static function BackConsole(){
		$script = $_POST["console_script"];
		$response = Module::custom($script,1);
		util::debug($response);
	}

	public static function BackDisplayAdd()
	{
		parent::loadAdminInterface();
		self::$template->setcontent(Admin::GetAccessLevelList(), null, 'levels');
		self::$template->add('user.admin.add.xsl');
		self::$template->display();
	}

	public static function BackDisplayAddTest()
	{
		echo "esto es una prueba";
	}
	
	public static function BackAdd()
	{
		$DTO    = $_POST;
		$message = '';
		
		
		// Si los passwords no coinciden
		if($DTO['user_pass0'] != $DTO['user_pass1']):
			$message = 'Error: Passwords do not match. ';
		endif;
		
		// Si el email ya existe en la db, le damos la opcion de resetear su contraseña.
		if(Admin::UsernameExists($DTO['username'])):
			$message = 'Error: The username '.$DTO['username'].' is taken.';
		endif;
		
		// Si el email ya existe en la db, le damos la opcion de resetear su contraseña.
		if(Admin::EmailExists($DTO['user_email'])):
			$message = 'Error: The account '.$DTO['user_email'].' has been already registered.';
		endif;

		// Si el nick que eligio esta restringido
		if(in_array($DTO['username'], self::$restrictedNicks)):
			$message = 'Error: The choosen nickname cannot be used.';
		endif;

		if($message!=''):
			parent::loadAdminInterface();
			self::$template->setcontent(Admin::GetAccessLevelList(), null, 'levels');
			self::$template->setcontent($DTO, null, 'user');
			self::$template->setparam('message', $message);
			self::$template->add('user.admin.add.xsl');
			self::$template->display();
		else:
			$DTO['user_password'] = $DTO['user_pass0'];
			$user_id = Admin::AddUser($DTO);

			// Application::Route(array(
			// 	'module'     => 'admin',
			// 	'item_id'    => $user_id,
			// 	'back'       => 0,
			// 	)
			// );
			self::BackReturn();
		endif;
	}
	
	public static function BackDisplayEdit()
	{
		$user_id = Util::getvalue('id');
		$user = Admin::GetById($user_id);
		$pass = Admin::GetPass($user['password']);
		parent::loadAdminInterface();
		if(!$user_id):
			$message = 'El usuario no existe';
			self::$template->setparam('message', $message);
		else:
			self::$template->setcontent($user, null, 'user');
		endif;
		self::$template->setcontent(Admin::getAccessLevelList(), null, 'levels');
		self::$template->setparam('pass', $pass);
		self::$template->add('user.admin.edit.xsl');
		self::$template->display();
	}
	
	public static function BackEdit()
	{
		if($user = Admin::IsLoguedIn()):
			$DTO    = $_POST;
			$message = '';
			
			if(!isset($DTO['user_email'])):
				$message = 'Error: El campo email no puede estar vacío.';
			else:
				if($user['email'] == $DTO['user_email']):
					unset($DTO['user_email']);
				else:
					if(Admin::EmailExists($DTO['user_email'], $DTO['user_id'])):
						$message = 'Error: El email '.$DTO['user_email'].' ya se encuentra registrado.';
					endif;
				endif;	
			endif;

			// Si los passwords no coinciden
			if($DTO['user_pass0'] == '' && $DTO['user_pass1'] == '' && $DTO['user_pass'] == ''):
				unset($DTO['user_pass']);
				unset($DTO['user_pass0']);
				unset($DTO['user_pass1']);
			elseif($DTO['user_pass'] != ''):
				if(Admin::ValidatePass($user['username'], $DTO['user_pass'])):
					if($DTO['user_pass0'] != $DTO['user_pass1']):
						$message = 'Error: Los campos para la nueva contraseña no coinciden.';
					else:
						$DTO['user_password'] = $DTO['user_pass0'];
						unset($DTO['user_pass']);
						unset($DTO['user_pass0']);
						unset($DTO['user_pass1']);
					endif;
				else:
					$message = 'Error: La contraseña original no es correcta.';
				endif;
			elseif($DTO['user_pass'] == '' && ($DTO['user_pass0'] != '' || $DTO['user_pass1'] != '')):
				$message = 'Error: La contraseña original no es correcta.';
			endif;


			// Si el nick que eligio esta restringido
			/*
			if(in_array($DTO['user_alias'], self::$restrictedNicks)):
				$message = 'Error: The choosen nickname cannot be used.';
			endif;
			*/

			if($message!=''):
				$user = Admin::GetById($DTO['user_id']);
				$pass = Admin::GetPass($user['password']);
				
				parent::loadAdminInterface();
				self::$template->setcontent(Admin::GetAccessLevelList(), null, 'levels');
				self::$template->setcontent($user, null, 'user');
				self::$template->setparam('message', $message);
				self::$template->setparam('pass', $pass);
				self::$template->add('user.admin.edit.xsl');
				self::$template->display();
			else:
				$user = Admin::UpdateUser($DTO);

				Application::Route(array(
					'module'     => 'admin',
					'item_id'    => $DTO['user_id'],
					'back'       => (isset($_POST['back'])) ? 1 : 0,
					)
				);
			endif;
		endif;
	}

	public static function BackDeleteUser()
	{
		$user_id = Util::getvalue('user_id');
		echo Admin::DeleteUser($user_id);
	}

	public static function BackEmailSend()
	{
		$user_id = Util::getvalue('user_id');
		$user    = Admin::GetById($user_id);
		//Util::debug($user);
		$email = new Email();
		$emailhtml = self::BackEmailBody($user);
		$email->SetFrom(ConfigurationManager::GetSender(), ConfigurationManager::GetSenderName());
		$email->SetSubject('Tu usuario de ' . ConfigurationManager::GetApplicationID());
		$address = (string)$user['email'];
		$email->AddTo($address);
		$email->SetHTMLBody($emailhtml);
		$email->Send();
		echo '1';
	}

	public static function BackDisplayLostPass()
	{
		parent::loadAdminInterface($baseXsl='user.login.xsl');
		if(self::$message): 
			self::$template->setparam('message', $message); 
		endif;
		self::$template->setparam('call', 'password');
		self::$template->display();
	}


	public static function BackDisplaySendPass()
	{
		$address = Util::getvalue('email');

		if($user = Admin::GetByEmail($address)):

			$emailhtml = self::BackEmailBody($user);
			$email = new Email();
			$email->SetFrom(ConfigurationManager::GetSender(), ConfigurationManager::GetSenderName());
			$email->SetSubject('Tu usuario de ' . ConfigurationManager::GetApplicationID());
			$email->AddTo($address);
			$email->SetHTMLBody($emailhtml);
			$email->Send();

			parent::loadAdminInterface($baseXsl='user.login.xsl');
			self::$template->setparam('email', $address);
			self::$template->setparam('call', 'pass-sended');
			self::$template->display();
		else:
			parent::loadAdminInterface($baseXsl='user.login.xsl');
			self::$template->setparam('email', $address);
			self::$template->setparam('call', 'notexist');
			self::$template->display();
		endif;
	}

	/*
		email_sendPass($email) realiza la transformaciondel cuerpo del email 
		con las instrucciones con la contraseña
		Devuelve la transformación, sin imprimir nada en pantalla.
	*/
	public static function BackEmailBody($user, $call=false)
	{
		if(isset($user['password'])):
			$pass = Admin::decrypt($user['password']);
		else:
			$pass = Admin::decrypt($user['user_password']);
		endif;
		parent::loadAdminInterface($baseXsl='user.mail.body.xsl');

		self::$template->setcontent($user, null, 'user');
		self::$template->setparam('pass', $pass);
		if($call):
			self::$template->setparam('call', $call);
		endif;
		return self::$template->returnDisplay();
		//self::$template->display();
		//die();
	}	
	

	/*  User profile data */
	public static function BackDisplayEditMyData()
	{
		$user = Admin::IsLoguedIn();

		parent::loadAdminInterface();
		self::$template->setcontent($user, null, 'user');
		self::$template->add('user.admin.profile.xsl');
		self::$template->display();

	}

	public static function BackEditMyData()
	{
		if($user = Admin::IsLoguedIn()):
			$DTO    = $_POST;

			$message = '';
			
			if($DTO['user_id'] != $user['user_id-att']):
				$message = 'Error: no está permitido editar otro usuario.';
			endif;

			if(!isset($DTO['user_email'])):
				$message = 'Error: El campo email no puede estar vacío.';
			else:
				if($user['email'] == $DTO['user_email']):
					unset($DTO['user_email']);
				else:
					if(Admin::EmailExists($DTO['user_email'], $DTO['user_id'])):
						$message = 'Error: El email '.$DTO['user_email'].' ya se encuentra registrado.';
					endif;
				endif;	
			endif;

			// Si los passwords no coinciden
			if($DTO['user_pass0'] == '' && $DTO['user_pass1'] == '' && $DTO['user_pass'] == ''):
				unset($DTO['user_pass']);
				unset($DTO['user_pass0']);
				unset($DTO['user_pass1']);
			elseif($DTO['user_pass'] != ''):
				if(Admin::ValidatePass($user['username'], $DTO['user_pass'])):
					if($DTO['user_pass0'] != $DTO['user_pass1']):
						$message = 'Error: Los campos para la nueva contraseña no coinciden.';
					else:
						$DTO['user_password'] = $DTO['user_pass0'];
					endif;
				else:
					$message = 'Error: La contraseña original no es correcta.';
				endif;
			elseif($DTO['user_pass'] == '' && ($DTO['user_pass0'] != '' || $DTO['user_pass1'] != '')):
				$message = 'Error: La contraseña original no es correcta.';
			endif;


			// Si el nick que eligio esta restringido
			/*
			if(in_array($DTO['user_alias'], self::$restrictedNicks)):
				$message = 'Error: The choosen nickname cannot be used.';
			endif;
			*/

			if($message!=''):
				$user = Admin::GetById($DTO['user_id']);
				$pass = Admin::GetPass($user['password']);
				
				parent::loadAdminInterface();
				self::$template->setcontent(Admin::GetAccessLevelList(), null, 'levels');
				self::$template->setcontent($user, null, 'user');
				self::$template->setparam('message', $message);
				self::$template->setparam('pass', $pass);
				self::$template->add('user.admin.edit.xsl');
				self::$template->display();
			else:
				$user = Admin::UpdateUser($DTO);

				Application::Route(array(
					'module'     => 'admin',
					'item_id'    => $DTO['user_id'],
					'back'       => (isset($_POST['back'])) ? 1 : 0,
					)
				);
			endif;
		endif;
	}


	public static function BackReturn()
	{
		$display['module']  = 'admin';
		Application::Route($display);
	}








	/*
	public static function BackDisplayDefault()
	{
		
		parent::loadAdminInterface();
		//self::$template->setcontent(ConfigurationManager::getConfiguration(), $xpath='/configuration', null);
		self::$template->add('configuration.xsl');
		self::$template->setparam('configfile',ConfigurationManager::GetConfigFile());
		self::$template->display();
	}
	
	public static function setskin(){
		
		$set = Util::getvalue('skin');
		if (strlen($set)>1):
			$path = $set;
			if(is_dir($path)):
				$default = new DOMDocument('1.0');
				$default->formatOutput = true;
				$default->load(PathManager::GetModulesPath().'/skins/defaultskin.xml');
				$new = new DOMDocument('1.0');
				$new->load($path.'/skinconfiguration.xml');
				$default->getElementsByTagName('name')->item(0)->nodeValue = $new->getElementsByTagName('name')->item(0)->nodeValue;
				$default->getElementsByTagName('path')->item(0)->nodeValue = $new->getElementsByTagName('path')->item(0)->nodeValue;
				$default->getElementsByTagName('iphone')->item(0)->nodeValue = $new->getElementsByTagName('iphone')->item(0)->nodeValue;
				$default->save(PathManager::GetModulesPath().'/skins/defaultskin.xml');
			endif;

		endif;
		
		self::loadInterface();
		$list = Skin::getAllSkins();

		foreach ($list as $num=>$skinpath):
			$config = $skinpath . '/skinconfiguration.xml';
			self::$template->setcontent($config , '/skin', 'skins');
		endforeach;
		

		self::$template->setcontent(Skin::getDefaultSkin() , null, 'default');
		self::$template->add('skins.xsl');
		self::$template->display();
	}
	
	public static function saveConfiguration(){
		
		echo "Datos por post a parsear: <br/>";
		Util::debug($_POST);
	}
	*/
	
	
	
	
	
}

?>