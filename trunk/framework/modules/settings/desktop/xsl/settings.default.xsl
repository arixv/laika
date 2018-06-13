<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="total" />

<xsl:variable name="htmlHeadExtra">
</xsl:variable>


<xsl:variable name="htmlFooterExtra">
	<script type="text/javascript" src="{$modPath}/desktop/js/settings.js"  >&#xa0;</script>
</xsl:variable>

<xsl:template name="content">
<div class="row">
	<div class="col-sm-12">
		
		<section class="panel">
			<div class="panel-heading wht-bg">
				<a href="#modal" class="pull-right btn btn-add-costo btn-info" data-toggle="modal" >Agregar Costo Operativo</a>
				<h4>
					Costo Operativo Mensual
				</h4>
			</div>
		</section>
			
		<section class="panel">
			<div class="panel-body">
				<table class="table table-bordered table-striped table-condensed">
					<thead>
						<th>Descripción</th>
						<th>Costo</th>
						<th>Acciones</th>
					</thead>
					<tbody>
						<xsl:for-each select="$content/costos/costo_operativo">
							<tr id="costo_{id}" >
								<td><xsl:value-of select="title" /></td>
								<td>$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="amount" /></xsl:call-template></td>
								<td>
									<a href="#" class="btn-edit-costo btn btn-primary btn-sm" costo-id="{id}" >Editar</a>
									<a href="#" class="btn-delete-costo btn btn-default btn-sm" costo-id="{id}" >Eliminar</a>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
					<tfoot>
						<tr>
							<td>Costo Operativo Mensual:</td>
							<td><b>$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="$total" /></xsl:call-template></b> </td>
						</tr>
				
					</tfoot>
				</table>
			</div>
		</section>
			
	</div>
</div>

<div id="modal" class="modal" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>


</xsl:template>

</xsl:stylesheet>