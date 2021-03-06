<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="type" />
<xsl:param name="indice" />
<xsl:param name="iva" />
<xsl:param name="total_estimate" />
<xsl:param name="total_imprevistos" />
<xsl:param name="total_ganancia" />
<xsl:param name="total_impuestos" />
<xsl:param name="subtotal_neto" />

<!-- PROJECT OBJECT -->
<xsl:variable name="object" select="$content/object" />



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

	<!-- jQuery Flot Chart-->
	<script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.js">&#xa0;</script>
	<script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.tooltip.min.js">&#xa0;</script>
	<script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.resize.js">&#xa0;</script>
	<script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.pie.resize.js">&#xa0;</script>
	<script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.selection.js">&#xa0;</script>
	<script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.stack.js">&#xa0;</script>
	<script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.time.js">&#xa0;</script>


	<xsl:if test="$content/object/@state != 0">
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
				var gauge_set = <xsl:value-of select="$content/partidas/@amount + $content/facturas/@paid-amount-withno-partida" />;
				gauge.set(gauge_set); // set actual value
				}
		   	
			</script>
	</xsl:if>

	<xsl:if test="$content/object/@state != 0">
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
	</xsl:if>

</xsl:variable>


<xsl:template name="content">



<xsl:call-template name="project.nav" >
	<xsl:with-param name="active" >dashboard</xsl:with-param>
</xsl:call-template>

<form name="edit" action="{$adminroot}{$modName}/edit/" method="post">


	<div class="row">
	    <div class="col-sm-12">
	    	<section class="panel">
	    		<div class="panel-body">
	    			<div class="btn-group pull-right">
						  <button type="button" class="btn btn-primary  dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						    Imprimir <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu">
						    <li><a target="_impresion_interna" href="/admin/project/print/{$object/@id}" >Impresión interna</a></li>
						    <li><a target="_impresion_cliente" href="/admin/project/print_client/{$object/@id}" >Imprimir para Cliente</a></li>
						  </ul>
						</div>
	    		</div>
	    	</section>
	    </div>
	</div>
	
<xsl:if test="$content/object/@state !=0">


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
</xsl:if>

<xsl:if test="$content/object/@state !=0">
	<div class="row">

	    <div class="col-md-4">
	        <div class="mini-stat clearfix">
	            <span class="mini-stat-icon orange"><i class="fa fa-gavel">&#xa0;</i></span>
	            <div class="mini-stat-info">
	               <a href="{$adminroot}{$modName}/list_factura/{$object/@id}">
	               	<xsl:value-of select="$content/facturas/@pendientes" />
	                Facturas Pendientes<br/>
	                <span>$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="$content/facturas/@amount - $content/facturas/@paid-amount" /></xsl:call-template>
	            	</span>
	               </a>
	            </div>
	        </div>
	    </div>

	    <div class="col-md-4">
	        <div class="mini-stat clearfix">
	            <span class="mini-stat-icon tar"><i class="fa fa-tag">&#xa0;</i></span>
	            <div class="mini-stat-info">
	            	<a href="{$adminroot}{$modName}/list_factura/{$object/@id}">
	                	<xsl:value-of select="$content/facturas/@pagas" /> Facturas Pagas
	                	<span>$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="$content/facturas/@paid-amount" /></xsl:call-template></span>
	                </a>
	            </div>
	        </div>
	    </div>

	    <div class="col-md-4">
	        <div class="mini-stat clearfix">
	            <span class="mini-stat-icon pink"><i class="fa fa-money">&#xa0;</i></span>
	            <div class="mini-stat-info">
	            	<a href="{$adminroot}{$modName}/list_partida/{$object/@id}">
	                	Total <xsl:value-of select="$content/partidas/@total" /> Partidas
	                	<span>$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="$content/partidas/@amount" /></xsl:call-template></span>
	                </a>
	            </div>
	        </div>
	    </div>
	</div><!-- /row -->
</xsl:if>


<xsl:if test="$content/object/@state !=0">

	<div class="row" >
		<div class="col-sm-8">
			<!-- PANEL TOTAL PRESUPUESTADO VS TOTAL GASTOS -->
			 <section class="panel">
		        <div class="panel-body">
		            <div class="top-stats-panel">
		                <div class="gauge-canvas">
		                    <h4 class="widget-h">Total Presupuestado<br/>$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="$total_estimate" /></xsl:call-template></h4>
		                    <canvas width="160" height="100" id="gauge"></canvas>
		                </div>
		                <ul class="gauge-meta clearfix">
		                    <li id="gauge-textfield" class="pull-left gauge-value">Total Gastos $<xsl:call-template name="format.price"><xsl:with-param name="amount" select="$content/partidas/@amount + $content/facturas/@paid-amount-withno-partida" /></xsl:call-template></li>
		                    <li class="pull-right gauge-title">Gastos vs. Presupuestado</li>
		                </ul>
		            </div>
		        </div>
		    </section>
		    <!-- // PANEL TOTAL PRESUPUESTADO VS TOTAL GASTOS -->

		    <xsl:if test="$content/future_payments/payment">
			    <section class="panel">
			    	<header class="panel-heading">Próximos pagos</header>
			        <div class="panel-body">
			        	<xsl:for-each select="$content/future_payments/payment">
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
				                        <li class="pull-left notification-sender"><span><a href="#">$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="value" /></xsl:call-template></a></span></li>
				                        

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
            <header class="panel-heading">Próximos Cobros</header>
            <div class="panel-body">
            	<xsl:choose>
            		<xsl:when test="$content/cobros/cobro">
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
		                                    <li class="pull-left notification-sender"><span>$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="amount" /></xsl:call-template></span></li>
		                                    

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
		                                    <b>Cliente: <xsl:value-of select="client_title" /></b>
		                                </p>
		                            </div>
		                        </div>
		                     </a>
		                </xsl:for-each>
		              </xsl:when>
		              <xsl:otherwise>
						<p>No tiene próximos cobros</p>
		              </xsl:otherwise>
		           </xsl:choose>
            </div>
        </section>

	</div>
</div>

</xsl:if>



<div class="row">

	<div class="col-sm-12">
		
		<section class="panel">
			<header class="panel-heading">Estimación</header>
			<div class="panel-body">

				<!-- row -->
				<div class="row">
					<div class="col-md-6"><!-- column left -->

						
						<div class="form-group">
							<div class="row">
								<label class="col-md-6">SUBTOTAL RECURSOS</label> 
								<p class="col-md-6 text-right">$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="$content/estimate/total" /></xsl:call-template></p>
							</div>	
						</div>	

						<div class="form-group">
							<div class="row">
								<label class="col-md-6">INDICE EPL</label> 
								<!-- <p class="col-md-6 text-right"><input type="number" value="{$object/indice_epl}" min="0" step="0.01" data-number-to-fixed="2" data-number-stepfactor="100" class="currency"  /></p> -->
								<p class="col-md-6 text-right">$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="$object/indice_epl" /></xsl:call-template></p>
							</div>	
						</div>	


		                <div class="form-group">
							<div class="row">
								<label class="col-md-6">IMPREVISTOS</label>
								<div class="col-md-6 text-right">
									<h5>$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="$total_imprevistos" /></xsl:call-template></h5>
								</div>
							</div>
						</div>

						<div class="form-group">
							<div class="row">
								<label class="col-md-6">HONORARIOS PRODUCTORA</label>
								<div class="col-md-6 text-right">
									<h5>$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="$total_ganancia" /></xsl:call-template></h5>
								</div>
							</div>
						</div>

						<div class="form-group">
							<div class="row">
								<label class="col-md-6">IMPUESTOS</label>
								<div class="col-md-6 text-right">
									<h5>$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="ceiling($total_impuestos)" /></xsl:call-template></h5>
								</div>
								
							</div>
						</div>

						<xsl:variable name="iva"><xsl:value-of select="$iva" /></xsl:variable>

						<div class="form-group">
							<div class="row">
								<label class="col-md-6">SUBTOTAL NETO</label>
								<div class="col-md-6 text-right">
									<h5>$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="$subtotal_neto" /></xsl:call-template></h5>
								</div>
							</div>
						</div>

						<div class="form-group">
							<div class="row">
								<label class="col-md-6">IVA 21%</label>
								<h5 class="col-md-6 text-right">$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="$iva" /></xsl:call-template></h5>
							</div>
						</div>

						<hr />


						<div class="form-group">
							<div class="row">
								<h4 class="col-md-6">Total</h4>
								<h4 class="col-md-6 text-right">$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="$subtotal_neto + $iva" /></xsl:call-template></h4>
							</div>	
						</div>

					</div><!-- // column left-->
					
					<div class="col-md-6">
						<xsl:if test="$object/@state != 0">
							<div class="form-group">
								<div class="row">
									<label class="col-md-6 text-danger">SUBTOTAL RECURSOS REAL</label> 
									<p class="col-md-6">
										<b class="text-danger">$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="$content/real/total" /></xsl:call-template></b>
									</p>
								</div>	
							</div>	
						</xsl:if>

					</div>
				</div><!-- //row -->

			</div>
		</section>
	</div>
</div>

</form>

<div id="modal" class="modal" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>

</xsl:template>
</xsl:stylesheet>