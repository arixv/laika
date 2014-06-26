<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />

<xsl:variable name="config" select="/xml/configuration" />
<xsl:variable name="cellsPerRow">3</xsl:variable>
<xsl:param name="object_id" />
<xsl:param name="type_id" />
<xsl:param name="query" />

<xsl:template match="/xml">
<html>
	<head>
		<title>Relaciones</title>
		<xsl:call-template name="jquery" />
		<xsl:call-template name="modal.scripts" />
		
		<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/css/admin.css" />
		<script>
			$(document).ready(function(){

				layer.Ready();
				$('input:checkbox').change(function(){
					relation.AddItem($(this));
				});
				

				var options = { 
					success: closeModal
				};
				$("form[name='relacionar']").ajaxForm(options);
			});

			function closeModal(responseText, statusText, xhr, $form){
				//alert('listo!');
				parent.relation.updateList(<xsl:value-of select="$object_id" />, <xsl:value-of select="$type_id" />);
				parent.layer.Remove();
			}
		</script>
		<style>
			body {font-size:13px;}
		</style>
	</head>
	<body class="mdn_modal">

		<div class="modal-header">
			<div class="search">
				<form name="buscador" action="?m=object&amp;action=BackDisplayModalSearch" method="post">
					<input type="text" name="q" value="{$query}" />
					<input type="hidden" name="object_id" value="{$object_id}" />
					<input type="hidden" name="type_id" value="{$type_id}" />
					<button type="submit" class="boton">Buscar</button>
				</form>
			</div>
			<h3>Relaciones</h3>
		</div>
		
		<form name="relacionar" action="{$config/system/adminpath}?m={configuration/module/@name}&amp;action=BackObjectRelations" method="post">
			<input type="hidden" name="object_id" value="{$object_id}" />
			<input type="hidden" name="type_id" value="{$type_id}" />

			<div id="modalContent" class="showButtons">
				<div class="padding">
					<div id="grid" class="grid-list">
						<!-- <div id="output1"></div> -->
						<div class="relacionar" >
							<ul class="list">
								<li class="head">Solo se listan elementos publicados</li>
							</ul>
							<xsl:call-template name="listado.objetos">
								<xsl:with-param name="objectos" select="content/objetos"/>
							</xsl:call-template>
						</div>
						
						<div style="display:none;">
							<b class="encabezado">Elementos relacionados</b>
							<ul id="relations-list">
								<xsl:for-each select="content/relations/object">
									<li id="item-{object_id}">
										<input type="hidden" name="objects[]" value="{object_id}" />
										<xsl:value-of select="object_title" />
									</li>
								</xsl:for-each>
							</ul>
						</div>
					</div>
					<p style="padding:0 0 10px 10px;"><em> Si el elemento buscado no se encuentra listado, utilice el buscador</em></p>
				</div>
			</div>
			<div class="modal-controls">
				<button type="submit" class="btn btn-inverse">Guardar</button>
				<a class="btn" onclick="parent.layer.Remove();return false;">Cancelar</a>
			</div>
		</form>
		<xsl:if test="$debug=1">
			<xsl:call-template name="debug" />
		</xsl:if>
	</body>
</html>

</xsl:template>


<xsl:template name="listado.objetos">
	<xsl:param name="objectos" />
	<xsl:for-each select="$objectos/object[not(object_id = $object_id)]">
		<ul>
			<li>
				<xsl:if test="object_id = /xml/content/relations//object_id">
					<xsl:attribute name="class">sel</xsl:attribute>
				</xsl:if>
				<input type="checkbox" name="relacion" id="rel_{object_id}" value="{object_id}">
					<xsl:if test="object_id = /xml/content/relations//object_id">
						<xsl:attribute name="checked">checked</xsl:attribute>
						<xsl:attribute name="disabled">disabled</xsl:attribute>
					</xsl:if>
				</input>
				<label for="rel_{object_id}">
					<span style="color:#777">
					<xsl:call-template name="fecha.formato.numerico">
						<xsl:with-param name="fecha" select="creation_date" />
					</xsl:call-template> - 
					</span>
					<xsl:value-of select="object_title" />
				</label>
			</li>
		</ul>
	</xsl:for-each>
</xsl:template>


</xsl:stylesheet>