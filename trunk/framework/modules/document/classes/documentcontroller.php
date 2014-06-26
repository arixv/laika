<?php
class DocumentController extends MultimediaController
{

	/**
	* Display a List of Objects
	* @return none
	**/
	public static function BackDisplayDefault()
	{	
		$currentPage = Util::getvalue('page', 1);
		$state       = Util::getvalue('state', 'false');
		$categories  = Util::getvalue('categories', 'false');

		$options = array(
				'module'     => 'document',
				'model'		 => 'DocumentModel',
				'table'		 => DocumentModel::$table,
				'type_id'	 => DocumentModel::$multimedia_typeid,
				'currentPage' => $currentPage,
				'display'	 => 20, 
				'state'		 => ($state != 'false') ? $state : false, 
				'categories' => ($categories != 'false') ? $categories : false,
				//'debug'     => true,
		);

		$Collection = Document::GetList($options);

		$CategoriesFilters = Document::GetCategoriesFilter($options);

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
			'model'         => 'DocumentModel',
			'module'        => 'document',
			'type_id'       => DocumentModel::$multimedia_typeid,
			'table'         => DocumentModel::$table,
			'multimedia_id' => Util::getvalue('id'),
			'categories'    => true,
			'relations'     => true,
			'debug'         => false,
		);
		$document = Document::getById($options);

		if($document):
			parent::loadAdminInterface();
			self::$template->setcontent($document, null, 'document');
			self::$template->add("edit.xsl");
			self::$template->display();
		else:
			Application::Route(array('module'=>'document'));
		endif;		
	}

	public static function BackEdit()
	{
		$objectEdited  = Document::edit(
			$options = array(
				'data'		=> $_POST,
				'model' 	=> 'DocumentModel',
				'table' 	=> DocumentModel::$table,
				'verbose' 	=> true
			)
		);

		$display = array(
			'back'       => (isset($_POST['back'])) ? 1 : 0,
			'item_id'    => $_POST['document_id'],
			'module'     => 'document',
		);

		Application::Route($display);
	}

	public static function BackDisplaySearch()
	{

		$query       = Util::getvalue('q', false);
		$page        = Util::getvalue('page', 1);
		$state       = Util::getvalue('state');
		$categories  = Util::getvalue('categories', false);

		parent::loadAdminInterface();

		$collection = Document::Search(
			array(
				'query'       => $query,
				'type_id'     => DocumentModel::$multimedia_typeid,
				'table'       => DocumentModel::$table,
				'currentPage' => $page,
				'display'     => 15,
				'model'       => 'DocumentModel',
				'state'       => $state,
				'categories'  => $categories,
			)
		);

		$CategoriesFilters = Document::GetCategoriesFilter(array('module'=>'document'));

		self::$template->setcontent($collection, null, 'collection');
		self::$template->setcontent($CategoriesFilters, null, 'filter');
		self::$template->setparam("state", $state);
		self::$template->setparam("query", $query);
		self::$template->setparam("category_id", $categories);
		self::$template->add("list.xsl");
		self::$template->display();
	}

	public static function BackUpload()
	{

		$options = array(
			'module'       => 'document',
			'folderoption' => 'target',
			'user_id'      => (isset($_POST['user_id'])) ? $_POST['user_id'] : 0,
			'user_type'    => (isset($_POST['user_type'])) ? $_POST['user_type'] : '',
			'type_id'      => DocumentModel::$multimedia_typeid,
		);

		$multimedia = MultimediaController::Upload($options);

		if($multimedia['uploaded'] === true){

			$basicUpload = Util::getvalue('simple_upload', false);
			$redirect    = Util::getvalue('redirect', false);

			$category_id = Util::getvalue('category_id');
			$object_id   = Util::getvalue('object_id');
			
			$categoriesConfig = ConfigurationManager::query("/configuration/modules/module[@name='document']/options/group[@name='categories']/option");

			$categories = array();
			if($categoriesConfig)
			{

				foreach($categoriesConfig as $option){
					if($option->getAttribute('type') == 'default'){
						$options = array(
							'multimedia_id' => $multimedia['multimedia_id'],
							'categories'    => array($option->getAttribute('value'))
						);
						Document::setCategoriesByMultimediaId($options);
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
			}

			if(!$basicUpload){

				$response = array(
					'status'     => 'ok',
					'type'       => 'document',
					'generated'  => $multimedia['target'],
					'data'       => $multimedia,
					'categories' => $categories,
				);
				echo json_encode($response);
				die;
			}
			else
			{
				Application::Route(
					array(
						'module'  => 'document', 
						'item_id' => $multimedia['multimedia_id'], 
						'back'    => 0,
						'url'     => Util::getvalue('url', false),
					)
				);
			}
		}
		else{
			echo json_encode($multimedia);
			die;
		}
	}

	public static function BackUpdateBundle()
	{
		$photos = $_POST;
		$url = Util::getvalue('url', false);

		foreach($_POST['ids'] as $key=>$id):
			$DTO['document_title']   = $photos['title_'.$id];
			$DTO['document_id']      = $id;

			if(isset($photos['categories_'.$id]) && count($photos['categories_'.$id])):
				foreach($photos['categories_'.$id] as $cat):
					$DTO1['multimedia_id'] = $id;
					//$DTO1['parent_id']     = $photos['parent_'.$cat.'_'.$id];
					$DTO1['category_id']   = $cat;
					Document::setCategoryByMultimediaId($DTO1);
				endforeach;
			endif;

			$defaults = array(
					'data'		=> $DTO,
					'model' 	=> 'DocumentModel',
					'table'     => DocumentModel::$table,
					'verbose' 	=> false
			);
			Document::Edit($defaults);
		endforeach;

		Application::Route(array('module'=>'document', 'url'=>$url));
	}


	public static function BackDisplayRelationModal()
	{
		$object_id 	  = Util::getvalue('object_id');
		$category_id  = Util::getvalue('category_id',false);
		$parent   	  = Util::getvalue('parent',false);
		$currentPage  = Util::getvalue('page', 1);

		parent::loadAdminInterface($base='modal.relations.xsl');


		if($object_id):

			$options = array(
					'module'      => 'document',
					'model'		  => 'DocumentModel',
					'table'		  => DocumentModel::$table,
					'type_id'	  => DocumentModel::$multimedia_typeid,
					'currentPage' => $currentPage,
					'display'	  => 5, 
					'state'		  => false, 
					'categories'  => ($category_id != 'false') ? $category_id : false,
					'parent'      => ($parent != 'false') ? $parent : false,
					'debug'       => false,
			);

			$CategoriesFilters = Document::GetCategoriesFilter($options);

			self::$template->setcontent($CategoriesFilters, null, 'filter');
			self::$template->setcontent(Document::GetList($options), null, 'documents');
			self::$template->setcontent(Category::GetById($parent), null, 'category');
			
			if($parent):
				self::$template->setparam('parent', 1);
			endif;
			
			$objectConf = ConfigurationManager::GetModuleConfigurationByType(Object::getTypeByObjectId($object_id));

			self::$template->setcontent(
				Document::getMultimediasByObjectId(
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

	public static function BackModalSearch()
	{
		$object_id = Util::getvalue('object_id');
		$category  = Util::getvalue('category_id');

		$current  = Util::getvalue('page', 1);
		$query    = Util::getvalue('q');

		
		if($object_id):

			parent::loadAdminInterface($base='modal.relations.xsl');

			$objectMultimedias = Document::getMultimediasByObjectId(
				array(
					'object_id' => $object_id,
					'module'    => 'document',
				)
			);
			self::$template->setcontent($objectMultimedias, null, 'object');

			$options = array(
					'query'       => $query,
					'type_id'     => DocumentModel::$multimedia_typeid,
					'currentPage' => (int)$current,
					'module'      => 'document',
					'model'       => 'DocumentModel',
					'display'     => 10,
					'table'       => DocumentModel::$table,
					'state'       => false,
					'categories'  => $category,
				);
			$collection = Multimedia::Search($options);

			$CategoriesFilters = Document::GetCategoriesFilter($options);
			self::$template->setcontent($CategoriesFilters, null, 'filter');
			self::$template->setcontent($collection, null, 'documents');

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
		echo "1";
		
		//$object_typeid = Object::getTypeByObjectId($options['object_id']);

		//$module = ConfigurationManager::Query("/configuration/modules/module[@type_id='".$object_typeid."']");
		//PhotoCache::GenerateSizes($options['multimedia_id'],$module->item(0)->getAttribute('name'));

		
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

		parent::loadAdminInterface($base='modal.order.xsl');
		if($object_id):
			$photos = Multimedia::getMultimediasByObjectId(array('object_id'=>$object_id, 'module'=>'document'));
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

		Document::setRelationOrder($DTO);
		Util::debug($DTO);
	}




	
	
	/* Front end */

	

	public static function Download()
	{
		$document_id = Util::getvalue('document_id');
		$options = array(
			'model'         => 'DocumentModel',
			'module'        => 'document',
			'type_id'       => DocumentModel::$multimedia_typeid,
			'table'         => DocumentModel::$table,
			'multimedia_id' => $document_id,
			'categories'    => true,
			'relations'     => true,
			'debug'         => false,
		);
		$doc          = Document::getById($options);
		$moduleConfig = ConfigurationManager::GetModuleConfiguration('document');
		$folder       = ConfigurationManager::Query("/module/options/group[@name='folders']/option[@name='target']", $moduleConfig);
		$docpath      = PathManager::GetApplicationPath().'/'.$folder->item(0)->nodeValue.'/'.substr($document_id, - 1).'/'.$document_id.'.'.$doc['type-att'];

		switch($doc['type-att'])
		{
			case "pdf": $ctype="application/pdf"; break;
			case "exe": $ctype="application/octet-stream"; break;
			case "zip": $ctype="application/zip"; break;
			case "docx":
			case "doc": $ctype="application/msword"; break;
			case "xlsx":
			case "xls": $ctype="application/vnd.ms-excel"; break;
			case "pptx":
			case "ppt": $ctype="application/vnd.ms-powerpoint"; break;
			default: $ctype="application/force-download";
		}
		
		header("Pragma: public"); // required
		header("Expires: 0");
		header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
		header("Cache-Control: private",false); // required for certain browsers
		header("Content-Type: $ctype");
		header('Content-Disposition: attachment;filename="'.$doc['title'].'.'.$doc['type-att'].'"');
		header("Content-Transfer-Encoding: binary");
		header('Content-Length: '.$doc['size-att']);

		$fp=fopen($docpath,'r');
		fpassthru($fp);
		fclose($fp);
		exit();
	}
	
}
?>
