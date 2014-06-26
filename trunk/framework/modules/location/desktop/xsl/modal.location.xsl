<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />


<xsl:variable name="cellsPerRow">3</xsl:variable>
<xsl:param name="object_id" />
<xsl:param name="parent" />

<xsl:template match="/xml">
<html>
	<head>
		<title>Editar Categorías</title>

		<xsl:call-template name="jquery" />
		<xsl:call-template name="modal.scripts" />

		
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
				parent.category.objectUpdateList(<xsl:value-of select="$object_id" />, <xsl:value-of select="$parent" />);
				parent.layer.Remove();
			}

		</script>
	</head>
	<body class="mdn_modal">
		<div class="modal-header">
			<h3>Editar Ubicacion</h3>
		</div>
		
		<form name="categorizar" action="/admin/?m={configuration/module/@name}&amp;action=BackObjectLocation" method="post">
				<input type="hidden" name="object_id" value="{$object_id}" />
				<input type="hidden" name="parent_id" value="{$parent}" />
				

				<div id="modalContent" class="showButtons">
					<div class="padding">
					

						<div class="modal-categories" >
								
								<div class="list-header rounded floatFix">
									Ubicaciones
								</div>
							
								<ul class="list-parent rounded">
									<li>
										<xsl:call-template name="list.locations">
											<xsl:with-param name="locations" select="content/locations"/>
										</xsl:call-template>
									</li>
								</ul>
						</div>
			
					</div>
				</div>
				<div class="modal-controls">
					<button type="submit" class="btn btn-inverse">Guardar</button>
					<button class="btn">Cancelar</button>
				</div>
		</form>
		<xsl:if test="$debug = 1">
			<xsl:call-template name="debug" />
		</xsl:if>
	</body>
</html>

</xsl:template>


<xsl:template name="list.locations">
	<xsl:param name="locations" />
	<xsl:for-each select="$locations/location">
		<xsl:sort order="ascending" select="name" />
		<ul>
			<li>
				<input type="checkbox" name="location" id="location_{@id}" value="{@id}">
					<xsl:if test="@id = /xml/content/object//location/@id">
						<xsl:attribute name="checked">checked</xsl:attribute>
						<xsl:attribute name="disabled">disabled</xsl:attribute>
					</xsl:if>
				</input>
				<label for="location_{@id}"><xsl:value-of select="name" /></label>
				<xsl:if test="locations/location">
					<xsl:call-template name="list.locations">
						<xsl:with-param name="locations" select="locations" />
					</xsl:call-template>
				</xsl:if>
			</li>
		</ul>
	</xsl:for-each>
</xsl:template>


</xsl:stylesheet>