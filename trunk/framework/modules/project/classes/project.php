<?php
class Project extends Object_Custom
{
	

	public static function getById($options = array())
	{
		$defaults = array(
			'createdby'=> false
		);
		$options = Util::extend($defaults,$options);

		
		if(isset($options['user_logged']) && $options['user_logged']['role']['user_level_name'] == 'responsable'):
			$options['createdby'] = $options['user_logged']['user_id-att'];
		endif;


		$Object = Object_Custom::getById(
			$options = array(
				'id'	 	  => $options['id'],
				'model'      => 'ProjectModel',
				'table'      => ProjectModel::$table,
				'tables'	 => ProjectModel::$tables,
				'module'	 => 'project',
				'state'		 => false, 
				'relations'	 => true,
				'multimedas' => true,
				'categories' => true,
				'createdby'  => $options['createdby'],
			)
		);
		return $Object;
	}


	// Filtrar por estado y paginado
	public static function getList($options = array())
	{
		$defaults = array(
			'start_date'=>false,
			'end_date'=>false,
			'page'=>1,
			'pagesize'=>10,
			'orderby'=>'project.id DESC',
			'createdby'=> false,
		);

		$options = Util::extend($defaults,$options);

		if(isset($options['user_logged']) && $options['user_logged']['role']['user_level_name'] == 'responsable'):
			$options['createdby'] = $options['user_logged']['user_id-att'];
		endif;


		$filters = array();

		if($options["start_date"] != false):
			$filters[]="project.contact_date>='".$options["start_date"]." 00:00:00'";
		endif;

		if($options["end_date"] != false):
			$filters[]="project.contact_date<='".$options["end_date"] ." 24:00:00'";
		endif;

		if($options["createdby"] != false):
			$filters[]="project.creation_userid=".$options["createdby"];
		endif;

	

		$fields = ProjectModel::getFields(array('*'), ProjectModel::$table);
		$fields[] = 'client.title as client_title';

		$params = array(
			'fields'	=> $fields,
			'table'		=> ProjectModel::$table . ' left join client on project.client_id = client.id',
			'filters'	=> $filters,
			'orderby'	=> $options['orderby'],
		);

		if($options['page'] != -1):
			$from = ($options['page']-1) * $options['pagesize'];
			$params['limit'] = $from.', '.$options['pagesize'];
		endif;

		
		$result = parent::select($params,$debug=false);

		$result['total-att'] = self::getTotal($options);
		$result['pagesize-att'] = $options['pagesize'];
		$result['page-att'] = $options['page'];
		$result['tag'] = 'object';
		return $result;
	}

	public static function getRubros($options=array())
	{
		$params =  array(
			'fields'=>array('rubro.*'),
			'table'=>'project_rubro LEFT JOIN rubro ON project_rubro.rubro_id = rubro.id',
			'filters'=>array(
				'project_rubro.project_id='.$options['project_id']
			),
			'orderby'=>'project_rubro.position ASC'
		);
		$rubros = self::select($params);
		$total = 0;

		/* get resources */
		foreach($rubros as $key=>$rubro)
		{
			$total = 0;
			$estimate_total = 0;
			
			$Resources = self::getResources(array(
				'project_id' => $options['project_id'],
				'rubro_id'	 => $rubro['id']
			));	


			$rubros[$key]['resources'] = $Resources;
			$rubros[$key]['total-att'] = $total;
			$rubros[$key]['estimate_total-att'] = $estimate_total;

		}
		$rubros['tag']='rubro';
		return $rubros;
	}


	public static function getResources($options = array())
	{
		$params = array(
			'fields'=>array(
				"project_resource.*",
				"rubro.title",
				"sindicato.name as sindicato_name",
				"project_resource.sindicato_percentage as sindicato_percentage",
			),
			'table'=>'project_resource INNER JOIN rubro ON project_resource.subrubro_id = rubro.id LEFT JOIN sindicato ON rubro.sindicato_id = sindicato.id',
			'filters'=>array()
		);

		if(isset($options['project_id'])):
			$params['filters'][] = 'project_resource.project_id=' . $options['project_id'];
		endif;

		if(isset($options['rubro_id'])):
			$params['filters'][] = 'project_resource.rubro_id=' . $options['rubro_id'];
		endif;


		$Resources = self::select($params,0);


		$total =0;
		$estimate_total = 0;

		foreach($Resources as $key=>$resource)
		{
				//Get Resource Facturado
				$params = array(
					'fields'=>array(
						'sum(amount) as total_facturado'
					),
					'table' => 'factura',
					'filters' => array(
						'project_id='.$options['project_id'],
						'resource_id='.$resource['resource_id'],
						'state=1'
					)
				);

				$result_total_facturado = self::select($params);

				$sindicato = $resource['estimate_cost'] * $Resources[$key]['sindicato_percentage'] / 100;

				$estimate_subtotal = $resource['estimate_units'] * $resource['estimate_quantity'] * ($resource['estimate_cost']+$sindicato);

				$subtotal = $resource['units'] * $resource['quantity'] * $resource['cost'];

				$total_facturado = ($result_total_facturado[0]['total_facturado'] == '')?0:$result_total_facturado[0]['total_facturado'];

				if($subtotal != 0):
					$progress = round ( $total_facturado * 100 / $subtotal , $precision = 0);
				else:
					$progress = 0;
				endif;


				$Resources[$key]['total_facturado'] = $total_facturado;
				$Resources[$key]['progress'] = $progress;
				$Resources[$key]['estimate_subtotal'] =  $estimate_subtotal;
				$Resources[$key]['subtotal'] =  $subtotal;

				

				$total += $Resources[$key]['subtotal']; 
				$estimate_total += $Resources[$key]['estimate_subtotal']; 
		}

		$Resources['total'] = $total;
		$Resources['estimate_total'] = $estimate_total;
		$Resources['tag'] = 'resource';
		return $Resources;
	}


	/* duplicate */
	public static function Duplicate($project_id)
	{

		$params = array(
			'table'     => 'project',
			'filters'   => array(
				'id='.$project_id
			)
		);
		$old_item   = parent::select($params);		
		$new_item = $old_item[0];
		$User = Admin::IsLoguedIn();

		unset($new_item['id']);
		unset($new_item['modification_date']);
		unset($new_item['modification_userid']);
		unset($new_item['modification_usertype']);

		$new_item['title']          = "Copia de: ".$old_item[0]['title'];
		$new_item['creation_date']         = date('Y-m-d H:i:s');
		$new_item['creation_userid']       = $User['user_id-att'];
		$new_item['modification_userid']   = 0;
		$new_item['modification_usertype'] = '';
		$new_item['state']          = 0;

		$newParams = array(
			'fields' => $new_item,
			'table'  => 'project',
		);

		$new_id = parent::insert($newParams);


		//*** Duplicate Rubros *** //
		$rubros = Module::select(array(
			'fields'=>array('*'),
			'table'=>'project_rubro',
			'filters'=>array(
				'project_id='.$old_item[0]['id']
			)
		));

		if(!empty($rubros)){
			$newItems = array();
			foreach($rubros as $key=>$item){
				$item['project_id'] = $new_id;
				Module::insert(
					array(
						'fields'=>$item,
						'table'=>'project_rubro',
					),
					$debug=false
				);
			}
		}
		
		//*** Duplicate Resources ***
		$Resource = Module::select(array(
			'fields'=>array('*'),
			'table'=>'project_resource',
			'filters'=>array(
				'project_id='.$old_item[0]['id']
			)
		));
		if(!empty($Resource)){
			$newItems = array();
			foreach($Resource as $key=>$item){
				$item['project_id'] = $new_id;
				unset($item['resource_id']);
				Module::insert(
					array(
						'fields'=>$item,
						'table'=>'project_resource',
					),
					$debug=false
				);
			}
		}



		

		// // Duplicate Multimedias
		// $multimediaQuery = array(
		// 	'table'   => 'multimedia_object',
		// 	'filters' => array('object_id='.$object_id),
		// );
		// $multimedias = parent::select($multimediaQuery);
		
		// if(isset($multimedias[0]))
		// {
		// 	foreach($multimedias as $multimedia)
		// 	{
		// 		$newRecord = $multimedia;
		// 		unset($newRecord['relation_oder']);
		// 		$newRecord['object_id'] = $new_id;
		// 		$newRecordSql = array(
		// 			'table'  => 'multimedia_object',
		// 			'fields' => $newRecord,
		// 		); 
		// 		parent::insert($newRecordSql);
		// 	}
		// }
		return;
	}

	/* getResource */
	public static function getResource($options=array())
	{
		$params =  array(
			'fields'=>array('project_resource.*'),
			'table'=>'project_resource',
			'filters'=>array(
				'project_id='.$options['project_id'],
				'resource_id='.$options['resource_id']
			)
		);
		$result = self::select($params,false);

		if(empty($result)):
			return false;
		endif;
		$Resource = $result[0];
		$Resource['tag'] = 'resource';

		//Get Payments Calendar
		$Resource['payments_list'] = self::getListPayment(array(
			'project_id'=>$options['project_id'],
			'resource_id'=>$Resource['resource_id']
		));
		return $Resource;
	}

	public static function getListPayment($options = array()){
		$params =  array(
			'fields'=>array('project_resource_payments.*'),
			'table'=>'project_resource_payments',
			'filters'=>array(),
			'orderby'=>'date asc'
		);

		if(isset($options['project_id'])){
			$params['filters'][] = 'project_id='.$options['project_id'];
		}
		if(isset($options['resource_id'])){
			$params['filters'][] = 'resource_id='.$options['resource_id'];
		}
		if(isset($options['start_date'])){
			$params['filters'][] = "date >='".$options['start_date']."'";
		}
		if(isset($options['limit'])){
			$params['limit'] = '0,'.$options['limit'];
		}

		//payments list
		$payments = self::select($params,false);

		//** if get resource ***
		if(isset($options['get_resources'])){
			foreach($payments as $key=>$payment){
				$resource = self::select(array(
					'fields'=>array(
						'project_resource.*',
						'rubro.*',
						'project.title as project_title',
						'provider.title as provider_title'
					),
					'table'=>'project_resource left join rubro on project_resource.subrubro_id = rubro.id left join provider on project_resource.provider_id = provider.id left join project on project_resource.project_id = project.id',
					'filters'=>array(
						'resource_id='.$payment['resource_id']
					)
				));	
				if(!empty($resource)){
					$payments[$key]['resource'] = $resource[0];	
				}
			
			}
		}

		$payments['tag'] = 'payment';
		return $payments;

	}

	public static function getEstimatedPaymentCalendar($options = array())
	{
		$params = array(
			'fields'=>array('sum(value) as total','date'),
			'table'=>'project_resource_payments',
			'groupby'=>'date',
			'orderby'=>'date'
		);

		if(isset($options['project_id'])){
			$params['filters'][] = 'project_id='.$options['project_id'];
		}

		if(isset($options['start_date'])){
			$params['filters'][] = "date>='".$options['start_date']."'";
		}

		if(isset($options['end_date'])){
			$params['filters'][] = "date<='".$options['end_date']."'";
		}

		$results = self::select($params,$debug=0);

		foreach($results as $key=>$item){
			$results[$key]['date'] = strtotime("$item[date] UTC") * 1000;
		}

		$results['tag'] = 'calendar';
		return $results;
	}


	public static function getPaymentCalendar($options = array())
	{

		$sql = 'select sum(amount) as total,date
				from factura 
				where factura.state=1 ';

		if(isset($options['project_id'])):
			$sql.= ' and project_id=? ';
		endif;
		if(isset($options['start_date'])):
			$sql.= " and date>=? ";
		endif;
		if(isset($options['end_date'])):
			$sql.= " and date<=? ";
		endif;

		$sql .= ' GROUP BY date ORDER by date ASC';

		// $sql.=' union ';
		// $sql.='	(SELECT sum(amount) as total,date FROM partida ';
		
		// if(isset($options['project_id'])):
		// 	$sql.= ' where partida.project_id=? ';
		// endif;
		// if(isset($options['start_date'])):
		// 	$sql.= " where date>=? ";
		// endif;
		//$sql.= ' group by date order by date asc);';

		$values = array();

		if(isset($options['project_id'])):
			//$values = array($options['project_id'],$options['project_id']);
			$values = array($options['project_id']);
		else:
			if(isset($options['start_date'])):
				$values = array($options['start_date']);
			endif;
			if(isset($options['start_date'])):
				$values[] = $options['end_date'];
			endif;
		endif;


		$results = self::custom($sql,$values,$debug=false);

		foreach($results as $key=>$item){
			$results[$key]['date'] = strtotime("$item[date] UTC") * 1000;
		}



		$results['tag'] = 'calendar';
		return $results;
	}




	public static function getEstimate($options = array()){

		$params = array(
			'fields'=>array(
				'estimate_units',
				'estimate_quantity',
				'estimate_cost',
				'rubro.title',	
				"sindicato.name as sindicato_name",
				"project_resource.sindicato_percentage as sindicato_percentage",
			),
			'table'=>'project_resource INNER JOIN rubro ON project_resource.subrubro_id = rubro.id LEFT JOIN sindicato ON rubro.sindicato_id = sindicato.id',
			'filters'=>array(
				'project_id='.$options['project_id']
			)
		);

		$Result = Module::select($params);
		$Estimate = 0;
		foreach($Result as $key=>$val){
			$sindicato = $val['sindicato_percentage'] * $val['estimate_cost'] / 100;
			$Estimate += $val['estimate_units'] * $val['estimate_quantity'] * ($val['estimate_cost'] + $sindicato);
		}
		
		$Return = array(
			'total' => $Estimate
		);
		
		return $Return;
	}

	public static function getReal($options = array()){

		$params = array(
			'fields'=>array(
				'units',
				'quantity',
				'cost',
				'rubro.title',	
				"sindicato.name as sindicato_name",
				"project_resource.sindicato_percentage as sindicato_percentage",
			),
			'table'=>'project_resource INNER JOIN rubro ON project_resource.subrubro_id = rubro.id LEFT JOIN sindicato ON rubro.sindicato_id = sindicato.id',
			'filters'=>array(
				'project_id='.$options['project_id']
			)
		);

		$Result = Module::select($params);
		$Real = 0;
		foreach($Result as $key=>$val){
			$sindicato = $val['sindicato_percentage'] * $val['cost'] / 100;
			$Real += $val['units'] * $val['quantity'] * ($val['cost']  + $sindicato );
		}
		
		$Return = array(
			'total' => $Real
		);
		
		return $Return;
	}

	public static function getPartidas($options=array()){
		$params =  array(
			'fields'=>array(),
			'table'=>'partida',
			'filters'=>array(
				'project_id='.$options['project_id']
			)
		);
		if(isset($options['partida_id'])):
			$params['filters'][] = 'id='.$options['partida_id'];
		endif;

		$partidas = self::select($params);

		if(!empty($partidas)):
			foreach($partidas as $key=>$partida):
				$result = self::select(array(
					'fields'=>array('sum(amount) as total'),
					'table'=>'factura',
					'filters'=>array(
						'state=1',
						'partida_id='.$partida['id']
					)
				));	
				$total_facturado = $result[0]['total'];
				$partidas[$key]['total_facturado-att'] = $total_facturado;
				if($partida['amount']>0):
					$partidas[$key]['progress-att'] = number_format( $total_facturado * 100 / $partida['amount'], 0 );
				else:
					$partidas[$key]['progress-att'] = 0;
				endif;

			endforeach;
		endif;


		$partidas['total-att']= self::getPartidasTotal(array('project_id'=>$options['project_id']));
		$partidas['amount-att']= self::getPartidasAmount(array('project_id'=>$options['project_id']));
		$partidas['tag']='partida';
		return $partidas;
	}

	public static function getPartidasTotal($options=array()){
		$params =  array(
			'fields'=>array('count(*) as cant'),
			'table'=>'partida',
			'filters'=>array(
				'project_id='.$options['project_id']
			)
		);
		$return = self::select($params);

		if($return[0]['cant'] == ''):
			return 0;
		else:
			return $return[0]['cant'];
		endif;
	}


	public static function getPartidasAmount($options=array()){
		$params =  array(
			'fields'=>array('sum(amount) as amount'),
			'table'=>'partida',
			'filters'=>array(
				'project_id='.$options['project_id']
			)
		);
		$return = self::select($params);
		return ($return[0]['amount'] == '')?0:$return[0]['amount'];
	}


	public static function getFacturas( $options=array() ) {

		$defaults = array(
			'project_id'=>false,
			'factura_id'=>false,
			'partida_id'=>false,
			'orderby'=>false,
			'ordering'=> 'ASC',
			'debug'=>false
		);
		$options = util::extend($defaults,$options);

		$params =  array(
			'fields'=>array(
				'factura.*',
				'rubro.title as rubro_title',
				'partida.description as partida_title',
				'provider.title as provider_name',

			),
			'table'=>'factura LEFT JOIN project_resource ON factura.resource_id = project_resource.resource_id  LEFT JOIN partida ON factura.partida_id = partida.id  LEFT JOIN provider ON factura.provider_id = provider.id LEFT JOIN rubro ON factura.subrubro_id = rubro.id',
			'filters'=>array()
		);

		if($options['project_id'] !== false ):
			$params['filters'][] = 'factura.project_id='.$options['project_id'];
		endif;

		if($options['factura_id']  !== false ):
			$params['filters'][] = 'factura.id='.$options['factura_id'];
		endif;

		if($options['partida_id'] !== false):
			$params['filters'][] = 'factura.partida_id='.$options['partida_id'];
		endif;

		if($options['orderby'] !== false):
			$params['orderby'] = $options['orderby'] . ' ' . $options['ordering'];
		endif;

		$facturas = self::select($params,$options['debug']);
		$facturas['total-att']= self::getFacturasTotal(array('project_id'=>$options['project_id']));
		$facturas['pendientes-att'] = self::getFacturasTotal(array('project_id'=>$options['project_id'],'state'=>0));
		$facturas['pagas-att'] = self::getFacturasTotal(array('project_id'=>$options['project_id'],'state'=>1));
		$facturas['amount-att']= self::getFacturasAmount(array('project_id'=>$options['project_id']));
		$facturas['tag']='object';
		return $facturas;
	}

	public static function getFacturasTotal($options=array()){
		$params =  array(
			'fields'=>array('count(*) as cant'),
			'table'=>'factura',
			'filters'=>array()
		);

		if(isset($options['project_id'])){
			$params['filters'][] = 'project_id='.$options['project_id'];
		}
		if(isset($options['state'])){
			$params['filters'][] = 'state='.$options['state'];
		}
		if(isset($options['partida_id'])){
			$params['filters'][] = 'partida_id='.$options['partida_id'];
		}
		$return = self::select($params);
		return $return[0]['cant'];
	}


	public static function getFacturasAmount($options=array()){
		$params =  array(
			'fields'=>array('sum(amount) as amount'),
			'table'=>'factura',
			'filters'=>array()
		);
		if(isset($options['project_id'])){
			$params['filters'][] = 'project_id='.$options['project_id'];
		}
		if(isset($options['state'])){
			$params['filters'][] = 'state='.$options['state'];
		}
		if(isset($options['partida_id'])){
			$params['filters'][] = 'partida_id='.$options['partida_id'];
		}
		$return = self::select($params);
		if($return[0]['amount'] == ''){
			return 0;
		}else{
			return $return[0]['amount'];	
		}
		
	}



	public static function getTotal($options=false)
	{
		$defaults = array(
			'start_date'=>false,
			'end_date'=>false,
			'createdby'=>false,
			'debug'=>false
		);

		$options = Util::extend($defaults,$options);

		$params = array(
			'fields'=> array('count(*) as cant'),
			'table' => ProjectModel::$table,
			'filters'=> array()
		);


		if($options["start_date"] != false):
			$params['filters'][]="contact_date>='".$options["start_date"]." 00:00:00'";
		endif;

		if($options["end_date"] != false):
			$params['filters'][]="contact_date<='".$options["end_date"] ." 24:00:00'";
		endif;

		if($options["createdby"] != false):
			$params["filters"][]="project.creation_userid=".$options["createdby"];
		endif;

		$r = parent::select($params,$debug=$options['debug']);
		if(!empty($r)):
			$total = $r[0]['cant'];
		else:
			$total = 0;
		endif;
		return $total;

	}



	public static function getListStates(){
		$states = array(
			array(
				'id'=>0,
				'name'=>'Presupuesto',
				'label'=>'warning'
			),
			array(
				'id'=>1,
				'name'=>'En curso',
				'label'=>'info'
			),
			array(
				'id'=>2,
				'name'=>'Finalizado',
				'label'=>'success'
			),
			array(
				'id'=>3,
				'name'=>'Cancelado',
				'label'=>'warning'
			),
			array(
				'id'=>4,
				'name'=>'Excedido',
				'label'=>'danger'
			),
		);

		$states['tag'] = 'state';
		return $states;

	}

	public static function saveIndiceEPL( $project_id ) {
		$Object = Project::getById( array(
				'id' => $project_id,
		) );

		//Total Estimate
		// $TotalEstimate = Project::getEstimate(array('project_id'=>$project_id));

		//Total Real
		// $TotalReal = Project::getReal(array('project_id'=>$project_id));
		
		//Calculos
		// $total_estimate = $TotalEstimate['total'];
		// $total_imprevistos = ceil($total_estimate * $Object['imprevistos'] / 100);
		// $total_ganancia = ceil(($total_estimate + $total_imprevistos) * $Object['ganancia'] / 100);
		// $total_impuestos = ceil((($total_ganancia + $total_imprevistos + $total_estimate) * $Object['impuestos']) / 100);
		// $subtotal_neto = $total_estimate + $total_imprevistos + $total_ganancia + $total_impuestos;
		// $iva = ceil($subtotal_neto * $Object['iva'] / 100);
		// $costo_proyecto = $subtotal_neto + $iva;
		// $tipo_facturacion = settings::get('tipo_facturacion');
		$start_date = new DateTime($Object['start_date-att']);
		$end_date = new DateTime($Object['end_date-att']);
		$interval = date_diff( $start_date, $end_date );
		$meses = 0;
		$days = number_format( $interval->d , 0 );
		$meses = 30 * ( $start_date->diff($end_date)->m + ( $start_date->diff( $end_date )->y * 12 ) ); // int(8)
		$duracion_en_dias = $meses + $days;
		$costo_operativo_diario = $Object['costo_operativo'] / 30;
		// $porcentaje_costo = $costo_proyecto / $facturacion_anual['setting_value'];

		// util::debug($Object);
		// echo '<p>calcular indicie epl';
		// echo '<p>costo operativo mensual: ' . $Object['costo_operativo'];
		// echo '<p>costo operativo diario: ' . $costo_operativo_diario;
		// echo '<p>Porcentaje: ' . $Object['porcentaje_costo_operativo'];
		// echo '<p>Duracion meses: ' . $meses;
		// echo '<p>Duracion days: ' . $days;

		// util::debug( $start_date );
		// util::debug( $end_date );

		$indice_epl = round(  ( $costo_operativo_diario * $Object['porcentaje_costo_operativo'] * $duracion_en_dias ) / 100, $precision = 0);

		// util::debug( $indice_epl );
		// die;

		// insertupdate.
		Module::update( array(
			'fields'  => array(
				'indice_epl' => $indice_epl
			),
			'table'   => 'project',
			'filters' => array( 'id=' . $project_id ),
		) );
	}
	
}

?>
