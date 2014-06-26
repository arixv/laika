<?php
class PhotoController extends MultimediaController
{

	/**
	* Display a List of Objects
	* @return none
	**/
	public static function BackDisplayDefault()
	{	
		$currentPage = Util::getvalue('page', 1);
		$state       = Util::getvalue('state', 'false');
		$categories  = (isset($_REQUEST['categories']))?$_REQUEST['categories']:false;

		$options = array(
				'module'     => 'photo',
				'model'		 => 'PhotoModel',
				'table'		 => PhotoModel::$table,
				'type_id'	 => PhotoModel::$multimedia_typeid,
				'currentPage' => $currentPage,
				'display'	 => 20, 
				'state'		 => ($state != 'false') ? $state : false, 
				'categories' => ($categories != 'false') ? $categories : false,
				//'debug'     => true,
		);

		$Collection = Photo::GetList($options);

		$CategoriesFilters = Photo::GetCategoriesFilter($options);

		self::loadAdminInterface();
		self::$template->setcontent($Collection, null, 'collection');
		self::$template->setcontent($CategoriesFilters, null, 'filter');
		self::$template->setparam('state',$options['state']);
		self::$template->setparam('category_id',$options['categories']);
		self::$template->add("list.xsl");
		self::$template->display();
	}




	public static function BackDisplayAdd($message=false)
	{
		$errortype = Util::getvalue('errortype');
		parent::loadAdminInterface();
		self::$template->setparam("error", $errortype);
		self::$template->add("add.xsl");
		self::$template->display();
	}



	public static function BackDisplayEdit()
	{
		$options = array(
			'model'         => 'PhotoModel',
			'module'        => 'photo',
			'type_id'       => PhotoModel::$multimedia_typeid,
			'table'         => PhotoModel::$table,
			'multimedia_id' => Util::getvalue('id'),
			'categories'    => true,
			'relations'     => true,
			'debug'         => false,
		);
		$photo = Photo::getById($options);

		if($photo):
			parent::loadAdminInterface();
			self::$template->setcontent($photo, null, 'photo');
			/*			
			$source = PathManager::GetApplicationPath().'/content/photos/source/'.substr($mid, - 1).'/'.$mid.'.'.$photo['type-att'];
			if(file_exists($source)){
				list($width, $height) = getimagesize($source);	
				self::$template->setparam('width', $width);
				self::$template->setparam('height', $height);
			}*/
			self::$template->add("edit.xsl");
			self::$template->display();
		else:
			Application::Route(array('module'=>'photo'));
		endif;		
	}

	public static function BackEdit()
	{
		$objectEdited  = Photo::edit(
			$options = array(
				'data'		=> $_POST,
				'model' 	=> 'PhotoModel',
				'table' 	=> PhotoModel::$table,
				'verbose' 	=> true
			)
		);

		$display = array(
			'back'       => (isset($_POST['back'])) ? 1 : 0,
			'item_id'    => $_POST['photo_id'],
			'module'     => 'photo',
		);

		Application::Route($display);
	}



	public static function BackUpdateBundle()
	{
		$photos = $_POST;
		$url = util::getvalue("url");

		foreach($_POST['ids'] as $key=>$id):
			$DTO['photo_title']   = $photos['title_'.$id];
			$DTO['photo_summary'] = $photos['summary_'.$id];
			$DTO['photo_id']      = $id;

			if(isset($photos['categories_'.$id]) && count($photos['categories_'.$id])):
				foreach($photos['categories_'.$id] as $cat):
					$DTO1['multimedia_id'] = $id;
					//$DTO1['parent_id']     = $photos['parent_'.$cat.'_'.$id];
					$DTO1['category_id']   = $cat;
					Photo::setCategoryByMultimediaId($DTO1);
				endforeach;
			endif;

			$defaults = array(
					'data'		=> $DTO,
					'model' 	=> 'PhotoModel',
					'table'     => PhotoModel::$table,
					'verbose' 	=> false
			);
			Photo::Edit($defaults);
		endforeach;

		Application::Route(array('module'=>'photo', 'url'=>$url));
		

	}


	

	public static function BackCreatePreview()
	{
		$pos_x  = Util::getvalue('x');
		$pos_y  = Util::getvalue('y');
		$width  = Util::getvalue('w');
		$height = Util::getvalue('h');

		$photo_id = Util::getvalue('original_id');
		
		PhotoCacheManager::GenerateCustomSize($photo_id,$pos_x,$pos_y,150,150,$width,$height);
		
		$photo = array(
			'photo_width'   => Util::getvalue('original_width'), 
			'photo_height'  =>Util::getvalue('original_height'), 
			'photo_preview' =>1, 
			'photo_id'      =>$photo_id
		);
		$id  = Photo::editPhoto($photo);
		Util::redirect('/admin/?m=photo&action=BackDisplayEdit&mid='.$photo_id);
	}

	public static function BackDisplaySearch()
	{
		$query       = Util::getvalue('q', false);
		$page        = Util::getvalue('page', 1);
		$state       = Util::getvalue('state');
		$categories  = $_REQUEST['categories'];

		parent::loadAdminInterface();

		$photos = Multimedia::Search(
			array(
				'query'       => $query,
				'type_id'     => PhotoModel::$multimedia_typeid,
				'table'       => PhotoModel::$table,
				'currentPage' => $page,
				'display'     => 15,
				'model'       => 'PhotoModel',
				'state'       => $state,
				'categories'  => $categories,
			)
		);

		$CategoriesFilters = Photo::GetCategoriesFilter(array('module'=>'photo'));

		self::$template->setcontent($photos, null, 'collection');
		self::$template->setcontent($CategoriesFilters, null, 'filter');
		self::$template->setparam("state", $state);
		self::$template->setparam("query", $query);
		self::$template->setparam("category_id", $categories);
		self::$template->add("list.xsl");
		self::$template->display();
	}


	public static function BackUpload()
	{
		$Site = Session::get("backend_site");

		$options = array(
			'module'       => 'photo',
			'folderoption' => 'target',
			'user_id'      => (isset($_POST['user_id'])) ? $_POST['user_id'] : 0,
			'user_type'    => (isset($_POST['user_type'])) ? $_POST['user_type'] : '',
			'type_id'      => PhotoModel::$multimedia_typeid,
			'site_preffix' => $Site["preffix"]
		);

		$multimedia = MultimediaController::Upload($options);

		if($multimedia['uploaded'] === true){

			// Si se subio el multimedia generamos los tamaños default
			$photoOptions = array(
				'module'       => 'photo',
				'folderoption' => 'generated',
				'site_preffix' => $Site["preffix"]
			);
			$photoPath = PathManager::GetContentTargetPath($options);

			$photo_id   = $multimedia['multimedia_id'];
			$photo_src  = $multimedia['target'];

			PhotoCache::Generate($photo_id,$photo_src,$photoOptions);

			list($photoWidth, $photoHeight) = getimagesize($photo_src);

			$dto = array(
				'photo_id'     => $photo_id,
				'photo_width'  => $photoWidth,
				'photo_height' => $photoHeight,
				'photo_weight' => filesize($photo_src),
			);

			Photo::edit(
				$options = array(
					'data'		=> $dto,
					'model' 	=> 'PhotoModel',
					'table' 	=> PhotoModel::$table,
					'verbose' 	=> true
				)
			);

			
			$basicUpload = Util::getvalue('simple_upload', false);
			$redirect    = Util::getvalue('redirect', false);

			
			$category_id = Util::getvalue('category_id');
			$object_id   = Util::getvalue('object_id');
			
			$categoriesConfig = ConfigurationManager::query("/configuration/modules/module[@name='photo']/options/group[@name='categories']/option");

			$categories = array();

			foreach($categoriesConfig as $option){
				if($option->getAttribute('type') == 'default'){
					$options = array(
						'multimedia_id' => $photo_id,
						'categories'    => array($option->getAttribute('value'))
					);
					Photo::setCategoriesByMultimediaId($options);
				}
				if($option->getAttribute('type') == 'parent'){
					
					$category = array(
						'category_id' => $option->getAttribute('value'),
						'title' => $option->getAttribute('title'),
						'subcategories' => array(),
					);

					$list = Category::GetList($option->getAttribute('value'));
					foreach($list as $key=>$cat):
						if(is_numeric($key)):
							$subcategory = array(
								'category_id' => $cat['category_id-att'],
								'name'        =>  $cat['name'],
								'selected'    => ($category_id && $cat['category_id-att']==$category_id) ? 1 : 0,
							);
							array_push($category['subcategories'], $subcategory);
						endif;
					endforeach;
					array_push($categories, $category);
				}
			}

			if(!$basicUpload){

				$generated = PathManager::GetContentTargetPath($photoOptions);
				$folder    = PathManager::GetDirectoryFromId($generated, $photo_id);

				$generatedFile = substr($folder,strlen(PathManager::GetApplicationPath()), strlen($folder)) . '/'. $photo_id. '_p.'. $multimedia['type'];

				$response = array(
					'status'     => 'ok',
					'type'       => 'image',
					'generated'  => $generatedFile,
					'data'       => $multimedia,
					'categories' => $categories,
				);
				//Util::debug($response);

				echo json_encode($response);
				die;
			}
			else
			{
				$url = Util::getvalue('url', false);
				if($url):
					Util::redirect($url);
				else:
					Application::Route(
						array(
							'module'  => 'photo', 
							'item_id' => $photo_id, 
							'back'=>0
						)
					);
				endif;
			}
		}
		else{
			// Util::Debug($multimedia);
			// die;
			echo json_encode($multimedia);
			die;
		}
	}



	public static function BackDisplayRelationModal()
	{
		$object_id 	  = Util::getvalue('object_id');
		$category_id  = Util::getvalue('category_id',false);
		$parent   	  = Util::getvalue('parent',false);
		$currentPage  = Util::getvalue('page', 1);

		parent::loadAdminInterface($base='modal.relaciones.xsl');

		if($object_id):

			$options = array(
					'module'      => 'photo',
					'model'		  => 'PhotoModel',
					'table'		  => PhotoModel::$table,
					'type_id'	  => PhotoModel::$multimedia_typeid,
					'currentPage' => $currentPage,
					'display'	  => 10, 
					'state'		  => false, 
					'categories'  => ($category_id != 'false') ? $category_id : false,
					'parent'      => ($parent != 'false') ? $parent : false,
					'debug'       => false,
			);

			$CategoriesFilters = Photo::GetCategoriesFilter($options);

			self::$template->setcontent($CategoriesFilters, null, 'filter');
			self::$template->setcontent(Photo::GetList($options), null, 'photos');
			self::$template->setcontent(Category::GetById($parent), null, 'category');
			
			if($parent):
				self::$template->setparam('parent', 1);
			endif;
			
			$objectConf = ConfigurationManager::GetModuleConfigurationByType(Object::getTypeByObjectId($object_id));

			self::$template->setcontent(
				Photo::getMultimediasByObjectId(
					array(
						'object_id'  => $object_id,
						'module'     => $objectConf->getAttribute('name'),
					)
				), 
				null, 
				'object'
			);
			
			self::$template->setparam('request_uri', $_SERVER['REQUEST_URI']);
			self::$template->setparam('object_id', $object_id);
			self::$template->setparam('category_id', $category_id);
			self::$template->setparam('parent_id', $parent);
			self::$template->display();
		endif;
	}


	public static function BackDisplayEmbedModal()
	{
		$object_id = Util::getvalue('object_id');
		$type_id   = Util::getvalue('type_id');

		parent::loadAdminInterface($base='modal.embed.xsl');

		if($object_id):
			//self::$template->setcontent(Photo::GetListByObjectId($object_id), null, 'photos');

			$options = array(
				'object_id' => $object_id,
				'module'    => 'photo',
			);

			self::$template->setcontent(Photo::getMultimediasByObjectId($options), null, 'object');
			
			self::$template->setparam('object_id', $object_id);
			self::$template->setparam('type_id', $type_id);
			self::$template->display();
		endif;
	}


	public static function BackDisplayModalUpdate()
	{
		$object_id   = Util::getvalue('object_id');
		$type_id     = Util::getvalue('type_id');
		$category_id = Util::getvalue('category_id');
		$parent      = Util::getvalue('parent');
		$photo_id    = Util::getvalue('photo_id');
		$page        = Util::getvalue('page', 1);

		if($object_id):
			parent::loadAdminInterface($base='modal.relaciones.xsl');
			self::$template->setcontent(Multimedia::getMultimediasByObjectId($object_id), null, 'object');
			self::$template->setcontent(Photo::getById($photo_id), null, 'photo');
			if($category_id):
				self::$template->setcontent(Photo::getListByCategory($category_id, $page), null, 'photos');
				self::$template->setcontent(Category::GetById($category_id), null, 'category');
			endif;
			$mod = ConfigurationManager::GetModuleConfiguration(basename(dirname(dirname(__FILE__))));
			if($mod->options->categories['enabled']=='true'):
				$categories = array();
				foreach($mod->options->categories->category_parent as $category):
					$list = Category::GetList($parent=$category['id']);
					array_push($categories, $list);
				endforeach;
				$categories['tag'] = 'listado';
				self::$template->setcontent($categories, null, 'categorylist');
			endif;
			self::$template->setparam('object_id', $object_id);
			self::$template->setparam('type_id', $type_id);
			self::$template->setparam('category_id', $category_id);
			self::$template->setparam('parent_id', $parent);
			self::$template->setparam('pagina', $page);
			self::$template->setparam('edit', 1);
			self::$template->display();
		endif;
	}

	public static function BackModalSearch()
	{
		$object_id = Util::getvalue('object_id');
		$category  = Util::getvalue('category_id');

		$current  = Util::getvalue('page', 1);
		$query    = Util::getvalue('q');

		
		if($object_id):

			parent::loadAdminInterface($base='modal.relaciones.xsl');

			$objectPhotos = Multimedia::getMultimediasByObjectId(
				array(
					'object_id' => $object_id,
					'module'    => 'photo',
				)
			);
			self::$template->setcontent($objectPhotos, null, 'object');

			$options = array(
					'query'       => $query,
					'type_id'     => PhotoModel::$multimedia_typeid,
					'currentPage' => (int)$current,
					'module'      => 'photo',
					'model'       => 'PhotoModel',
					'display'     => 10,
					'table'       => PhotoModel::$table,
					'state'       => false,
					'categories'  => $category,
				);
			$photos = Multimedia::Search($options);

			$CategoriesFilters = Photo::GetCategoriesFilter($options);
			self::$template->setcontent($CategoriesFilters, null, 'filter');
			self::$template->setcontent($photos, null, 'photos');

			self::$template->setparam('object_id', $object_id);
			self::$template->setparam('category_id', $category);
			self::$template->setparam('pagina', $current);
			self::$template->setparam('query', $query);
			self::$template->setparam('isSearch', 1);
			self::$template->display();
		endif;
	}

	public static function BackSetRelation()
	{
		$options = array(
			'object_id'     => Util::getvalue('object_id'),
			'multimedia_id' => Util::getvalue('multimedia_id')
		);

		Multimedia::setMultimediaByObjectId($options);

		$object_typeid = Object::getTypeByObjectId($options['object_id']);

		$module = ConfigurationManager::Query("/configuration/modules/module[@type_id='".$object_typeid."']");
		PhotoCache::GenerateSizes($options['multimedia_id'],$module->item(0)->getAttribute('name'));

		echo "1";
	}

	public static function BackRefreshRelation()
	{
		$object_id = Util::getvalue('object_id');
		parent::loadAdminInterface($base='ajax.manager.xsl');
		self::$template->setcontent(Multimedia::getMultimediasByObjectId(array('object_id'=>$object_id)), null, 'object');
		self::$template->setparam('call', 'refresh');
		self::$template->setparam('object_id', $object_id);
		self::$template->display();
	}
	
	public static function BackDisplayRelationOrderModal()
	{
		$object_id = Util::getvalue('object_id');
		$category_id   = Util::getvalue('category_id');

		parent::loadAdminInterface($base='modal.ordenar.xsl');
		if($object_id):
			$photos = Multimedia::getMultimediasByObjectId(array('object_id'=>$object_id, 'module'=>'photo'));
			self::$template->setcontent($photos, null, 'object');
			self::$template->setparam('object_id', $object_id);
			self::$template->setparam('category_id', $category_id);
			self::$template->display();
		endif;
	}
	
	public static function BackObjectRelationsOrder()
	{
		$DTO = array();
		$DTO['object_id'] = Util::getvalue('object_id');
		$DTO['category_id'] = Util::getvalue('category_id');
		$DTO['order'] = Util::getvalue('order');

		Photo::setRelationOrder($DTO);
		Util::debug($DTO);
	}







	
	
	/* Front end */

	public static function FrontDisplayDefault(){
		exit();
	}



	

}
?>
