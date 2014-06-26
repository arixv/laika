<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--Import relativo del master xsl-->
<xsl:import href="../layout.xsl" />
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="configfile" />

<xsl:variable name="htmlHeadExtra">
	<script type="text/javascript">
		jQuery().ready(function(){
			//jQuery("#save").saveconfig();
		});
	</script>
</xsl:variable>


<xsl:template name="content">
	
	<div class="box">
		<h2>System Configuration</h2>
		<p>
			This page is only to avoid open the xml file to edit configuration.<br/>
			<span class="blue">Do not modify this configuration if you don't know what you're doing. You can screw up the hole system. </span> <span class="red">Or make backup first.</span><br/>
			If you want to add nodes or edit de xml file you can open it in <strong><em><xsl:value-of select="$configfile" /></em></strong> in any text editor.<br/>
		</p>
		<div id="msj"></div>
		<xsl:apply-templates select="/xml/configuration" mode="confPage"/>
	</div>
</xsl:template>

<xsl:template match="configuration" mode="confPage">
	<form name="config" id="config" action="?m=admin&amp;action=saveconfiguration" method="post">
		<ul class="configurationbox">
			<xsl:apply-templates mode="conf"/>
			<li class="buttons"><input type="submit" name="save" value="Save Changes" /></li>
		</ul>
	</form>
</xsl:template>

<xsl:template match="configuration" mode="conf">
		<xsl:apply-templates mode="conf"/>
 </xsl:template>


<xsl:template match="configuration/*" mode="conf">
    <li>
		<xsl:variable name="xpath">xml<xsl:apply-templates select="." mode="path-builder" /></xsl:variable>
		<h4 class="blue"><xsl:value-of select="name()" /></h4>
		<xsl:choose>
			<xsl:when test="not(./*) and not(./@*)">
				<!--Node has no children-->
				<input type="text" name="{$xpath}" value="{.}" id="{$xpath}" class="level1"/>
				<span class="comment"><xsl:value-of select="comment()" disable-output-escaping="yes" /></span>
			</xsl:when>
			<xsl:otherwise>
				<!--Node has childrens-->
				<br clear="all"/>
				<span class="comment"><xsl:value-of select="comment()" disable-output-escaping="yes" /></span>
				<xsl:apply-templates  mode="inConf"/>
			</xsl:otherwise>
		</xsl:choose>
	</li>
 </xsl:template>

<xsl:template match="*" mode="inConf">
	<xsl:variable name="xpath">xml<xsl:apply-templates select="." mode="path-builder" /></xsl:variable>
	<xsl:choose>
	<xsl:when test="name()!='module'">
		<div class="box floatFix">
			<xsl:choose>
				<xsl:when test="not(./*) and not(./text())">
					<label class="blue"><xsl:value-of select="name()" />: &#160;&#160;</label>
					<xsl:apply-templates select='@*' mode="attConf"/>
				</xsl:when>
				<xsl:otherwise>
					<label class="blue"><xsl:value-of select="name()" /></label>
					<xsl:variable name="styles">width:<xsl:value-of select="(string-length(.) * 6) + 10"/>px;</xsl:variable>
					<input type="text" name="{$xpath}" value="{.}" id="{$xpath}" style="{$styles}"/> &#160;
					<xsl:apply-templates select='@*' mode="attConf"/>
					<xsl:apply-templates select='*' mode="inConf"/>
				</xsl:otherwise>
			</xsl:choose>
			<span style="color:red"><xsl:value-of select="comment()" disable-output-escaping="yes" /></span>
		</div>
	</xsl:when>
	<xsl:otherwise>
		<div class="module">
			<h4 class="blue"><xsl:value-of select="./@name" /></h4>
			<p><xsl:value-of select="comment()" disable-output-escaping="yes" /></p>
			<div class="att floatFix">
				<xsl:apply-templates select="@*" mode="module" />
			</div>
			<xsl:apply-templates select="*" mode="module" />
		</div>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="*" mode="module">
	<xsl:variable name="xpath">xml<xsl:apply-templates select="." mode="path-builder" /></xsl:variable>
	<div class="padding">
		<xsl:choose>
			<xsl:when test="not(./*) and not(./text())">
				<div class="subnode">
					<b class="blue"><xsl:value-of select="name()" /></b> &#160;  &#160;
					<xsl:apply-templates select="@*" mode="module" />
				</div>
			</xsl:when>
			<xsl:when test="not(./*) and not(@*)">
				<div class="subnode">
					<label class="blue" style="width:45px;"><b><xsl:value-of select="name()" /></b></label> &#160;  &#160;
					<xsl:variable name="styles">width:<xsl:value-of select="(string-length(.) * 6) + 10"/>px;</xsl:variable>
					<input type="text" name="{$xpath}" value="{.}" id="{$xpath}" style="{$styles}"/>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="subnode">
					<b class="blue"><xsl:value-of select="name()" /></b> &#160;  &#160;
					<xsl:apply-templates select="@*" mode="module" />
					<xsl:apply-templates select="*" mode="module" />
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</div>
</xsl:template>

<xsl:template match="@*" mode="module">
	<xsl:variable name="xpath">xml<xsl:apply-templates select="." mode="path-builder" /></xsl:variable>
	<xsl:variable name="styles">width:<xsl:value-of select="(string-length(.) * 6) + 10"/>px;</xsl:variable>
	<span><b class="red"><xsl:value-of select="name()" /></b> <input type="text" name="{$xpath}" value="{.}" id="{$xpath}" style="{$styles}"/></span>
</xsl:template>

<xsl:template match="@*" mode="attConf">
	<xsl:variable name="xpath">xml<xsl:apply-templates select="." mode="path-builder" /></xsl:variable>
	<xsl:variable name="styles">width:<xsl:value-of select="(string-length(.) * 6) + 10"/>px;</xsl:variable>
	<span class="red"><xsl:value-of select="name()" /></span> &#160;<input type="text" name="{$xpath}" value="{.}" id="{$xpath}" style="{$styles}"/>  &#160;&#160;
</xsl:template>

<xsl:template match="*" mode="path-builder">
	<xsl:apply-templates select="parent::*" mode="path-builder"/>
	<xsl:if test="name()!='page' and name()!='context' and name()!='xml'">
		<xsl:choose>
			<xsl:when test="name(preceding-sibling::*) = name() or name(following-sibling::*) = name()">
				<xsl:text>[nodes-collection-</xsl:text><xsl:value-of select="name()"/><xsl:text>]</xsl:text>
				<xsl:text>[name-</xsl:text><xsl:value-of select="@name"/><xsl:text>]</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>[node-</xsl:text><xsl:value-of select="name()"/><xsl:text>]</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<!--<xsl:text>[</xsl:text><xsl:value-of select="name()"/><xsl:text>]</xsl:text>-->
		</xsl:if>
</xsl:template>
<xsl:template match="@*" mode="path-builder">
	<xsl:apply-templates select="parent::*" mode="path-builder"/>
	<xsl:if test="name()!='page' and name()!='context' and name()!='xml'">
		<xsl:choose>
			<xsl:when test="name(preceding-sibling::*) = name() or name(following-sibling::*) = name()">
				<xsl:text>[attr-</xsl:text><xsl:value-of select="name()"/><xsl:text>]</xsl:text>
				<xsl:text>[attr-</xsl:text><xsl:value-of select="@name"/><xsl:text>]</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>[attr-</xsl:text><xsl:value-of select="name()"/><xsl:text>]</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:if>
</xsl:template>


</xsl:stylesheet>