<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="calendar" />
<xsl:param name="type" />
<xsl:param name="error" />

<xsl:variable name="htmlHeadExtra">
	<link rel="stylesheet" type="text/css" href="{$modPath}/desktop/css/document.css" />
	<script type="text/javascript" src="{$modPath}/desktop/js/upload.handler.js">&#xa0;</script>
	<script type="text/javascript">
		default_categories = [<!-- 
			 --><xsl:for-each select="$config/module/options/group[@name='categories']/option[@type='default']"><!-- 
			 	-->"<xsl:value-of select="@value" />"<!-- 
			 	--><xsl:if test="position() != last()">, </xsl:if><!-- 
			 --></xsl:for-each><!-- 
		 -->];
		 modpath = "<xsl:value-of select="$modPath" />";
	</script>
</xsl:variable>


<xsl:template name="content">

	<div class="content100 showTools">

		<h2 class="techo">Subir Documentos</h2>

		<xsl:if test="$error = 1">
			<div class="message">
				El formato de archivo no es válido.
			</div>
		</xsl:if>

		<xsl:variable name="fileTypes"><!--
			--><xsl:for-each select="$config/module/options/group[@name='acepted_files']/option"><!--
				-->*.<xsl:value-of select="."/><!--
				--><xsl:if test="position()!=last()">;</xsl:if><!--
			--></xsl:for-each><!--
		--></xsl:variable>

		<xsl:call-template name="swf.upload">
			<xsl:with-param name="uploadLimit"><xsl:value-of select="$config/module/options/group[@name='acepted_files']/@sizelimit" /></xsl:with-param>
			<xsl:with-param name="filesLimit"><xsl:value-of select="$config/module/options/group[@name='acepted_files']/@limit" /></xsl:with-param>
			<xsl:with-param name="filesTypes"><xsl:value-of select="$fileTypes" /></xsl:with-param>
			<xsl:with-param name="filesTypesDescription">Archivos permitidos (<xsl:value-of select="$fileTypes" />)</xsl:with-param>
			<xsl:with-param name="module"><xsl:value-of select="$config/module/@name" /></xsl:with-param>
			<xsl:with-param name="action">BackUpload</xsl:with-param>
			<xsl:with-param name="mode">standalone</xsl:with-param>


			<!--
				Nombre de la funcion de javascript para manejar el resultado del upload
			-->
			<xsl:with-param name="handler">UploadHandler</xsl:with-param>

			<!--
				Adonde apuntar el form con el html obtenido del upload
			-->
			<xsl:with-param name="callback"><xsl:value-of select="$adminroot"/>?m=<xsl:value-of select="$config/module/@name" />&amp;action=BackUpdateBundle</xsl:with-param>
		</xsl:call-template>


		<!--<div class="photo-data floatFix">
					<img src="/content/photos/generated/4/4_p.jpg" />
					<input type="hidden" name="ids[]" value="4" />
					<span>Título</span>
					<input type="text" name="titulo_4" value="" />
					<span>Epigrafe</span>
					<textarea name="epigrafe_4"></textarea>
				</div>-->
	</div>


</xsl:template>
</xsl:stylesheet>