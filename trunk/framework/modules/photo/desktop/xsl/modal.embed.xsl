<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />


<xsl:param name="object_id" />
<xsl:param name="type_id" />


<xsl:variable name="config" select="/xml/configuration" />

<xsl:template match="/xml">

	
<html>
	<head>
		<title>Relaciones</title>
		<xsl:call-template name="jquery" />
		<xsl:call-template name="modal.scripts" />
		
		
		<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/css/admin.css" />
		<link rel="stylesheet" type="text/css" href="{$modPath}/desktop/css/photo.css" />
		<script type="text/javascript" src="{$modPath}/desktop/js/embed.js" />
		<script type="text/javascript" src="{$modPath}/desktop/js/modals.js" />
		<script type="text/javascript" >
			sourcePath    = "/<xsl:value-of select="$config/module/options/group[@name='folders']/option[@name='target']"/>/";
			generatedPath = "/<xsl:value-of select="$config/module/options/group[@name='folders']/option[@name='generated']"/>/";

			<!-- function clodeModal(responseText, statusText, xhr, $form){
				parent.layer.Remove();
			} -->
		</script>
	</head>
	<body class="mdn_modal">

		<div class="modal-header">
			<h3>Agregar Fotos Relacionadas al contenido</h3>
		</div>

		<div id="modalContent">
			<div class="padding">

				<xsl:if test="count(content/object/photos/photo) &gt; 1">
					<div class="list-header embedgallery rounded floatFix">
						
						<a href="#" onclick="EmbedAsGallery({$object_id});return false;" class="boton right embedAll" title="Para modificar el orden de las imágenes utilizar el ordenamiento de la caja de imágenes relacionadas">Todas</a>
						<a href="#" onclick="EmbedSelectedAsGallery({$object_id});return false;" class="boton right embedGallery" >Seleccionar</a>
						<span>Embeber como galería</span>
						<!-- <a href="#" onclick="CancelEmbedSelectedAsGallery();return false;" class="boton right cancelEmbedGallery" >Cancelar</a> -->

						<!--
						<a href="#" style="color:#fff" onclick="EmbedAsGallery({$object_id});return false;">Embeber todas las fotos como una galería</a> (para modificar el orden utilizar el ordenamiento de imágenes)
						-->
						
					</div>
				</xsl:if>

				<div id="listado" class="on listado">

					<ul>
						<xsl:if test="position() mod 2 = 0">
							<xsl:attribute name="class">alt</xsl:attribute>
						</xsl:if>
						<xsl:for-each select="content/object/photos/photo">
							<xsl:variable name="thisID" select="@photo_id" />
							<li id="photo-{@photo_id}">

								
								<img src="/content/photos/generated/{substring(@photo_id, string-length(@photo_id), 1)}/{@photo_id}_t.{@type}" alt=""/>
								<h4><xsl:value-of select="title" /></h4>
								<p>
									<xsl:value-of select="summary" disable-output-escaping="yes"/>
								</p>
								
								
								<form name="photo_{@photo_id}" id="photo_{@photo_id}" method="post" action="{$config/systema/adminpath}?m=photo" onsubmit="processPhoto(this);return false;">
									<input type="hidden" name="photo_id" value="{@photo_id}" />
									<input type="hidden" name="type" value="{@type}" />
									<div class="embed-details floatFix">
										<div class="options">
											<div class="option">
												<input type="radio" name="column" id="op1_{@photo_id}" value="1" checked="checked"/> 
												<label for="op1_{@photo_id}">Alineación Izquierda</label>
											</div>
											<div class="option">
												<input type="radio" name="column" id="op2_{@photo_id}" value="2" checked="checked"/> 
												<label for="op2_{@photo_id}">Alineación Derecha</label>
											</div>
											<div class="option">
												<input type="radio" name="column" id="op3_{@photo_id}" value="0" /> 
												<label for="op3_{@photo_id}">Cortada al ancho</label>
											</div>
											<div class="option">
												<input type="radio" name="column" id="op0_{@photo_id}" value="3" /> 
												<label for="op0_{@photo_id}">Original centrada</label>
											</div>
										</div>
										
										<button type="submit" class="boton">Embed</button>
									</div>
								</form>

							</li>
							
							
							
						</xsl:for-each>
					</ul>

				</div>
				<!-- <script>
					$('#photo_<xsl:value-of select="@photo_id"/>').submit(function(){
						processPhoto($(this));
						return false;
					});
				</script> -->
			

			</div>
		</div>
		<xsl:if test="$debug=1">
			<xsl:call-template name="debug" />
		</xsl:if>


	</body>
</html>

</xsl:template>


</xsl:stylesheet>