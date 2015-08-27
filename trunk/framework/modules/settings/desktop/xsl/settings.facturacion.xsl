<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="tipo_facturacion" />
<xsl:param name="facturacion_anual" />
<xsl:variable name="htmlHeadExtra">
	 	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/fuelux/css/tree-style.css" />
</xsl:variable>


<xsl:variable name="htmlFooterExtra">
	<script type="text/javascript" src="{$adminPath}/desktop/js/tree.js">&#xa0;</script>
	<script type="text/javascript" src="{$modPath}/desktop/js/rubro.js"  >&#xa0;</script>
</xsl:variable>

<xsl:template name="content">
<div class="row">
	<div class="col-sm-12">

		<a href="#" class="btn btn-info btn-add-rubro pull-right">Agregar Gasto Mensual</a>
		<h1>Facturación</h1>
			
		<section class="panel">
			<div class="panel-body">
				<form action="{$adminroot}?m={$modName}&amp;action=BackEditFacturacionSettings" method="post" >
					<div class="radio">
						<label for="automatico" >
							<input id="automatico" type="radio" name="tipo_facturacion" value="automatico" >
								<xsl:if test="$tipo_facturacion = 'automatico'"><xsl:attribute name="checked" >checked</xsl:attribute></xsl:if>
							</input>
							Monto Automático
						</label>
					</div>
					<div class="radio">
						<label for="manual" >
							<input id="manual" type="radio" name="tipo_facturacion" value="manual" > 
								<xsl:if test="$tipo_facturacion = 'manual'"><xsl:attribute name="checked" >checked</xsl:attribute></xsl:if>
							</input>
							Monto Manual
						</label>
					</div>
					
					<div class="form-group" id="facturacion_manual" >
						<xsl:choose>
							<xsl:when test="$tipo_facturacion = 'automatico'">
								<xsl:attribute name="style">display:none</xsl:attribute>
							</xsl:when>
						</xsl:choose>
							
						<label>Facturación Anual Manual</label>
						<input type="text" name="facturacion_anual" class="form-control" value="{$facturacion_anual}" />
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-primary">Guardar</button>
					</div>
				</form>
			</div>
		</section>

		<script>
			$(document).ready(function(){
				$('input[name="tipo_facturacion"]').change(function(){
					if($(this).val() == 'manual' ){
						$('#facturacion_manual').slideDown();
					}else{
						$('#facturacion_manual').slideUp();
					}
				});
			});
		</script>
			
	</div>
</div>




</xsl:template>

</xsl:stylesheet>