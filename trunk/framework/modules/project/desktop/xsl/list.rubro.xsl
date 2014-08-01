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
							
							<h6>
								<xsl:value-of select="title" />
								&#xa0;
								<strong class="badge bg-info">Total Estimado&#xa0;$<xsl:value-of select="@estimate_total" /></strong>
								<xsl:if test="$content/object/@state != 0">
									<strong class="badge bg-important">Total Real&#xa0;$<xsl:value-of select="@total" /></strong>
								</xsl:if>
							</h6>
								
						</header>

						<div class="panel-body">
							<table class="table table-bordered table-striped table-condensed">
								<thead>
									<tr>
										<th>Nombre</th>
										<th>Proveedor</th>
										<th class="numeric" >Cantidad<br/>Estimada</th>
										<th class="numeric" >Costo<br/>Estimado</th>
										<th class="numeric" >Subtotal<br/>Estimado</th>
										<xsl:if test="$content/object/@state != 0">
											<th class="numeric" >Cantidad<br/>Real</th>
											<th class="numeric" >Costo<br/>Real</th>
											<th class="numeric" >Subtotal<br/>Real</th>
											<th>Progreso</th>
										</xsl:if>
										
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>
									<xsl:for-each select="./subrubros/subrubro">
										<xsl:variable name="thisProvider" select="provider_id" />
										<tr id="subrubro_{subrubro_id}">
											<td><xsl:value-of select="title" /></td>
											<td><xsl:value-of select="$content/providers/object[@id = $thisProvider]/title" /></td>
											<td class="numeric" ><xsl:value-of select="estimate_quantity" /></td>
											<td class="numeric" >$ <xsl:value-of select="estimate_cost" /></td>
											<td class="numeric" >$ <xsl:value-of select="estimate_subtotal" /></td>
											<xsl:if test="$content/object/@state != 0">
												<td class="numeric" ><xsl:value-of select="quantity" /></td>
												<td class="numeric" >$ <xsl:value-of select="cost" /></td>
												<td class="numeric" >$ <xsl:value-of select="subtotal" /></td>
												<td>
													<div class="progress progress-striped">
														<xsl:variable name="progress_color">
															<xsl:choose>
																<xsl:when test="progress &gt; 80" >progress-bar-success</xsl:when>
																<xsl:when test="progress &lt; 80 and progress &gt;= 50" >progress-bar-warning</xsl:when>
																<xsl:when test="progress &lt; 50" >progress-bar-danger</xsl:when>
															</xsl:choose>
														</xsl:variable>
														<xsl:variable name="progress_width">
															<xsl:choose>
																<xsl:when test="progress &lt; 100" ><xsl:value-of select="progress" /></xsl:when>
																<xsl:when test="progress &gt;= 100" >100</xsl:when>
															</xsl:choose>
														</xsl:variable>
									                    <div class="progress-bar {$progress_color}" role="progressbar" aria-valuenow="{@progress}" aria-valuemin="0" aria-valuemax="100" style="width: {$progress_width}%;">
									                        <span><xsl:value-of select="progress" />%</span>
									                    </div>

									                </div>

									                <!-- <xsl:value-of select="progress" />% -->



												</td>
											</xsl:if>
											<td>
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm">
														Acciones
														<span class="caret">&#xa0;</span>
													</button>

													<ul role="menu" class="dropdown-menu">
						                               <li><a href="#" class="btn-edit-subrubro" project-id="{$content/object/@id}" subrubro-id="{subrubro_id}" ><i class="fa fa-edit">&#xa0;</i>Editar</a></li>
						                                <li class="divider"></li>
						                                <li><a href="#" class="btn-delete-subrubro" project-id="{$content/object/@id}" subrubro-id="{subrubro_id}" ><i class="fa fa-trash-o">&#xa0;</i>Eliminar</a></li>
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
							Este proyecto no tiene ningun recurso asignado
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