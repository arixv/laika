<?php

Class Rewrite
{

	public static function parseURL()
	{
		Application::setFrontend();

		$ConfigurationSites = ConfigurationManager::Query('/configuration/sites/site');


		if($_SERVER["SERVER_NAME"] == "educacao.brajobs.com"):
			$BrasilConfig = ConfigurationManager::Query('/configuration/sites/site[title="Brasil"]');
			$mySite['id'] = $BrasilConfig->item(0)->getAttribute('id');
			foreach($BrasilConfig->item(0)->childNodes as $node){
				$mySite[$node->nodeName] = $node->nodeValue;
			}
			Session::set("site",$mySite);


			// if($_SERVER['REQUEST_URI'] == '/'):
			// 	Util::redirect('/'.$mySite["preffix"]);
			// endif;
			//util::debug($mySite);die;
		endif;

		$sessionSite = Session::get('site');


		//***********  Esto esta configurado solo para que ande el sitio para ARGENTINA ****** //
		if(!is_array($sessionSite) && $_SERVER['REQUEST_URI'] == '/'):
			Util::redirect('/argentina');
			die;
		endif;
		//******************//



		if(is_array($sessionSite) && $_SERVER['REQUEST_URI'] == '/'):
			Util::redirect('/'.$sessionSite['preffix']);
			die;
		else:
			$ffound=0;

			
			foreach($ConfigurationSites as $configSite):
				$Preffix = ConfigurationManager::Query('preffix',$configSite);
				$Preffix = $Preffix->item(0)->nodeValue;
				$pattern = '#^\/'.$Preffix.'#';

				if(preg_match($pattern,$_SERVER['REQUEST_URI'], $matches)):
					$mySite['id'] = $configSite->getAttribute('id');
					foreach($configSite->childNodes as $node)
					{
						$mySite[$node->nodeName] = $node->nodeValue;
					}
					if(isset($mySite['#text'])):unset($mySite['#text']);endif;
					Session::set('site',$mySite);
					$ffound = 1;
				endif;
			endforeach;



			if(!$ffound && $_SERVER['REQUEST_URI'] !== '/seleccionar-pais'):
				Util::redirect('/seleccionar-pais');
				die;
			endif;
		endif;
	


		$modules = ConfigurationManager::Query('/configuration/modules/module');


		foreach($modules as $module):

			$rules = ConfigurationManager::query('rewrite/frontend/rule', $module);

			if($rules):

				$controller = $module->getAttribute('controller');
				$name       = $module->getAttribute('name');
				$debug      = ($module->getElementsByTagName('rewrite')->item(0)->getAttribute('debug') == 1)?1:0;

				if($debug):
					echo "module: ".$name."<br/>";
					echo "Controller: ".$controller."<br/>";
				endif;


				if(isset($rules->length)):

					foreach($rules as $rule):					
						self::MatchRule($rule, $controller, $name, $access_level=false, $debug);
					endforeach;

				else:
					self::MatchRule($rules, $controller, $name, $access_level=false, $debug);
				endif;



			endif;
		endforeach;

		//Util::redirect('/error/404/?ref='.$_SERVER['REQUEST_URI']);
	}



	public static function parseAdminURL()
	{
		Application::ValidateAdminUser();

		$subject = $_SERVER['REQUEST_URI'];
		$params = explode('/', $subject);
		$adminPath = $params[1];
		$moduleName = $params[2];

		$moduleConfiguration = ConfigurationManager::Query('/configuration/modules/module');

		foreach($moduleConfiguration as $module):

			$rules = ConfigurationManager::query('rewrite/backend/rule', $module);
			
			if($rules):

				$controller = $module->getAttribute('controller');
				$name       = $module->getAttribute('name');
				$debug      = ($module->getElementsByTagName('rewrite')->item(0)->nodeValue == 1)?1:0;


				if($debug):
					echo "module: ".$name."<br/>";
					echo "Controller: ".$controller."<br/>";
				endif;

				// $user  = Admin::isLoguedIn();
				// Util::debug($user);

				foreach($rules as $rule):
					
					if($rule->getAttribute('access_level') != ''):
						$access_level = $rule->getAttribute('access_level');
					else:
						$access_level = false;
					endif;

					$match = $rule->getAttribute('match');
					$match = str_replace('{$adminPath}', $adminPath, $match);
					$match = str_replace('{$moduleName}', $moduleName, $match);
					$rule->setAttribute('match', $match);
					self::MatchRule($rule, $controller, $name, $access_level, $debug);
				endforeach;
				
			else:	
				//echo 'no rules<br/>';
			endif;

		endforeach;


		// Si la regla no existe en el modulo, me fijo si es generica
		$Configuration = ConfigurationManager::Query('/configuration/adminpath');
		
		if($adminPath == str_replace('/', '', $Configuration->item(0)->nodeValue)){
			$module =  ConfigurationManager::Query('/configuration/modules/module[@name = "'.$moduleName.'"]');
			
			if(!$module)
			{
				//echo 'module not exists';
				//die;
			}
			elseif($module->item(0)->getAttribute('active') == 1)
			{
				//echo $module->item(0)->getAttribute('active');
				$conf  = ConfigurationManager::Query('/configuration/rewrite');
				$debug = $conf->item(0)->getAttribute('debug');

				$rules = ConfigurationManager::Query('/rewrite/backend/rule', $conf->item(0));
				$controller = $module->item(0)->getAttribute('controller');
				
				foreach($rules as $rule):
					//echo $rule->getAttribute('match'),'<br/>';
					$match = $rule->getAttribute('match');
					$match = str_replace('{$adminPath}', $adminPath, $match);
					$match = str_replace('{$moduleName}', $moduleName, $match);
					$rule->setAttribute('match', $match);
					self::MatchRule($rule, $controller, $moduleName, $access_level=false, $debug);
				endforeach;

			}else {
				//echo 'module no active';
				//die;
			}

		}
		
		


	}
	
	
	public static function MatchRule($rule, $controller, $module, $access_level=false, $debug)
	{
		$subject = $_SERVER['REQUEST_URI'];
		//echo "<p>subject: ". $subject;
		//Util::debug(parse_url($subject));
		
		$rulematch = $rule->getAttribute('match');
		//$rulematch = str_replace('{$adminPath}', 'admin', $rulematch);

		
		$pattern = '#'.$rulematch.'#';
		$replace = ($rule->getAttribute('args')!='')?$rule->getAttribute('args'):false;
		$method  = $rule->getAttribute('apply');

		//echo '<p>pattern: '.$pattern;
		//echo '<p>subjects: '.$subject;
		//echo '<p>matches: '.$matches;

		if(preg_match($pattern, $subject, $matches)):

			if($debug):
				Util::debug($rulematch);
				Util::debug($rule->getAttribute('args'));
				Util::debug($rule->getAttribute('apply'));
				echo preg_replace($pattern, $replace, $subject);
			endif;

			if($access_level):
				if($user = Admin::isLoguedIn()):
					$user_access   = $user['access-att'];
					$rule_access   = $rule->getAttribute('access_level');
					$rule_redirect = $rule->getAttribute('redirect');
					if(strpos($rule_access, $user_access) === false):
						if($rule_redirect != ''):
							$conf = ConfigurationManager::Query('/configuration/adminpath');
							$adminFolder = $conf->item(0)->nodeValue;
							Util::redirect($adminFolder.$module.$rule_redirect);
						endif;

						die("You dont have access to this area");
					endif;
				endif;
			endif;

			if($replace):
				$args = preg_replace($pattern, $replace, $subject);
				$args = str_replace('?','',$args);
				$args = explode('&', $args);

				$namedArgs = array();
				foreach($args as $argument):
					$thisArg = explode('=', $argument);
					if(isset($thisArg[0]) && isset($thisArg[1])):
						$namedArgs[$thisArg[0]] = $thisArg[1];
					endif;
				endforeach;

				call_user_func_array(array((string)$controller,(string)$method), $namedArgs);
			else:

				// echo 'call_user_func<br>';
				// echo (string)$controller.'<br>';
				// echo (string)$method.'<br>';	

				call_user_func(array((string)$controller,(string)$method));
			endif;
			die();
		endif;


	}
	
}

?>