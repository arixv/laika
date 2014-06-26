<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:template name="debug">
	<script type="text/javascript" src="/framework/modules/admin/desktop/js/debug.js">&#xa0;</script>
	<link rel="stylesheet" href="/framework/modules/admin/desktop/css/debug.css" type="text/css" />

	<div class="debug">&#xa0;</div>
	<div class="techoDebug">
		<a href="#">abrir / cerrar</a>
		<b>Debug</b>
	</div>
	<div class="xmlContentBack">&#xa0;</div>
	<div class="xmlContent">
		<xsl:call-template name="verNodos">
			<xsl:with-param name="pi_nombreVar" select="'var'"/>
			<xsl:with-param name="pi_nodos" select="."/>
		</xsl:call-template>
	</div>
</xsl:template>

<xsl:template name="verNodos">
	<xsl:param name="pi_nombreVar"/>
	<xsl:param name="pi_nodos"/>
	<!-- <a name="{$pi_nombreVar}">Nombre de variable: <xsl:value-of select="$pi_nombreVar"/></a> -->
	

	<xsl:apply-templates select="$pi_nodos" mode="docs"/>
	
</xsl:template>
  
<xsl:template match="*[*]" mode="docs">
	<div class="codigo">
		<a href="#">
			<img src="/framework/modules/admin/desktop/imgs/closetree.gif" alt=""/>
			<img src="/framework/modules/admin/desktop/imgs/opentree.gif" alt="" style="display:none"/>
		</a> 
		<span class="tag">&lt;<b class="node"><xsl:value-of select="name()" /></b><xsl:apply-templates select="@*" mode="docs"/>&gt;</span>
		<div class="bloque"><xsl:apply-templates mode="docs"/></div>
		<span class="tag close">&lt;/<b class="node"><xsl:value-of select="name()" /></b>&gt;</span>
	</div>
</xsl:template>
    
    
<xsl:template match="*[not(*)]" mode="docs">
	<div class="codigo">
		<b class="tag">&lt;<span><xsl:value-of select="name()" /></span></b>
		<xsl:apply-templates select="@*" mode="docs"/>
		<b class="tag">/&gt;</b>
	</div>
</xsl:template>
  
<xsl:template match="*[not(*)][node()]" mode="docs">
	<div class="codigo">
		<b class="tag">&lt;</b><b class="node"><xsl:value-of select="name()" /></b>
		<xsl:apply-templates select="@*" mode="docs"/>
		<b class="tag">&gt;</b>
			<xsl:value-of select="node()"/>
		<b class="tag">&lt;/</b><b class="node"><xsl:value-of select="name()" /></b><b class="tag">&gt;</b>
	</div>
</xsl:template>
  
<xsl:template match="@*" mode="docs">
	<span class="attname"><xsl:text> </xsl:text><xsl:value-of select="name()" />=</span><span class="att">"<xsl:value-of select="." />"</span>
</xsl:template>

</xsl:stylesheet>