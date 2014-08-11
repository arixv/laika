<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="type" />

<!-- PROJECT OBJECT -->
<xsl:variable name="object" select="$content/object" />

<!-- TOTAL ESTIMATE -->
<xsl:variable name="total_estimate">
<xsl:value-of select="$content/estimate/total" />
</xsl:variable>

<!-- IMPREVISTOS -->
<xsl:variable name="total_imprevistos">
<xsl:value-of select="$total_estimate * $object/imprevistos div 100" />
</xsl:variable>

<!-- GANANCIAS -->
<xsl:variable name="total_ganancia">
<xsl:value-of select="($total_estimate + $total_imprevistos) * $object/ganancia div 100" />
</xsl:variable>

<!-- IMPUESTOS -->
<xsl:variable name="total_impuestos">
<xsl:value-of select="($total_ganancia + $total_imprevistos + $total_estimate) * $object/impuestos div 100" />
</xsl:variable>

<!-- HEAD EXTRA -->
<xsl:variable name="htmlHeadExtra">
	<script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script>
	<script src="{$modPath}/desktop/js/project.edit.js" type="text/javascript">&#xa0;</script>
</xsl:variable>

<!-- FOOTER EXTRA -->
<xsl:variable name="htmlFooterExtra">
	<script src="{$adminPath}/desktop/js/morris-chart/morris.js">&#xa0;</script>
	<script src="{$adminPath}/desktop/js/gauge/gauge.js">&#xa0;</script>
	<script src="{$adminPath}/desktop/js/morris-chart/raphael-min.js">&#xa0;</script>
	<script src="{$adminPath}/desktop/js/easypiechart/jquery.easypiechart.js">&#xa0;</script>

	
	<!--Chart JS-->
	<script src="{$adminPath}/desktop/js/chart-js/Chart.js">&#xa0;</script>

	<script type="text/javascript" >
		if (Gauge) {
		var opts = {
		    lines: 12, // The number of lines to draw
		    angle: 0, // The length of each line
		    lineWidth: 0.48, // The line thickness
		    pointer: {
		        length: 0.6, // The radius of the inner circle
		        strokeWidth: 0.03, // The rotation offset
		        color: '#464646' // Fill color
		    },
		    limitMax: 'true', // If true, the pointer will not go past the end of the gauge
		    colorStart: '#fa8564', // Colors
		    colorStop: '#fa8564', // just experiment with them
		    strokeColor: '#F1F1F1', // to see which ones work best for you
		    generateGradient: true
		};


		var target = document.getElementById('gauge'); // your canvas element
		var gauge = new Gauge(target).setOptions(opts); // create sexy gauge!
		gauge.maxValue = <xsl:value-of select="$total_estimate" />; // set max gauge value
		gauge.animationSpeed = 50; // set animation speed (32 is default value)
		gauge.set(<xsl:value-of select="$content/partidas/@amount + $content/facturas/@paid-amount-withno-partida" />); // set actual value
		}

	    var barChartData = {
            labels : [
            	"ALQUILER DE CAMARAS",
            	"PRODUCCION",
            	"VARIOS",
            	"OTROS",
            	"CONTENIDO",
            	"June",
            	"July",
            	"ALQUILER DE CAMARAS",
            	"PRODUCCION",
            	"VARIOS",
            	"OTROS",
            	"CONTENIDO",
            	"June",
            	"July",
            	"ALQUILER DE CAMARAS",
            	"PRODUCCION",
            	"VARIOS",
            	"OTROS",
            	"CONTENIDO",
            	"June",
            	"July",
            	"ALQUILER DE CAMARAS",
            	"PRODUCCION",
            	"VARIOS",
            	"OTROS",
            	"CONTENIDO",
            	"June",
            	"July"
            ],
            datasets : [
                {
                    fillColor : "#E67A77",
                    strokeColor : "#E67A77",
                    data : [
                    	1265,
                    	59,
                    	90,
                    	81,
                    	56,
                    	55,
                    	40,
                    	65,
                    	59,
                    	90,
                    	81,
                    	56,
                    	55,
                    	40,
                    	65,
                    	59,
                    	90,
                    	81,
                    	56,
                    	55,
                    	40,
                    	65,
                    	59,
                    	90,
                    	81,
                    	56,
                    	55,
                    	40
                    ]
                },
                {
                    fillColor : "#79D1CF",
                    strokeColor : "#79D1CF",
                    data : [1000,48,40,19,96,27,100,28,48,40,19,96,27,100,28,48,40,19,96,27,100,28,48,40,19,96,27,100]
                }
            ]

        }

        var myLine = new Chart($("#bar-chart-js").getContext("2d")).Bar(barChartData);

	</script>

</xsl:variable>


<xsl:template name="content">



<xsl:call-template name="project.nav" >
	<xsl:with-param name="active" >dashboard</xsl:with-param>
</xsl:call-template>

<form name="edit" action="{$adminroot}{$modName}/edit/" method="post">

<xsl:if test="$content/object/@state !=0">
	<div class="row">

	    <div class="col-md-3">
	        <div class="mini-stat clearfix">
	            <span class="mini-stat-icon orange"><i class="fa fa-gavel">&#xa0;</i></span>
	            <div class="mini-stat-info">
	               <a href="{$adminroot}{$modName}/list_factura/{$object/@id}">
	               	<span><xsl:value-of select="$content/facturas/@pendientes" /></span>
	                Facturas Pendientes
	               </a>
	            </div>
	        </div>
	    </div>
	    <div class="col-md-3">
	        <div class="mini-stat clearfix">
	            <span class="mini-stat-icon tar"><i class="fa fa-tag">&#xa0;</i></span>
	            <div class="mini-stat-info">
	            	<a href="{$adminroot}{$modName}/list_factura/{$object/@id}">
	                	<span><xsl:value-of select="$content/facturas/@pagas" /></span>
	                	Facturas Pagas
	                </a>
	            </div>
	        </div>
	    </div>
	    <div class="col-md-3">
	        <div class="mini-stat clearfix">
	            <span class="mini-stat-icon pink"><i class="fa fa-money">&#xa0;</i></span>
	            <div class="mini-stat-info">
	            	<a href="{$adminroot}{$modName}/list_partida/{$object/@id}">
	                	<span>$ <xsl:value-of select="$content/partidas/@amount" /></span>
	                	Monto total Partidas
	                </a>
	            </div>
	        </div>
	    </div>
	    <div class="col-md-3">
	        <div class="mini-stat clearfix">
	            <span class="mini-stat-icon green"><i class="fa fa-eye">&#xa0;</i></span>
	            <div class="mini-stat-info">
	                <a href="{$adminroot}{$modName}/list_partida/{$object/@id}">
	                	<span><xsl:value-of select="$content/partidas/@total" /></span>
	                	Partidas
	                </a>
	            </div>
	        </div>
	    </div>
	</div><!-- /row -->
</xsl:if>

<div class="row" >

	<xsl:if test="$content/object/@state !=0">
		<div class="col-sm-8">
			<!-- PANEL TOTAL PRESUPUESTADO VS TOTAL GASTOS -->
			 <section class="panel">
		        <div class="panel-body">
		            <div class="top-stats-panel">
		                <div class="gauge-canvas">
		                    <h4 class="widget-h">Total Presupuestado<br/>$ <xsl:value-of select="$total_estimate" /></h4>
		                    <canvas width="160" height="100" id="gauge"></canvas>
		                </div>
		                <ul class="gauge-meta clearfix">
		                    <li id="gauge-textfield" class="pull-left gauge-value">Total Gastos $<xsl:value-of select="$content/partidas/@amount + $content/facturas/@paid-amount-withno-partida" /></li>
		                    <li class="pull-right gauge-title">Gastos vs. Presupuestado</li>
		                </ul>
		            </div>
		        </div>
		    </section>
		    <!-- // PANEL TOTAL PRESUPUESTADO VS TOTAL GASTOS -->

		    <xsl:if test="$content/payments/payment">
			    <section class="panel">
			    	<header class="panel-heading">Próximos pagos</header>
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
					                        		<xsl:value-of select="date" />
					                        	</xsl:otherwise>
					                        </xsl:choose>
				                       	</li>
				                    </ul>
				                    <p><b><xsl:value-of select="resource/title" /></b> (<xsl:value-of select="resource/provider_title" />)</p>
				                </div>
				            </div>
				        </xsl:for-each>
			        </div>
			    </section>
			</xsl:if>

		</div>
	</xsl:if>

			


	<div class="col-sm-4">


		<xsl:if test="$object/@state != 0">
			<section class="panel">
				<header class="panel-heading">Progreso</header>
				<div class="panel-body">
					<div class="form-group">
						<label><xsl:value-of select="$content/progress/value" />% Completado</label>
						<div class="progress">
		                    <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:{$content/progress/value}%;">
		                        &#xa0;
		                    </div>
		                </div>
		            </div>
				</div>
			</section>
		</xsl:if>

		<section class="panel">
			<header class="panel-heading">Estimación</header>
			<div class="panel-body">

								


				<div class="form-group">
					<label>Estimación de Recursos</label> $<xsl:value-of select="$content/estimate/total" />
				</div>		
				<div class="form-group">
					<!-- <label class="label label-danger">Costo Real de Recursos $<xsl:value-of select="$content/real/total" /></label> -->
					<p class="text-danger"><b>Costo Real de Recursos $<xsl:value-of select="$content/real/total" /></b></p>
				</div>	
				
                <div class="form-group">
					
					<div class="row">
						<label class="col-md-6">Imprevistos</label>
						<div class="col-md-2">
							<h5>$<xsl:value-of select="$total_imprevistos" /></h5>
						</div>
						
					</div>
				</div>
				<div class="form-group">
					<div class="row">
						<label class="col-md-6">Ganancia</label>
						<div class="col-md-2">
							<h5>$<xsl:value-of select="floor($total_ganancia)" /></h5>
						</div>
						
					</div>
				</div>
				<div class="form-group">
					<div class="row">
						<label class="col-md-6">Impuestos</label>
						<div class="col-md-6">
							<h5>$<xsl:value-of select="floor($total_impuestos)" /></h5>
						</div>
						
					</div>
				</div>

				<xsl:variable name="total_neto"><xsl:value-of select="floor($content/estimate/total + $total_imprevistos + $total_ganancia + $total_impuestos)" /></xsl:variable>

				<xsl:variable name="iva"><xsl:value-of select="$total_neto * $object/iva div 100" /></xsl:variable>


				<div class="form-group">
					<div class="row">
						<label class="col-md-6">IVA <xsl:value-of select="$object/iva"/>%</label>
						<div class="col-md-6">
							<h5>$ <xsl:value-of select="$iva" /></h5>
						</div>
						
					</div>
				</div>

				<div class="form-group">
					<div class="row">
						<label class="col-md-6">Total Neto</label>
						<div class="col-md-6">
							<h5>$<xsl:value-of select="$total_neto" /></h5>
						</div>
					</div>
				</div>

				<hr />

				


				<div class="form-group">
					<h4 class="col-md-6">Total</h4>
					<h4 class="col-md-6">$<xsl:value-of select="$total_neto + $iva" /></h4>
				</div>


			</div>
		</section>

	</div>
</div>




</form>










<div id="modal" class="modal fade" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>

</xsl:template>
</xsl:stylesheet>