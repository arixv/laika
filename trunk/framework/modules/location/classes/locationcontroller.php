<?php
class LocationController extends Controller implements ModuleController{


	public static function BackDisplayDefault()
	{
		$Locations = Location::getList();

		parent::loadAdminInterface();
		self::$template->setcontent($Locations, null, 'locations');
		self::$template->add("location.list.xsl");
		self::$template->display();
	}


	public static function BackDisplayEdit()
	{

		$id = Util::getvalue('id');

		parent::loadAdminInterface($baseXsl='ajax.manager.xsl');
		self::$template->setcontent(Location::getById($id),null, 'location');
		self::$template->setcontent(Location::getList(),null, 'locations');
		self::$template->setparam('call', 'item.edit');
		self::$template->setparam('id', $id);
		self::$template->display();
	}

	public static function BackEdit()
	{
		$DTO    = $_POST;
		Location::edit($DTO);
		header("Location:index.php?m=location");
	}

	public static function BackDisplayAdd()
	{
		parent::loadAdminInterface();
		self::$template->setcontent(Location::getList(),null, 'locations');
		self::$template->add("location.add.xsl");
		self::$template->display();
	}

	public static function BackDisplayLocationModal()
	{
		$module     = Util::getvalue('module');
		$list       = Util::getvalue('list');
		$arr        = explode(',', $list);

		$locations = Location::getList();

		//$arr['tag'] = 'id';
		//self::$template->setcontent($arr, null, 'ids');

		parent::loadAdminInterface($base='modal.location.xsl');
		self::$template->setcontent($locations, null, 'locations');
		self::$template->display();
	}

	public static function BackDisplayOptionItems()
	{
		$locationParent = Util::getvalue('location');
		$Locations = Location::getList($locationParent,$getSubitems = false,$orderby='location_name ASC');
		parent::loadAdminInterface($base='ajax.manager.xsl');
		self::$template->setcontent($Locations,null,'locations');
		self::$template->setparam('call','option.items');
		self::$template->setparam('id','0');
		self::$template->display();
	}

	public static function BackDisplayAddChild()
	{
		$id = Util::getvalue('id');
		$Location = Location::getById($id);

		parent::loadAdminInterface($baseXsl='ajax.manager.xsl');
		self::$template->setcontent($Location,null, 'location');
		self::$template->setparam('call', 'item.add');
		self::$template->setparam('id', $id);
		self::$template->display();

	}

	public static function BackAdd()
	{
		$DTO    = $_POST;
		$id = Location::create($DTO);
		header("Location:/admin/location/");
	}

	public static function BackRemove()
	{

		$id = Util::getvalue('id');
		$r = Location::remove($id);
		
		echo $r;
	}
	
	
	public static function FrontDisplayDefault(){}


	public static function FrontDisplayJSON()
	{
		$parentId = util::Getvalue("parent");
		$Locations = Location::GetList($parentId,$getSubcategories = true,$orderby = 'location_name ASC',$debug=1);
		
		if(!empty($Locations))
		{
			unset($Locations['tag']);
			$Results = array();
			foreach($Locations as $key=>$val){
				$location = array(
					"id"=>$val['id-att'],
					"name"=>$val['name']
				);
				$Results[] = $location;
			}
			$Json = array(
				"results"=>$Results
			);
			echo json_encode($Json);
		}
	}
}
?>