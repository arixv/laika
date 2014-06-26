<?php
class SearchController extends Controller implements ModuleController 
{
	
	public static function BackDisplayDefault()
	{
		
	}
	
	
	
	
	
	public static function FrontDisplayDefault()
	{
	}
	
	public static function FrontDisplaySearch()
	{
		$query        = Util::getvalue('q');
		$currentPage  = Util::getvalue('page', 1);

		if($query != ''):
			$search = Search::GetResult($query, $currentPage);
			$inteface = SkinController::loadInterface();
			$inteface->setcontent($search, null, 'search');
			$inteface->setparam('query', $query);
			$inteface->add('article/searchresult.xsl');
			$inteface->display();
		else:
			Util::redirect('/');
		endif;
	}
}
?>