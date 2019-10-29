<?php
Class Admin extends Module
{

	private static $sessionAdmin    = 'mdn_admin';
	private static $AdminCookieName = 'admin';
	private static $cookieTime      = 1209600; //2 semanas; 
	private static $cookiePath      = '/';
	private static $userData        = array();

	/* Nuevo del framework */
	private static $adminTable      = 'user_admin';
	public static $encryptHash      = '994248963017717334501526818365836079525263207585';



	/* Usuarios de backend */
	public static function getAccessLevel($userLevelId = false){
		if($userLevelId):
			$params = array(
				'fields'=>array('*'),
				'table'=>'user_level',
				'filters'=>array('user_level_id='.$userLevelId)
			);
			$result = parent::select($params);
			if(count($result)):
				return $result[0];
			else:
				return false;
			endif;
		endif;
	}
	
	public static function validateAccesLevel($userAccessLevel=false,$moduleAccessLevel=false)
	{
		
		if($userAccessLevel && $moduleAccessLevel):
		
			//If AccessLevel is 'all' returns true to getAccess
			if($moduleAccessLevel == 'all' || $userAccessLevel == 'administrator'):
				return true;
			endif;
			
			
			$moduleAccessLevel = explode(",",$moduleAccessLevel);
			
			foreach($moduleAccessLevel as $accessLevel):
				if($accessLevel === $userAccessLevel):
					return true;
				endif;
				
			endforeach;
		else:
			return false;
		endif;
	}
	
	public static function getAccessLevelList()
	{
		$fields = array('*');
		$fields = AdminModel::parseFields(AdminModel::$tables, $fields, AdminModel::$tableLevels);
		$params = array(
			'fields' => $fields,
			'table'  =>'user_level',
		);
		$result = parent::select($params);
		
		$result['tag'] = 'level';
		return $result;
	}
	
	public static function IsLoguedIn()
	{

		$user = Session::Get(self::$sessionAdmin);

		if(!empty($user)):
			return $user;
		else:
			return false;
		endif;
	}

	
	public static function UsernameExists($username)
	{
		$params = array(
			'table'=> AdminModel::$table,
			'filters'=> array('username='.Util::quote($username)),
			'fields'=>array('*'),
		);
		$return = parent::select($params);
		if(!empty($return)):
			return true;
		else:
			return false;
		endif;
	}

	public static function EmailExists($email, $user_id=false)
	{
		$params = array(
			'table'=> AdminModel::$table,
			'filters'=> array('user_email='.Util::quote($email)),
			'fields'=>array('*'),
		);
		if($user_id):
			array_push($params['filters'], 'user_id!='.$user_id);
		endif;
		$return = parent::select($params);
		if(count($return) >= 1):
			return true;
		else:
			return false;
		endif;
	}

	public static function ValidatePass( $username, $pass ) {

		$params = array(
			'table' => AdminModel::$table,
			'filters'=>array(
				'username=' . Util::quote( $username ), 
				'user_password='. Util::quote( self::encrypt( $pass ) ),
			)
		);
		$return = parent::select($params);
		if( count($return) == 1):
			return true;
		else:
			return false;
		endif;
	}
	
	public static function Login($user)
	{
		$fields = array('*');
		$fields = Model::parseFields(AdminModel::$tables, $fields, AdminModel::$table);

		$params = array(
			'table' => AdminModel::$table,
			'fields' => $fields,
			'filters'=>array(
				'username='.Util::quote($user['username']), 
				'user_password='.Util::quote(self::encrypt($user['password'])),
			)
		);

		$userData = parent::select($params,false);

		if(count($userData)==1){

			/* 
				Si el usuario tiene la cookie, se la borramos. Luego preguntamos si quiere que se lo recuerde, para dejarsela.
				Esto sirve, por si un usuario se arrepiente y destilda la opcion para que le escribamos el user y pass en el login
			*/
			if(isset($_COOKIE[self::$AdminCookieName])):
				setcookie(self::$AdminCookieName, '', -1, self::$cookiePath, '', 0, 1);
			endif;
			if($user['remember']==1){
				$cookie = base64_encode(serialize(array('email'=>$user['email'], 'pass'=>$user['pass'])));
				setcookie(self::$AdminCookieName, $cookie,time()+self::$cookieTime, self::$cookiePath, '', 0, 1);
			}

			//$userData[0]['avatar'] = self::getAvatar($userData[0]['photo_id-att']);

			self::$userData = $userData[0];
			self::$userData['role'] = self::getAccessLevel($userData[0]['access_level-att']);
			//$_SESSION[self::$sessionAdmin] = self::$userData;
			Session::Set(self::$sessionAdmin, self::$userData);

			return true;
		}else{
			return false;
		}
	}

	public static function AdminLogout()
	{
		Session::Delete(self::$sessionAdmin);
		/*$_SESSION[self::$sessionAdmin] = array();
		unset($_SESSION[self::$sessionAdmin]);*/
	}

	public static function GetList($page=false, $limit=false)
	{
		$fields = array('*');
		$fields = AdminModel::parseFields(AdminModel::$tables, $fields, AdminModel::$table);
		$params = array(
			'table'=>AdminModel::$table,
			'fields'=>$fields,
			'orderby'=>'user_name ASC',
		);
		$perPage = 20;

		if($limit):     
			$cantidad = $limit;
		else:
			if($page):
				$from = ($page-1) * $perPage;
			else:
				$from = 0;
			endif;
			$cantidad = $from.', '.$perPage;
		endif;

		$params['limit'] = $cantidad;
		$list = parent::select($params);
		
		foreach($list as $key=>$user):
			$list[$key]['role'] = self::getAccessLevel($user['access_level-att']);
		endforeach;
		
		$list['tag'] = 'user';
		$list['total-att'] = self::getTotalAdminUsers();
		$list['mostrar-att'] = $perPage;
		return $list;
	}

	public static function getTotalAdminUsers()
	{
		$fields = array('user_id');
		$params = array(
			'table'=>AdminModel::$table,
			'fields'=>$fields
		);
		$total = parent::select($params);
		return count($total);
	}

	public static function AddUser($DTO)
	{
		$fields = AdminModel::inputFields(AdminModel::$tables, $DTO, AdminModel::$table, $verbose=false);
		$params = array(
			'table'=>AdminModel::$table,
			'fields'=>$fields
		);
		return parent::insert($params);
	}
	
	public static function UpdateUser($DTO)
	{
		$fields = AdminModel::inputFields(AdminModel::$tables, $DTO, AdminModel::$table, $verbose=true);

		$params = array(
			'table'  => AdminModel::$table,
			'fields' => $fields,
			'filters'=> array('user_id=' . $DTO['user_id'] ),
		);
		return parent::update( $params, $debug = false );
	}

	public static function GetById($user_id)
	{
		$fields = array('*');
		$fields = AdminModel::parseFields(AdminModel::$tables, $fields, AdminModel::$table);
		$params = array(
			'table'=>AdminModel::$table,
			'fields'=>$fields,
			'filters'=> array('user_id='.$user_id),
		);
		$user = parent::select($params);
		if(count($user)==1):
			return $user[0];
		else:
			return false;
		endif;
	}

	public static function DeleteUser($user_id)
	{
		$params = array(
			'table'=>AdminModel::$table,
			'filters'=> array('user_id='.$user_id),
		);
		parent::delete($params);
		return 1;
	}

	public static function GetByEmail($email)
	{
		$params = array(
			'table'=>AdminModel::$table,
			'filters'=> array('user_email='.Util::quote($email)),
		);
		$user = parent::select($params);
		if(count($user)==1):
			return $user[0];
		else:
			return false;
		endif;
	}

	public static function GetPass($pass){
		return self::decrypt($pass, self::$encryptHash);
	}















	// Desencriptado 
	public static function decrypt ($Msg){
		$Key = self::$encryptHash;
		if( strlen( $Key ) != 48 ){
			return( -1 );
		}
		$MsgLen = strlen ( $Msg );
		$Ctrl = 0;
		$MsgFinal = "";
		for ( $i = 0; $i < ( ( $MsgLen / 2 ) - 1 ) ; $i++ ){
			$Pos = $i % 17;
			if ( $Pos == 16 ){
				if ( $i > 0 ){
					$Part = hexdec ( substr( $Msg  , ( $i * 2 ) , 2 ) );
					$Ctrl = $Ctrl ^ ord ( substr ( $Key , 32 , 1 ) );
					/*if ( $Ctrl != $Part ){
					return ( -1 );
					}*/
				}
				$Ctrl = 0;
				continue;
			}
			$Part = hexdec ( substr( $Msg  , ( $i * 2 ) , 2 ) );
			$Part    = $Part ^ ord ( substr ( $Key , ( 16 + $Pos ) , 1 ) );
			$Ctrl    = $Ctrl ^ $Part;
			$Part    = $Part ^ ord ( substr ( $Key , $Pos , 1 ) );
			if ( $i < ( ( $MsgLen / 2 ) - 1 ) ){
				$MsgFinal = $MsgFinal . chr ($Part );
			}
		}
		// Tomo el Ultimo Elemento para descartarlo del CTRL
		$Part = hexdec ( substr( $Msg  , ( $MsgLen - 2 )  , 2 ) );
		$Ctrl = $Ctrl ^ ord ( substr ( $Key , 32 , 1 ) );
		if ( $Ctrl != $Part){
			return ( -1 ) ;
		}
		return ( $MsgFinal );
	}

	// Encriptado 
	public static function encrypt ($Msg){
		$Key = self::$encryptHash;
		if( strlen( $Key ) != 48 ){
			return( -1 );
		}
		$MsgLen = strlen ( $Msg );
		$Ctrl = 0;
		$MsgFinal = "";
		for ( $i = 0; $i < $MsgLen; $i++ ){
			$Pos = $i % 16;
			if ( $Pos == 0 ){
				if ( $i > 0 ){
					$Part = $Ctrl ^ ord ( substr( $Key , 32 , 1 ) ); // 16 + 17 - 1
					$MsgFinal = $MsgFinal . sprintf ( "%02x", $Part );
				}
				$Ctrl = 0;
			}
			$Part    = ord ( substr( $Msg , $i , 1 ) ) ^ ord ( substr( $Key , $Pos , 1 ) );
			$Ctrl    = $Ctrl ^ $Part;
			$Part    = $Part ^ ord ( substr( $Key , ( 16 + $Pos ) , 1 ) );
			$MsgFinal = $MsgFinal . sprintf ( "%02x", $Part );
		}
		$Part = $Ctrl ^ ord ( substr( $Key , 32 , 1 ) ); // 16 + 17 - 1
		$MsgFinal = $MsgFinal . sprintf ( "%02x" , $Part );
		return ( $MsgFinal );
	}



}
?>