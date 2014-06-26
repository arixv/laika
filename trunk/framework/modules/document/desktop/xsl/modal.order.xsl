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
		<title>Fotos</title>
		<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/css/admin.css" />
		<xsl:call-template name="jquery" />

		<script type="text/javascript" src="{$adminPath}/desktop/js/jquery-ui.js" />
		<script type="text/javascript" src="{$adminPath}/desktop/js/forms.js" />
		<script type="text/javascript" src="{$adminPath}/desktop/js/admin.js" />
		<script type="text/javascript" src="{$adminPath}/desktop/js/jquery.cookie.js" />
		
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
							<xsl:for-each select="content/object/documents/document">
								<xsl:sort order="ascending" select="@order" data-type="number"/>
								<li id="el-{@document_id}">
									<img src="{$modPath}/desktop/imgs/{@type}.png" class="icon" style="vertical-align:middle;margin:0 10px 0 0;"/>
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