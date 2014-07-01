<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="calendar" />
<xsl:param name="type" />

<xsl:variable name="htmlHeadExtra">

	<xsl:call-template name="js.cal" />
	<script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script>

	<!-- <xsl:call-template name="tiny_mce">
		<xsl:with-param name="elements">description</xsl:with-param>
		<xsl:with-param name="width">100%</xsl:with-param>
		<xsl:with-param name="object_id" select="$content/object/@id" />
		<xsl:with-param name="object_typeid" select="$content/object/@typeid" />
	</xsl:call-template> -->

</xsl:variable>

<xsl:template name="content">

<xsl:variable name="object" select="$content/object" />

<form name="edit" action="{$adminroot}{$modName}/edit/" method="post">

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
							<select name="client" class="form-control" >
								<option  value="ClientXXX">ClientXXX</option>
							</select>
						</div>
						<div class="form-group">
							<label>Tipo</label>
							<select name="client" class="form-control" >
								<option  value="ClientXXX">Tipoxxx</option>
							</select>
						</div>
			</div>
		</section>
	</div>

	<div class="col-sm-4">
		<section class="panel">
			<header class="panel-heading">Información del Proyecto</header>
			<div class="panel-body">
				<div class="progress">
                    <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
                        <span>60% Completado</span>
                    </div>
                </div>

                <div class="form-group">
                	<label>Fecha Inicio</label>
                	<input type="text" class="form-control" value="21-06-2014" />
                </div>
                <div class="form-group">
                	<label>Fecha Inicio</label>
                	<input type="text" class="form-control" value="21-07-2014" />
                </div>
			  <div class="form-group">
                	<label>Creado por</label>
                	<input type="text" class="form-control" value="Admin" />
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
                <span>320</span>
                Facturas a Pagar
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon tar"><i class="fa fa-tag">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span>50</span>
                Facturas Impagas
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon pink"><i class="fa fa-money">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span>20</span>
                Partidas
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon green"><i class="fa fa-eye">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span>20</span>
                Partidas
            </div>
        </div>
    </div>


</div><!-- /row -->


<div class="row">
	<div class="col-sm-12">
		<section class="panel">

			<header class="panel-heading">
				<a href="#addFactura" data-toggle="modal" class="btn btn-xs pull-right"><i class="fa fa-plus">&#xa0;</i> Agregar Factura</a>
				Facturas
			</header>
			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>#</th>
							<th>Descripción</th>
							<th>Tipo</th>
							<th>Fecha</th>
							<th>Estado</th>
							<th>Monto</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>122</td>
							<td>Camión Remolque para equipos de Producción</td>
							<td>A</td>
							<td>12/06/2014</td>
							<td><span class="label label-success label-mini">COBRADA</span></td>
							<td>$ 125</td>
						</tr>
						<tr>
							<td>122</td>
							<td>Camión Remolque para equipos de Producción</td>
							<td>A</td>
							<td>12/06/2014</td>
							<td><span class="label label-success label-mini">COBRADA</span></td>
							<td>$ 125</td>
						</tr>
						<tr>
							<td>122</td>
							<td>Camión Remolque para equipos de Producción</td>
							<td>A</td>
							<td>12/06/2014</td>
							<td><span class="label label-success label-mini">COBRADA</span></td>
							<td>$ 125</td>
						</tr>
						<tr>
							<td>121</td>
							<td>Camión Remolque para equipos de Producción</td>
							<td>C</td>
							<td>11/06/2014</td>
							<td><span class="label label-warning label-mini">PENDIENTE</span></td>
							<td>$ 125</td>
						</tr>
						<tr>
							<td>121</td>
							<td>Camión Remolque para equipos de Producción</td>
							<td>C</td>
							<td>11/06/2014</td>
							<td><span class="label label-warning label-mini">PENDIENTE</span></td>
							<td>$ 125</td>
						</tr>
						<tr>
							<td>121</td>
							<td>Camión Remolque para equipos de Producción</td>
							<td>C</td>
							<td>11/06/2014</td>
							<td><span class="label label-warning label-mini">PENDIENTE</span></td>
							<td>$ 125</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div id="addFactura" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h4 class="modal-title">Agregar Factura</h4>
                        </div>
                        <div class="modal-body">

                        	<div class="form-group">
                        		<label>Nro de Factura</label>
                        		<input type="text" name="nro" class="form-control" />
                        	</div>

                        	<div class="form-group">
                        		<label>Monto</label>
                        		<input type="text" name="monto" class="form-control" />
                        	</div>

                        	<div class="form-group">
                        		<label>Descripción</label>
                        		<input type="text" name="description" class="form-control" />
                        	</div>


                        	<div class="form-group">
                        		<label>Partida Asociada</label>
                        		<select class="form-control">
                        			<option value="">Seleccionar</option>
                        		</select>
                        	</div>

                        	<div class="form-group">
                        		<label>Tipo de Factura</label>
                        		<select class="form-control">
                        			<option value="A">A</option>
                        			<option value="B">B</option>
                        			<option value="C">C</option>
                        			<option value="Ticket">Ticket</option>
                        		</select>
                        	</div>

                        	<div class="form-group">
                        		<label>Proveedor</label>
                        		<select class="form-control">
                        			<option value="">Seleccionar</option>
                        		</select>
                        	</div>

                        	<div class="form-group">
                        		<label>Estado</label>
                        		<select class="form-control">
                        			<option value="">Seleccionar</option>
                        		</select>
                        	</div>


                        	<div class="form-group">
                        		<label>Rubro</label>
                        		<select class="form-control">
                        			<option value="">Seleccionar</option>
                        		</select>
                        	</div>


                        	<div class="form-group">
                        		<label>Fecha</label>
                        		<input type="text" name="fecha" class="form-control" />
                        	</div>

                        	

                        	
                            
                        </div>
                        <div class="modal-footer">
                        	<button class="btn btn-info">Guardar</button>
                            <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                        </div>
                    </div>
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
</xsl:template>
</xsl:stylesheet>