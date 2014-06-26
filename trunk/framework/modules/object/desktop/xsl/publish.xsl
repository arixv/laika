<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" omit-xml-declaration="no" encoding="UTF-8" indent="yes" />

<xsl:param name="object_id" />
<xsl:param name="parent" />
<xsl:param name="module" />
<xsl:param name="tag" />

<xsl:template match="/xml">
<xml>
	<xsl:element name="{$tag}">
		<xsl:apply-templates select="content/object/@*" />
		<xsl:apply-templates select="content/object/*" />
	</xsl:element>
</xml>
</xsl:template>

<xsl:template match="@*">
	<xsl:attribute name="{name()}"><xsl:value-of select="." /></xsl:attribute>
</xsl:template>

<xsl:template match="*">
	<xsl:element name="{name()}">
		<xsl:apply-templates select="@*" />
		<xsl:apply-templates />
	</xsl:element>
</xsl:template>

<xsl:template match="text()">
	<xsl:value-of select="." />
</xsl:template>
</xsl:stylesheet>