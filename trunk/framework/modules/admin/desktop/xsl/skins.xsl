<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--Import relativo del master xsl-->
<xsl:import href="../layout.xsl" />
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="configfile" />
<xsl:variable name="cellsPerRow">3</xsl:variable>

<xsl:variable name="htmlHeadExtra">
	<script type="text/javascript">
		jQuery().ready(function(){
			jQuery("#save").saveconfig();
		});
	</script>
</xsl:variable>


<xsl:template name="content">
	
	<div class="box">
		<h2>Skin Configuration</h2>
		<xsl:for-each select="content/skins/skin[position() mod $cellsPerRow = 1]">
			<ul class="skins floatFix">
				<xsl:apply-templates select=".|following-sibling::skin[position() &lt; $cellsPerRow]" />
			</ul>
		</xsl:for-each>
		
		
	</div>
</xsl:template>

<xsl:template match="skin">
	<li>
		<xsl:choose>
			<xsl:when test="position() mod 3 = 0 and /xml/content/default/name != name">
				<xsl:attribute name="class">last</xsl:attribute>
			</xsl:when>
			<xsl:when test="position() mod 3 != 0 and /xml/content/default/name = name">
				<xsl:attribute name="class">selected</xsl:attribute>
			</xsl:when>
			<xsl:when test="position() mod 3 = 0 and /xml/content/default/name = name">
				<xsl:attribute name="class">last selected</xsl:attribute>
			</xsl:when>
		</xsl:choose>
		<h4><xsl:value-of select="name"/></h4>
		<p>Version: <xsl:value-of select="version"/></p>
		<p>Author: <xsl:value-of select="author"/></p>
		<p>Description: <xsl:value-of select="description"/></p>
		<p class="current">
		<xsl:choose>
			<xsl:when test="/xml/content/default/name = name">
				Current Skin
			</xsl:when>
			<xsl:otherwise>
				<a href="?m=admin&amp;action=setskin&amp;skin={path}">Select this Skin</a>
			</xsl:otherwise>
		</xsl:choose>
		</p>
	</li>
</xsl:template>

</xsl:stylesheet>