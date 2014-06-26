<?php
class Util {

	
	public static function debug($m){
		echo "<pre>";
		print_r($m);
		//var_export($m);
		echo "</pre>";
	}

	public static function debugXML($m)
	{
		$out = new DOMDocument();
		$dom_sxe = $out->importNode($m, true);
		$out->appendChild($dom_sxe);
		header("Content-type:text/xml");
		echo $out->saveXML();		
	}
	
	public static function redirect($location)
	{
		header('location:'.$location);
		die;
	}
	
	public static function getvalue($name,$default=false,$nosession=false) 
	{

		// Check if caller function is reciving the param
		$trace = debug_backtrace();

		if(isset($trace[2]['args'][1][$name]) && $trace[2]['args'][1][$name] != '')
		{
			return $trace[2]['args'][1][$name];
		}
		if(isset($_POST[$name]) && $_POST[$name] != '')
		{
			return Util::noInjection($_POST[$name]);
		}
		elseif(isset($_GET[$name]) && $_GET[$name] != '')
		{
			return Util::noInjection($_GET[$name]);
	    } 
		else
		{
			return $default;
		}
	}


	public static function getPost($name,$default=false,$nosession=false) 
	{

		// Check if caller function is reciving the param
		$trace = debug_backtrace();

		if (isset($_POST[$name]))
			return util::noInjection($_POST[$name]);
		else
			return false;
	}
	
	public static function extend($defaults,$options) {
		$extended = $defaults;
		if(is_array($options) && count($options)) {
			$extended = array_merge($defaults,$options);
		}
		return $extended;
	}

	public static function getdaybydate($date){
		return date("l", mktime(0,0,0, substr($date, 5, 2), substr($date, 8, 2), substr($date, 0, 4)));
	}

	public static function quote($string){
		$res = (get_magic_quotes_gpc())?stripslashes($string):$string;
		return "'".$res."'";
	}

	public static function isAdmin()
	{
		$conf = ConfigurationManager::Query('/configuration/adminpath');
		$manager = $_SERVER['PHP_SELF']; /* Ruta del archivo ejecutado */
		$adminFolder = $conf->item(0)->nodeValue;

		if(stristr($manager, $adminFolder)):
			return true;
		else:
			return false;
		endif;
	}




	public static function normalize($string)
	{
		$string = str_replace('á', 'a', $string);
		$string = str_replace('é', 'e', $string);
		$string = str_replace('í', 'i', $string);
		$string = str_replace('ó', 'o', $string);
		$string = str_replace('ú', 'u', $string);
		$string = str_replace('ñ', 'n', $string);
		return $string;
	}
	
	
	

	public static function redirectto($url) {
	    if (strstr($_SERVER["SERVER_SOFTWARE"],"Apache/2")) {
	        if (substr($url,0,strlen('http'))!='http') {
	            if (substr($url,0,strlen('/'))!='/') {
	                $url='http://'.$_SERVER['SERVER_NAME'].self::getbaseurl($_SERVER['REQUEST_URI']).$url;
	            } else {
	                $url='http://'.$_SERVER['SERVER_NAME'].$url;
	            }
	        }
	    } else {
	        if (substr($url,0,strlen('http'))!='http') {
	            if (substr($url,0,strlen('/'))!='/') {
	                $url=getbaseurl($_SERVER['SCRIPT_URI']).$url;
	            } else {
	                $url='http://'.$_SERVER['SERVER_NAME'].$url;
	            }
	        }
	    }
	    header("Location: $url");
	    print "<a href=$url>$url</a>";
	    exit;
	}
	
	public static function getbaseurl($url) {
	    return substr($url,0,strrpos($url,'/')).'/';
	}
	
	public static function htmlescape($string)
	{
		return htmlspecialchars($string, ENT_COMPAT, 'UTF-8');
	}

	public static function Reflection($classname){
			$class = new ReflectionClass($classname);

			printf(
				"	<font size='2' face='verdana' style='color:black;'><b>La %s%s%s %s '%s' [Extiende de %s] <br/>" .
				"	Está declarada en este archivo %s <br/>" .
				"	En las lineas de la %d hasta la %d <br/>" .
				"	Teniendo estos Modificadores %d [%s] <br/> </font>",
					$class->isInterface() ? 'Interface' : 'Clase',
					$class->isAbstract() ? ' Abstracta' : '',
					$class->isFinal() ? ' Final' : '',
					$class->isInternal() ? 'internal' : 'Definida por el Usuario',
					$class->getName(),
					var_export($class->getParentClass(),1),
					$class->getFileName(),
					$class->getStartLine(),
					$class->getEndline(),
					$class->getModifiers(),
					implode(' ', Reflection::getModifierNames($class->getModifiers()))
			);

			// Print documentation comment
			printf("<font size='2' face='verdana' style='color:black;'><b>Documentacion</b></font> %s<br/>", var_export($class->getDocComment(), 1));

			// Print which interfaces are implemented by this class
			printf(" <font size='2' face='verdana' style='color:black;'><b>Implementa</b></font> %s<br/>", var_export($class->getInterfaces(), 1));

			// Print class constants
			printf(" <font size='2' face='verdana' style='color:black;'><b>Constantes</b></font> %s<br/>", var_export($class->getConstants(), 1));

			// Print class properties
			printf(" <font size='2' face='verdana' style='color:black;'><b>Atributos</b></font> <br/>");
			// Print class methods
				$array = $class->getProperties();
				foreach( $array as $method){
					echo "<font size='2px' face='verdana' style='color:blue;margin-top:1px;margin-left:20px;'>".$method->getName()."</font><br/>";
				}
			
			printf(" <font size='2' face='verdana' style='color:black;'><b>Metodos</b></font> <br/>");
			// Print class methods
				$array = $class->getMethods();
				foreach( $array as $method){
					echo "<font size='2px' face='verdana' style='color:blue;margin-top:1px;margin-left:20px;'>".$method->getName()."</font><br/>";
				}
			

			// If this class is instantiable, create an instance
			if ($class->isInstantiable()) {
				$classnames = $class->newInstance();

				echo $classname."<font size='2' face='verdana' style='color:black;'><b>Tiene Instancias?</b></font> <br/>"; 
				echo $class->isInstance($classnames) ? "<font size='2' face='verdana' style='color:black;'><b>Yes</b></font> <br/>" : "<font size='2' face='verdana' style='color:black;'><b>No</b></font> <br/>";
			}
		}
		
		
	public static function friendlyURL($string){
		$string = strtolower($string);
		$string = str_replace('#','',$string);
		$string = str_replace('ñ','n',$string);
		$string = str_replace('"','',$string);
		$string = str_replace('¨','',$string);
		$string = str_replace("'",'',$string);
		$string = str_replace(',','',$string);
		$string = str_replace('&','n',$string);
		$string = str_replace('!','',$string);
		$string = str_replace('+','',$string);
		$string = str_replace('<br/>','-',$string);
		$string = str_replace(':','',$string);
		$string = str_replace('.','',$string);
		$string = str_replace(' ','-',$string);
		$string = str_replace('á','a',$string);
		$string = str_replace('à','a',$string);
		$string = str_replace('ä','a',$string);
		$string = str_replace('é','e',$string);
		$string = str_replace('è','e',$string);
		$string = str_replace('ë','e',$string);
		$string = str_replace('í','i',$string);
		$string = str_replace('ï','i',$string);
		$string = str_replace('ì','i',$string);
		$string = str_replace('ó','o',$string);
		$string = str_replace('ö','o',$string);
		$string = str_replace('ò','o',$string);
		$string = str_replace('ú','u',$string);
		$string = str_replace('ü','u',$string);
		$string = str_replace('ù','u',$string);
		$string = str_replace('ç','c',$string);
		$string = str_replace('/','-',$string);	
		$string = str_replace('---','-',$string);
		$string = str_replace('--','-',$string);
		return $string;
	}


	public static function noInjection($param)
	{
	    $forbidden=array(
	    	"<",
	    	">",
	    	"'",
	    	'"',
	    	'\\',
	    	'(',
	    	')',
	    	"%",
	    	"*",
	    	"´",
	    	"`",
	    	"=",
	    	';',
	    );

	    if(is_array($param)){
	    	foreach($param as $key=>$item){
	    		for ($i=0; $i<count($forbidden); $i++) 
		    	{
			 		$repl=$forbidden[$i];
				 	$param[$key]=str_replace($repl,"",$item);	 
		    	}
			 	$param[$key] = strip_tags($param[$key]);
	    	}
	    	return $param;
	    }else{
	    	for ($i=0; $i<count($forbidden); $i++) 
	    	{
		 		$repl=$forbidden[$i];
			 	$param=str_replace($repl,"",$param);	 
	    	}
			$param = strip_tags($param);
	   		return ($param);
	    }

    	
	}

	

}
?>