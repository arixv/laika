<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="calendar" />
<xsl:param name="type" />
<xsl:param name="error" />

<xsl:variable name="htmlHeadExtra">
	<link rel="stylesheet" type="text/css" href="{$modPath}/desktop/css/photo.css" />
	<script type="text/javascript" src="{$modPath}/desktop/js/upload.handler.js">&#xa0;</script>
	<script type="text/javascript">
		default_categories = [<!-- 
			 --><xsl:for-each select="$config/module/options/group[@name='categories']/option[@type='default']"><!-- 
			 	-->"<xsl:value-of select="@value" />"<!-- 
			 	--><xsl:if test="position() != last()">, </xsl:if><!-- 
			 --></xsl:for-each><!-- 
		 -->];
	</script>
</xsl:variable>


<xsl:template name="content">

	<div class="content100 showTools">

		<div class="list-header">
			<h2 class="techo">Subir Imágenes</h2>
			<a href="{$adminroot}{$config/module/@name}/list" class="btn left" ><i class="icon icon-chevron-left">&#xa0;</i>&#xa0;Volver</a>
		</div>

		<div class="edit-body">

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
				<xsl:with-param name="handler">UploadHandler</xsl:with-param>
				<xsl:with-param name="callback"><xsl:value-of select="$adminroot"/>?m=photo&amp;action=BackUpdateBundle</xsl:with-param>
			</xsl:call-template>


			
		</div>
	</div>


</xsl:template>
</xsl:stylesheet>