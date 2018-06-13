<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="sort" />

<xsl:variable name="htmlHeadExtra">
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/jquery-multi-select/css/multi-select.css" />
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/select2/select2.css" />

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
	<script type="text/javascript" src="{$adminPath}/desktop/js/module.list.js" >&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/module.edit.js" >&#xa0;</script>
	<script type="text/javascript" src="{$modPath}/desktop/js/project.edit.js"  >&#xa0;</script>
</xsl:variable>

<xsl:template name="content">

	<xsl:variable name="object" select="$content/object" />

	<xsl:call-template name="project.nav">
		<xsl:with-param name="active" >factura</xsl:with-param>
	</xsl:call-template>

	<form name="list" id="list_form" action="{$adminroot}{$modulename}/list_factura/{$object/@id}/" method="get">
		<input type="hidden" name="sort" value="{$sort}" />
	</form>


<!-- FACTURAS -->
<div class="row">
	<div class="col-sm-12">

		
			
	

		<section class="panel">

			<header class="panel-heading wht-bg">

				<div class="pull-right">
					<xsl:if test="$content/object/@state &lt; 2">
						<a href="#modal" class="btn btn-add-factura btn-info" project-id="{$object/@id}" data-redirect="/list_factura/{$object/@id}" data-toggle="modal" >Agregar Facturas</a>
					</xsl:if>
				</div>
					
               <h4 class="gen-case">Facturas</h4>
            </header>

			<div class="panel-body">

				<div class="mail-option">

					


                  <!--   <div class="chk-all">

                        <div class="btn-group">
                            <a data-toggle="dropdown" href="#" class="btn all">
                                Filtrar por 
                                <i class="fa fa-angle-down ">&#xa0;</i>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="#"> Todas</a></li>
                                <li><a href="#"> Pagas</a></li>
                                <li><a href="#"> Pendientes</a></li>
                            </ul>
                        </div>
                    </div>


                    <div class="btn-group">
                    	<input type="text" class="form-control" placeholder="Fecha desde" />
                    </div>
                    <div class="btn-group">
                    	<input type="text" class="form-control" placeholder="Fecha hasta" />
                    </div> -->

                           
				</div>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>
								<a href="#" data-sort="factura.number" >#</a>
								<xsl:if test="$sort = 'factura.number'"><i class="fa fa-caret-down"></i></xsl:if>
							</th>
							<th>
								<a href="#" data-sort="date" >Fecha</a>
								<xsl:if test="$sort = 'date'"><i class="fa fa-caret-down"></i></xsl:if>
							</th>
							<th>
								<a href="#" data-sort="partida_id" >Partida</a>
								<xsl:if test="$sort = 'partida_id'"><i class="fa fa-caret-down"></i></xsl:if>
							</th>
							<th>
								<a href="#" data-sort="rubro.title" >Rubro</a>
								<xsl:if test="$sort = 'rubro.title'"><i class="fa fa-caret-down"></i></xsl:if>
							</th>
							<th>
								<a href="#" data-sort="provider.title" >Proveedor</a>
								<xsl:if test="$sort = 'provider.title'"><i class="fa fa-caret-down"></i></xsl:if>
							</th>
							<th>
								<a href="#" data-sort="type" >Tipo</a>
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
						<xsl:for-each select="$content/facturas/object">
							<xsl:variable name="partida_id"><xsl:value-of select="partida_id" /></xsl:variable>
							<xsl:variable name="provider_id"><xsl:value-of select="provider_id" /></xsl:variable>
							
							<tr id="factura_{id}">
								<td><xsl:value-of select="number" /></td>
								<td><xsl:call-template name="fecha.formato.numerico"><xsl:with-param name="fecha" select="date" /></xsl:call-template></td>
								<td><xsl:choose><xsl:when test="$partida_id = 0">- Sin Partida Asociada -</xsl:when><xsl:otherwise><xsl:value-of select="partida_title" /></xsl:otherwise></xsl:choose></td>
								<td><xsl:value-of select="rubro_title" /></td>
								<td><xsl:value-of select="provider_name" /></td>
								<td><xsl:value-of select="type" /></td>
								
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
								<td>$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="amount" /></xsl:call-template></td>
								<td>
									<div class="btn-group">

										<button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm">
											Acciones
											<span class="caret">&#xa0;</span>
										</button>

										<ul role="menu" class="dropdown-menu">
			                               <li><a href="{$adminroot}{$modName}/edit_factura/{$object/@id}/factura/{id}" class="btn-edit-factura" project-id="" factura-id="{id}" ><i class="fa fa-edit">&#xa0;</i>Editar</a></li>
			                                <!-- <li><a href="#"><i class="fa fa-copy">&#xa0;</i>Duplicar</a></li> -->
			                                <li class="divider"></li>
			                                <li><a href="#" class="btn-delete-factura" project-id="{$object/@id}" factura-id="{id}" ><i class="fa fa-trash-o">&#xa0;</i>Eliminar</a></li>
			                            </ul>
									</div>
								</td>
							</tr>
						</xsl:for-each>
						
					</tbody>
				</table>
			</div>


		</section>



	</div>
</div>
<!-- //FACTURAS -->


<div id="modal" class="modal" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>
	
</xsl:template>
</xsl:stylesheet>