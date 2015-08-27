<?php

class SettingsController extends Controller implements ModuleController{

	public static function BackDisplayDefault(){
		$Costos = CostoOperativo::getList();
		$Total = CostoOperativo::getTotal();
		parent::loadAdminInterface();
		self::$template->setcontent($Costos,null,"costos");
		self::$template->setParam('total',$Total);
		self::$template->add("settings.default.xsl");
		self::$template->display();
	}

	public static function BackDisplayFacturacion(){

		$tipo_facturacion = settings::get('tipo_facturacion');
		$facturacion_anual = settings::get('facturacion_anual');
		
		parent::loadAdminInterface();
		self::$template->add("settings.facturacion.xsl");
		self::$template->setparam('tipo_facturacion',$tipo_facturacion['setting_value']);
		self::$template->setparam('facturacion_anual',$facturacion_anual['setting_value']);
		self::$template->display();
	}

	public static function BackDisplayAddCosto(){
		parent::loadAdminInterface('modal.add.costo.xsl');
		self::$template->display();
	}

	/* BackDisplayEditCosto */
	public static function BackDisplayEditCosto(){
		$CostoOperativo = CostoOperativo::getById(array(
			'id'=>Util::getvalue('costo_id')
		));
		parent::loadAdminInterface('modal.edit.costo.xsl');
		self::$template->setcontent($CostoOperativo,null,'costo');
		self::$template->display();
	}

	public static function BackEditCosto(){

		$DTO    = $_POST;
		$id     = CostoOperativo::edit($DTO);
		$CostoOperativo   = CostoOperativo::getById(Util::Getvalue("id"));
		self::BackReturn();

	}

	/* add costo */
	public static function BackAddCosto(){
		$title = util::Getvalue('title');
		$amount = util::Getvalue('amount');

		CostoOperativo::Create(array(
			'title'=>$title,
			'amount'=>$amount
		));
		self::BackReturn();

	}

	public static function BackReturn()
	{
		$display['module']  = 'settings';
		Application::Route($display);
	}

	public static function BackDeleteCosto(){
		$costo_id = util::getvalue('costo_id');

		echo CostoOperativo::Remove(array(
			'id'=>$costo_id
		));	
		

	}

	public static function BackEditFacturacionSettings(){
		$tipo_facturacion = util::getvalue('tipo_facturacion');
		$facturacion_anual= util::getvalue('facturacion_anual');

		Settings::set(array(
			'setting_name'=>'tipo_facturacion',
			'setting_value'=>$tipo_facturacion
		));
		Settings::set(array(
			'setting_name'=>'facturacion_anual',
			'setting_value'=>$facturacion_anual
		));

		Application::Route($display =array(
			'url'=>'/admin/settings/facturacion',
		));
	}

	public static function FrontDisplayDefault(){}

}

?>