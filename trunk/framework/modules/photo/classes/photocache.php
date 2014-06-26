<?php
class PhotoCache {

	protected static $generatedDir;
	protected static $photoId;
	protected static $cropQuality;
	protected static $resizeQuality;


	static function generate($photo_id, $photo_src, $options)
	{
		$defaults = array(
			'module' => 'photo',
			'folderoption' => 'generated'
		);

		$options = Util::extend(
			$defaults,
			$options
		);

		$realPath = PathManager::GetContentTargetPath($options);
		$folder   = PathManager::GetDirectoryFromId($realPath, $photo_id);

		// Generate Sizes 
		$images = ConfigurationManager::Query("/configuration/modules/module[@name='".$options['module']."']/options/group[@name='images']/option");

		self::CreateSizes($images, $photo_id, $photo_src, $folder);
		/*if($images){
			foreach($images as $image){
				$targetFile = $folder. '/' . $photo_id . $image->getAttribute('suffix');
				$img = new Image();
				$img->load($photo_src);
				$width  = (int)$image->getAttribute('width');
				$height = (int)$image->getAttribute('height');
				if($image->getAttribute('type') == 'crop')   { $img->crop($width, $height); }
				if($image->getAttribute('type') == 'resize') { $img->resize($width, $height); }
				$img->save($targetFile, (int)$image->getAttribute('quality'));
			}
		}*/

		// Image usage
		/*
			$img = new Image();
			$img->load($file);
			$img->crop(40, 600); //or $img->resize($percent);
			//$img->rotate(180);
			//$img->caption('Caption text.', PathManager::GetModulePath().'/desktop/Arial.ttf', 25, 50, true);
			//$img->logo(PathManager::GetModulePath().'/desktop/logonike.png', '', '', 0, 5);
			//$img->save($filePath, (int)self::$resizeQuality);
			$img->display();
		*/
	}

	static function GenerateSizes($photo_id, $module)
	{
		$Site 		 = Session::get("backend_site");

		// Get source file
		$options = array(
			'module' => 'photo',
			'folderoption' => 'target',
			'site_preffix' => $Site["preffix"]
		);

		$realPath = PathManager::GetContentTargetPath($options);

		$folder   = PathManager::GetDirectoryFromId($realPath, $photo_id);

		$photoOptions = array(
			'multimedia_id' => $photo_id,
			'model'         => 'PhotoModel',
			'table'         => PhotoModel::$table,
			'module'        => 'photo',
			'relations'     => false,
			'multimedias'   => false,
			'categories'    => false
		);

		$photo     = Multimedia::GetById($photoOptions);
		$photo_src = $folder.'/'.$photo_id.'.'.$photo['type-att'];

		$options['folderoption'] = 'generated';
		$realPath = PathManager::GetContentTargetPath($options);
		$folder   = PathManager::GetDirectoryFromId($realPath, $photo_id);

		$images    = ConfigurationManager::Query("/configuration/modules/module[@name='".$module."']/options/group[@name='images']/option");
		self::CreateSizes($images, $photo_id, $photo_src, $folder);
	}


	static function CreateSizes($images=false, $photo_id, $photo_src, $folder)
	{
		if($images){
			foreach($images as $image){
				$targetFile = $folder. '/' . $photo_id . $image->getAttribute('suffix');
				
				$img = new Image();
				$img->load($photo_src);
				$width  = (int)$image->getAttribute('width');
				$height = (int)$image->getAttribute('height');
				if($image->getAttribute('type') == 'crop')   { $img->crop($width, $height); }
				if($image->getAttribute('type') == 'resize') { $img->resize($width, $height); }
				$img->save($targetFile, (int)$image->getAttribute('quality'));
			}
		}
	}


	/*
	@deprecated
	static function GenerateSizes($photo_id,$module_name,$fullPath=false,$user_id=false)
	{
		self::$photoId= $photoId;

		if(!$fullPath):
			$photo = Photo::getById($photoId);
			//$thisConf = ConfigurationManager::GetModuleConfiguration(basename(dirname(dirname(__FILE__))));
			$source_dir = self::getSourcePath();
			$photoFullPath = $source_dir.'/'.substr($photoId, -1).'/'.$photoId.'.'.$photo['tipo-att'];
		else:
			$photoFullPath = $fullPath;
		endif;

		$data = array();
		$photo = array();

		$conf = ConfigurationManager::query("/configuration/modules/module[@name='".$module_name."']");
		
		$r = ConfigurationManager::query('/module/options/images/resize_quality/@value', $conf->item(0));
		$c = ConfigurationManager::query('/module/options/images/crop_quality/@value', $conf->item(0));

		self::$cropQuality   = $r->item(0)->nodeValue;
		self::$resizeQuality = $c->item(0)->nodeValue;
		
		
		$images = ConfigurationManager::query('/module/options/images/image', $conf->item(0));
		foreach ($images as $type){
			if($type->getAttribute('type') == 'resize'){
				
				$sizes = ConfigurationManager::query('/image/size', $type);
				foreach($sizes as $size){
					$filePath = self::getImagePath($size->getAttribute('prefix'));
					$img = new Image();
					$img->load($photoFullPath);
					$img->resize((int)$size->getAttribute('width'), (int)$size->getAttribute('height'));
					$img->save($filePath, (int)self::$resizeQuality);
				}	
			}

			if($type->getAttribute('type') == 'crop'){
				$sizes = ConfigurationManager::query('/image/size', $type);
				foreach($sizes as $size){
					$filePath = self::getImagePath($size->getAttribute('prefix'));
					$img = new Image();
					$img->load($photoFullPath);
					$img->crop((int)$size->getAttribute('width'), (int)$size->getAttribute('height'));
					$img->save($filePath, (int)self::$resizeQuality);
				}
			}
		}
	}*/

	/*static function GenerateHomeSizes($photoId,$conf,$fullPath=false,$user_id=false)
	{
		self::$photoId= $photoId;
		if(!$fullPath):
			$photo = Photo::getById($photoId);
			//$thisConf = ConfigurationManager::GetModuleConfiguration(basename(dirname(dirname(__FILE__))));
			$source_dir = self::getSourcePath();
			$photoFullPath = $source_dir.'/'.substr($photoId, -1).'/'.$photoId.'.'.$photo['tipo-att'];
		else:
			$photoFullPath = $fullPath;
		endif;

		$data = array();
		$photo = array();
		
		self::$cropQuality   = 95;
		self::$resizeQuality = 95;
		
		if(isset($conf->images)):
			foreach ($conf->images->image as $type){
				if($type['type']=='resize'){
					foreach($type->size as $size){
						$filePath = self::getImagePath($size['prefix']);
						$img = new Image();
						$img->load($photoFullPath);
						$img->resize((int)$size['width'], (int)$size['height']);
						$img->save($filePath, (int)self::$resizeQuality);
					}
				}
				if($type['type']=='crop'){
					foreach($type->size as $size){
						$filePath = self::getImagePath($size['prefix']);
						$img = new Image();
						$img->load($photoFullPath);
						$img->crop((int)$size['width'], (int)$size['height']);
						$img->save($filePath, (int)self::$resizeQuality);
					}
				}
			}
		endif;
	}*/
	


	static function GenerateCustomSize($photoId,$pos_x,$pos_y,$custom_width,$custom_height,$width,$height){
		
		self::$photoId= $photoId;
		$photo = Photo::getById($photoId);
		//$thisConf = ConfigurationManager::GetModuleConfiguration(basename(dirname(dirname(__FILE__))));
		$source_dir = self::getSourcePath();
		$photoFullPath = $source_dir.'/'.substr($photoId, -1).'/'.$photoId.'.'.$photo['tipo-att'];

		$filePath = self::getImagePath('_custom');
		$img = new Image();
		$img->load($photoFullPath);
		$img->customcrop($pos_x,$pos_y,$custom_width,$custom_height,$width,$height);
		$img->save($filePath, 100);

	}

	static function getImagePath($prefix)
	{
		// Get cache from configuration file
		$generated = ConfigurationManager::query("/configuration/modules/module[@name='".basename(dirname(dirname(__FILE__)))."']/options/folders/generated");
		self::$generatedDir = PathManager::GetApplicationPath().'/'.$generated->item(0)->nodeValue;

		$subdir = self::$generatedDir.'/'.substr(self::$photoId, -1);
		if (!is_dir($subdir)):
			mkdir($subdir, 0777);
		endif;
		//echo $subdir .'/'. self::$photoId . $prefix . ".jpg";
		return   $subdir .'/'. self::$photoId . $prefix;
	}
	
	static function getImagePathUser($prefix, $user_id)
	{
		// Get cache from configuration file
		$mod = ConfigurationManager::GetModuleConfiguration('users');
		self::$generatedDir = $_SERVER['DOCUMENT_ROOT'].'/'.(string)$mod->options->folders->generated;

		$subdir = self::$generatedDir.'/'.$user_id;
		if (!is_dir($subdir)):
			mkdir($subdir, 0777);
		endif;
		//echo $subdir .'/'. self::$photoId . $prefix . ".jpg";
		return   $subdir .'/'. self::$photoId . $prefix;
	}

	static function getSourcePath()
	{
		// Get cache from configuration file
		$source    = ConfigurationManager::query("/configuration/modules/module[@name='".basename(dirname(dirname(__FILE__)))."']/options/folders/source");
		$directory = PathManager::GetApplicationPath().'/'.$source->item(0)->nodeValue;

		return $directory;
	}

}


?>