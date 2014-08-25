<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="active" />
<xsl:param name="from_date" />
<xsl:param name="to_date" />


<xsl:variable name="htmlHeadExtra"></xsl:variable>



<xsl:template name="content">

<xsl:call-template name="reports.navigation">
		<xsl:with-param name="active">partidas</xsl:with-param>
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
										<th><a href="{$adminroot}{$modulename}/list/?order=">Nro#</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Descripción</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Responsable</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Proyecto</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Monto</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Fecha</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Creado Por</a></th>
									</tr>
								</thead>
								<tbody>
								<xsl:for-each select="$content/collection/object">
									<tr class="item_row" id="object_{id}" item_id="{id}">
										<td><xsl:value-of select="id" /></td>
										<td><xsl:value-of select="description" /></td>
										<td><xsl:value-of select="responsable" /></td>
										<td><xsl:value-of select="project_title" /></td>
										<td>$ <xsl:value-of select="amount" /></td>
										<td>
											<xsl:call-template name="fecha.formato.numerico">
												<xsl:with-param name="fecha" select="date" />
											</xsl:call-template>
										</td>
										<td><b><xsl:value-of select="username" /></b>&#xa0;(<xsl:value-of select="user_name" />&#xa0;<xsl:value-of select="user_lastname" />)</td>
										<td>
											<xsl:variable name="this_state" select="state" />
											<span class="label label-{$content/states/state[id=$this_state]/label}"><xsl:value-of select="$content/states/state[id=$this_state]/name" /></span>
																								
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