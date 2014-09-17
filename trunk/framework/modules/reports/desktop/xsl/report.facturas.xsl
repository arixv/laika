<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="rubro_id"/>
<xsl:param name="number"/>
<xsl:param name="project_id"/>
<xsl:param name="min_amount"/>
<xsl:param name="max_amount"/>
<xsl:param name="provider_id"/>
<xsl:param name="subrubro_id"/>
<xsl:param name="start_date"/>
<xsl:param name="end_date"/>
<xsl:param name="state" />
<xsl:param name="type" />
<xsl:param name="creation_userid" />
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
	<xsl:with-param name="active">facturas</xsl:with-param>
</xsl:call-template>



<form name="export" id="form_export" action="{$adminroot}" method="get">
	<input type="hidden" name="m" value="reports" />
	<input type="hidden" name="action" value="BackExportFacturas" />
	<input type="hidden" name="start_date" value="{$start_date}" />
	<input type="hidden" name="end_date" value="{$end_date}" />
	<input type="hidden" name="project_id" value="{$project_id}" />
	<input type="hidden" name="client_id" value="{$client_id}" />
	<input type="hidden" name="provider_id" value="{$provider_id}" />
	<input type="hidden" name="subrubro_id" value="{$subrubro_id}" />
	<input type="hidden" name="type" value="{$type}" />
	<input type="hidden" name="state" value="{$state}" />
	<input type="hidden" name="min_amount" value="{$min_amount}" />
	<input type="hidden" name="max_amount" value="{$max_amount}" />
	<input type="hidden" name="creation_userid" value="{$creation_userid}" />
	<input type="hidden" name="export_data" value="1" />
</form>


<form name="list" id="list_form" action="{$adminroot}" method="get">
	<input type="hidden" name="m" value="reports" />
	<input type="hidden" name="action" value="BackReportFacturas" />
	<input type="hidden" name="start_date" value="{$start_date}" />
	<input type="hidden" name="end_date" value="{$end_date}" />
	<input type="hidden" name="project_id" value="{$project_id}" />
	<input type="hidden" name="client_id" value="{$client_id}" />
	<input type="hidden" name="provider_id" value="{$provider_id}" />
	<input type="hidden" name="subrubro_id" value="{$subrubro_id}" />
	<input type="hidden" name="type" value="{$type}" />
	<input type="hidden" name="state" value="{$state}" />
	<input type="hidden" name="min_amount" value="{$min_amount}" />
	<input type="hidden" name="max_amount" value="{$max_amount}" />
	<input type="hidden" name="creation_userid" value="{$creation_userid}" />
	<input type="hidden" name="sort" value="{$sort}" />
</form>


<div class="row">
	<div class="col-sm-12">
		<section class="panel">
			<header class="panel-heading">
				<a href="" class="btn btn-primary btn-export pull-right"><i class="fa fa-download">&#xa0;</i> Exportar XSL</a>
				<h4>Reporte Facturas</h4>
			</header>
			<div class="panel-body">
				
				<table class="table table-hover general-table" >
								<thead>
									<tr>
										<th>
											<a href="#" data-sort="state" >Estado</a>
											<xsl:if test="$sort = 'state'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="id" >Nro</a>
											<xsl:if test="$sort = 'id'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="type" >Tipo</a>
											<xsl:if test="$sort = 'type'">
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
											<a href="#" data-sort="subrubro_id" >Subrubro</a>
											<xsl:if test="$sort = 'subrubro_id'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="partida_id" >Partida</a>
											<xsl:if test="$sort = 'partida_id'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="date" >Fecha</a>
											<xsl:if test="$sort = 'date'">
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
											<a href="#" data-sort="user_name" >Creador</a>
											<xsl:if test="$sort = 'user_name'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="amount" >Monto</a>
											<xsl:if test="$sort = 'amount'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
									</tr>
								</thead>
								<tbody>
								<xsl:for-each select="$content/collection/object">
									<tr class="item_row" id="object_{@id}" item_id="{@id}">
										<td>
											<xsl:choose>
												<xsl:when test="state = 1">
													<span class="label label-success label-mini"><i class="fa fa-check">&#xa0;</i></span>
												</xsl:when>
												<xsl:when test="state = 0">
													<span class="label label-warning label-mini"><i class="fa fa-times">&#xa0;</i></span>
												</xsl:when>
											</xsl:choose>
										</td>
										<td><xsl:value-of select="number" /></td>
										<td><xsl:value-of select="type" /></td>
										<td><xsl:value-of select="provider_title" /></td>
										<td><xsl:value-of select="subrubro_title" /></td>
										<td><xsl:value-of select="partida_id" /></td>

										<td>
											<xsl:call-template name="fecha.formato.numerico">
												<xsl:with-param name="fecha" select="date" />
											</xsl:call-template>
										</td>
										<td><xsl:value-of select="project_title" /></td>
										<td><xsl:value-of select="user_name" />&#xa0;<xsl:value-of select="user_lastname" /></td>
										
										<td>$<xsl:value-of select="amount" /></td>
										
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