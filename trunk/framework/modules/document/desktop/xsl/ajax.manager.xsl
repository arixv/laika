<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />

<xsl:param name="call" />
<xsl:param name="object_id" />
<xsl:param name="object_typeid" />

<xsl:variable name="config" select="/xml/configuration" />
<xsl:variable name="adminroot" select="$config/system/adminpath" />

<xsl:template match="/xml">

	<!-- <xsl:copy-of select="." /> -->
	<xsl:choose>
		<xsl:when test="$call='refresh'">
			<xsl:call-template name="refresh" />
		</xsl:when>
	</xsl:choose>
	
</xsl:template>


<xsl:template name="refresh">
	<xsl:for-each select="/xml/content/object/documents//document">
		<xsl:sort order="ascending" select="@order" data-type="number"/>
		<li id="mid-{@document_id}">
			<a class="right" href="#" onclick="multimedia.removeRelation({$object_id}, {@document_id}, {@type_id});return false;" title="Borrar Documento">Delete</a>
			<img src="{$modPath}/desktop/imgs/{@type}.png" style="margin:0 10px 0 0;vertical-align:middle;" class="icon"/>
			<a href="{$adminroot}document/edit/{@document_id}/" title="Editar documento">
				<xsl:value-of select="title" />
			</a>
			<span class="data">
				Peso:
				<xsl:choose>
					<xsl:when test="@weight='' or not(@weight)">
						--
					</xsl:when>
					<xsl:when test="@weight &gt; 1000000">
						<xsl:value-of select='format-number(@weight div 1000000, "#.##")' /> Mb
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select='format-number(@weight div 1000, "#.##")' /> Kb
					</xsl:otherwise>
				</xsl:choose> |  
				Tipo: <xsl:value-of select="@type" />
			</span>
		</li>
	</xsl:for-each>
</xsl:template>



</xsl:stylesheet>