<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />


<xsl:variable name="cellsPerRow">3</xsl:variable>
<xsl:param name="object_id" />
<xsl:param name="parent" />

<xsl:template match="/xml">
<html>
	<head>
		<title>Agregar Categorías</title>
		<xsl:call-template name="jquery" />
		<xsl:call-template name="modal.scripts" />
		
		<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/css/admin.css" />
		<script>
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
				//parent.category.objectUpdateList(<xsl:value-of select="$object_id" />, <xsl:value-of select="$parent" />);
				parent.list.updateView();
				parent.layer.Remove();
			}

		</script>
	</head>
	<body class="mdn_modal">
		<div class="modal-header">
			<h3>Agregar Categorías a varios elementos</h3>
		</div>

		<form name="categorizar" action="/admin/?m={configuration/module/@name}&amp;action=BackSetCategoriesGroup" method="post">
			<xsl:for-each select="content/ids/id">
				<input type="hidden" name="objects[]" value="{.}" />
			</xsl:for-each>
			<div id="modalContent" class="showButtons">
				<div class="padding">
				
					<div class="modal-categories" >
						
						<div class="list-header rounded floatFix">
							Categorías
						</div>
						<xsl:for-each select="content/categories/group">
							<ul class="list-parent rounded">
								<li>
									<xsl:call-template name="list.categories">
										<xsl:with-param name="categories" select="."/>
									</xsl:call-template>
								</li>
							</ul>
						</xsl:for-each>
					</div>

					<!-- <div class="categorizar right">
						<b class="encabezado">Categorías Seleccionadas</b>
						<ul id="category-list">
						</ul>
					</div> -->

			</div>
		</div>
		<div class="modal-controls">
				<button type="submit" class="btn btn-inverse">Guardar</button>
				<a href="#" class="btn" onclick="parent.layer.Remove();return false;">Cancelar</a>
			</div>
		</form>
		<xsl:if test="$debug = 1">
			<xsl:call-template name="debug" />
		</xsl:if>
	</body>
</html>

</xsl:template>


<xsl:template name="list.categories">
	<xsl:param name="categories" />
	<xsl:for-each select="$categories/category[not(@parent=1)]">
		<xsl:sort order="ascending" select="name" />
		<ul>
			<li>
				<input type="checkbox" name="category" id="cat_{@category_id}" value="{@category_id}">
					<xsl:if test="@category_id = /xml/content/object//category/@category_id">
						<xsl:attribute name="checked">checked</xsl:attribute>
						<xsl:attribute name="disabled">disabled</xsl:attribute>
					</xsl:if>
				</input>
				<label for="cat_{@category_id}"><xsl:value-of select="name" /></label>
				<xsl:if test="categories/category">
					<xsl:call-template name="list.categories">
						<xsl:with-param name="categories" select="categories" />
					</xsl:call-template>
				</xsl:if>
			</li>
		</ul>
	</xsl:for-each>
</xsl:template>


</xsl:stylesheet>