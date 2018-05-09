<?php
class ProfileController extends Controller implements ModuleController {
	public static function BackDisplayDefault() {

		$CurrentUser = Admin::IsLoguedIn();
		if ( false !== $CurrentUser ) :
			$User = Admin::GetById( $CurrentUser['user_id-att'] );
			parent::loadAdminInterface();
			self::$template->setcontent( $User, null, 'user');
			self::$template->setcontent( Admin::getAccessLevelList(), null, 'levels' );
			self::$template->add('user.profile.xsl');
			self::$template->display();
		endif;
	}
	public static function FrontDisplayDefault() {}


	public static function BackDisplayEdit() {
		$CurrentUser = Admin::IsLoguedIn();

		if ( false !== $CurrentUser ) :
			$User = Admin::GetById( $CurrentUser['user_id-att'] );
			parent::loadAdminInterface();
			self::$template->setcontent( $User, null, 'user');
			self::$template->setcontent( Admin::getAccessLevelList(), null, 'levels' );
			self::$template->add('user.profile.xsl');
			self::$template->display();
		endif;
	}

	public static function BackEdit() {
			if ( $user = Admin::IsLoguedIn() ) :
			$DTO  = $_POST;

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
			elseif( $DTO['user_pass'] != '' ) :
				if(Admin::ValidatePass($user['username'], $DTO['user_pass'])):
					if( $DTO['user_pass0'] != $DTO['user_pass1'] ) :
						$message = 'Error: Los campos para la nueva contraseña no coinciden.';
					else:
						$DTO['user_password'] = $DTO['user_pass0'];
						unset( $DTO['user_pass'] );
						unset( $DTO['user_pass0'] );
						unset( $DTO['user_pass1'] );
					endif;
				else:
					$message = 'Error: La contraseña original no es correcta.';
				endif;
			elseif($DTO['user_pass'] == '' && ($DTO['user_pass0'] != '' || $DTO['user_pass1'] != '')):
				$message = 'Error: La contraseña original no es correcta.';
			endif;


			if( $message !='' ) :
				$user = Admin::GetById( $DTO['user_id'] );
				$pass = Admin::GetPass( $user['password'] );
				
				parent::loadAdminInterface();
				self::$template->setcontent( Admin::GetAccessLevelList(), null, 'levels' );
				self::$template->setcontent($user, null, 'user');
				self::$template->setparam('message', $message );
				self::$template->setparam('pass', $pass);
				self::$template->add('user.profile.xsl');
				self::$template->display();
			else:
				$user = Admin::UpdateUser( $DTO );
				Application::Route(array(
					'module'     => 'profile',
					'item_id'    => $DTO['user_id'],
					'back'       => ( isset($_POST['back'] ) ) ? 1 : 0,
					)
				);
			endif;
		endif;
	}
}

