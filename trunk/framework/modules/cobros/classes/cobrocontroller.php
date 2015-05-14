<?php

class CobroController extends Controller{
	
	public static function BackDisplayDefault(){
		$List = Cobro::getList();
		parent::loadAdminInterface();
		self::$template->setcontent($List, null, 'cobros');
		self::$template->add("list.cobros.xsl");
		self::$template->setparam('sort','');
		self::$template->display();
	}

	public static function BackDisplayAddCobro(){
		$redirect = util::getvalue("redirect");	
		self::loadAdminInterface('modal.add.cobro.xsl');
		// self::$template->setcontent($Cobros,null,'partidas');
		// self::$template->setcontent($Providers,null,'providers');
		// self::$template->setcontent($Rubros,null,'rubros');
		self::$template->setparam('redirect',$redirect);
		
		self::$template->display();
	}

	public static function BackAddCobro(){
		$User = Admin::IsLoguedIn();
		$redirect= util::getvalue('redirect');
		$params = array(
			'fields'=>array(
				'number'=>util::getvalue('number'),
				'type'=>util::getvalue('type'),
				'description'=> util::getvalue('description'),
				'amount'=>util::getvalue('amount'),
				'state'=>util::getvalue('state'),
				'date'=>util::inversedate(util::getvalue('date')),
				'creation_userid'=>$User['user_id-att'],
			),
			'table'=>CobroModel::$table
		);
		// util::debug($params);
		$id = Cobro::insert($params,$debug=0);
		Util::redirect($redirect);

	}

	public static function BackDisplayEdit(){
		
		$Cobro = Cobro::getById(array('id'=>util::Getvalue('id')));
		self::loadAdminInterface();
		self::$template->add('edit.cobro.xsl');
		self::$template->setcontent($Cobro,null,'cobro');
		self::$template->display();
	}


	public static function BackEdit(){
		$cobro_id = Util::getvalue("id");
		if(is_numeric($cobro_id)){
			$params = array(
				'fields'=>array(
					'number'=>Util::Getvalue("number"),
					'description'=>Util::Getvalue("description"),
					'amount'=>Util::Getvalue('amount'),
					'type'=>Util::Getvalue('type'),
					'state'=>Util::Getvalue('state'),
					'date'=>util::inverseDate(Util::Getvalue('date')),
				),
				'table'=>CobroModel::$table,
				'filters'=>array(
					'id='.$cobro_id
				)
			);
			$id = Cobro::update($params,$debug=false);
			

		}
		Util::redirect("/admin/cobros/edit/".$cobro_id);
	}
	
	public static function BackRemove(){
		$id = util::getvalue('id');
		if(is_numeric($id)):
			Cobro::Remove(array(
				'id'=>$id,
				'table'=>CobroModel::$table,
				'debug'=>false
			));
			echo "1";
		else:
			echo "0";
		endif;
	}
	public static function FrontDisplayDefault(){}
}

?>