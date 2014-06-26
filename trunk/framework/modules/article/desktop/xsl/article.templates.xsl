<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:template match="p|P">
	<p>
		<xsl:apply-templates select="@*" mode="atts" />
		<xsl:apply-templates />
	</p>
</xsl:template>

<xsl:template match="b|strong">
	<strong>
		<xsl:apply-templates select="@*" mode="atts" />
		<xsl:apply-templates />
	</strong>
</xsl:template>

<xsl:template match="i|em">
	<em>
		<xsl:apply-templates select="@*" mode="atts" />
		<xsl:apply-templates />
	</em>
</xsl:template>

<xsl:template match="span">
	<span>
		<xsl:apply-templates select="@*" mode="atts" />
		<xsl:apply-templates />
	</span>
</xsl:template>

<xsl:template match="a|A">
	<a>
		<xsl:apply-templates select="@*" mode="atts" />
		<xsl:apply-templates />
	</a>
</xsl:template>

<xsl:template match="img">
	<img>
		<xsl:if test="@src"><xsl:attribute name="src"><xsl:value-of select="@src" /></xsl:attribute></xsl:if>
		<xsl:if test="@class"><xsl:attribute name="class"><xsl:value-of select="@class" /></xsl:attribute></xsl:if>
		<xsl:if test="@width"><xsl:attribute name="width"><xsl:value-of select="@width" /></xsl:attribute></xsl:if>
		<xsl:if test="@height"><xsl:attribute name="height"><xsl:value-of select="@height" /></xsl:attribute></xsl:if>
		<xsl:if test="@alt"><xsl:attribute name="alt"><xsl:value-of select="@alt" /></xsl:attribute></xsl:if>
	</img>
</xsl:template>

<xsl:template match="br">
	<br/>
</xsl:template>

<xsl:template match="h1|h2|h3|h4|h5">
	<xsl:element name="{name()}">
		<xsl:apply-templates select="@*" mode="atts" />
		<xsl:apply-templates />
	</xsl:element>
</xsl:template>

<xsl:template match="slideshow">
	<xsl:copy-of select="." />
</xsl:template>

<xsl:template match="iframe">
	<xsl:copy-of select="." />
</xsl:template>

<xsl:template match="div">
	<div>
		<xsl:apply-templates select="@*" mode="atts" />
		<xsl:apply-templates />
	</div>
</xsl:template>

<xsl:template match="object">
	<xsl:copy-of select="." />
</xsl:template>

<xsl:template match="embed">
	<xsl:copy-of select="." />
</xsl:template>

<xsl:template match="@*" mode="atts">
	<xsl:attribute name="{name()}"><xsl:value-of select="." /></xsl:attribute>
</xsl:template>

<xsl:template match="text()">
	<xsl:value-of select="." disable-output-escaping="yes" />
</xsl:template>

</xsl:stylesheet>