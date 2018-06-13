<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="calendar" />
<xsl:param name="type" />
<xsl:param name="pagenumber" />
<xsl:param name="query" />
<xsl:param name="filter" />

<xsl:param name="start_date" />
<xsl:param name="end_date" />

<xsl:param name="state" >0</xsl:param>
<xsl:param name="category_id" />
<xsl:param name="project_id" />
<xsl:param name="creation_userid" />

<xsl:param name="page_url"/>
<xsl:param name="page_params"/>

<xsl:variable name="htmlHeadExtra">
	<script type="text/javascript" src="{$adminPath}/desktop/js/module.list.js">&#xa0;</script>

	<script type="text/javascript">
		$(document).ready(function(){

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
</xsl:variable>

<xsl:template name="content">

	<form name="list" id="list_form" action="{$adminroot}{$modulename}/list/" method="get">
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
			<ul class="breadcrumb">
		        <li ><i class="fa fa-home">&#xa0;</i> <xsl:value-of select="$config/module/@title" /></li>
		        <li>
				</li>
		    </ul>
		</div>
	</div>

	<div class="row">
		<div class="col-sm-12">
			<section class="panel">
				<header class="panel-heading wht-bg">
					<div class="pull-right">
						<a href="{$adminroot}{$modulename}/add" class="btn btn-info">Crear Nuevo</a>
					</div>

					
					<h4><xsl:value-of select="$config/module/@title" /></h4>
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
											<a href="#" data-sort="client.title" >Cliente</a>
											<xsl:if test="$sort = 'client.title'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>
											<a href="#" data-sort="start_date">Comienzo</a>
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
											<a href="#" data-sort="project.state">Estado</a>
											<xsl:if test="$sort = 'project.state'">
												<i class="fa fa-caret-down"></i>
											</xsl:if>
										</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>
								<xsl:for-each select="$content/collection/object">
									<tr class="item_row" id="object_{@id}" item_id="{@id}">
										<td><a href="{$adminroot}{$modulename}/dashboard/{@id}"><xsl:value-of select="title" /></a></td>
										<td><xsl:value-of select="client_title" /></td>
										<td>
											<xsl:call-template name="fecha.formato.numerico">
												<xsl:with-param name="fecha" select="@start_date" />
											</xsl:call-template>
										</td>

										<td>
											<xsl:call-template name="fecha.formato.numerico">
												<xsl:with-param name="fecha" select="@end_date" />
											</xsl:call-template>
										</td>
											
										<td>
											<xsl:variable name="this_state" select="@state" />
											<span class="label label-{$content/states/state[id=$this_state]/label}"><xsl:value-of select="$content/states/state[id=$this_state]/name" /></span>
																								
										</td>
										
										<td>
												<div class="btn-group">

													<button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm">
														Acciones
														<span class="caret">&#xa0;</span>
													</button>

													<ul role="menu" class="dropdown-menu">
			                               				<li>
															<a href="{$adminroot}{$modulename}/edit/{@id}" >
																<i class="fa fa-pencil">&#xa0;</i>
																Editar
															</a> 
														</li>
														<li>
															<a href="{$adminroot}{$modulename}/duplicate/{@id}" >
																<i class="fa fa-copy">&#xa0;</i>
																Clonar
															</a> 
														</li>
														<li>
															<a class="deleteObject" href="#" title="Borrar">
																<i class="fa fa-trash-o">&#xa0;</i>
																Eliminar
															</a>
														</li>
													</ul>
												</div>
											</td>
									</tr>
								</xsl:for-each>
								</tbody>
							</table>

	                       <xsl:call-template name="pagination.box" />

				</div>
			</section>

		</div>
	</div>

	
</xsl:template>
</xsl:stylesheet>