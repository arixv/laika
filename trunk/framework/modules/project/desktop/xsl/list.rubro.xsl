<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="calendar" />
<xsl:param name="type" />
<xsl:param name="pagenumber" />
<xsl:param name="query" />
<xsl:param name="filter" />
<xsl:param name="state" >0</xsl:param>
<xsl:param name="category_id" />

<xsl:variable name="htmlHeadExtra">
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/jquery-multi-select/css/multi-select.css" />
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/select2/select2.css" />
</xsl:variable>

<xsl:variable name="htmlFooterExtra">

	<script type="text/javascript" src="{$adminPath}/desktop/js/module.list.js" >&#xa0;</script>
	<script type="text/javascript" src="{$modPath}/desktop/js/project.edit.js" >&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/fuelux/js/spinner.min.js"></script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery-multi-select/js/jquery.multi-select.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery-multi-select/js/jquery.quicksearch.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/select2/select2.js">&#xa0;</script>
</xsl:variable>


<xsl:template name="content">

	<xsl:variable name="object" select="$content/object" />

	<xsl:call-template name="project.nav">
		<xsl:with-param name="active" >rubro</xsl:with-param>
	</xsl:call-template>



<!-- RUBROS -->
<div class="row">
	<div class="col-sm-12">

		
		
		<h1>
			<a href="#modal" class="btn btn-info pull-right btn-add-subrubro" project-id="{$content/object/@id}" data-toggle="modal" >Agregar Recurso</a>
			Recursos
		</h1>

		<xsl:choose>
			<xsl:when test="$content/rubros/rubro">


				<xsl:for-each select="$content/rubros/rubro">
					<section class="panel" id="rubro_{id}" >
						<header class="panel-heading">
							


							<div class="btn-group pull-right">

								<a href="#" onclick="DeleteRubro({$content/object/@id},{id});">
	                             	<i class="fa fa-trash-o">&#xa0;</i>&#xa0;Eliminar
	                             </a> 

							</div>
							
							<h6><xsl:value-of select="title" />&#xa0;<strong class="badge bg-info">Total $<xsl:value-of select="@total" /></strong></h6>
						</header>

						<div class="panel-body">
							<table class="table">
								<thead>
									<tr>
										<th>Nombre</th>
										<th>Descripción</th>
										<th>Cantidad</th>
										<th>Concepto</th>
										<th>Costo / Unidad</th>
										<th>Subtotal</th>
										<th>Progreso</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>
									<xsl:for-each select="./subrubros/subrubro">
										<tr id="subrubro_{subrubro_id}">
											<td><xsl:value-of select="title" /></td>
											<td><xsl:value-of select="description" /></td>
											<td><xsl:value-of select="quantity" /></td>
											<td><xsl:value-of select="concept" /></td>
											<td><xsl:value-of select="cost" /></td>
											<td><xsl:value-of select="subtotal" /></td>
											<td>
												<div class="progress progress-striped progress-sm">
													<xsl:variable name="progress_color">
														<xsl:choose>
															<xsl:when test="progress &gt; 80" >progress-bar-success</xsl:when>
															<xsl:when test="progress &lt; 80 and progress &gt;= 50" >progress-bar-warning</xsl:when>
															<xsl:when test="progress &lt; 50" >progress-bar-danger</xsl:when>
														</xsl:choose>
													</xsl:variable>
								                    <div class="progress-bar {$progress_color}" role="progressbar" aria-valuenow="{@progress}" aria-valuemin="0" aria-valuemax="100" style="width: {progress}%;">
								                        <span class="sr-only" ><xsl:value-of select="progress" />% Completado</span>
								                    </div>

								                </div>

								                <p><xsl:value-of select="progress" />%</p>



											</td>
											<td>
												<div class="btn-group">
													<button class="btn btn-default btn-sm btn-edit-subrubro" project-id="{$content/object/@id}" subrubro-id="{subrubro_id}">
														Editar
														
													</button>
													<button class="btn btn-default btn-sm btn-delete-subrubro" project-id="{$content/object/@id}" subrubro-id="{subrubro_id}">
														Eliminar
													</button>
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
							Este proyecto no tiene ningun subrubro asignado
						</center>
					</p>
				</div>
			</xsl:otherwise>
		</xsl:choose>

		
	</div>
</div>

<!-- / RUBROS -->


<div id="modal" class="modal fade" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>
	
</xsl:template>
</xsl:stylesheet>