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

												<xsl:choose>
													<xsl:when test="@state = 0">
														<span class="label label-warning">Presupuesto</span>
													</xsl:when>
													<xsl:when test="@state = 1">
														<span class="label label-success">En Curso</span>
													</xsl:when>
													<xsl:when test="@state = 2">
														<span class="label label-default">Finalizado</span>
													</xsl:when>
												</xsl:choose>

												

												

												<xsl:for-each select="categories/category[not(@parent=1)]">
													<xsl:sort order="ascending" select="@order" data-type="number"/>
													<span class="cat">
														<a href="{$adminroot}{$modName}/list/?categories={@category_id}"><xsl:value-of select="name" /></a>
													</span>
													<!-- <xsl:if test="position()!=last()">, </xsl:if> -->
												</xsl:for-each>
												
										</td>


											
										<td>
												
													<a href="{$adminroot}{$modulename}/edit/{@id}" class="btn btn-sm btn-info" >
														<i class="fa fa-pencil">&#xa0;</i>
														Editar
													</a> 
													<a class="btn btn-sm btn-default deleteObject" href="#" title="Borrar">
														<i class="fa fa-trash-o">&#xa0;</i>
														Borrar
													</a>
												
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