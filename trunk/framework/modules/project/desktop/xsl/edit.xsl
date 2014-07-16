<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="type" />

<xsl:variable name="htmlHeadExtra">
	<script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script>
	<script src="{$modPath}/desktop/js/project.edit.js" type="text/javascript">&#xa0;</script>
</xsl:variable>

<xsl:template name="content">

<xsl:variable name="object" select="$content/object" />

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
							<select name="type" class="form-control" >
								<option value="TV">TV</option>
								<option value="Publicidad">Publicidad</option>
								<option value="Servicio">Servicio de Producción</option>
							</select>
						</div>
						<!-- <div class="form-group">
							<label>Producto</label>
							<input type="text" maxlength="200" class="form-control" name="producto" value=""/>
						</div>
						<div class="form-group">
							<label>Duración</label>
							<input type="text" maxlength="200" class="form-control" name="duracion" value=""/>
						</div>
						<div class="form-group">
							<label>Medio</label>
							<input type="text" maxlength="200" class="form-control" name="medio" value=""/>
						</div> -->

			</div>
		</section>
	</div>

	<div class="col-sm-4">
		<section class="panel">
			<header class="panel-heading">Información del Proyecto</header>
			<div class="panel-body">

				<div class="form-group">
					<label>Estado</label>
					<span class="label label-{$content/states/state[id=$object/@state]/label}"><xsl:value-of select="$content/states/state[id=$object/@state]/name" /></span>
				</div>
				
				<xsl:if test="$content/object/@state != 0">
					<div class="form-group">
						<h3>Estimación $<xsl:value-of select="$object/budget" /></h3>
					</div>		
				</xsl:if>
				
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

					<label>Progreso</label>
					<div class="progress">
	                    <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:10%;">
	                        <span>10% Completado</span>
	                    </div>
	                </div>
	            </div>


			  	<div class="form-group">
                	<label>Creado por</label>
                	<span class="label label-default"><xsl:value-of select="$content/project_owner/name" />&#xa0;<xsl:value-of select="$content/project_owner/lastname" />&#xa0;</span>
                </div>

                <div class="form-group">
                	<label>Fecha Inicio</label>
                	<div data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date=""  class="input-append date dpYears">
	        			<input type="text" readonly="readonly" name="start_date" size="16" class="form-control form-control-inline input-medium default-date-picker" value="{$object/@start_date}" />
	        		</div>
	        		<script>
                		$('.default-date-picker').datepicker({
					        format: 'yyyy-mm-dd'
					    });
					    $('.dpYears').datepicker();
					</script>
                </div>
                <div class="form-group">
                	<label>Fecha Fin</label>
                	<div data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date=""  class="input-append date dpYears">
                		<input type="text" name="end_date" readonly="readonly" class="form-control form-control-inline input-medium default-date-picker" value="{$object/@end_date}" />
                	</div>
                </div>

                <div class="form-group">
					<label>Imprevistos (<xsl:value-of select="$object/imprevistos" />%)</label>
				</div>
				<div class="form-group">
					<label>Ganancia (<xsl:value-of select="$object/ganancia" />%)</label>
					
				</div>
				<div class="form-group">
					<label>Impuestos (<xsl:value-of select="$object/impuestos" />%)</label>
				</div>

				<div class="form-group">
					<button type="submit" class="btn btn-info pull-right">Guardar</button>
					<a href="" class="btn"><i class="fa fa-trash-o">&#xa0;</i>Eliminar</a>
				</div>


			</div>
		</section>
	</div>
</div>






<!--

	<div class="col-sm-12">				
		
				
 				<xsl:call-template name="tool.categories">
					<xsl:with-param name="categories" select="$object/categories" />
					<xsl:with-param name="object_id" select="$object/@id" />
				</xsl:call-template>


				<xsl:call-template name="multimedia.relations">
					<xsl:with-param name="configuration" select="$config/module/options/group[@name='multimedias']" />
					<xsl:with-param name="multimedias" select="$object/multimedias" />
					<xsl:with-param name="object_id" select="$object/@id" />
					<xsl:with-param name="position" select="100" />
				</xsl:call-template>
				
				<xsl:call-template name="object.relations">
					<xsl:with-param name="objects" select="$config/module/options/group[@name='relations']" />
					<xsl:with-param name="relations" select="$object/relations" />
					<xsl:with-param name="object_id" select="$object/@id" />
					<xsl:with-param name="position" select="200" />
				</xsl:call-template>
 

	</div>
-->
	

</form>










<div id="modal" class="modal fade" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>

</xsl:template>
</xsl:stylesheet>