<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />


<xsl:variable name="htmlHeadExtra">
	<script type="text/javascript" src="{$adminPath}/desktop/js/module.list.js" >&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/module.edit.js" >&#xa0;</script>
	
</xsl:variable>

<xsl:variable name="htmlFooterExtra">
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

		<h1>
			<a href="#modal" class="btn btn-add-factura btn-info pull-right" project-id="{$object/@id}" data-toggle="modal" >Agregar Facturas</a>
			Facturas
		</h1>

		<section class="panel">

			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>#</th>
							<th>Descripción</th>
							<th>Partida</th>
							<th>Rubro > Subrubro</th>
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
								<td><xsl:value-of select="description" /></td>
								<td><xsl:value-of select="$content/partidas//partida[id = $partida_id]/description" /></td>
								<td><xsl:value-of select="rubro_id" /> > <xsl:value-of select="subrubro_id" /></td>
								<td><xsl:value-of select="$content/providers/object[@id = $provider_id]/title" /></td>
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