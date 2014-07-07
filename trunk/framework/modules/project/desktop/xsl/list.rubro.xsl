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
			<a href="#modal" class="btn btn-info pull-right btn-add-subrubro" project-id="{$content/object/@id}" data-toggle="modal" >Agregar Rubro</a>
			Rubros
		</h1>

		<xsl:choose>
			<xsl:when test="$content/rubros/rubro">


				<xsl:for-each select="$content/rubros/rubro">
					<section class="panel">
						<header class="panel-heading">
							


							<div class="btn-group pull-right">

							<!-- 	<button class="btn btn-inverse btn-sm" ><i class="fa fa-trash-o">&#xa0;</i> Eliminar</button> -->

								<button data-toggle="dropdown" class="btn btn-inverse dropdown-toggle btn-sm">
									Acciones
									<span class="caret">&#xa0;</span>
								</button>



								<ul role="menu" class="dropdown-menu">
	                               <li>
	                               		<a href="#" onclick="LoadModalAddSubRubro({$content/object/@id},{id});" data-toggle="modal" >
	                               			<i class="fa fa-plus">&#xa0;</i>&#xa0;Agregar Sub-Rubro
	                               		</a> 
	                               	</li>
	                                <li>
	                                	<a href="#" onclick="DeleteRubro({$content/object/@id},{id});">
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
										<tr id="subrubro_{id}">
											<td><xsl:value-of select="title" /></td>
											<td><xsl:value-of select="description" /></td>
											<td><xsl:value-of select="quantity" /></td>
											<td><xsl:value-of select="concept" /></td>
											<td><xsl:value-of select="cost" /></td>
											<td><xsl:value-of select="subtotal" /></td>
											<td><xsl:value-of select="state" /></td>
											<td>
												<div class="btn-group">
													<button class="btn btn-default btn-sm btn-edit-subrubro" project-id="{$content/object/@id}" subrubro-id="{id}">
														Editar
														
													</button>
													<button class="btn btn-default btn-sm btn-delete-subrubro" project-id="{$content/object/@id}" subrubro-id="{id}">
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
							Este proyecto no tiene ningun rubro asociado
							<br/><br/>
							<a href="#" onclick="LoadModalAddRubro({$content/object/@id});" class="btn btn-info" data-toggle="modal" >Agregar Rubro</a>
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