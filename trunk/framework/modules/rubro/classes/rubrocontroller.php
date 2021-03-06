<?php
class RubroController extends Controller implements ModuleController{


	public static function BackDisplayDefault()
	{
		$Rubros = Rubro::getList(array('parent'=>0,'subrubros'=>1));
		parent::loadAdminInterface();
		self::$template->setcontent($Rubros, null, 'rubros');
		self::$template->add("rubro.list.xsl");
		self::$template->display();
	}


	public static function BackDisplayEdit()
	{
		$id = Util::getValue('id');
		$Rubro = Rubro::getById($id);
		$RubroList = Rubro::getList(array('parent'=>0,'subrubros'=>1));
		$Sindicatos = Sindicato::getList();

		self::loadAdminInterface('modal.edit.rubro.xsl');
		self::$template->setcontent($Rubro, null, 'rubro');
		self::$template->setcontent($RubroList, null, 'rubros');
		self::$template->setcontent($Sindicatos, null, 'sindicatos');
		self::$template->display();
	}

	public static function BackEdit()
	{

		$DTO    = $_POST;
		$id     = Rubro::edit($DTO);
		$Rubro     = Rubro::getById(Util::Getvalue("id"));
		self::BackReturn();
	}

	public static function BackSetHighlight()
	{
		$rubroId = Util::getvalue("id");

		$params = array(
			'id'=>$rubroId
		);
		$return = Rubro::edit($params,1);
		echo $return;

	}
	public static function BackUnsetHighlight(){
		$rubroId = Util::getvalue("id");

		$params = array(
			'id'=>$rubroId,
			'rubro_highlight'=>0
		);
		$return = Rubro::edit($params,1);
		echo $return;
	}
	public static function BackDisplayAdd()
	{
		parent::loadAdminInterface('modal.add.rubro.xsl');
		self::$template->setcontent(Rubro::getList(),null, 'rubros');
		self::$template->setcontent(Sindicato::getList(),null, 'sindicatos');
		self::$template->display();
	}

	public static function BackDisplayAddChild()
	{
		$id = Util::getvalue('id');
		parent::loadAdminInterface($baseXsl='ajax_manager.xsl');
		self::$template->setcontent(Rubro::getById($id),null, 'categoria');
		self::$template->setparam('call', 'agregarSubcategoria');
		self::$template->setparam('id', $id);
		self::$template->display();

	}

	public static function BackAdd()
	{
		$DTO    = $_POST;
		$id = Rubro::create($DTO);
		header("Location:index.php?m=rubro");
	}

	public static function BackRemove()
	{

		$id = Util::getvalue('id');
		Rubro::remove($id);
		echo 1;
	
	}


	public static function BackReturn()
	{
		$display['module']  = 'rubro';
		Application::Route($display);
	}

	
	/* FRONT END METHODS*/	
	public static function FrontDisplayDefault(){}

}
?>