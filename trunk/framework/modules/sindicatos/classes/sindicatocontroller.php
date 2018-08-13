<?php
class SindicatoController extends Controller implements ModuleController{


	public static function BackDisplayDefault()
	{
		parent::loadAdminInterface();
		$page = util::getvalue('page',1);
		$sort = util::getvalue('sort','name');	

		$List = Sindicato::getList(array(
			'sort'=>$sort,
			'ordering'=>'DESC'
		));

		self::$template->setparam('sort',$sort);
		self::$template->setcontent($List, null, 'sindicatos');	
		self::$template->add("list.xsl");
		self::$template->display();
	}


	public static function BackDisplayEdit()
	{
		$id = Util::getvalue('id');
		$Sindicato = Sindicato::getById($id);
		self::loadAdminInterface('modal.edit.xsl');
		self::$template->setcontent($Sindicato, null, 'sindicato');
		self::$template->display();
	}

	public static function BackEdit()
	{
		$DTO    = $_POST;
		$id     = Sindicato::edit($DTO);
		$Sindicato     = Sindicato::getById(Util::Getvalue("id"));
		self::BackReturn();
	}


	public static function BackDisplayAdd()
	{
		parent::loadAdminInterface("modal.add.xsl");
		self::$template->display();
	}

	
	public static function BackAdd()
	{
		$DTO    = $_POST;
		$id = Sindicato::create($DTO);
		header("Location:/admin/sindicatos");
	}

	public static function BackRemove()
	{

		$id = Util::getvalue('id');
		Sindicato::remove($id);
		echo 1;
	
	}


	public static function BackReturn()
	{
		$display['module']  = 'sindicatos';
		Application::Route($display);
	}

	
	/* FRONT END METHODS*/	
	public static function FrontDisplayDefault(){}

}
?>