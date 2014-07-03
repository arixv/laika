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


<div class="row">
	<div class="col-sm-12">
		<ul class="breadcrumb">
	        <li ><a href="/admin/project"><i class="fa fa-home">&#xa0;</i> Proyectos</a></li>
	        <li >Editar Proyecto</li>
	    </ul>
	</div>
</div>

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

						<div class="form-group">
							<button type="submit" class="btn btn-info pull-right">Guardar</button>
						</div>
			</div>
		</section>
	</div>

	<div class="col-sm-4">
		<section class="panel">
			<header class="panel-heading">Información del Proyecto</header>
			<div class="panel-body">
				<div class="form-group">
					<label>Estado</label>
					<xsl:choose>
						<xsl:when test="$object/@state = 0">
							<span class="label label-warning">Presupuesto</span>
						</xsl:when>
						<xsl:when test="$object/@state = 1">
							<span class="label label-success">En Curso</span>
						</xsl:when>
						<xsl:when test="$object/@state = 2">
							<span class="label label-default">Finalizado</span>
						</xsl:when>
					</xsl:choose>
				</div>
				<div class="form-group">
					<select name="state" class="form-control">
						<option value="0">
							<xsl:if test="$object/@state = 0" >
								<xsl:attribute name="selected">selected</xsl:attribute>
							</xsl:if>
							Presupuesto
						</option>
						<option value="1">
							<xsl:if test="$object/@state = 1" >
								<xsl:attribute name="selected">selected</xsl:attribute>
							</xsl:if>
								En Curso
						</option>
						<option value="2">
							<xsl:if test="$object/@state = 2" >
								<xsl:attribute name="selected">selected</xsl:attribute>
							</xsl:if>
							Finalizado
						</option>
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
                	<label>Fecha Inicio</label>
                	<input type="text" name="start_date" class="form-control" value="{$object/@start_date}" />
                </div>
                <div class="form-group">
                	<label>Fecha Fin</label>
                	<input type="text" name="end_date" class="form-control" value="{$object/@end_date}" />
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


<!-- RUBROS -->
<div class="row">
	<div class="col-sm-12">

		
		
		<h1>
			<a href="#modal" onclick="LoadModalAddRubro({$object/@id});" class="btn btn-info pull-right" data-toggle="modal" >Agregar Rubro</a>
			Rubros
		</h1>

		<xsl:choose>
			<xsl:when test="$object/rubros/rubro">





				<xsl:for-each select="$object/rubros/rubro">
					<section class="panel">
						<header class="panel-heading">
							<div class="btn-group pull-right">
								<button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm">
									Acciones
									<span class="caret">&#xa0;</span>
								</button>

								<ul role="menu" class="dropdown-menu">
	                               <li>
	                               		<a href="#" onclick="LoadModalAddSubRubro({$object/@id},{id});" data-toggle="modal" >
	                               			<i class="fa fa-plus">&#xa0;</i>&#xa0;Agregar Sub-Rubro
	                               		</a> 
	                               	</li>
	                                <li>
	                                	<a href="#" onclick="DeleteRubro({$object/@id},{id});">
	                                		<i class="fa fa-trash-o">&#xa0;</i>&#xa0;Eliminar Rubro
	                                	</a> 
	                                </li>
	                            </ul>
							</div>
							
							<h6><xsl:value-of select="title" />&#xa0;<strong class="badge bg-info">$<xsl:value-of select="@total" /></strong></h6>
						</header>

						<div class="panel-body">
							<table class="table">
								<thead>
									<tr>
										<th>Rubro</th>
										<th>Descripción</th>
										<th>Cantidad</th>
										<th>Concepto</th>
										<th>Costo / Unidad</th>
										<th>Subtotal</th>
										<th>Estado</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>
									<xsl:for-each select="./subrubros/subrubro">
										<tr>
											<td><xsl:value-of select="title" /></td>
											<td><xsl:value-of select="description" /></td>
											<td><xsl:value-of select="quantity" /></td>
											<td><xsl:value-of select="concept" /></td>
											<td><xsl:value-of select="cost" /></td>
											<td><xsl:value-of select="subtotal" /></td>
											<td><xsl:value-of select="state" /></td>
											<td>
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm">
														Acciones
														<span class="caret">&#xa0;</span>
													</button>

													<ul role="menu" class="dropdown-menu">
						                               <li><a href="#" onclick="EditSubRubro({$object/@id},{id});" ><i class="fa fa-edit">&#xa0;</i>Editar Subrubro</a></li>
						                                <li><a href="#" onclick="DeleteSubRubro({$object/@id},{id});" ><i class="fa fa-trash-o">&#xa0;</i>Eliminar Subrubro</a></li>
						                            </ul>
												</div>
											</td>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
						</div>
					</section>
				</xsl:for-each>

				

			</xsl:when>
			<xsl:otherwise>
				<div class="alert alert-info fade in">
					<p>
						<center>
							Este proyecto no tiene ningun rubro asociado
							<br/><br/>
							<a href="#" onclick="LoadModalAddRubro({$object/@id});" class="btn btn-info" data-toggle="modal" >Agregar Rubro</a>
						</center>
					</p>
				</div>
			</xsl:otherwise>
		</xsl:choose>

		
	</div>
</div>

<!-- / RUBROS -->


<div id="modal" class="modal fade" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>


<!-- PARTIDAS -->
<div class="row">
	<div class="col-sm-12">

		<h1>
			<a href="#modal" onclick="LoadModalAddPartida({$object/@id});" class="btn btn-info pull-right" data-toggle="modal" >Agregar Partidas</a>
			Partidas
		</h1>
		<section class="panel">

			<header class="panel-heading">
				<a href="#addPartida" data-toggle="modal" class="btn btn-xs pull-right"><i class="fa fa-plus">&#xa0;</i> Agregar Partida</a>
				Partidas
			</header>
			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>#</th>
							<th>Fecha</th>
							<th>Descripción</th>
							<th>Monto</th>
							<th>Responsable</th>
							<th>Estado</th>
							<th>Progreso</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="$content/partidas/partida">
							<tr>
								<td><xsl:value-of select="id" /></td>
								<td><xsl:value-of select="date" /></td>
								<td><xsl:value-of select="description" /></td>
								<td>$ <xsl:value-of select="amount" /></td>
								<td><xsl:value-of select="responsable" /></td>
								<td><span class="label label-success label-mini">Pendiente</span></td>
								<td>
									<div class="progress progress-striped progress-sm">
					                    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
					                        <span class="sr-only" >60% Completado</span>
					                    </div>
					                </div>
								</td>
								<td>
									<div class="btn-group">
										<button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm">
											Acciones
											<span class="caret">&#xa0;</span>
										</button>

										<ul role="menu" class="dropdown-menu">
			                               <li><a href="#"><i class="fa fa-edit">&#xa0;</i>Editar</a></li>
			                                <li><a href="#"><i class="fa fa-copy">&#xa0;</i>Duplicar</a></li>
			                                <li class="divider"></li>
			                                <li><a href="#" class="btn-delete-partida" data-id="{id}" ><i class="fa fa-trash-o">&#xa0;</i>Eliminar</a></li>
			                            </ul>
									</div>
								</td>
							</tr>
						</xsl:for-each>
						
						
					</tbody>
				</table>
			</div>

			

		</section>



	</div>
</div>
<!-- //PARTIDAS -->



<!-- FACTURAS -->
<div class="row">
	<div class="col-sm-12">

		<h1>
			<a href="#modal" onclick="LoadModalAddFactura({$object/@id});" class="btn btn-info pull-right" data-toggle="modal" >Agregar Facturas</a>
			Facturas
		</h1>

		<section class="panel">

			<header class="panel-heading">
				<a href="#" onclick="LoadModalAddFactura({$object/@id});" data-toggle="modal" class="btn btn-xs pull-right"><i class="fa fa-plus">&#xa0;</i> Agregar Factura</a>
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
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="$content/facturas/object">
							<tr>
								<td><xsl:value-of select="number" /></td>
								<td><xsl:value-of select="description" /></td>
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
			                               <li><a href="#"><i class="fa fa-edit">&#xa0;</i>Editar</a></li>
			                                <li><a href="#"><i class="fa fa-copy">&#xa0;</i>Duplicar</a></li>
			                                <li class="divider"></li>
			                                <li><a href="#"><i class="fa fa-trash-o">&#xa0;</i>Eliminar</a></li>
			                            </ul>
									</div>
								</td>
							</tr>
						</xsl:for-each>
						
					</tbody>
				</table>
			</div>


		</section>



	</div>
</div>
<!-- //FACTURAS -->

</xsl:template>
</xsl:stylesheet>