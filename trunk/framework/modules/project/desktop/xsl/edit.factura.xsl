<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="type" />

<!-- PROJECT OBJECT -->
<xsl:variable name="object" select="$content/object" />

<!-- TOTAL ESTIMATE -->
<xsl:variable name="total_estimate">
<xsl:value-of select="$content/estimate/total" />
</xsl:variable>

<!-- IMPREVISTOS -->
<xsl:variable name="total_imprevistos">
<xsl:value-of select="floor($total_estimate * $object/imprevistos div 100)" />
</xsl:variable>

<!-- GANANCIAS -->
<xsl:variable name="total_ganancia">
<xsl:value-of select="floor(($total_estimate + $total_imprevistos) * $object/ganancia div 100)" />
</xsl:variable>

<!-- IMPUESTOS -->
<xsl:variable name="total_impuestos">
<xsl:value-of select="floor(($total_ganancia + $total_imprevistos + $total_estimate) * $object/impuestos div 100)" />
</xsl:variable>

<!-- HEAD EXTRA -->
<xsl:variable name="htmlHeadExtra">
	<script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script>
	<script src="{$modPath}/desktop/js/project.edit.js" type="text/javascript">&#xa0;</script>
</xsl:variable>

<!-- FOOTER EXTRA -->
<xsl:variable name="htmlFooterExtra">

</xsl:variable>


<xsl:template name="content">

<xsl:call-template name="project.nav" />

<form name="editFactura" role="form" action="/admin/?m=project&amp;action=BackEditFactura" method="post">
	<input type="hidden" name="project_id" value="{$project_id}" />
	<input type="hidden" name="factura_id" value="{$content/factura/id}" />

	<div class="row" >
		<div class="col-sm-12">
				<section class="panel">
					<header class="panel-heading wht-bg">
						<div class="form-group">
							<button type="submit" class="btn btn-info pull-right">Guardar</button>
						</div>
						<h4 class="gen-case">Editar Factura</h4>
					</header>
					<div class="panel-body">
						<xsl:call-template name="form.edit.factura" />
					</div>
				</section>
		</div>
	</div>
</form>






<div id="modal" class="modal fade" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>

</xsl:template>
</xsl:stylesheet>