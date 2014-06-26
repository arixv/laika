<?php
class XmlDoc
{
	/**
	*	@author: Claudio Romano Cherñac
	*	El funcionalidad de esta clase es pasar un array a xml.
	*	Para crear xml con un arbol muy complejo es necesario especificar el nombre del tag para vectores con indice numericos con el subindice 'tag'.
	*	EJ simple:
	*	array(
	*		'name'=>'Book Title',
	*		'pages'=>'530',
	*		'chapters'=>array(
	*			'0'=>'Title One',
	*			'1'=>'Title Two',
	*			'2'=>'Title Three',
	*			'tag'=>'chapter'
	*			)
	*	)
	*	The result is:
	*	<xml>
	*		<name>Book Title</name>
	*		<pages>530</pages>
	*		<chapters>
	*			<chapter>Title One</chapter>
	*			<chapter>Title Two</chapter>
	*			<chapter>Title Three</chapter>
	*		</chapters>
	*	</xml>
	**/

	private $xml;
	private $encoding;
	private $context;
	private $config;
	private $content;
	private $destinyChild;

	public $data;
	public $dom_tree;
	public $dom_tree2;


	public	function __construct(){

		$this->data = new DOMDocument("1.0", "UTF-8");
		$this->data->formatOutput = true;
		$this->dom_tree = $this->data->createElement('xml');
		$this->config   = $this->data->createElement('configuration');
		$this->context  = $this->data->createElement('context');
		$this->content  = $this->data->createElement('content');
		$this->dom_tree->appendChild($this->config);
		$this->dom_tree->appendChild($this->content);
		$this->dom_tree->appendChild($this->context);

		$this->data->appendChild($this->dom_tree);

	}

	/* Generar un xml sin la estructura del sistema*/
	public function newXML($root)
	{
		$this->data->removeChild($this->dom_tree);
		$this->dom_tree2 = $this->data->createElement((string)$root);
		$this->data->appendChild($this->dom_tree2);
	}

	public function generateCustomXml($array){
		if(!is_array($array)):
			throw new Exception('XmlDoc require an array', 1);
			unset($this);
		endif;
		$this->recurse_node($array, $this->dom_tree2);
	}

	public function generateXML($config, $content, $context){
		foreach(func_get_args() as $arg):
			if(!is_array($arg)):
				throw new Exception('XmlDoc require an array', 1);
				unset($this);
			endif;
		endforeach;

		$this->recurse_node($config, $this->config);
		$this->recurse_node($content, $this->content);
		$this->recurse_node($context, $this->context);
	}


	public function addXml($insertIn, $file, $xpath=false, $destinyChild=false)
	{

		$domDoc = new DOMDocument("1.0", "UTF-8");
		$domDoc->loadXML($file);
		$rootName = $domDoc->documentElement->tagName;


		// Add content to specified node
		if ($destinyChild && $destinyChild != $rootName){
			$node = $this->$insertIn->getElementsByTagName((string)$destinyChild);
			if($node->length == 0){
				//if node doesn't exist lets create it inside context
				$this->destinyChild = $this->data->createElement((string)$destinyChild);
				$this->$insertIn->appendChild($this->destinyChild);
			}else{
				//Otherwise we use the created node
				$this->destinyChild = $this->$insertIn->getElementsByTagName((string)$destinyChild)->item(0);
			}
		}

		$xp = new DOMXPath($domDoc);
		if($xpath){
			// Grab the node indicated
			$selectedNodes = $xp->query((string)$xpath);
			//Util::debug($selectedNodes);
			//$selectedNodes = $dom_sxe->getElementsByTagName((string)$xpath);
			foreach($selectedNodes as $tag) {
				$nodeImport = $this->data->importNode($tag, true);
				if($destinyChild){
					// Insert it to specified node
					$this->destinyChild->appendChild($nodeImport);
				}else{
					// Otherwise insert it to context
					$this->$insertIn->appendChild($nodeImport);
				}
			}
		}else{
			// If no xpath is passed, grab the hole file
			$dom_sxe = $this->data->importNode($domDoc->documentElement, true);

			// If root node of xml is the same as Xpath, prevent duplicates.
			if($destinyChild == $rootName):
				$this->$insertIn->appendChild($dom_sxe);
			else:
				if($destinyChild){
					// Insert it to specified node
					$this->destinyChild->appendChild($dom_sxe);
				}else{
					// Otherwise insert into structure
					$this->$insertIn->appendChild($dom_sxe);
				}
			endif;
			//$this->$insertIn->appendChild($dom_sxe);
		}
	}


	/**
	* array recursivo que devuelve el dom
	*
	* @param array $data
	* @param dom element $obj
	*/
	private function recurse_node($data, $obj){

		$i = 0;
		foreach($data as $key=>$value){

			//Si es un array numerico, tomo el nombre del tag o el deafult
			if (is_numeric($key)){
				$key = (isset($data['tag'])) ? $data['tag'] : 'node'.$key;
			}

			if(is_array($value)){

				$sub_obj[$i] = $this->data->createElement($key);
				$obj->appendChild($sub_obj[$i]);

				//Recursiva si es necesario
				$this->recurse_node($value, $sub_obj[$i]);

			} elseif(is_object($value)) {

				//No se soportan objetos, lo imprimimos para mostrarlo
				$sub_obj[$i] = $this->data->createElement($key, 'Object: "' . $key . '" type: "'  . get_class($value) . '"');
				$obj->appendChild($sub_obj[$i]);

			} else {

				$value = str_replace ('&' , '&amp;' , $value);
				

				if($key!='tag'){
					
					// Load as Attribute
					if(strrchr($key,'-') == '-att'){
						$key=substr($key,0,strlen($key)-strlen("-att"));
						//Transformamos todo a utf para no tener errores
						$obj->setAttribute($key, $value);
					}
					
					// Load as XML content
					else if(strrchr($key,'-') == '-xml'){
						$key=substr($key,0,strlen($key)-strlen("-xml"));

						$nodeDoc = new DOMDocument("1.0", "UTF-8");
						$node = "<$key>".$value."</$key>";

						$this->validate($node);
						$nodeDoc->loadXML($node);

						$src = $nodeDoc->getElementsByTagName("$key")->item(0);
						$dom_nxe = $this->data->importNode($src, true);

						$sub_obj[$i] = $this->data->createElement($key);

						//$sub_obj[$i]->appendChild($dom_nxe);
						$obj->appendChild($dom_nxe);

					}

					// Load as Node
					else{
						//Transformamos todo a utf para no tener errores
						$sub_obj[$i] = $this->data->createElement($key, $value);
						$obj->appendChild($sub_obj[$i]);
					}

				}
			}
			$i++;
		}
	}

	/**
	 * imprime el xml final como string
	 *
	 * @return string
	 */
	public function saveXML(){
		return $this->data->saveXML();
	}
	
	
	public static function validate($xml)
	{
		libxml_use_internal_errors(true);
		$doc = new DOMDocument("1.0", "UTF-8");
		$doc->loadXML($xml);

		$errors = libxml_get_errors();
		if (empty($errors))
		{
			return true;
		}else{

			$error = $errors[0];
			if($error->code == 4):
				return false;
			else:
				$lines = explode("r", $xml);
				$line = $lines[($error->line)-1];
				$message = $error->message.' at line '.$error->line.':<br />'.htmlentities($line);
				throw New Exception($message);
			endif;
		}
	}
	
	private function fileToString($file)
	{
		$data = @file_get_contents($file);
		if ($data === false): throw new Exception('Could not load file "'.$file.'"'); endif;
		return $data;
	}


	public static function XMLTransform($xmlDoc, $xslDoc, $params=array())
	{
		$xml = new DOMDocument("1.0", "UTF-8");
		$xml->loadXML($xmlDoc);

		$xsl = new DOMDocument("1.0", "UTF-8");
		$xsl->loadXML($xslDoc);

		$proc = new XSLTProcessor;
		$proc->importStyleSheet($xsl);

		if (is_array($params) && count($params))
			{
				foreach ($params as $key=>$value) {
					//$xmlTemp.="agrego parametro ".$key." = ".$value."<br />";
					$proc->setParameter(null, $key, $value);
				}
			}
		//$proc->setParameter(null, "host", HOST);
		$fechaActual = date("Y-m-d");
		$horaActual  = date("H:i");
		$proc->setParameter(null, "fechaActual", $fechaActual);
		$proc->setParameter(null, "horaActual", $horaActual);

		return $proc->transformToXML($xml);
	}
}
?>