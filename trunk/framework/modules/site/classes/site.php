<?php
class Site extends Module
{
	static $cacheFolder = 'sites';
	
	public static function getList()
	{
		$cacheKey = 'sites.list';
		$cacheFolder = 'sites';
		$expires  = '86400'; // 1 dia
		
		if(!($return = Cache::getKey($cacheKey, self::$cacheFolder))):

			$fields = array('*');
			$fields = SiteModel::getFields($fields, SiteModel::$table);
			$params = array(
						'fields'=>$fields,
						'table'=>SiteModel::$table,
						'orderby'=>'id DESC'
			);
			$return = self::select($params,false);
			$return['tag'] = 'site';

			Cache::setKey($cacheKey, $return, $expires, self::$cacheFolder);
		endif;

		return $return;
	}


	// Get by id
	public static function getById($id=1)
	{
		if($id)
		{
			$cacheKey = 'sites.id.'.$id;
			$cacheFolder = 'sites';
			$expires  = '86400'; // 1 dia

			if(!$object = Cache::getKey($cacheKey, self::$cacheFolder)):
				$fields = array('*');
				$fields = SiteModel::getFields($fields, SiteModel::$table);
				$params = array('table'=>SiteModel::$table, 'filters'=>array('id='.$id), 'fields'=>$fields);
				$r = self::select($params,false);
				if(isset($r[0])):
					$object = $r[0];
				else:
					return false;
				endif;

				Cache::setKey($cacheKey, $object, $expires, self::$cacheFolder);

			endif;

			return $object;


		}else{
			return false;
		}

	}


	// Get by Preffix
	public static function GetByPreffix($preffix='ar')
	{
		if($preffix)
		{
			$cacheKey = 'site.'.$preffix;
			$cacheFolder = 'sites';
			$expires  = '86400'; // 1 dia

			if(!$object = Cache::getKey($cacheKey, self::$cacheFolder)):
				$fields = array('*');
				$fields = SiteModel::getFields($fields, SiteModel::$table);
				$params = array('table'=>SiteModel::$table, 'filters'=>array('preffix="'.$preffix.'"'), 'fields'=>$fields);
				$r = self::select($params,false);
				if(isset($r[0])):
					$object = $r[0];
				else:
					return false;
				endif;

				Cache::setKey($cacheKey, $object, $expires, self::$cacheFolder);

			endif;

			return $object;


		}else{
			return false;
		}

	}
	
}

?>
