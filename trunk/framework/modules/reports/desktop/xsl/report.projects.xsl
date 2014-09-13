<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="active" />
<xsl:param name="start_date" />
<xsl:param name="end_date" />
<xsl:param name="project_id" />
<xsl:param name="client_id" />
<xsl:param name="type" />
<xsl:param name="state" />
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
		<xsl:with-param name="active">projects</xsl:with-param>
</xsl:call-template>

<form name="export" id="form_export" action="{$adminroot}" method="get">
	<input type="hidden" name="m" value="reports" />
	<input type="hidden" name="action" value="BackExportProject" />
	<input type="hidden" name="start_date" value="{$start_date}" />
	<input type="hidden" name="end_date" value="{$end_date}" />
	<input type="hidden" name="project_id" value="{$project_id}" />
	<input type="hidden" name="client_id" value="{$client_id}" />
	<input type="hidden" name="type" value="{$type}" />
	<input type="hidden" name="state" value="{$state}" />
	<input type="hidden" name="creation_userid" value="{$creation_userid}" />
	<input type="hidden" name="export_data" value="1" />
</form>


<form name="list" id="list_form" action="{$adminroot}" method="get">
	<input type="hidden" name="m" value="reports" />
	<input type="hidden" name="action" value="BackReportProjects" />
	<input type="hidden" name="start_date" value="{$start_date}" />
	<input type="hidden" name="end_date" value="{$end_date}" />
	<input type="hidden" name="project_id" value="{$project_id}" />
	<input type="hidden" name="client_id" value="{$client_id}" />
	<input type="hidden" name="type" value="{$type}" />
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
											<a href="#" data-sort="title" >Titulo</a>
											<xsl:if test="$sort = 'title'">
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
											<a href="#" data-sort="client_id">Cliente</a>
											<xsl:if test="$sort = 'client_id'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="start_date">Inicio</a>
											<xsl:if test="$sort = 'start_date'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="end_date">Fin</a>
											<xsl:if test="$sort = 'end_date'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="creation_userid">Creador</a>
											<xsl:if test="$sort = 'creation_userid'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="state">Estado</a>
											<xsl:if test="$sort = 'state'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										
									</tr>
								</thead>
								<tbody>
								<xsl:for-each select="$content/collection/object">
									<tr class="item_row" id="object_{@id}" item_id="{@id}">
										<td><xsl:value-of select="title" /></td>
										<td><xsl:value-of select="type" /></td>
										<td><xsl:value-of select="client_title" /></td>
										<td>
											<xsl:call-template name="fecha.formato.numerico">
												<xsl:with-param name="fecha" select="start_date" />
											</xsl:call-template>
										</td>
										<td>
											<xsl:call-template name="fecha.formato.numerico">
												<xsl:with-param name="fecha" select="end_date" />
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