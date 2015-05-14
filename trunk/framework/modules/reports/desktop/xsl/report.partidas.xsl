<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="active" />
<xsl:param name="start_date" />
<xsl:param name="end_date" />
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
		<xsl:with-param name="active">partidas</xsl:with-param>
</xsl:call-template>

<form name="export" id="form_export" action="{$adminroot}" method="get">
	<input type="hidden" name="m" value="reports" />
	<input type="hidden" name="action" value="BackExportPartidas" />
	<input type="hidden" name="start_date" value="{$start_date}" />
	<input type="hidden" name="end_date" value="{$end_date}" />
	<input type="hidden" name="project_id" value="{$project_id}" />
	<input type="hidden" name="state" value="{$state}" />
	<input type="hidden" name="creation_userid" value="{$creation_userid}" />
	<input type="hidden" name="export_data" value="1" />
</form>


<form name="list" id="list_form" action="{$adminroot}" method="get">
	<input type="hidden" name="m" value="reports" />
	<input type="hidden" name="action" value="BackReportPartidas" />
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
				<a href="#" class="btn btn-primary btn-export pull-right"><i class="fa fa-download">&#xa0;</i> Exportar XSL</a>
				<h4>Reporte </h4>
			</header>
			<div class="panel-body">
				
				<table class="table table-hover general-table" >
								<thead>
									<tr>
										<th>
											<a href="#" data-sort="id" >Nro</a>
											<xsl:if test="$sort = 'id'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="description" >Descripcion</a>
											<xsl:if test="$sort = 'description'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="responsable" >Responsable</a>
											<xsl:if test="$sort = 'responsable'">
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
											<a href="#" data-sort="amount" >Monto</a>
											<xsl:if test="$sort = 'amount'">
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
											<a href="#" data-sort="username" >Usuario</a>
											<xsl:if test="$sort = 'username'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
									</tr>
								</thead>
								<tbody>
								<xsl:for-each select="$content/collection/object">
									<tr class="item_row" id="object_{id}" item_id="{id}">
										<td><xsl:value-of select="id" /></td>
										<td><a href="{$adminroot}project/view_partida/{project_id}/partida/{id}"><xsl:value-of select="description" /></a></td>
										<td><xsl:value-of select="responsable" /></td>
										<td><a href="{$adminroot}project/edit/{project_id}"><xsl:value-of select="project_title" /></a></td>
										<td>$ <xsl:value-of select="amount" /></td>
										<td>
											<xsl:call-template name="fecha.formato.numerico">
												<xsl:with-param name="fecha" select="date" />
											</xsl:call-template>
										</td>
										<td>
											<a href="{$adminroot}admin/edit/{user_id}"><b><xsl:value-of select="username" /></b>&#xa0;(<xsl:value-of select="user_name" />&#xa0;<xsl:value-of select="user_lastname" />)
											</a>
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