<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="active" />
<xsl:param name="from_date" />
<xsl:param name="to_date" />


<xsl:variable name="htmlHeadExtra"></xsl:variable>



<xsl:template name="content">

<xsl:call-template name="reports.navigation">
		<xsl:with-param name="active">projects</xsl:with-param>
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
										<th><a href="{$adminroot}{$modulename}/list/?order=title">Titulo</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=type">Tipo</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=type">Cliente</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=start_date">Fecha Inicio</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=end_date">Fecha Fin</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=end_date">Creado Por</a></th>
										<th><a href="{$adminroot}{$modulename}/list/?order=state">Estado</a></th>
										
									</tr>
								</thead>
								<tbody>
								<xsl:for-each select="$content/collection/object">
									<tr class="item_row" id="object_{@id}" item_id="{@id}">
										<td><xsl:value-of select="title" /></td>
										<td><xsl:value-of select="type" /></td>
										<td><xsl:value-of select="client_title" /></td>
										<td><xsl:value-of select="start_date" /></td>
										<td><xsl:value-of select="end_date" /></td>
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