<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />


<xsl:variable name="htmlHeadExtra">
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/jquery-multi-select/css/multi-select.css" />
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/select2/select2.css" />
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



<!-- FACTURAS -->
<div class="row">
	<div class="col-sm-12">

		
			
	

		<section class="panel">

			<header class="panel-heading wht-bg">
               <h4 class="gen-case">Facturas
                <!-- <form action="/admin/{$modPath}/list_factura/{$object/@id}/" class="pull-right mail-src-position">
                    <div class="input-append">
                        <input name="q" type="text" class="form-control" placeholder="Buscar Facturas" />
                    </div>
                </form> -->
               </h4>
            </header>

			<div class="panel-body">

				<div class="mail-option">

					<div class="pull-right">
						<a href="#modal" class="btn btn-add-factura btn-info" project-id="{$object/@id}" data-redirect="/list_factura/{$object/@id}" data-toggle="modal" >Agregar Facturas</a>
					</div>


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
							<th>#</th>
							<th>Partida</th>
							<th>Subrubro</th>
							<th>Proveedor</th>
							<th>Tipo</th>
							<th>Fecha</th>
							<th>Estado</th>
							<th>Monto</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="$content/facturas/object">
							<xsl:variable name="partida_id"><xsl:value-of select="partida_id" /></xsl:variable>
							<xsl:variable name="provider_id"><xsl:value-of select="provider_id" /></xsl:variable>
							<tr id="factura_{id}">
								<td><xsl:value-of select="number" /></td>
								<!-- <td><xsl:value-of select="description" /></td> -->
								<td><xsl:value-of select="partida_title" /></td>
								<td><xsl:value-of select="rubro_title" /></td>
								<td><xsl:value-of select="provider_name" /></td>
								<td><xsl:value-of select="type" /></td>
								<td><xsl:value-of select="date" /></td>
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
			                               <li><a href="#" class="btn-edit-factura" project-id="{$object/@id}" factura-id="{id}" ><i class="fa fa-edit">&#xa0;</i>Editar</a></li>
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


<div id="modal" class="modal fade" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>
	
</xsl:template>
</xsl:stylesheet>