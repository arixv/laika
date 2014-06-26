<?php
class MultimediaController extends Controller{

	public static function BackDisplayDefault(){}
	public static function FrontDisplayDefault(){}

	/* Categorizar */

	public static function BackDisplayCategoryModal()
	{
		$mid = Util::getvalue('mid');
		$parent_id = Util::getvalue('parent_id');
		$parent = Util::getvalue('parent', false);
		parent::loadAdminInterface($base='modal.categories.xsl');
		if($mid):
			$options = array(
				'multimedia_id' => $mid,
				'parent' 	    => false,
				'level' 	    => 0
			);


			self::$template->setcontent(Multimedia::getCategoriesByMultimediaId($options), null, 'multimedia');
			self::$template->setcontent(Category::getList($parent_id), null, 'categories');
			self::$template->setparam('mid', $mid);
			self::$template->setparam('parent', $parent_id);
			self::$template->display();
		endif;
	}

	public static function BackObjectCategory()
	{
		$DTO = array();
		$DTO['multimedia_id'] = Util::getvalue('mid');
		$DTO['parent_id'] = Util::getvalue('parent_id');
		$DTO['categories'] =$_REQUEST['categories'];
		Multimedia::setCategoriesByMultimediaId($DTO);
		Util::debug($DTO);
	}

	public static function BackRefreshCategories()
	{
		$multimedia_id = Util::getvalue('multimedia_id');
		$parent_id     = Util::getvalue('parent_id');
		parent::loadAdminInterface($base='ajax.manager.xsl');

		$options = array(
			'multimedia_id' => $multimedia_id,
			'parent' 	    => false,
			'level' 	    => 0
		);

		self::$template->setcontent(Multimedia::getCategoriesByMultimediaId($options), null, 'multimedia');
		self::$template->setparam('mid', $multimedia_id);
		self::$template->setparam('call', 'categories');
		self::$template->display();
	}

	public static function BackDisplayGroupCategoryModal()
	{
		$module     = Util::getvalue('module');
		$list       = Util::getvalue('list');
		$arr        = explode(',', $list);
		$categories = ConfigurationManager::Query("/configuration/modules/module[@name='".$module."']/options/group[@name='categories']/option");

		parent::loadAdminInterface($base='modal.categories.group.xsl');
		$arr['tag'] = 'id';
		self::$template->setcontent($arr, null, 'ids');

		$container = array();
		if($categories)
		{
			foreach($categories as $category){
				if($category->getAttribute('type') == 'parent')
				{
					$list = Category::getList($category->getAttribute('value'));
					array_push($container, $list);
				}
			}
			$container['tag'] = 'group';
			self::$template->setcontent($container, null, 'categories');
		}
		self::$template->display();

	}

	public static function BackSetCategoriesGroup()
	{
		$multimedias    = Util::getvalue('multimedias');
		$categories = Util::getvalue('categories');
		
		if(is_array($multimedias))
		{
			foreach($multimedias as $key=>$multimedia_id)
			{
				$dto = array(
					'multimedia_id'  => $multimedia_id,
					'categories' => $categories
				);
				Multimedia::setCategoriesByMultimediaId($dto);
			}
		}
		//Util::debug($categories);
		//Util::debug($objects);
		die;
	}


	public static function BackDeleteCategoryRelation()
	{
		$multimedia_id = Util::getvalue('multimedia_id');
		$category_id   = Util::getvalue('category_id');
		Multimedia::deleteCategory($multimedia_id, $category_id);
		echo "1";
	}


	/* Relaciones  */

	public static function BackChangeState(){
		$object_id = Util::getvalue('object_id');
		$object_state  = Util::getvalue('object_state');

		if($object_id && $object_state):
			$Object = array (
				"object_id"=> $object_id,
				"object_state"=> $object_state,
			);
			$return = Object::Edit($Object);
			echo $return;
		else:
			echo 0;
		endif;
	}

	public static function BackDeleteRelation()
	{
		$object_id   = Util::getvalue('object_id');
		$multimedia  = Util::getvalue('mid');
		if(is_numeric($object_id) && is_numeric($multimedia)):
			Multimedia::deleteRelation($object_id, $multimedia);
			echo "1";
		endif;
	}
	
	
	public static function BackDelete()
	{
		$item_id = Util::getvalue('item_id');
		if(is_numeric($item_id)):
			Multimedia::Remove($item_id);
			echo "1";
		endif;
	}

	public static function BackDeleteGroup()
	{
		$list = Util::getvalue('list');
		$arr  = explode(',', $list);
		if(is_array($arr) && !empty($arr)){
			foreach($arr as $key=>$item_id){
				Multimedia::Remove($item_id);
			}
		}
		echo "1";
		die;
	}


	/**
	* Upload Files
	*/
	public static function Upload($options)
	{
		$Site = Session::get("backend_site");

		$defaults = array(
			'module'       => 'multimedia',
			'folderoption' => 'target',
			'type_id'      => false,
			'user_id'      => 0,
			'user_type'    => '',
			'site_preffix' => $Site['preffix']
		);

		$options = Util::extend(
			$defaults,
			$options
		);
		
		if($options['type_id'] === false) Error::Alert('type_id is mandatory to upload files');

		$realPath = PathManager::GetContentTargetPath($options);

		if($realPath){

			$FileTemp = $_FILES['Filedata'];
			if($FileTemp['name'] !='' && $FileTemp['tmp_name'] !='')
			{
				$explode   = explode('.', $FileTemp['name']);
				$extension = strtolower($explode[count($explode)-1]);
				$weight    = filesize($FileTemp['tmp_name']);

				if(self::isAceptedExtension($extension, $options)){

					// Corrige el bug del mime-type y las imgs generadas
					if($extension == 'jpeg') $extension = 'jpg';
					
					$multimedia = array(
						'multimedia_title'  => $FileTemp['name'], 
						'multimedia_source' => $extension, 
						'multimedia_weight' => $weight, 
						'multimedia_typeid' => $options['type_id'], 
						'creation_date'     => date('Y-m-d H:i:s'),
						'creation_userid'   => $options['user_id'],
						'creation_usertype' => $options['user_type'],
					);
					$options['data'] = $multimedia;

					$multimedia_id = Multimedia::Add($options);
					$folder        = PathManager::GetDirectoryFromId($realPath, $multimedia_id);
					$targetFile    = $folder. '/' .$multimedia_id . '.' . $extension;

					//rename($FileTemp['tmp_name'], $targetFile);
					move_uploaded_file($FileTemp['tmp_name'], $targetFile);
					chmod($targetFile, 0775);

					$multimedia['multimedia_id'] = $multimedia_id;
					$multimedia['target']        = $targetFile;
					$multimedia['type']          = $extension;
					$multimedia['uploaded']      = true;

					return $multimedia;
				}

				$error = array(
					'uploaded' => false,
					'message'  => 'Extension not valid',
				);

			}

			$error = array(
				'uploaded' => false,
				'message'  => 'There was no file to upload',
			);

		}else{
			$error = array(
				'uploaded' => false,
				'message'  => 'Something went wrong. I could not get the target path.',
			);
		}
		return $error;
	}

	public static function isAceptedExtension($extension, $options){
		$isValid = false;
		$types = ConfigurationManager::query("/configuration/modules/module[@name='".$options['module']."']/options/group[@name='acepted_files']/option");

		foreach($types as $type):
			if($type->nodeValue == $extension):
				$isValid = true;
			endif;
		endforeach;
		return $isValid;
	}




}
?>