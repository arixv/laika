<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:variable name="htmlHeadExtra">
	<link href="{$adminPath}/desktop/js/jvector-map/jquery-jvectormap-1.2.2.css" rel="stylesheet" />
	<link href="{$adminPath}/desktop/css/clndr.css" rel="stylesheet" />
	<link href="{$adminPath}/desktop/js/morris-chart/morris.css" rel="stylesheet"  />

</xsl:variable>

<xsl:variable name="htmlFooterExtra">
	<!--Morris Chart-->
	<script src="{$adminPath}/desktop/js/morris-chart/morris.js">&#xa0;</script>
	<script src="{$adminPath}/desktop/js/gauge/gauge.js">&#xa0;</script>
	<script src="{$adminPath}/desktop/js/morris-chart/raphael-min.js">&#xa0;</script>
	<script src="{$adminPath}/desktop/js/easypiechart/jquery.easypiechart.js">&#xa0;</script>

    <!-- jQuery Flot Chart-->
    <script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.js">&#xa0;</script>
    <script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.tooltip.min.js">&#xa0;</script>
    <script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.resize.js">&#xa0;</script>
    <script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.pie.resize.js">&#xa0;</script>
    <script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.selection.js">&#xa0;</script>
    <script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.stack.js">&#xa0;</script>
    <script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.time.js">&#xa0;</script>

	<script src="{$modPath}/desktop/js/dashboard.js" >&#xa0;</script>

	<script type="text/javascript">
	var data7_1 = [
		<xsl:for-each select="$content/estimated_payment_calendar/calendar">
	    	[<xsl:value-of select="date" />, <xsl:value-of select="total" />],
		</xsl:for-each>
	];
	var data7_2 = [
		<xsl:for-each select="$content/payment_calendar/calendar">
			<xsl:sort select="date" />
	    	[<xsl:value-of select="date" />, <xsl:value-of select="total" />],
		</xsl:for-each>
	];

	$(function() {
	    $.plot($("#visitors-chart #visitors-container"), 
	    [
	    	{
	        	data: data7_1,
	        	label: "Gasto Estimado",
	        	lines: {
	            	fill: true
	        	}
	    	}, 
	   	{
		        data: data7_2,
		        label: "Pago Realizado",

		        points: {
		            show: true
		        },
		        lines: {
		            show: true,
		            fill: false
		        },
		        yaxis: 2
		    }
		  
	    ],
	       {
	           series: {
	                lines: {
	                    show: true,
	                    fill: false
	                },
	                points: {
	                    show: true,
	                    lineWidth: 2,
	                    fill: true,
	                    fillColor: "#ffffff",
	                    symbol: "circle",
	                    radius: 5
	                },
	                shadowSize: 0
	            },
	            grid: {
	                hoverable: true,
	                clickable: true,
	                tickColor: "#f9f9f9",
	                borderWidth: 1,
	                borderColor: "#eeeeee"
	            },
	            colors: ["#79D1CF", "#E67A77"],
	            tooltip: true,
	            tooltipOpts: {
	                defaultTheme: false
	            },
	            xaxis: {
	                mode: "time",
	    			timeformat: "%d-%m-%Y"
	            },
	            yaxes: [{
	                /* First y axis */
	            }, {
	                position: "right" 
	            }]
	        }
	    );
	});

</script>

    <script>
        $(function() 
        {
            var data = [{
                label: "Presupuestos",
                data: <xsl:value-of select="$content/totales/presupuestos" />
            },
            {
                label: "Cancelados",
                data: <xsl:value-of select="$content/totales/cancelados" />
            },
            {
                label: "En Curso",
                data: <xsl:value-of select="$content/totales/encurso" />
            },
            {
                label: "Terminados ",
                data: <xsl:value-of select="$content/totales/terminados" />
            }];

            var options = {
                series: {
                    pie: {
                        show: true,
                        innerRadius: 0.5,
                        show: true
                    }
                },
                legend: {
                    show: true
                },
                grid: {
                    hoverable: true,
                    clickable: true
                },
                colors: ["#79D1CF", "#D9DD81", "#E67A77","#9972B5"],
                tooltip: true,
                tooltipOpts: {
                    defaultTheme: true
                }
            };
            $.plot($("#pie-chart-donut #pie-donutContainer"), data, options);
        });
    </script>

</xsl:variable>

<xsl:template name="content">



  <div class="row">
	    <div class="col-sm-12">
	        <section class="panel">
	            <header class="panel-heading">
	               Pagos
	               </header>
	            <div class="panel-body">
	                <div id="visitors-chart">
	                    <div id="visitors-container" style="width: 100%;height:300px; text-align: center; margin:0 auto;">
	                    </div>
	                </div>
	            </div>
	        </section>
	    </div>
	</div>

<div class="row">
    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon orange"><i class="fa fa-gavel">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span><xsl:value-of select="$content/totales/presupuestos" /></span>
                Presupuestos
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon tar"><i class="fa fa-tag">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span><xsl:value-of select="$content/totales/encurso" /></span>
                Proyectos Activos
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon pink"><i class="fa fa-money">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span><xsl:value-of select="$content/totales/excedidos" /></span>
                Proyectos Excedidos
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon green"><i class="fa fa-eye">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span><xsl:value-of select="$content/clientes_con_proyectos/total" /></span>
                Clientes con Proyectos
            </div>
        </div>
    </div>
</div>


<div class="row">
	<div class="col-md-8">
		<!--widget graph start-->
        <section class="panel">
            <header class="panel-heading">Estado de Proyectos</header>
            <div class="panel-body">
                 <div id="pie-chart-donut" class="pie-chart">
                    <div id="pie-donutContainer" style="width:100%;height:400px; text-align: left;">&#xa0;
                    </div>
                </div>
            </div>
        </section>

        <!--widget graph end-->
     </div>

 

     <div class="col-md-4">
        
                <section class="panel">
                    <header class="panel-heading">Próximos Pagos</header>
                    <div class="panel-body">
                        <xsl:for-each select="$content/payments/payment">
                            <xsl:variable name="thisDate" select="date" />
                            <xsl:variable name="thisClass">
                                <xsl:choose>
                                    <xsl:when test="$thisDate = $fechaActual">danger</xsl:when>
                                    <xsl:otherwise>info</xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <div class="alert alert-{$thisClass} clearfix">
                                <span class="alert-icon"><i class="fa fa-money">&#xa0;</i></span>
                                <div class="notification-info">
                                    <ul class="clearfix notification-meta">
                                        <li class="pull-left notification-sender"><span><a href="#">$ <xsl:value-of select="value" /></a></span></li>
                                        

                                        <li class="pull-right notification-time">
                                            <xsl:choose>
                                                <xsl:when test="$thisDate = $fechaActual">
                                                    <b>hoy</b>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:call-template name="fecha.formato.numerico">
                                                        <xsl:with-param name="fecha" select="date" />
                                                    </xsl:call-template>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </li>
                                    </ul>
                                    <p>
                                        <b><xsl:value-of select="resource/project_title" /><br/>
                                        <xsl:value-of select="resource/title" /></b><br/>
                                        <xsl:value-of select="resource/provider_title" />
                                    </p>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>
                </section>


                <section class="panel">
                    <header class="panel-heading">Próximos Cobros</header>
                    <div class="panel-body">
                        <xsl:for-each select="$content/cobros/cobro">
                            <xsl:variable name="thisDate" select="date" />
                            <xsl:variable name="thisClass">
                                <xsl:choose>
                                    <xsl:when test="$thisDate = $fechaActual">danger</xsl:when>
                                    <xsl:otherwise>info</xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>

                            <a href="/admin/cobros/edit/{id}" >
	                            <div class="alert alert-{$thisClass} clearfix">
	                                <span class="alert-icon"><i class="fa fa-money">&#xa0;</i></span>
	                                <div class="notification-info">
	                                    <ul class="clearfix notification-meta">
	                                        <li class="pull-left notification-sender"><span><a href="#">$ <xsl:value-of select="amount" /></a></span></li>
	                                        

	                                        <li class="pull-right notification-time">
	                                            <xsl:choose>
	                                                <xsl:when test="$thisDate = $fechaActual">
	                                                    <b>hoy</b>
	                                                </xsl:when>
	                                                <xsl:otherwise>
	                                                    <xsl:call-template name="fecha.formato.numerico">
	                                                        <xsl:with-param name="fecha" select="date" />
	                                                    </xsl:call-template>
	                                                </xsl:otherwise>
	                                            </xsl:choose>
	                                        </li>
	                                    </ul>
	                                    <p>
	                                        <b>Tipo: <xsl:value-of select="type" /></b>
	                                    </p>
	                                </div>
	                            </div>
	                         </a>
                        </xsl:for-each>
                    </div>
                </section>
           

    </div>
</div>

<div class="row">

	<div class="col-md-4">
    	<section class="panel">
    		<header class="panel-heading">Proveedores con Facturas Impagas</header>
    		<div class="panel-body">
    			<table class="table">
    				<thead>
    					<tr>
    						<th>#Factura</th>
    						<th>Fecha</th>
    						<th>Monto</th>
                            
    					</tr>
    				</thead>
    				<tbody>
                        <xsl:for-each select="$content/proveedores_impagos/object">
    					<tr>
    						<td><a href="/admin/project/edit_factura/{project_id}/factura/{id}" ><xsl:value-of select="number" /></a></td>

    						<td>
                                <xsl:call-template name="fecha.formato.numerico">
                                    <xsl:with-param name="fecha" select="date" />
                                </xsl:call-template>
                            </td>
    						<td>$ <xsl:value-of select="amount" /></td>
                            
    					</tr>
                        </xsl:for-each>
    					
    				</tbody>
    			</table>
    		</div>
    	</section>
    </div>


    <div class="col-md-4">
    	<section class="panel">
    		<header class="panel-heading">Top 5 Rubros más costos</header>
    		<div class="panel-body">
    			<table class="table">
    				<thead>
    					<tr>
    						<th>Subrubro</th>
    						<th>Monto</th>
    					</tr>
    				</thead>
    				<tbody>
                        <xsl:for-each select="$content/rubros_mas_costosos/object">
        					<tr>
        						<td><xsl:value-of select="title" /></td>
        						<td>$ <xsl:value-of select="cost" /></td>
        					</tr>
                        </xsl:for-each>
    				</tbody>
    			</table>
    		</div>
    	</section>
    </div>

    <div class="col-md-4">
    	<section class="panel">
    		<header class="panel-heading">Top 5 Rubros más utilizados</header>
    		<div class="panel-body">
    			<table class="table">
    				<thead>
    					<tr>
    						<th>Subrubro</th>
    					</tr>
    				</thead>
    				<tbody>
    					<xsl:for-each select="$content/rubros_mas_utilizados/object">
                            <tr>
                                <td><xsl:value-of select="title" /></td>
                            </tr>
                        </xsl:for-each>
    				</tbody>
    			</table>
    		</div>
    	</section>
    </div>
</div>


<div class="row">

	<div class="col-md-4">
    	<section class="panel">
    		<header class="panel-heading">Usuarios con proyectos en cursos</header>
    		<div class="panel-body">
    			<table class="table">
    				<thead>
    					<tr>
    						<th>Nombre</th>
    						<th><span class="pull-right">Proyectos</span></th>
    					</tr>
    				</thead>
    				<tbody>
                        <xsl:for-each select="$content/users_topfive/user">
    					<tr>
    						<td><xsl:value-of select="user_name" />&#xa0;<xsl:value-of select="user_lastname" /></td>
    						<td><span class="label label-danger pull-right"><xsl:value-of select="total_project" /></span></td>
    					</tr>
                        </xsl:for-each>
    					
    				</tbody>
    			</table>
    		</div>
    	</section>
    </div>


    <div class="col-md-4">
    	<section class="panel danger">
    		<header class="panel-heading">Proyectos más rentables</header>
    		<div class="panel-body">
    			<table class="table">
    				<thead>
    					<tr>
    						<th>Nombre</th>
    						<th><span class="pull-right">Rentabilidad</span></th>
    					</tr>
    				</thead>
    				<tbody>
                        <xsl:for-each select="$content/rentabilidad/object[result&lt;0]">
                        	<xsl:variable name="estimated" >
                        		<xsl:value-of select="estimated_cost" />
                        	</xsl:variable>	
        					<tr>
        						<td><a href="{$adminroot}project/dashboard/{id}"><xsl:value-of select="title"/></a></td>
        						<td><span class="label label-danger pull-right"><xsl:value-of select="floor(result * 100 div $estimated * -1)"/> %</span></td>
        					</tr>
                        </xsl:for-each>
    				</tbody>
    			</table>
    		</div>
    	</section>
    </div>

    <div class="col-md-4">
    	<section class="panel">
    		<header class="panel-heading">Mejores Clientes</header>
    		<div class="panel-body">
    			<table class="table">
    				<thead>
    					<tr>
    						<th>Nombre</th>
    						<th><span class="pull-right">Proyectos</span></th>
    					</tr>
    				</thead>
    				<tbody>
    					 <xsl:for-each select="$content/best_clients/object">
    					 	<tr>
								<td><xsl:value-of select="title"/></td>
								<td><span class="label label-warning pull-right"><xsl:value-of select="total_project"/></span></td>
							</tr>
    					 </xsl:for-each>
    				</tbody>
    			</table>
    		</div>
    	</section>
    </div>
</div>

</xsl:template>
</xsl:stylesheet>