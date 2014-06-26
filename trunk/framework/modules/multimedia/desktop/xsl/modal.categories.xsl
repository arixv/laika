<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />


<xsl:variable name="adminroot" select="/xml/configuration/system/adminpath" />
<xsl:variable name="cellsPerRow">3</xsl:variable>
<xsl:param name="object_id" />
<xsl:param name="parent" />

<xsl:template match="/xml">
<html>
	<head>
		<title>Categorizar</title>
		<xsl:call-template name="jquery" />
		<xsl:call-template name="modal.scripts" />

		
		<script type="text/javascript">
			$(document).ready(function(){

				layer.Ready();
				$('input:checkbox').change(function(){
					category.AddItem($(this));
				});

				var options = { 
					success: closeModal
				};
				$("form[name='categorizar']").ajaxForm(options);
			});

			function closeModal(responseText, statusText, xhr, $form){
				parent.category.multimediaUpdateList(<xsl:value-of select="$mid" />, <xsl:value-of select="$parent" />);
				parent.layer.Remove();
			}

		</script>
	</head>
	<body class="mdn_modal">
		<div class="modal-header">
			<h3>Editar Categorías</h3>
		</div>

		
		<form name="categorizar" action="{$adminroot}?m={$modName}&amp;action=BackObjectCategory" method="post">
			<input type="hidden" name="mid" value="{$mid}" />
			<input type="hidden" name="parent_id" value="{$parent}" />

			<div id="modalContent" class="showButtons">
				<div class="padding">
					<div class="modal-categories">
							
							<div class="list-header rounded floatFix">
								Categorías
							</div>
						
							<ul class="list-parent rounded">
								<li>
									<xsl:call-template name="categories.list">
											<xsl:with-param name="categories" select="content/categories"/>
									</xsl:call-template>
								</li>
							</ul>
					</div>
				</div>
			</div>
		

			<div class="modal-controls">
				<button type="submit" class="boton azul">Guardar</button>
				<a href="#" onclick="parent.layer.Remove();return false;" class="boton">Cancelar</a>
			</div>
		</form>
		<xsl:if test="$debug = 1">
			<xsl:call-template name="debug" />
		</xsl:if>
	</body>
</html>

</xsl:template>


<xsl:template name="categories.list">
	<xsl:param name="categories" />
	<xsl:for-each select="$categories/category">
		<ul>
			<li>
				<input type="checkbox" name="category" id="cat_{@category_id}" value="{@category_id}">
					<xsl:if test="@category_id = /xml/content/multimedia//category/@category_id">
						<xsl:attribute name="checked">checked</xsl:attribute>
						<xsl:attribute name="disabled">disabled</xsl:attribute>
					</xsl:if>
				</input>
				<label for="cat_{@category_id}"><xsl:value-of select="name" /></label>
				<xsl:if test="categories/category">
					<xsl:call-template name="categories.list">
						<xsl:with-param name="categories" select="categories" />
					</xsl:call-template>
				</xsl:if>
			</li>
		</ul>
	</xsl:for-each>
</xsl:template>


</xsl:stylesheet>