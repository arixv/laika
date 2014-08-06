<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="active" />
<xsl:param name="from_date" />
<xsl:param name="to_date" />


<xsl:variable name="htmlHeadExtra"></xsl:variable>



<xsl:template name="content">

<xsl:call-template name="reports.navigation">
		<xsl:with-param name="active">providers</xsl:with-param>
</xsl:call-template>


<div class="row">
	<div class="col-sm-12">
		<section class="panel">
			<header class="panel-heading">
				<a href="" class="btn btn-primary pull-right"><i class="fa fa-download">&#xa0;</i> Exportar XSL</a>
				<h4>Reporte Proveedores</h4>
			</header>
			<div class="panel-body">
				
				<table class="table table-hover general-table" >
								<thead>
									<tr>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Nro#</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Nombre</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">cuit</a></th>
									</tr>
								</thead>
								<tbody>
								<xsl:for-each select="$content/collection/object">
									<tr class="item_row" id="object_{id}" item_id="{id}">
										<td><xsl:value-of select="id" /></td>
										<td><xsl:value-of select="title" /></td>
										<td><xsl:value-of select="cuit" /></td>
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