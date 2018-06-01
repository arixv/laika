<?php

class CobroController extends Controller{
	
	public static function BackDisplayDefault(){
		$page = util::getvalue('page',1);
		$sort = util::Getvalue('sort','date');
		$List = Cobro::getList(array(
			'page'=>$page,
			'sort'=>$sort
		));
		parent::loadAdminInterface();
		self::$template->setcontent($List, null, 'collection');
		self::$template->add("list.cobros.xsl");
		self::$template->setparam('sort',$sort);
		self::$template->setparam('page_url','/admin/cobros/list/');
		self::$template->display();
	}

	public static function BackDisplayAddCobro(){
		$redirect = util::getvalue("redirect");	

		$Clients = Client::getList();
		$Clients = Client::getList(array(
			'pagesize'=> false
		));
		$Projects = Project::getList(array(
			'page'=>-1
		));
		self::loadAdminInterface('modal.add.cobro.xsl');
		self::$template->setcontent( $Clients, null,'clients' );
		self::$template->setcontent( $Projects, null, 'projects' );
		self::$template->setparam( 'redirect', $redirect );
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
				'amount'=>util::getvalue('currency-default'),
				'state'=>util::getvalue('state'),
				'date'=>util::inversedate(util::getvalue('date')),
				'creation_userid'=>$User['user_id-att'],
				'client_id'=>util::getvalue('client_id'),
				'project_id'=>util::getvalue('project_id')
			),
			'table'=>CobroModel::$table
		);
		// util::debug($params);
		$id = Cobro::insert($params,$debug=0);
		Util::redirect($redirect);

	}

	public static function BackDisplayEdit(){
		
		$Cobro = Cobro::getById(array('id'=>util::Getvalue('id')));
		//util::debug(util::Getvalue('id'));
		//util::debug($Cobro);
		$Clients = Client::getList();
		$Projects = Project::getList(array(
			'page'=>-1
		));

		self::loadAdminInterface();
		self::$template->add('edit.cobro.xsl');
		self::$template->setcontent($Cobro,null,'cobro');
		self::$template->setcontent($Clients,null,'clients');
		self::$template->setcontent($Projects,null,'projects');
		self::$template->display();
	}


	public static function BackEdit(){
		$cobro_id = Util::getvalue("id");
		if(is_numeric($cobro_id)){
			$params = array(
				'fields'=>array(
					'number'=>Util::Getvalue("number"),
					'description'=>Util::Getvalue("description"),
					'amount'=>Util::Getvalue('currency-default'),
					'type'=>Util::Getvalue('type'),
					'state'=>Util::Getvalue('state'),
					'date'=>util::inverseDate(Util::Getvalue('date')),
					'client_id'=>util::getvalue('client_id'),
					'project_id'=>util::getvalue('project_id')
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