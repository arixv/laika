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
<xsl:value-of select="floor($total_estimate * $object/imprevistos div 100)" />
</xsl:variable>

<!-- GANANCIAS -->
<xsl:variable name="total_ganancia">
<xsl:value-of select="floor(($total_estimate + $total_imprevistos) * $object/ganancia div 100)" />
</xsl:variable>

<!-- IMPUESTOS -->
<xsl:variable name="total_impuestos">
<xsl:value-of select="floor(($total_ganancia + $total_imprevistos + $total_estimate) * $object/impuestos div 100)" />
</xsl:variable>

<!-- HEAD EXTRA -->
<xsl:variable name="htmlHeadExtra">
	<script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script>
	<script src="{$modPath}/desktop/js/project.edit.js" type="text/javascript">&#xa0;</script>
</xsl:variable>

<!-- FOOTER EXTRA -->
<xsl:variable name="htmlFooterExtra">

</xsl:variable>


<xsl:template name="content">



<xsl:call-template name="project.nav" />

<form name="edit" action="{$adminroot}{$modName}/edit/" method="post">


<div class="row" >
	<div class="col-sm-12">
			<section class="panel">
				
				<header class="panel-heading wht-bg">
					<div class="form-group">
						<button type="submit" class="btn btn-info pull-right">Guardar</button>
					</div>
					<h4 class="gen-case">Editar Proyecto</h4>
				</header>
			</section>
	</div>
</div>

<div class="row" >
	<div class="col-sm-8">
			<section class="panel">
				
				
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
                	<label>Creado por <xsl:value-of select="$content/project_owner/name" />&#xa0;<xsl:value-of select="$content/project_owner/lastname" /></label>
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


			  	

                <div class="form-group">
                	<label>Fecha Inicio</label>
                	<xsl:variable name="fechaInicio">
                		<xsl:choose>
                			<xsl:when test="$content/object/@start_date = '0000-00-00'"></xsl:when>
                			<xsl:otherwise><xsl:call-template name="fecha.formato.numerico"><xsl:with-param name="fecha" select="$content/object/@start_date" /></xsl:call-template></xsl:otherwise>
                		</xsl:choose>
                	</xsl:variable>
                	<div data-date-viewmode="years" data-date-format="dd-mm-yyyy" data-date="{$fechaInicio}"  class="input-append date dpYears">
	        			<input type="text" name="start_date" size="16" class="form-control form-control-inline input-medium default-date-picker" value="{$fechaInicio}" />
	        		</div>
	        		
                </div>
                <div class="form-group">
                	<label>Fecha Fin</label>
                	<xsl:variable name="fechaFin">
                		<xsl:choose>
                			<xsl:when test="$content/object/@end_date = '0000-00-00'"></xsl:when>
                			<xsl:otherwise><xsl:call-template name="fecha.formato.numerico"><xsl:with-param name="fecha" select="$content/object/@end_date" /></xsl:call-template></xsl:otherwise>
                		</xsl:choose>
                	</xsl:variable>
                	<div data-date-viewmode="years" data-date-format="dd-mm-yyyy" data-date="{$fechaFin}"  class="input-append date dpYears">
                		<input type="text" name="end_date" class="form-control form-control-inline input-medium default-date-picker" value="{$fechaFin}" />
                	</div>
                </div>


                <script>
            		$('.default-date-picker').datepicker({format: 'dd-mm-yyyy'});
				    $('.dpYears').datepicker();
				</script>

				
			</div>
		</section>

		<section class="panel">
			<header class="panel-heading">Estimación</header>
			<div class="panel-body">

                <div class="form-group">
					
					<div class="row">
						<label class="col-md-6">Imprevistos</label>
						<div class="col-md-6">
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
						<div class="col-md-6">
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
						<div class="col-md-6">
							<div class="input-group m-bot15">
								<input type="text" class="form-control" name="impuestos" value="{$object/impuestos}" />
								<span class="input-group-addon btn-default">%</span>
							</div>
						</div>
					</div>
				</div>

				<div class="form-group">
					<div class="row">
						<label class="col-md-6">IVA</label>
						<div class="col-md-6">
							<div class="input-group m-bot15">
								<input type="text" class="form-control" name="iva" value="{$object/iva}" />
								<span class="input-group-addon btn-default">%</span>
							</div>
						</div>
					</div>
				</div>


				<div class="form-group">
					<div class="row">
						<label class="col-md-6">Impuesto al Cheque</label>
						<div class="col-md-6">
							<div class="input-group m-bot15">
								<input type="text" class="form-control" name="impuesto_cheque" value="{$object/impuesto_cheque}" />
								<span class="input-group-addon btn-default">%</span>
							</div>
						</div>
					</div>
				</div>


				<div class="form-group">
					<div class="row">
						<label class="col-md-6">Otros Impuestos</label>
						<div class="col-md-6">
							<div class="input-group m-bot15">
								<input type="text" class="form-control" name="otros_impuestos" value="{$object/otros_impuestos}" />
								<span class="input-group-addon btn-default">%</span>
							</div>
						</div>
					</div>
				</div>

				

			</div>
		</section>

	</div>
</div>





</form>










<div id="modal" class="modal fade" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>

</xsl:template>
</xsl:stylesheet>