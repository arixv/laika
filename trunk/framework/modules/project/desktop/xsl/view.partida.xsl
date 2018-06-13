<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="type" />

<!-- HEAD EXTRA -->
<xsl:variable name="htmlHeadExtra">
	<script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script>
	<script src="{$modPath}/desktop/js/project.edit.js" type="text/javascript">&#xa0;</script>
</xsl:variable>

<!-- FOOTER EXTRA -->
<xsl:variable name="htmlFooterExtra">
	<script src="{$adminPath}/desktop/js/gauge/gauge.js">&#xa0;</script>
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
		    limitMax: 'false', // If true, the pointer will not go past the end of the gauge
		    colorStart: '#fa8564', // Colors
		    colorStop: '#fa8564', // just experiment with them
		    strokeColor: '#F1F1F1', // to see which ones work best for you
		    generateGradient: true
		};


		var target = document.getElementById('gauge'); // your canvas element
		var gauge = new Gauge(target).setOptions(opts); // create sexy gauge!
		gauge.maxValue = <xsl:value-of select="$content/partida/amount" />; // set max gauge value
		gauge.animationSpeed = 80; // set animation speed (32 is default value)
		gauge.set(<xsl:value-of select="$content/partida/@total_facturado" />); // set actual value
		}
	</script>
</xsl:variable>


<xsl:template name="content">

	<xsl:call-template name="project.nav">
		<xsl:with-param name="active" >partida</xsl:with-param>
	</xsl:call-template>

	<div class="row">
		<div class="col-md-12">
			<section class="panel">
				<header class="panel-heading wht-bg">
					
					<a target="_blank" href="/admin/project/print_partida_single/{$content/object/@id}/{$content/partida/id}" class="btn pull-right btn-primary" aria-haspopup="true" aria-expanded="false">
						Imprimir Partida
					</a>

					<h4 class="gen-case">
						Partida #<xsl:value-of select="$content/partida/id" />
					</h4>
				</header>
			</section>
		</div>
	</div>

	<div class="row" >
		<div class="col-sm-6">
				<section class="panel">
					
					<header class="panel-heading wht-bg">
						<h4 class="gen-case">
							Detalles
						</h4>
					</header>
					
					<div class="panel-body">
						
						<form name="addPartida" role="form" action="/admin/?m=project&amp;action=BackEditPartida" method="post">
                    		<input type="hidden" name="modToken" value="{$modToken}" />
							<input type="hidden" name="id" value="{$content/partida/id}" />
							<input type="hidden" name="project_id" value="{$content/object/@id}" />
							<input type="hidden" name="modification_userid" value="{$config/user/@user_id}" />
							<input type="hidden" name="modification_usertype" value="backend" />

                    		<div class="row form-group">
                    			<div class="col-sm-6">
                        			<label>Fecha del pedido</label>
                        			<div data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date="{$content/partida/date}"  class="input-append date dpYears" >
	                        			<input type="text" readonly="readonly" value="{$content/partida/date}" name="date" size="16" class="form-control default-date-picker" />
	                        		</div>
	                        	</div>
	                        	<div class="col-sm-6">
	                        		<label>Solicitante</label>
	                        		<input type="text" readonly="readonly"  name="responsable" value="{$content/partida/responsable}" class="form-control" />
	                        	</div>
                        	</div>

                        	<div class="form-group">
                        		<label>Descripción</label>
                        		<textarea name="description" readonly="readonly"  class="form-control" ><xsl:value-of select="$content/partida/description" /></textarea>
                        	</div>

                        	<div class="form-group">
                        		<label>Monto</label>
                        		<div class="input-group m-bot15">
                        		    <span class="input-group-addon btn-success">$</span>
                            		<input type="text" readonly="readonly"  name="amount" value="{$content/partida/amount}" class="form-control" />
                        		</div>
                        	</div>
	                        
                        </form>

				</div>
			</section>
		</div>

		<div class="col-sm-6">
			 <section class="panel">
		        <div class="panel-body">
		            <div class="top-stats-panel">
		                <div class="gauge-canvas">
		                    <h4 class="widget-h">Total Partida $ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="$content/partida/amount" /></xsl:call-template></h4>
		                    <canvas width="160" height="100" id="gauge"></canvas>
		                </div>
		                <ul class="gauge-meta clearfix">
		                    <li id="gauge-textfield" class="pull-left gauge-value">Total Rendido $<xsl:value-of select="$content/partida/@total_facturado" /></li>
		                    <li class="pull-right gauge-title">Monto Partida vs. Rendido</li>
		                </ul>
		            </div>

		           

		        </div>
		    </section>

		    <section class="panel">
		    	<div class="panel-body">
		    		 <div class="form-group">
                		<h4>Progreso</h4>
                		<div class="progress progress-sm">
							<xsl:variable name="progress_color">
								<xsl:choose>
									<xsl:when test="$content/partida/@progress &gt; 100" >progress-bar-danger</xsl:when>
									<xsl:when test="$content/partida/@progress &gt; 80 and $content/partida/@progress &lt;= 100" >progress-bar-success</xsl:when>
									<xsl:when test="$content/partida/@progress &lt; 80 and $content/partida/@progress &gt;= 50" >progress-bar-warning</xsl:when>
									<xsl:when test="$content/partida/@progress &lt; 50" >progress-bar-default</xsl:when>
								</xsl:choose>
							</xsl:variable>

							
							
		                    <div class="progress-bar {$progress_color}" role="progressbar" aria-valuenow="{$content/partida/@progress}" aria-valuemin="0" aria-valuemax="100" style="width: {$content/partida/@progress}%;">
		                        <span class="sr-only" ><xsl:value-of select="$content/partida/@progress" />% Completado</span>
		                    </div>
		                </div>
		                <xsl:value-of select="$content/partida/@progress" />%
                	</div>
				</div>
	         </section>
	         
		</div>
	</div>
	<!-- //row -->


	<div class="row" >
		<div class="col-sm-12">
			<section class="panel">
				
				<header class="panel-heading wht-bg">

					<h4 class="gen-case">
						<a href="#modal" class="btn btn-add-factura btn-info pull-right" project-id="{$content/object/@id}" partida-id="{$content/partida/id}" data-redirect="/view_partida/{$content/object/@id}/partida/{$content/partida/id}" data-toggle="modal" >Agregar Facturas</a>
						Facturas 
					</h4>
				</header>
				
				<div class="panel-body">

					<xsl:choose>
						<xsl:when test="$content/facturas/object">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>#</th>
										<th>Subrubro</th>
										<th>Proveedor</th>
										<th>Tipo</th>
										<th>Fecha</th>
										<th>Estado</th>
										<th>Monto</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<xsl:for-each select="$content/facturas/object">
									<xsl:variable name="partida_id"><xsl:value-of select="partida_id" /></xsl:variable>
									<xsl:variable name="provider_id"><xsl:value-of select="provider_id" /></xsl:variable>
									<tr id="factura_{id}">
										<td><a href="{$adminroot}{$modName}/edit_factura/{$project_id}/factura/{id}"><xsl:value-of select="number" /></a></td>
										
										<td><xsl:value-of select="rubro_title" /></td>
										<td><xsl:value-of select="provider_name" /></td>
										<td><xsl:value-of select="type" /></td>
										<td><xsl:value-of select="date" /></td>
										<td>
											<xsl:choose>
												<xsl:when test="state = 1">
													<span class="label label-success label-mini">PAGADA</span>
												</xsl:when>
												<xsl:when test="state = 0">
													<span class="label label-default label-mini">PENDIENTE</span>
												</xsl:when>
											</xsl:choose>
										</td>
										<td>$ <xsl:value-of select="amount" /></td>
										<td>
											<div class="btn-group">
												<button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm">
													Acciones
													<span class="caret">&#xa0;</span>
												</button>

												<ul role="menu" class="dropdown-menu">
					                               <li><a href="{$adminroot}{$modName}/edit_factura/{$project_id}/factura/{id}" class="btn-edit-factura" ><i class="fa fa-edit">&#xa0;</i>Editar</a></li>
					                                <li class="divider"></li>
					                                <li><a href="#" class="btn-delete-factura" project-id="{$content/object/@id}" factura-id="{id}" ><i class="fa fa-trash-o">&#xa0;</i>Eliminar</a></li>
					                            </ul>
											</div>
										</td>
									</tr>
								</xsl:for-each>
							</table>
						</xsl:when>
						<xsl:otherwise>
							<p>Esta Partida no tiene Facturas</p>
						</xsl:otherwise>
					</xsl:choose>

				</div>
			</section>
		</div>
	</div>

	<div id="modal" class="modal" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>
</xsl:template>
</xsl:stylesheet>