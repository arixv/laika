<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />

<xsl:variable name="config" select="/xml/configuration" />
<xsl:param name="call" />
<xsl:param name="object_id" />
<xsl:param name="object_typeid" />



<xsl:template match="/xml">

	<xsl:choose>
		<xsl:when test="$call='refresh'">
			<xsl:call-template name="photos.refresh" />
		</xsl:when>
	</xsl:choose>
	
</xsl:template>


<xsl:template name="photos.refresh">
	<xsl:for-each select="content/object/photos/photo">
		<xsl:sort order="ascending" select="@order" data-type="number"/>
		<li id="mid-{@photo_id}">
			<a class="right" href="#" onclick="multimedia.removeRelation({$object_id}, {@photo_id}, {@type_id});return false;" title="Borrar Foto">Delete</a>
			
			<h3>
				<a href="{$config/system/adminpath}?m=photo&amp;action=BackDisplayEdit&amp;mid={@photo_id}">
					<xsl:value-of select="title"/>
				</a>
			</h3>

			<xsl:call-template name="photo">
				<xsl:with-param name="id" select="@photo_id" />
				<xsl:with-param name="type" select="@type" />
				<xsl:with-param name="suffix">_t</xsl:with-param>
				<xsl:with-param name="alt" select="title" />
			</xsl:call-template>
			<xsl:value-of select="@width" /> x <xsl:value-of select="@height" />
			<br/>
			<xsl:value-of select="@type" />

		</li>
	</xsl:for-each>
</xsl:template>



</xsl:stylesheet>