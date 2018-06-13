<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="calendar" />
<xsl:param name="type" />
<xsl:param name="pagenumber" />
<xsl:param name="query" />
<xsl:param name="filter" />
<xsl:param name="state" >0</xsl:param>
<xsl:param name="category_id" />
<xsl:param name="resources_order" />


<xsl:variable name="htmlHeadExtra">
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/jquery-multi-select/css/multi-select.css" />
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/select2/select2.css" />
	<script>
		$(function () {
		  $('[data-toggle="tooltip"]').tooltip();
		})
	</script>
</xsl:variable>

<xsl:variable name="htmlFooterExtra">

	<script type="text/javascript" src="{$adminPath}/desktop/js/module.list.js" >&#xa0;</script>
	<script type="text/javascript" src="{$modPath}/desktop/js/project.edit.js" >&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/fuelux/js/spinner.min.js"></script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery-multi-select/js/jquery.multi-select.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery-multi-select/js/jquery.quicksearch.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/select2/select2.js">&#xa0;</script>
</xsl:variable>


<xsl:template name="content">

	<xsl:variable name="object" select="$content/object" />

	<xsl:call-template name="project.nav">
		<xsl:with-param name="active" >rubro</xsl:with-param>
	</xsl:call-template>

	<form name="ordenar" action="/admin/project/sort_resource" method="post" >
		<input type="hidden" name="project_id" id="project_id" value="{$content/object/@id}" />
		<input type="hidden" name="sort_order" id="sort_order" value="{$resources_order}" />
	</form>

<!-- RUBROS -->
<div class="row">
	<div class="col-sm-12">
		
		<section class="panel">
			<header class="panel-heading wht-bg">

				<xsl:if test="$content/object/@state &lt; 2">
					<div class="pull-right">
						<a href="#modal" class="btn btn-info btn-add-resource" project-id="{$content/object/@id}" data-toggle="modal" >Agregar Recurso</a>
					</div>
				</xsl:if>

           		<h4 class="gen-case">Recursos</h4>
        	</header>
        	
		</section>

		<xsl:choose>
			<xsl:when test="$content/rubros/rubro">

				<div id="sortable-rubros">
				<xsl:for-each select="$content/rubros/rubro">
					<section class="panel" id="rubro_{id}" >

						<header class="panel-heading wht-bg">
							<xsl:if test="$content/object/@state &lt; 2">
								<div class="btn-group pull-right">
									<a href="#" class="btn btn-default" onclick="DeleteRubro({$content/object/@id},{id});">
		                             	<i class="fa fa-trash-o">&#xa0;</i>&#xa0;Eliminar
		                             </a> 
								</div>
							</xsl:if>

							<h5>
								<span class="fa fa-arrows-v">&#xa0;</span>
								<xsl:value-of select="title" />
								&#xa0;
								<strong class="badge bg-info">Total Estimado&#xa0;$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="./resources/estimate_total" /></xsl:call-template></strong>
								<xsl:if test="$content/object/@state != 0">
									<strong class="badge bg-important">Total Real&#xa0;$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="./resources/total" /></xsl:call-template></strong>
								</xsl:if>
							</h5>
								
						</header>

						<div class="panel-body" style="overflow-x:scroll;">
							<table class="table table-bordered table-striped table-condensed" >
								<thead>
									<tr>
										<th>Nombre</th>
										<th>Proveedor</th>
										<th class="numeric" style="background:#E2E2E2;" >Unidades<br/>Estimadas</th>
										<th class="numeric" style="background:#E2E2E2;" >Cantidad<br/>Estimada</th>
										<th class="numeric" style="background:#E2E2E2;" >Costo<br/>Estimado</th>
										<th class="numeric" style="background:#E2E2E2;" >Subtotal<br/>Estimado</th>
										<th class="numeric" style="background:#E2E2E2;" >Sindicato</th>
										<xsl:if test="$content/object/@state != 0">
											<th class="numeric" >Unidades<br/>Real</th>
											<th class="numeric" >Cantidad<br/>Real</th>
											<th class="numeric" >Costo<br/>Real</th>
											<th class="numeric" >Subtotal<br/>Real</th>
											<th>Progreso</th>
										</xsl:if>
										
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>
									<xsl:for-each select="./resources/resource">
										<xsl:variable name="thisProvider" select="provider_id" />
										<tr id="resource_{resource_id}">
											<td>
												<xsl:value-of select="title" />&#xa0;
												<a id="tootltip_{resource_id}" href="#" class="badge badge-info pull-right" data-toggle="tooltip" data-placement="top" title="{description}"><i class="fa fa-info" ></i></a>
											</td>
											<td><xsl:value-of select="$content/providers/object[@id = $thisProvider]/title" /></td>
											<td class="numeric" ><xsl:value-of select="estimate_units" /></td>
											<td class="numeric" ><xsl:value-of select="estimate_quantity" />&#xa0;<xsl:value-of select="concept" /></td>
											<td class="numeric" >$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="estimate_cost" /></xsl:call-template></td>
											<td class="numeric" >$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="estimate_subtotal" /></xsl:call-template></td>
											<td class="numeric" ><xsl:value-of select="sindicato_percentage" /> %</td>
											<xsl:if test="$content/object/@state != 0">
												<td ><xsl:value-of select="units" /></td>
												<td ><xsl:value-of select="quantity" />&#xa0;<xsl:value-of select="concept" /></td>
												<td class="numeric" >$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="cost" /></xsl:call-template></td>
												<td class="numeric" >$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="subtotal" /></xsl:call-template></td>

												<td>
													<div class="progress progress-striped">
														<xsl:variable name="progress_color">
															<xsl:choose>
																<xsl:when test="progress &gt; 80" >progress-bar-success</xsl:when>
																<xsl:when test="progress &lt; 80 and progress &gt;= 50" >progress-bar-warning</xsl:when>
																<xsl:when test="progress &lt; 50" >progress-bar-danger</xsl:when>
															</xsl:choose>
														</xsl:variable>
														<xsl:variable name="progress_width">
															<xsl:choose>
																<xsl:when test="progress &lt; 100" ><xsl:value-of select="progress" /></xsl:when>
																<xsl:when test="progress &gt;= 100" >100</xsl:when>
															</xsl:choose>
														</xsl:variable>
									                    <div class="progress-bar {$progress_color}" role="progressbar" aria-valuenow="{@progress}" aria-valuemin="0" aria-valuemax="100" style="width: {$progress_width}%;">
									                        <span><xsl:value-of select="progress" />%</span>
									                    </div>

									                </div>
												</td>
											</xsl:if>
											<td>
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm">
														Acciones
														<span class="caret">&#xa0;</span>
													</button>

													<ul role="menu" class="dropdown-menu">
						                               <li><a href="#" class="btn-edit-resource" resource-id="{resource_id}" project-id="{$content/object/@id}" subrubro-id="{subrubro_id}" ><i class="fa fa-edit">&#xa0;</i>Editar</a></li>
						                                <li class="divider"></li>
						                                <li><a href="#" class="btn-delete-resource" resource-id="{resource_id}" project-id="{$content/object/@id}" subrubro-id="{subrubro_id}" ><i class="fa fa-trash-o">&#xa0;</i>Eliminar</a></li>
						                            </ul>

												</div>
											</td>
										</tr>
										<xsl:if test="sindicato_name != ''" >
											<tr>
												<td colspan="4" >
													<p style="text-align:right" ><b>+ Sindicato:&#xa0;<xsl:value-of select="sindicato_name" />&#xa0;<xsl:value-of select="sindicato_percentage" />%</b></p>
												</td>
												<td>
													$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="(subtotal * sindicato_percentage div 100)" /></xsl:call-template>
												</td>
												<td colspan="3"></td>
											</tr>
										</xsl:if>
									</xsl:for-each>
								</tbody>
							</table>
						</div>
					</section>
				</xsl:for-each>
			</div>
				

			</xsl:when>
			<xsl:otherwise>
				<div class="alert alert-info fade in">
					<p>
						<center>
							Este proyecto no tiene ningun recurso asignado
						</center>
					</p>
				</div>
			</xsl:otherwise>
		</xsl:choose>

		
	</div>
</div>

<!-- / RUBROS -->

  <script type="text/javascript" >



  $(function() {
	  $('form[name="ordenar"]').ajaxForm({
			success: function(){
				alert("elementos ordenados");
			}
		});

		$('#sortable-rubros').sortable({
			axis:'y',
			cursor:'move',
			update: function(){
				console.log('sortItems call');
				sortItems();
			}
		});
    
    $( "#sortable-rubros" ).disableSelection();
  });
  </script>



<div id="modal" class="modal" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>
	
</xsl:template>
</xsl:stylesheet>