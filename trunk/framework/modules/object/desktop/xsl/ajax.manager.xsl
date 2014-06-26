<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />

<xsl:param name="call" />
<xsl:param name="object_id" />
<xsl:param name="object_typeid" />



<xsl:template match="/xml">

	<xsl:choose>
		<xsl:when test="$call='categories'">
			<xsl:call-template name="categories.list" />
		</xsl:when>
		<xsl:when test="$call='relations'">
			<xsl:call-template name="objetos.listado" />
		</xsl:when>
	</xsl:choose>
	
</xsl:template>


<xsl:template name="categories.list">
	<xsl:for-each select="content/object/category[not(@parent=1)]">
		<xsl:sort order="ascending" select="@order" data-type="number"/>
		<li id="cat-{@category_id}" category_id="{@category_id}">
			<!-- <a class="right" onclick="deleteCategory({@category_id}, {$object_id});return false;" href="#" title="Delete">Delete</a> -->
			<a class="right" onclick="category.delete({@category_id}, {$object_id});" href="#" title="Delete">Delete</a>
			<xsl:value-of select="name"/>
		</li>
	</xsl:for-each>
</xsl:template>

<xsl:template name="objetos.listado">
	<xsl:for-each select="content/relations/object">
		<xsl:sort order="ascending" select="@order" data-type="number"/>
		<li id="rel-{object_id}" class="estado-{object_state}">
			<a class="right" href="#" onclick="relation.delete({$object_id}, {object_id});return false;" title="Borrar relación">Delete</a>
			<xsl:value-of select="object_title"/>
		</li>
	</xsl:for-each>
</xsl:template>


</xsl:stylesheet>