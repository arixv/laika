<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />



<xsl:param name="sort" />
<xsl:param name="projects" />
<xsl:param name="providers" />
<xsl:param name="subrubros" />
<xsl:param name="start_date" />
<xsl:param name="end_date" />
<xsl:param name="min_cost" />
<xsl:param name="max_cost" />
<xsl:param name="concept" />


<xsl:variable name="htmlHeadExtra">
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/jquery-multi-select/css/multi-select.css" />
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/select2/select2.css" />
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


<xsl:variable name="htmlFooterExtra">
	<script type="text/javascript" src="{$adminPath}/desktop/js/fuelux/js/spinner.min.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery-multi-select/js/jquery.multi-select.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery-multi-select/js/jquery.quicksearch.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/select2/select2.js">&#xa0;</script>
</xsl:variable>



<xsl:template name="content">

<xsl:call-template name="reports.navigation">
		<xsl:with-param name="active">resources</xsl:with-param>
</xsl:call-template>

<form name="export" id="form_export" action="{$adminroot}" method="get">
	<input type="hidden" name="m" value="reports" />
	<input type="hidden" name="action" value="BackExportResources" />
	<input type="hidden" name="concept" value="{$concept}" />
	<input type="hidden" name="start_date" value="{$start_date}" />
	<input type="hidden" name="end_date" value="{$end_date}" />
	<input type="hidden" name="min_cost" value="{$min_cost}" />
	<input type="hidden" name="max_cost" value="{$max_cost}" />
	<input type="hidden" name="projects" value="{$projects}" />
	<input type="hidden" name="providers" value="{$providers}" />
	<input type="hidden" name="subrubros" value="{$subrubros}" />
	<input type="hidden" name="export_data" value="1" />
</form>


<form name="list" id="list_form" action="{$adminroot}" method="get">
	<input type="hidden" name="m" value="reports" />
	<input type="hidden" name="action" value="BackReportResources" />
	<input type="hidden" name="concept" value="{$concept}" />
	<input type="hidden" name="start_date" value="{$start_date}" />
	<input type="hidden" name="end_date" value="{$end_date}" />
	<input type="hidden" name="min_cost" value="{$min_cost}" />
	<input type="hidden" name="max_cost" value="{$max_cost}" />
	<input type="hidden" name="projects" value="{$projects}" />
	<input type="hidden" name="providers" value="{$providers}" />
	<input type="hidden" name="subrubros" value="{$subrubros}" />
	<input type="hidden" name="sort" value="{$sort}" />
</form>

<div class="row">
	<div class="col-sm-12">
		<section class="panel">
			<header class="panel-heading">
				<a href="" class="btn btn-primary btn-export pull-right"><i class="fa fa-download">&#xa0;</i> Exportar XSL</a>
				<h4>Reporte de Recursos</h4>
			</header>
			<div class="panel-body">
				
				<table class="table table-hover general-table" >
								<thead>
									<tr>
										<th>
											<a href="#" data-sort="concept" >Concepto</a>
											<xsl:if test="$sort = 'concept'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="cost" >Costo</a>
											<xsl:if test="$sort = 'cost'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="quantity" >Cantidad</a>
											<xsl:if test="$sort = 'quantity'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										
										<th>
											<a href="#" data-sort="provider_title" >Proveedor</a>
											<xsl:if test="$sort = 'provider_title'">
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
											<a href="#" data-sort="rubro_title" >Rubro</a>
											<xsl:if test="$sort = 'rubro_title'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="subrubro_title" >SubRubro</a>
											<xsl:if test="$sort = 'subrubro_title'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="sindicato_id" >Sindicato</a>
											<xsl:if test="$sort = 'sindicato'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="username" >Creado</a>
											<xsl:if test="$sort = 'username'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
									</tr>
								</thead>
								<tbody>
								<xsl:for-each select="$content/collection/object">
									<tr class="item_row" id="object_{id}" item_id="{id}">

										<td><xsl:value-of select="concept" /></td>
										<td class="text-right" >$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="cost" /></xsl:call-template></td>
										<td class="text-right" ><xsl:value-of select="quantity" /></td>
										<td>
											<xsl:choose>
												<xsl:when test="provider_id != 0" >
													<a href="/admin/provider/edit/{provider_id}" ><xsl:value-of select="provider_title" /></a>
												</xsl:when>
												<xsl:otherwise>-</xsl:otherwise>
											</xsl:choose>
										</td>
										<td><a href="{$adminroot}project/list_resources/{project_id}" ><xsl:value-of select="project_title" /></a></td>
										<td><xsl:value-of select="rubro_title" /></td>
										<td><xsl:value-of select="subrubro_title" /></td>
										<td><xsl:value-of select="sindicato_name" /></td>
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