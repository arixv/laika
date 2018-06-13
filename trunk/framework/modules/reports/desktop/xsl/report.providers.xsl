<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="active" />
<xsl:param name="start_date" />
<xsl:param name="end_date" />
<xsl:param name="provider_id" />
<xsl:param name="project_id" />
<xsl:param name="project_id" />
<xsl:param name="sort" />



<xsl:variable name="htmlHeadExtra">
	<script type="text/javascript">
		$(document).ready(function(){
			$(".btn-export").click(function(e){
				e.preventDefault();
				$("#form_export").submit();
			});

			$('table th a').click(function(e){
				e.preventDefault();
				var sort = $(this).attr('data-sort');
				$('#list_form').find('input[name="sort"]').val(sort);
				$('#list_form').submit();
			});
		});
	</script>

</xsl:variable>



<xsl:template name="content">

<xsl:call-template name="reports.navigation">
		<xsl:with-param name="active">providers</xsl:with-param>
</xsl:call-template>


<form name="export" id="form_export" action="{$adminroot}" method="get">
	<input type="hidden" name="m" value="reports" />
	<input type="hidden" name="action" value="BackExportProviders" />
	<input type="hidden" name="start_date" value="{$start_date}" />
	<input type="hidden" name="end_date" value="{$end_date}" />
	<input type="hidden" name="project_id" value="{$project_id}" />
	<input type="hidden" name="state" value="{$state}" />
	<input type="hidden" name="creation_userid" value="{$creation_userid}" />
</form>


<form name="list" id="list_form" action="{$adminroot}" method="get">
	<input type="hidden" name="m" value="reports" />
	<input type="hidden" name="action" value="BackReportProviders" />
	<input type="hidden" name="start_date" value="{$start_date}" />
	<input type="hidden" name="end_date" value="{$end_date}" />
	<input type="hidden" name="project_id" value="{$project_id}" />
	<input type="hidden" name="state" value="{$state}" />
	<input type="hidden" name="creation_userid" value="{$creation_userid}" />
	<input type="hidden" name="sort" value="{$sort}" />
</form>


<div class="row">
	<div class="col-sm-12">
		<section class="panel">
			<header class="panel-heading">
				<a href="" class="btn btn-primary btn-export pull-right"><i class="fa fa-download">&#xa0;</i> Exportar XSL</a>
				<h4>Reporte Proveedores</h4>
			</header>
			<div class="panel-body">
				
				<table class="table table-hover general-table" >
								<thead>
									<tr>
										<th>
											<a href="#" data-sort="title" >Nombre</a>
											<xsl:if test="$sort = 'title'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="project_title" >Proyecto</a>
											<xsl:if test="$sort = 'project_title'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="cuit" >CUIT</a>
											<xsl:if test="$sort = 'cuit'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="date" >Fecha</a>
											<xsl:if test="$sort = 'date'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>Estado Factura</th>
										<th><a href="{$adminroot}{$modulename}/list/?order=">Monto Facturado</a></th>
										
									</tr>
								</thead>
								<tbody>
									<xsl:for-each select="$content/collection/object">
										<tr class="item_row" id="object_{id}" item_id="{id}">
											<td><a href="{$adminroot}provider/edit/{id}"><xsl:value-of select="title" /></a></td>
											<td><a href="{$adminroot}project/edit/{project_id}"><xsl:value-of select="project_title" /></a></td>
											<td><xsl:value-of select="cuit" /></td>
											<td>
												<xsl:call-template name="fecha.formato.numerico">
													<xsl:with-param name="fecha" select="date" />
												</xsl:call-template>
											</td>
											
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
											<td>$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="total_facturado" /></xsl:call-template></td>
										</tr>
									</xsl:for-each>
								</tbody>
								<!-- <tfoot>
									<tr>
										<td>&#xa0;</td>
										<td>&#xa0;</td>
										<td>&#xa0;</td>
										<td>&#xa0;</td>
										<td>&#xa0;</td>
										<td><b>Total  $<xsl:value-of select="$content/collection/total" /></b></td>

									</tr>
								</tfoot> -->
							</table>

	                       <!-- <xsl:call-template name="pagination.box" /> -->

			</div>
		</section>	
	</div>
</div>

</xsl:template>
</xsl:stylesheet>