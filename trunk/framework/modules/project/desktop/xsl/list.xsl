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
	<script type="text/javascript" src="{$adminPath}/desktop/js/module.list.js">&#xa0;</script>
</xsl:variable>


<xsl:template name="content">

	<!-- display.collection
	<xsl:call-template name="display.collection" >
		<xsl:with-param name="collection" select="$content/collection"/>
	</xsl:call-template>
	// display.collection -->

	<div class="row">
		<div class="col-sm-12">
			<ul class="breadcrumb">
		        <li ><i class="fa fa-home">&#xa0;</i> <xsl:value-of select="$config/module/@title" /></li>
		    </ul>
		</div>
	</div>

	<div class="row">
		<div class="col-sm-12">
			<section class="panel">
				<header class="panel-heading wht-bg">
					<div class="btn-group pull-right">
						<a href="{$adminroot}{$modulename}/add" class="btn btn-info">Agregar</a>
					</div>
					<h4><xsl:value-of select="$config/module/@title" /></h4>
				</header>
			

				<div class="panel-body">
							<table class="table table-hover general-table" >
								<thead>
									<tr>
										<th>Titulo</th>
										<th>Inicio</th>
										<th>Fin</th>
										<th>Estado</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>
								<xsl:for-each select="$content/collection/object">
									<tr class="item_row" id="object_{@id}" item_id="{@id}">
										<td>
											<a href="{$adminroot}{$modulename}/edit/{@id}">
												<xsl:value-of select="title" />
											</a>
										</td>
										<td>
											<xsl:value-of select="@start_date" />
										</td>

										<td>
											<xsl:value-of select="@end_date" />
										</td>
											
										<td>
											<xsl:variable name="this_state" select="@state" />
											<span class="label label-{$content/states/state[id=$this_state]/label}"><xsl:value-of select="$content/states/state[id=$this_state]/name" /></span>
												<!-- <xsl:choose>
													<xsl:when test="@state = 0">
														<span class="label label-default">Presupuesto</span>
													</xsl:when>
													<xsl:when test="@state = 1">
														<span class="label label-primary">En Curso</span>
													</xsl:when>
													<xsl:when test="@state = 2">
														<span class="label label-success">Finalizado</span>
													</xsl:when>
													<xsl:when test="@state = 3">
														<span class="label label-danger">Cancelado</span>
													</xsl:when>
												</xsl:choose> -->

																								
										</td>


											
										<td>
												<div class="btn-group">

													<button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm">
														Acciones
														<span class="caret">&#xa0;</span>
													</button>

													<ul role="menu" class="dropdown-menu">
			                               				<li>
															<a href="{$adminroot}{$modulename}/edit/{@id}" >
																<i class="fa fa-pencil">&#xa0;</i>
																Editar
															</a> 
														</li>
														<li>
															<a href="{$adminroot}{$modulename}/duplicate/{@id}" >
																<i class="fa fa-copy">&#xa0;</i>
																Clonar
															</a> 
														</li>
														<li>
															<a class="deleteObject" href="#" title="Borrar">
																<i class="fa fa-trash-o">&#xa0;</i>
																Eliminar
															</a>
														</li>
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

	
</xsl:template>
</xsl:stylesheet>