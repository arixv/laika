<?php
class CategoryController extends Controller implements ModuleController{


	public static function BackDisplayDefault()
	{
		parent::loadAdminInterface();
		self::$template->setcontent(Category::getList(), null, 'categories');
		self::$template->add("list.xsl");
		self::$template->display();
	}


	public static function BackDisplayEdit()
	{
		$categoria_id = Util::getvalue('categoria_id');
		parent::loadAdminInterface($baseXsl='ajax_manager.xsl');
		self::$template->setcontent(Category::getById($categoria_id),null, 'category');
		self::$template->setcontent(Category::getList(),null, 'categories');
		self::$template->setparam('call', 'editarCategoria');
		self::$template->setparam('categoria_id', $categoria_id);
		self::$template->display();
	}

	public static function BackEdit()
	{
		$DTO    = $_POST;
		$id     = Category::edit($DTO);
		echo $id;
		header("Location:index.php?m=category");
	}

	public static function BackSetHighlight()
	{
		$categoryId = Util::getvalue("category_id");

		$params = array(
			'category_id'=>$categoryId,
			'category_highlight'=>1
		);
		$return = Category::edit($params,1);
		echo $return;

	}
	public static function BackUnsetHighlight(){
		$categoryId = Util::getvalue("category_id");

		$params = array(
			'category_id'=>$categoryId,
			'category_highlight'=>0
		);
		$return = Category::edit($params,1);
		echo $return;
	}
	public static function BackDisplayAdd()
	{
		parent::loadAdminInterface();
		self::$template->setcontent(Category::getList(),null, 'categorias');
		self::$template->add("add.xsl");
		self::$template->display();
	}

	public static function BackDisplayAddChild()
	{
		$categoria_id = Util::getvalue('category_id');
		parent::loadAdminInterface($baseXsl='ajax_manager.xsl');
		self::$template->setcontent(Category::getById($categoria_id),null, 'categoria');
		self::$template->setparam('call', 'agregarSubcategoria');
		self::$template->setparam('categoria_id', $categoria_id);
		self::$template->display();

	}

	public static function BackAdd()
	{
		$DTO    = $_POST;
		$id = Category::create($DTO);
		header("Location:index.php?m=category");
	}

	public static function BackRemove()
	{

		$id = Util::getvalue('category_id');
		$r = Category::remove($id);
		$display = array(
			'module' => 'category'
		);
		Application::Route($display);
		
	}
	
	
	public static function FrontDisplayDefault(){}


	public static function FrontDisplayCategoryJson(){
		$parent = util::getvalue("parent");
		$List = Category::getListJSON($parent);
		echo $List;
	}
}
?>