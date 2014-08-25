<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="active" />
<xsl:param name="from_date" />
<xsl:param name="to_date" />


<xsl:variable name="htmlHeadExtra"></xsl:variable>



<xsl:template name="content">

<xsl:call-template name="reports.navigation">
	<xsl:with-param name="active">facturas</xsl:with-param>
</xsl:call-template>


<div class="row">
	<div class="col-sm-12">
		<section class="panel">
			<header class="panel-heading">
				<a href="" class="btn btn-primary pull-right"><i class="fa fa-download">&#xa0;</i> Exportar XSL</a>
				<h4>Reporte </h4>
			</header>
			<div class="panel-body">
				
				<table class="table table-hover general-table" >
								<thead>
									<tr>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Estado</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Nro#</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Tipo</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Descripción</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Proveedor</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Rubro</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Subrubro</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Partida</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Fecha</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Proyecto</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Creado Por</a></th>
										
										<th>Acciones</th>
										
									</tr>
								</thead>
								<tbody>
								<xsl:for-each select="$content/collection/object">
									<tr class="item_row" id="object_{@id}" item_id="{@id}">
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
										<td><xsl:value-of select="number" /></td>
										<td><xsl:value-of select="type" /></td>
										<td><xsl:value-of select="description" /></td>
										<td><xsl:value-of select="provider_title" /></td>
										<td><xsl:value-of select="rubro_id" /></td>
										<td><xsl:value-of select="subrubro_id" /></td>
										<td><xsl:value-of select="partida_id" /></td>
										<td>
											<xsl:call-template name="fecha.formato.numerico">
												<xsl:with-param name="fecha" select="date" />
											</xsl:call-template>
										</td>
										<td><xsl:value-of select="project_title" /></td>
										<td><b><xsl:value-of select="username" /></b>&#xa0;(<xsl:value-of select="user_name" />&#xa0;<xsl:value-of select="user_lastname" />)</td>
										
										<td>
											<a href="{$adminroot}project/edit_factura/{project_id}/factura/{id}" class="btn btn-sm btn-primary">Editar</a>
										</td>
									</tr>
								</xsl:for-each>
								</tbody>
							</table>

	                       <!-- <xsl:call-template name="pagination.box" /> -->

			</div>
		</section>	
	</div>
</div>

</xsl:template>
</xsl:stylesheet>