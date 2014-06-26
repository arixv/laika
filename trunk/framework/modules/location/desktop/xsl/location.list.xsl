<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />



<xsl:variable name="htmlHeadExtra">
		<script type="text/javascript" src="{$modPath}/desktop/js/locations.js">&#xa0;</script>
		<script type="text/javascript" >
			jQuery(document).ready(function(){
				jQuery('.tree-view').slideTree();
			});
		</script>
</xsl:variable>


<xsl:template name="content">

	<div class="content100">
		<div class="list-header">
			<h2 class="techo">Locaciones</h2>
			<div class="list-tools">
				<div class="btn-group">
					<a href="{$adminroot}{$modulename}/add" class="btn btn-inverse"><i class="icon-edit icon-white">&#xa0;</i>&#xa0;Agregar</a>
				</div>
			</div>
		</div>

		<div class="edit-body" >
			<div class="tree-view" >
				<xsl:call-template name="tree_leaf">
					<xsl:with-param name="locations" select="$content/locations"/>
				</xsl:call-template>
			</div>
		</div>

	</div>
</xsl:template>

<xsl:template name="tree_leaf">
	<xsl:param name="locations" />
	
	<xsl:for-each select="$locations/location">
		<xsl:sort order="ascending" select="@order" data-type="number"/>
		<xsl:sort order="ascending" select="name" />


		<div class="leaf_item" id="id_{@id}">

			<div class="leaf">

				<xsl:if test="locations/location">
					<a href="#" class="openclose open opened" >&#xa0;</a>
				</xsl:if>

				<a onclick="editItem({@id});return false;" href="?m={/xml/configuration/module/@name}&amp;action=edit&amp;location_id={@id}">
					<xsl:value-of select="name" />
				</a>


				<xsl:if test="@order!=0">
					<span class="label label-info order">Order: <xsl:value-of select="@order" /></span>
				</xsl:if>
				<span class="label id">id <xsl:value-of select="@id" /></span>


				<span class="buttons">
					<a class="btn btn-small" onclick="editItem({@id});return false;" href="#">
						<i class="icon-edit" >&#xa0;</i>
						&#xa0;Edit
					</a>
					<a class="btn btn-small" onclick="addSubItem({@id});return false;" href="#" >
						<i class="icon-plus" >&#xa0;</i>&#xa0;
						Add Sublocation
					</a>
					<a class="btn btn-small" onclick="deleteItem({@id});return false;" href="#" >
						<i class="icon-remove" >&#xa0;</i>
						&#xa0;Delete
					</a>
				</span>

				
			</div>

			<xsl:if test="locations/location">
				<div class="leaf-childs cat_{@id}">
				<xsl:call-template name="tree_leaf">
					<xsl:with-param name="locations" select="locations"/>
				</xsl:call-template>
				</div>
			</xsl:if>
		</div>
	</xsl:for-each>

</xsl:template>
</xsl:stylesheet>