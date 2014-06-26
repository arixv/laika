<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />


<xsl:variable name="config" select="/xml/configuration" />
<xsl:variable name="cellsPerRow">3</xsl:variable>
<xsl:param name="object_id" />
<xsl:param name="category_id" />

<xsl:template match="/xml">
<html>
	<head>
		<xsl:call-template name="htmlHead" />
		<link rel="stylesheet" type="text/css" href="{$modPath}/desktop/css/photo.css" />
		
		<script type="text/javascript" src="{$modPath}/desktop/js/modals.js" />
		<script type="text/javascript" src="{$modPath}/desktop/js/order.js" />
		
		<script type="text/javascript">object_id = <xsl:value-of select="$object_id" />;</script>
	</head>
	<body class="mdn_modal">
		<div class="modal-header">
			<h3>Orden de las Relaciones</h3>
		</div>
		
		
		<form name="ordenar" action="{$config/system/adminpath}?m={configuration/module/@name}&amp;action=BackObjectRelationsOrder" method="post">
			<input type="hidden" name="object_id" value="{$object_id}" />
			<input type="hidden" name="category_id" value="{$category_id}" />
			<input type="hidden" name="order" value="" class="order"/>

			<div id="modalContent" class="showButtons">
				<div class="padding">
					<p style="margin:0 0 10px 0;">Mueva los elementos a la posición deseada</p>
					<div id="output1"></div>
					
					<div class="ordenar">
						<ul id="elementos">
							<xsl:for-each select="content/object/photos/photo">
								<xsl:sort order="ascending" select="@order" data-type="number"/>
								<li id="el-{@photo_id}">
									<img src="/{$config/module/options/group[@name='folders']/option[@name='generated']}/{substring(@photo_id, string-length(@photo_id),1)}/{@photo_id}_t.{@type}" class="foto"/>
									<xsl:value-of select="title" />
								</li>
							</xsl:for-each>
						</ul>
					</div>

				</div>
			</div>
			<div class="modal-controls">
				<button type="submit" class="boton azul">Guardar</button>
				<a class="boton" onclick="parent.layer.Remove();;return false;">Cancelar</a>
			</div>
		</form>
		<xsl:if test="$debug = 1">
			<xsl:call-template name="debug" />
		</xsl:if>
	</body>
</html>

</xsl:template>




</xsl:stylesheet>