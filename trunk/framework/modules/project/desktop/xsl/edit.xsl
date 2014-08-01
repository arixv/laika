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
		gauge.set(<xsl:value-of select="$content/partidas/@amount" />); // set actual value
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



<xsl:call-template name="project.nav" />

<form name="edit" action="{$adminroot}{$modName}/edit/" method="post">


<div class="row">

    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon orange"><i class="fa fa-gavel">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span><xsl:value-of select="$content/facturas/@pendientes" /></span>
                Facturas Pendientes
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon tar"><i class="fa fa-tag">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span><xsl:value-of select="$content/facturas/@pagas" /></span>
                Facturas Pagas
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon pink"><i class="fa fa-money">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span>$ <xsl:value-of select="$content/partidas/@amount" /></span>
                Monto total Partidas
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon green"><i class="fa fa-eye">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span><xsl:value-of select="$content/partidas/@total" /></span>
                Partidas
            </div>
        </div>
    </div>


</div><!-- /row -->

<div class="row" >
	<div class="col-sm-8">
			<section class="panel">
				
				<header class="panel-heading wht-bg"><h4 class="gen-case">Editar Proyecto</h4></header>
				
				<div class="panel-body">
					
						<input type="hidden" name="modToken" value="{$modToken}" />
						<input type="hidden" name="id" value="{$object/@id}" />
						<input type="hidden" name="modification_userid" value="{$config/user/@user_id}" />
						<input type="hidden" name="modification_usertype" value="backend" />
							
						<div class="form-group" >
							<label>Título</label>
							<input type="text" maxlength="200" class="form-control" name="title" value="{$object/title}"/>
						</div>
	 					<div class="form-group">
							<label>Descripción</label>
							<textarea name="description" id="description" class="form-control">
								<xsl:apply-templates select="$object/description"/>
								<xsl:comment />
							</textarea>
						</div>
						<div class="form-group">
							<label>Cliente</label>
							
							
							<select name="client_id" class="form-control" >
								<xsl:for-each select="$content/clients/object">
									<option  value="{@id}">
										<xsl:if test="@id = $object/client_id">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										<xsl:value-of select="title" />
									</option>
								</xsl:for-each>
							</select>
						</div>
						<div class="form-group">
							<label>Tipo</label>
							<div class="label label-default">
								<xsl:choose>
									<xsl:when test="$content/object/type = 'TV'">TV</xsl:when>
									<xsl:when test="$content/object/type = 'Publicidad'">Publicidad</xsl:when>
									<xsl:when test="$content/object/type = 'Servicio'">Servicio</xsl:when>
								</xsl:choose>
							</div>
						</div>
						
						<xsl:choose>
							<xsl:when test="$content/object/type = 'TV'">
								<div class="type_options" id="TV" >
									<div class="form-group">
										<label>Cantidad de Programas</label>
										<input type="text" name="type_option_programas" value="{$content/object/type_option_programas}" class="form-control" />
									</div>
									<div class="form-group">
										<label>Segundaje de Programas</label>
										<input type="text" name="type_option_segundaje" value="{$content/object/type_option_segundaje}" class="form-control" />
									</div>
								</div>
							</xsl:when>
							<xsl:when test="$content/object/type = 'Publicidad'">
								<div class="type_options" id="Publicidad" >
									<div class="form-group">
										<label>Producto</label>
										<input type="text" name="type_option_producto" value="{$content/object/type_option_producto}" class="form-control" />
									</div>
									<div class="form-group">
										<label>Duración</label>
										<input type="text" name="type_option_duracion" value="{$content/object/type_option_duracion}" class="form-control" />
									</div>
									<div class="form-group">
										<label>Medio</label>
										<input type="text" name="type_option_medio" value="{$content/object/type_option_medio}"  class="form-control" />
									</div>
								</div>
							</xsl:when>
							<xsl:when test="$content/object/type = 'Servicio'">
								<div class="type_options" id="Servicio" >
									<div class="form-group">
										<label>Producto</label>
										<input type="text" name="type_option_tipo_servicio" value="{$content/object/type_option_tipo_servicio}"  class="form-control" />
									</div>
								</div>
							</xsl:when>
						</xsl:choose>



					


					


			</div>
		</section>

		 <section class="panel">
	        <div class="panel-body">
	            <div class="top-stats-panel">
	                <div class="gauge-canvas">
	                    <h4 class="widget-h">Total Presupuestado<br/>$ <xsl:value-of select="$total_estimate" /></h4>
	                    <canvas width="160" height="100" id="gauge"></canvas>
	                </div>
	                <ul class="gauge-meta clearfix">
	                    <li id="gauge-textfield" class="pull-left gauge-value">Total Partidas $<xsl:value-of select="$content/partidas/@amount" /></li>
	                    <li class="pull-right gauge-title">Partidas vs. Presupuestado</li>
	                </ul>
	            </div>
	        </div>




	    </section>







	</div>

	<div class="col-sm-4">
		<section class="panel">
			<header class="panel-heading">Información</header>
			<div class="panel-body">
				<div class="form-group">
					<label>Estado</label>
					<span class="label label-{$content/states/state[id=$object/@state]/label}"><xsl:value-of select="$content/states/state[id=$object/@state]/name" /></span>
				</div>
				
				<div class="form-group">
					<select name="state" class="form-control">
						<xsl:for-each select="$content/states/state">
							<option value="{id}">
								<xsl:if test="$object/@state = id" >
									<xsl:attribute name="selected">selected</xsl:attribute>
								</xsl:if>
								<xsl:value-of select="name" />
							</option>
						</xsl:for-each>
					</select>
					
				</div>

				<xsl:if test="$object/@state != 0">
					<div class="form-group">
						<label>Progreso (<xsl:value-of select="$content/progress/value" />% Completado)</label>
						<div class="progress">
		                    <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:{$content/progress/value}%;">
		                        &#xa0;
		                    </div>
		                </div>
		                
		            </div>
		        </xsl:if>


			  	<div class="form-group">
                	<label>Creado por</label>
                	<span class="label label-default"><xsl:value-of select="$content/project_owner/name" />&#xa0;<xsl:value-of select="$content/project_owner/lastname" />&#xa0;</span>
                </div>

                <div class="form-group">
                	<label>Fecha Inicio</label>
                	<div data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date=""  class="input-append date dpYears">
	        			<input type="text" name="start_date" size="16" class="form-control form-control-inline input-medium default-date-picker" value="{$object/@start_date}" />
	        		</div>
	        		
                </div>
                <div class="form-group">
                	<label>Fecha Fin</label>
                	<div data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date=""  class="input-append date dpYears">
                		<input type="text" name="end_date" class="form-control form-control-inline input-medium default-date-picker" value="{$object/@end_date}" />
                	</div>
                </div>


                <script>
            		$('.default-date-picker').datepicker({format: 'yyyy-mm-dd'});
				    $('.dpYears').datepicker();
				</script>

				<div class="form-group">
					<button type="submit" class="btn btn-info pull-right">Guardar</button>
					<a href="" class="btn"><i class="fa fa-trash-o">&#xa0;</i>Eliminar</a>
				</div>
			</div>
		</section>

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
						<div class="col-md-4">
							<div class="input-group m-bot15">
								<input type="text" class="form-control" name="imprevistos" value="{$object/imprevistos}" />
								<span class="input-group-addon btn-default">%</span>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="row">
						<label class="col-md-6">Ganancia</label>
						<div class="col-md-2">
							<h5>$<xsl:value-of select="$total_ganancia" /></h5>
						</div>
						<div class="col-md-4">
							<div class="input-group m-bot15">
								<input type="text" class="form-control" name="ganancia" value="{$object/ganancia}" />
								<span class="input-group-addon btn-default">%</span>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="row">
						<label class="col-md-6">Impuestos</label>

						<div class="col-md-2">
							<h5>$<xsl:value-of select="$total_impuestos" /></h5>
						</div>
						<div class="col-md-4">
							<div class="input-group m-bot15">
								<input type="text" class="form-control" name="impuestos" value="{$object/impuestos}" />
								<span class="input-group-addon btn-default">%</span>
							</div>
						</div>
					</div>
				</div>

				<hr />

				<div class="form-group">
					<h4>Total $<xsl:value-of select="$content/estimate/total + $total_imprevistos + $total_ganancia + $total_impuestos" /></h4>
				</div>


			</div>
		</section>



	</div>
</div>


<!-- 

<div class="row" >
	<div class="col-sm-12">				
		
				
	    <section class="panel">
            <header class="panel-heading">
               Estimado por Rubro vs Gasto Real por Rubro
            </header>
            <div class="panel-body">

                <div class="chartJS">
                    <canvas id="bar-chart-js" height="600" width="1300" ></canvas>
                </div>

            </div>
        </section>
 

	</div>
</div> -->


</form>










<div id="modal" class="modal fade" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>

</xsl:template>
</xsl:stylesheet>