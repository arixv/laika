<?php
class MenuController extends Controller implements ModuleController {


	/*** BACKEND ***/
	public static function BackDisplayDefault(){
		parent::loadAdminInterface();
		self::$template->setcontent(Menu::getList(), null, 'menus');
		self::$template->add("list.xsl");
		self::$template->display();
	}
	public static function BackDisplayEdit(){
		$menu_id = Util::getvalue('menu_id');
		parent::loadAdminInterface($baseXsl='ajax_manager.xsl');
		self::$template->setcontent(Menu::getById($menu_id),null, 'menu');
		self::$template->setcontent(Menu::getList(),null, 'menus');
		self::$template->setparam('call', 'editMenu');
		self::$template->setparam('menu_id', $menu_id);
		self::$template->display();
	}

	public static function BackEdit(){
		$DTO    = $_POST;
		$id     = Menu::edit($DTO);
		echo $id;
		header("Location:index.php?m=menu");
	}

	public static function BackDisplayAdd(){
		parent::loadAdminInterface();
		self::$template->setcontent(Menu::getList(),null, 'menus');
		self::$template->add("add.xsl");
		self::$template->display();
	}

	public static function BackDisplayAddChild(){
		$menu_id = Util::getvalue('menu_id');
		parent::loadAdminInterface($baseXsl='ajax_manager.xsl');
		self::$template->setcontent(Menu::getById($menu_id),null, 'menu');
		self::$template->setparam('call', 'addSubMenu');
		self::$template->setparam('menu_id', $menu_id);
		self::$template->display();

	}

	public static function BackAdd(){
		$DTO    = $_POST;
		$id = Menu::create($DTO);
		$display = array(
			'module' => 'menu',
		);
		Application::Route($display);
		
	}

	public static function BackRemove()
	{
		$id = Util::getvalue('id');
		$r = Menu::remove($id);
		self::BackReturn();
	}

	public static function BackReturn()
	{
		$display['module']  = 'menu';
		Application::Route($display);
	}

		
	/*** FRONTEND ***/
	public static function FrontDisplayDefault(){}

}	
?>