<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="page_url"/>
<xsl:param name="page_params"/>

<xsl:variable name="htmlHeadExtra">
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/jquery-multi-select/css/multi-select.css" />
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/select2/select2.css" />
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
	<script type="text/javascript" src="{$adminPath}/desktop/js/fuelux/js/spinner.min.js"></script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery-multi-select/js/jquery.multi-select.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery-multi-select/js/jquery.quicksearch.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/select2/select2.js">&#xa0;</script>
	<script type="text/javascript" src="{$modPath}/desktop/js/cobros.js"  >&#xa0;</script>
</xsl:variable>



<xsl:template name="content">

	<xsl:variable name="object" select="$content/object" />

	<form name="list" id="list_form" action="{$adminroot}{$modulename}/list/{$object/@id}/" method="get">
		<input type="hidden" name="sort" value="{$sort}" />
	</form>


<!-- COBROS -->
<div class="row">
	<div class="col-sm-12">
			
	

		<section class="panel">

			<header class="panel-heading wht-bg">
               <div class="pull-right">
					<a href="#modal" class="btn btn-add-cobro btn-info"  data-toggle="modal" >Agregar Cobro</a>
				</div>
				<h4 class="gen-case">Cobros</h4>
            </header>

			<div class="panel-body">

				<div class="mail-option">

					
                           
				</div>
				
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>
								<a href="#" data-sort="cobro.number" >#</a>
								<xsl:if test="$sort = 'cobro.number'"><i class="fa fa-caret-down"></i></xsl:if>
							</th>
							<th>
								<a href="#" data-sort="date" >Fecha</a>
								<xsl:if test="$sort = 'date'"><i class="fa fa-caret-down"></i></xsl:if>
							</th>
							<th>
								<a href="#" data-sort="type" >Proveedor</a>
								<xsl:if test="$sort = 'type'"><i class="fa fa-caret-down"></i></xsl:if>
							</th>
							
							<th>
								<a href="#" data-sort="state" >Estado</a>
								<xsl:if test="$sort = 'state'"><i class="fa fa-caret-down"></i></xsl:if>
							</th>
							<th>
								<a href="#" data-sort="amount" >Monto</a>
								<xsl:if test="$sort = 'amount'"><i class="fa fa-caret-down"></i></xsl:if>
							</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="$content/collection/cobro">
							
							<tr id="cobro_{id}">
								<td><xsl:value-of select="number" /></td>
								<td><xsl:call-template name="fecha.formato.numerico"><xsl:with-param name="fecha" select="date" /></xsl:call-template></td>
								<td><xsl:value-of select="provider_title" /></td>
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
								<td>$ <xsl:value-of select="amount" /></td>
								<td>
									<div class="btn-group">
										<button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm">
											Acciones
											<span class="caret">&#xa0;</span>
										</button>

										<ul role="menu" class="dropdown-menu">
			                               <li><a href="{$adminroot}{$modName}/edit/{id}" class="btn-edit-cobro" data-id="{id}" ><i class="fa fa-edit">&#xa0;</i>Editar</a></li>
			                                <li class="divider"></li>
			                                <li><a href="#" class="btn-delete-cobro"  data-id="{id}" ><i class="fa fa-trash-o">&#xa0;</i>Eliminar</a></li>
			                            </ul>
									</div>
								</td>
							</tr>
						</xsl:for-each>
						
					</tbody>
				</table>
				
				
				<xsl:call-template name="pagination">
					<xsl:with-param name="total" select="content/collection/@total" />
					<xsl:with-param name="display" select="content/collection/@pagesize" />
					<xsl:with-param name="currentPage" select="content/collection/@page" />
					<xsl:with-param name="url" select="$page_url" />
					<xsl:with-param name="params" select="$page_params" />
				</xsl:call-template>
				
			</div>


		</section>



	</div>
</div>
<!-- //COBROS -->


<div id="modal" class="modal fade" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>
	
</xsl:template>
</xsl:stylesheet>