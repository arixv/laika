<?php
class Project extends Object_Custom
{

	public static function FrontSearch()
	{
		$query = Util::getvalue('query', false);
		$page  = Util::getvalue('page', 1);

		//$queryStr = str_replace("'", "\'", $query);
		
		$options = array(
			'query'       => $query,
			'module'      => 'project',
			'model'		  => 'ProjectModel',
			'table'		  => ProjectModel::$table,
			'display'     => 10,
			'currentPage' => $page,
			'state'       => 1,
			'categories'  => false,
		);

		return Project::Search($options);
	}


	// Filtrar por estado y paginado
	public static function getList($options = array())
	{
		$defaults = array(
			'start_date'=>false,
			'end_date'=>false,
			'page'=>1,
			'pagesize'=>10,
			'orderby'=>'id DESC'
		);

		$options = Util::extend($defaults,$options);

		$filters = array();

		if($options["start_date"] != false):
			$filters[]="contact_date>='".$options["start_date"]." 00:00:00'";
		endif;

		if($options["end_date"] != false):
			$filters[]="contact_date<='".$options["end_date"] ." 24:00:00'";
		endif;

		$from = ($options['page']-1) * $options['pagesize'];



		$params = array(
					'fields'	=> ProjectModel::getFields(array('*'), ProjectModel::$table),
					'table'		=> ProjectModel::$table,
					'filters'	=> $filters,
					'orderby'	=> $options['orderby'],
					'limit'		=> $from.', '.$options['pagesize'],
		);

		
		$result = parent::select($params);

		$result['total-att'] = self::getTotal($options);
		$result['pagesize-att'] = $options['pagesize'];
		$result['page-att'] = $options['page'];
		$result['tag'] = 'object';
		return $result;
	}

	public static function getRubros($options=array()){
		$params =  array(
			'fields'=>array('rubro.*'),
			'table'=>'project_rubro LEFT JOIN rubro ON project_rubro.rubro_id = rubro.id',
			'filters'=>array(
				'project_rubro.project_id='.$options['project_id']
			)
		);
		$rubros = self::select($params);
		$total = 0;

		/* get subrubros*/
		foreach($rubros as $key=>$rubro)
		{
			$total = 0;
			$subrubros = self::select(array(
				'fields'=>array("project_subrubro.*","rubro.title"),
				'table'=>'project_subrubro LEFT JOIN rubro ON project_subrubro.subrubro_id = rubro.id',
				'filters'=>array(
					'project_subrubro.project_id='.$options['project_id'],
					'project_subrubro.rubro_id='.$rubro['id']
				)
			));

			foreach($subrubros as $key2=>$subrubro){
				$subrubros[$key2]['subtotal'] =  $subrubro['quantity'] * $subrubro['cost'];
				$total += $subrubros[$key2]['subtotal']; 
			}
			$subrubros['tag'] = 'subrubro';
			$rubros[$key]['subrubros'] = $subrubros;
			$rubros[$key]['total-att'] = $total;
		}
		
		$rubros['tag']='rubro';
		return $rubros;
	}


	public static function getPartidas($options=array()){
		$params =  array(
			'fields'=>array(),
			'table'=>'partida',
			'filters'=>array(
				'project_id='.$options['project_id']
			)
		);
		$partidas = self::select($params);
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
		return $return[0]['cant'];
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
		return $return[0]['amount'];
	}


	public static function getFacturas($options=array()){
		$params =  array(
			'fields'=>array(),
			'table'=>'factura',
			'filters'=>array(
				'project_id='.$options['project_id']
			)
		);
		$facturas = self::select($params);
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
			'filters'=>array(
				'project_id='.$options['project_id']
			)
		);

		if(isset($options['state'])){
			$params['filters'][] = 'state='.$options['state'];
		}
		$return = self::select($params);
		return $return[0]['cant'];
	}


	public static function getFacturasAmount($options=array()){
		$params =  array(
			'fields'=>array('sum(amount) as amount'),
			'table'=>'factura',
			'filters'=>array(
				'project_id='.$options['project_id']
			)
		);
		$return = self::select($params);
		return $return[0]['amount'];
	}



	public static function getTotal($options=false)
	{
		$defaults = array(
			'start_date'=>false,
			'end_date'=>false,
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

		$r = parent::select($params);
		if(!empty($r)):
			$total = $r[0]['cant'];
		else:
			$total = 0;
		endif;
		return $total;

	}
	
}

?>
