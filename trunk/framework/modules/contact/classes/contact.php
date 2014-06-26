<?php
class Contact extends Module
{
	
	protected static $table = 'contact';
	
	public static function addContact($data){
		$params = array(
			'table'=>self::$table,
			'fields'=>$data,
		);
		$query = parent::insert($params);
		return $query;
	}
	
	public static function editContact($data)
	{
		if(is_array($data)):
			$fields = array();
			foreach($data as $fieldName=>$value){$fields[$fieldName]=$value;}

			$params = array(
				'fields'=>$fields,
				'filters'=>array(
					'contact_id='.$fields['contact_id']
				),
				'table'=>self::$table
			);
			$r = self::update($params,$debug = false);
			return $r[0];
		else:
			return false;
		endif;
	}
	
	public static function getById($contact_id)
	{
		$fields = array('*');
		$fields = ContactModel::getFields($fields, self::$table);
		$params = array(
			'fields' => $fields,
			'table'=> self::$table,
			'filters' => array("contact_id=".$contact_id),
		);
		$return = parent::select($params);
		if(!empty($return)):
			return $return[0];
		else:
			return false;
		endif;
	}

	public static function getByTypeObjectId($type,$object_id)
	{
		$key = 'comments.'.$type.'.'.$object_id;
		
		if(!($return = Cache::getKey($key, $folder='comments'))):
			$fields = array('*');
			$fields = ContactModel::getFields($fields, self::$table);
			$params = array(
				'table'=> self::$table,
				'fields' => $fields,
				'filters' => array("objecttype_id=".$type,"object_id=".$object_id),
				'orderby' => "contact_id desc"
			);

			$return = parent::select($params);

			$return['tag'] = 'comentario';
			$expires = (86400 * 30) * 3; // 3 meses
			Cache::setKey($key, $return, $expires, $folder='comentarios'); // 10 dias
		endif;


		/*
			Para los comentarios en los items, traigo los datos de los usuario de cache.
			Porque cada vez que alguien comenta, el cache de comentarios del item se borra. 
			Asi no esta pidiendolos todo el tiempo, o si es el mismo user que comento muchas veces, lo pide una sola vez
		*/
		
		
		foreach($return as $k=>$v):
			if(is_numeric($k) && $return[$k]['usuario_id-att']!=''):
				$user = User::getCacheById($return[$k]['usuario_id-att']);
				if($user):
					$return[$k]['user'] = $user;
				endif;
			endif;
		endforeach;


		return $return;
	}
	
	public static function getByUserId($user_id)
	{
		$fields = array('*');
		$fields = ContactModel::getFields($fields, self::$table);
		$params = array(
			'table'=> self::$table,
			'fields' => $fields,
			'filters' => array("usuario_id=".$user_id),
			'orderby' => "contact_id desc"
		);

		self::initDB();
		$return = self::$db->select($params);
		self::closeDB();
		$return['tag'] = 'comentario';
		return $return;
	}
	
	
	public static function getTotalByObjetId($objectType, $objectId)
	{

			$result = parent::select(
				$parms = array(
					'fields'=>array('count(*) as cant'),
					'table'=>self::$table,
					'filters'=>array(
						'object_id'=>$objectId,
						'object_type'=>$objectType
					)
				)
			);

			if(isset($result[0])):
				return $result[0]['cant'];
			else:
				return false;
			endif;
	}



	// Filtrar por estado y paginado
	public static function getList($options)
	{
		$defaults = array(
			'university'=>false,
			'start_date'=>false,
			'end_date'=>false,
			'carrera'=>false,
			'page'=>1,
			'pagesize'=>10,
			'orderby'=>'contact_id DESC'
		);

		$options = Util::extend($defaults,$options);

		$filters = array();

		if($options["university"] != false):
			$filters[]="universidad_id=".$options["university"];
		endif;
		if($options["carrera"] != false):
			$filters[]="carrera_id=".$options["carrera"];
		endif;

		if($options["start_date"] != false):
			$filters[]="contact_date>='".$options["start_date"]." 00:00:00'";
		endif;

		if($options["end_date"] != false):
			$filters[]="contact_date<='".$options["end_date"] ." 24:00:00'";
		endif;

		$from = ($options['page']-1) * $options['pagesize'];



		$params = array(
					'fields'	=> ContactModel::getFields(array('*'), self::$table),
					'table'		=> self::$table,
					'filters'	=> $filters,
					'orderby'	=> $options['orderby'],
					'limit'		=> $from.', '.$options['pagesize'],
		);

		
		$result = parent::select($params);


		// foreach($r as $k=>$v):
		// 	$user = User::getCacheById($r[$k]['usuario_id-att']);
		// 	if($user):
		// 		$r[$k]['usuario'] = $user;
		// 	endif;
		// 	if($r[$k]['reportador']!=0):
		// 		$r[$k]['reportador'] = User::getById($r[$k]['reportador']);
		// 	endif;
		// endforeach;
		$result['total-att'] = self::getTotal($options);
		$result['pagesize-att'] = $options['pagesize'];
		$result['page-att'] = $options['page'];
		$result['tag'] = 'object';
		return $result;
	}


	public static function getTotal($options=false)
	{
		$defaults = array(
			'university'=>false,
			'start_date'=>false,
			'end_date'=>false,
			'carrera'=>false,
		);

		$options = Util::extend($defaults,$options);

		$params = array(
			'fields'=> array('count(*) as cant'),
			'table' => self::$table,
			'filters'=> array()
		);

		if($options["university"] != false):
			$params['filters'][]="universidad_id=".$options["university"];
		endif;
		if($options["carrera"] != false):
			$params['filters'][]="carrera_id=".$options["carrera"];
		endif;

		if($options["start_date"] != false):
			$params['filters'][]="contact_date>='".$options["start_date"]." 00:00:00'";
		endif;

		if($options["end_date"] != false):
			$params['filters'][]="contact_date<='".$options["end_date"] ." 24:00:00'";
		endif;

		$r = parent::select($params);
		if(!empty($r)):
			$total = $r[0]['cant'];
		else:
			$total = 0;
		endif;
		return $total;

	}

	/**
	*	Function: Remove 
	*	Params: Object Id
	*	@return: true or false
	**/
	public static function Remove($object_id)
	{

		if(is_numeric($object_id))
		{
			$params = array(
				'table'  => ContactModel::$table,
				'filters'=> array('contact_id='.$object_id)
			);
			return parent::delete($params);
		}
	}


	public static function Search($options)
	{
		$defaults = array(
			'query'       => "",
			'display'     => 20,
			'currentPage' => 1,
		);

		$options = util::extend($defaults,$options);



		$fields = array('*');
		$filters = array("contact_name like '%".$options["query"]."%' or contact_lastname like '%".$options["query"]."%' or contact_email like '%".$options["query"]."%'  ");
		//$fields = ContactModel::getFields($fields, contactmodel::$table);
		$params = array(
					'fields'=>$fields,
					'table'=>contactmodel::$table,
					'orderby'=>'contact_id DESC',
					'filters' => $filters,
		);
		
		$return = parent::select($params);
		util::debug($return);
		die;

		$counter = array(
					'fields'=>array('count(*) as cant'),
					'table'=>contactmodel::$table,
					'filters' => $filters,
		);

		die;

		$return = parent::select($counter);
		if(!empty($return)):
			$total = $return[0]['cant'];
		else:
			$total = 0;
		endif;

		/* Necesito obtener la configuracion del modulo */
		$module = ConfigurationManager::GetModuleConfiguration(basename(dirname(dirname(__FILE__))));
		/* Items a mostrar por pagina en el acu */
		$perPage = (int)$module->options->paginado['mostrar'];

		if($page):
			$from = ($page-1) * $perPage;
		else:
			$from = 0;
		endif;
		$params['limit'] = $from.', '.$perPage;
		$r = parent::select($params);


		if(!empty($r)):
		
			foreach($r as $k=>$v):
				$user = User::getCacheById($r[$k]['usuario_id-att']);
				if($user):
					$r[$k]['usuario'] = $user;
				endif;
				if($r[$k]['reportador']!=0):
					$r[$k]['reportador'] = User::getById($r[$k]['reportador']);
				endif;
			endforeach;
			$r['total-att'] = $total;
			$r['mostrar-att'] = $perPage;
			$r['tag'] = 'comentario';
			return $r;
		else:
			return false;
		endif;
	}


	public static function sendContactEmail($options = array())
	{
		$defaults = array(
			'to'			=> false,
			'from'			=> "ZonaJobs Educacion <no-reply@zonajobs.com>",
			'subject'		=> "Tienes un nuevo contacto interesado en tus ofertas académicas",
			'contact'		=> false,
			'site'			=> false,
			'carrera'		=> false,
			'universidad'	=> false
		);


		$options = Util::extend($defaults,$options);

		$message =  '<table width="100%" style="width:100%;margin:auto;font-family:\'Helvetica neue\',\'Helvetica\',Arial;font-size:100%;" ><tr><td>'.
							'<table width="100%" cellpadding="10" cellspacing="10" style="width:100%;margin:auto;background:#124759;"><tr><td><a href="http://educacion.zonajobs.com"><img src="http://educacion.zonajobs.com/interface/default/desktop/images/logos/zonajobs-educacion.png" alt="" border="0" /></a></td></tr></table>'.
							'<table width="100%" cellpadding="10" cellspacing="10" style="width:100%;margin:auto;background:#f4f4f4;color:#676563;"><tr>'.
							'<td valign="top">
								<div style="background:#fff;border:1px solid #DAD9D9;height:50px;padding:20px;text-align:center;">
									<img src="http://educacion.zonajobs.com/content/'.$options['site']["preffix"].'/logos/uni'.$options['universidad']['id-att'].'.jpg" border="0" alt=""  style="height:50px;" height="50" />
								</div>
							</td>'.
							'<td valign="top">'.					
							'<h3 style="margin-top:0;font-size:22px;font-weight:normal;" >Hola '.$options["universidad"]["title"].'</h3>'.
							'<p style="font-size:13px;line-height:18px;">Recibiste este contacto por tener tu aviso en Zonajobs Educación. Si quieres recibir nuevos contactos ahora o tienes alguna consulta, nos puedes escribir a <a href="mailto:educacion@zonajobs.com">educacion@zonajobs.com</a>.</p>'.
							'</td></tr>
							</table>'.
							'<table width="100%" cellpadding="10" cellspacing="10" style="width:100%;margin:auto;background:#f4f4f4;color:#676563;"><tr><td>'.
							'<p><a href="http://educacion.zonajobs.com/'.$options['site']['preffix'].'/carrera_'.$options["carrera"]["shorttitle"].'_'.$options["carrera"]["id-att"].'">'.$options["carrera"]["title"].'</a></p>'.
							'<p style="color:#676563;font-size:14px;line-height:22px;" >'.
							"<b>Nombre:</b> ".$options['contact']['contact_name']." ".$options['contact']['contact_lastname']."<br/>".
							'<b>Email:</b> <a href="mailto:'.$options['contact']['contact_email'].'" >'.$options['contact']['contact_email'].'</a><br/>'.
							"<b>Telefono:</b> ".$options['contact']['contact_phone']."<br/>".
							"<b>Ubicación:</b> ".$options['contact']['contact_location_name']."<br/>";
							
							if($options['contact']['contact_comment'] != ''):
								$message.= "<b>Comentario:</b> ".$options['contact']['contact_comment']."</p>";
							endif;

		$message .= 		'</td></tr></table>'.

							'<table width="100%" cellpadding="10" cellspacing="10" background="#124759" style="width:100%;margin:auto;background:#124759;color:#fff;"><tr><td>'.
							"	<p style='background:#124759;color:#fff;'>Muchas gracias,<br/> El equipo de ZonaJobs Educación.</p>".
							'</td></tr></table>'.

						'</td></tr></table>';

			$headers =  'From: ' . $options["from"] . "\r\n" .
	    				'Reply-To: ' . $options["from"] . "\r\n" .
	    				'MIME-Version: 1.0'. "\r\n" .
	    				'Content-type: text/html; charset=iso-8859-1' . "\r\n" .
	    				'X-Mailer: PHP/' . phpversion();
			$sent = mail($options["to"],$options["subject"],$message,$headers);

		return $sent;
	}


	public static function sendUserEmail($options = array())
	{
		$defaults = array(
			'to'			=> false,
			'from'			=> "ZonaJobs Educacion <no-reply@zonajobs.com>",
			'subject'		=> "Solicitaste información a la siguiente carrera",
			'contact'		=> false,
			'site'			=> false,
			'carrera'		=> false,
			'universidad'	=> false
		);


		$options = Util::extend($defaults,$options);

		//util::debug($options);

		$message =  '<table width="100%" style="width:100%;margin:auto;font-family:\'Helvetica neue\',\'Helvetica\',Arial;font-size:100%;" ><tr><td>'.
							'<table width="100%" cellpadding="10" cellspacing="10" style="width:100%;margin:auto;background:#124759;"><tr><td><a href="http://educacion.zonajobs.com"><img src="http://educacion.zonajobs.com/interface/default/desktop/images/logos/zonajobs-educacion.png" alt="" border="0" /></a></td></tr></table>'.
							'<table width="100%" cellpadding="10" cellspacing="10" style="width:100%;margin:auto;background:#f4f4f4;color:#676563;"><tr>'.
							'<td valign="top">
								<div style="background:#fff;border:1px solid #DAD9D9;height:50px;padding:20px;text-align:center;">
									<img src="http://educacion.zonajobs.com/content/'.$options['site']["preffix"].'/logos/'.$options['universidad']['logo'].'" border="0" alt=""  style="height:50px;" height="50" />
								</div>
							</td>'.
							'<td valign="top">'.					
							'<h3 style="margin-top:0;font-size:22px;font-weight:normal;" >¡Hola '.$options["contact"]["contact_name"].'!</h3>'.
							'<p style="font-size:13px;line-height:18px;">Solicitaste información a la siguiente carrera.</p>'.
							'</td></tr>
							</table>'.
							'<table width="100%" cellpadding="10" cellspacing="10" style="width:100%;margin:auto;background:#f4f4f4;color:#676563;"><tr><td>'.
							'<p><a href="http://educacion.zonajobs.com/'.$options['site']['preffix'].'/carrera_'.$options["carrera"]["shorttitle"].'_'.$options["carrera"]["id-att"].'" style="color:#333;">'.$options["carrera"]["title"].'</a></p>'.
							'<p style="color:#676563;font-size:14px;line-height:22px;" >'.
							"<b>Duración:</b> ".$options['carrera']['duracion']."<br/>".
							'<b>Nivel:</b> '.$options['carrera']['type']['name'].'<br/>'.
							"<b>Modalidad:</b> ".$options['carrera']['modalidad']['name']."<br/>".
							"<b>Ubicación:</b> ".$options['carrera']['location']['name'].", ". $options['carrera']['province']['name']."<br/>".
							'</td></tr></table>';

		// Util::Debug($options);
		// die;
		//Carrera
		$message_text = "";
		$button_text 	= "";
		$button_link 	= "";

		if(isset($options['site']['carreras_type']))
		{
			if( $options['carrera']['type-att'] == $options['site']['carreras_type'])
			{
				
					$message_text 	= 'Te invitamos a <strong>leer las notas de nuestros especialistas</strong> sobre carreras universitarias y orientación vocacional';
					$button_text 	= 'Ver notas';
					$button_link 	= 'http://educacion.zonajobs.com/'.$options['site']['preffix'].'/notas';
			}	
		}
		
		if(isset($options['site']['cursos_type'])){
			if($options['carrera']['type-att'] == $options['site']['cursos_type'])
			{
				
					$message_text 	= 'Te invitamos a ver el <strong>resto de los cursos que hay disponibles</strong> en el sitio';
					$button_text 	= 'Ver cursos';
					$button_link 	= 'http://educacion.zonajobs.com/'.$options['site']['preffix'].'/cursos';
			}
		}
		
		if(isset($options['site']['posgrados_type'])){
			if($options['carrera']['type-att'] == $options['site']['posgrados_type'])
			{
				
					$message_text = 'Te invitamos a descubrir otras <strong>ofertas de Posgrados y Maestrías</strong> que hay disponibles en el sitio';
					$button_text = 'Ver más';
					$button_link 	= 'http://educacion.zonajobs.com/'.$options['site']['preffix'].'/posgrados-y-maestrias';
			}	
		}
		
		if($message_text !== "")
		{

		

			$message .= '<table cellpadding="10" cellspacing="5" width="100%" style="width:100%;margin:auto;background:#666;color:#fff;">'.
        				'	<tr>'.
						'		<td width="530" height="20">'.
						'			<p style="background:#666;color:#fff;">'.$message_text.'</p>'.
						'		</td>'.
		  	      	    '        <td>'.
		  	      	    '        	<table style="font-family:Arial,sans-serif;margin:0;padding:0;border-collapse:collapse;" align="left" border="0" cellpadding="0" cellspacing="0">'.
						'				<tr height="36">'.
						'		         <td>'.
						'					<table align="center" border="0" cellpadding="10" cellspacing="0" style="background:#ed106e;">'.
						'		         	<tr>'.
								            	'<td width="164" height="36" align="center" valign="middle" >'.
								            		'<table style="background:#ED106E;margin-top:0;margin-right:0;margin-left:0;padding-top:0;padding-right:0;padding-bottom:0;padding-left:0;border-collapse:collapse" align="center" border="0" cellpadding="0" cellspacing="0">'.
						'		                	<tr>'.
						'		                  		<td style="text-align:center;line-height:14px" align="center" height="20" valign="middle" width="147"><a href="'.$button_link.'" style="margin:0;padding:0;text-align:center;color:#ffffff;font-weight:normal;font-size:16px;display:block;text-decoration:none;font-family:Arial,Helvetica,sans-serif" target="_blank">'.$button_text.'</a></td>'.
						'		                	</tr>'.
						'		            		</table>'.
						'						</td>'.
						'		          	</tr>'.
						'		      		</table></td>'.
						'		    </tr>'.
						'		</table> </td>'.
		                '   </tr>'.
		                '    </table>';
		}

		$message .= 	'<table width="100%" cellpadding="10" cellspacing="10" background="#124759" style="width:100%;margin:auto;background:#124759;color:#fff;"><tr><td>'.
							"	<p style='background:#124759;color:#fff;'>Muchas gracias,<br/> El equipo de ZonaJobs Educación.</p>".
							'</td></tr></table>'.

						'</td></tr></table>';

			// echo $message;
			// die;

			$headers =  'From: ' . $options["from"] . "\r\n" .
	    				'Reply-To: ' . $options["from"] . "\r\n" .
	    				'MIME-Version: 1.0'. "\r\n" .
	    				'Content-type: text/html; charset=iso-8859-1' . "\r\n" .
	    				'X-Mailer: PHP/' . phpversion();
			$sent = mail($options["to"],$options["subject"],$message,$headers);

		return $sent;
	}





	
}
?>