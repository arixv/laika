<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />



<xsl:variable name="htmlHeadExtra">
		<script type="text/javascript" src="{$modPath}/desktop/js/menu.js">&#xa0;</script>
		<link rel="stylesheet" type="text/css" href="{$modPath}/desktop/css/menu.css" />
		<script>
			jQuery(document).ready(function(){
				jQuery('.menu').slideMenus();
			});
			function validate(elem){
				if(confirm('Are you sure to delete this menu and sub-menus?')){
					window.location.href = $(elem).attr('href');
				}
			}
		</script>
</xsl:variable>


<xsl:template name="content">



	<div class="content100">

		<div class="list-header floatFix">
			<h2 class="techo">Menú</h2>

			<div class="list-tools">
				<div class="btn-group">
						<a href="{$adminroot}{$modulename}/add" class="btn btn-inverse"><i class="icon-edit icon-white">&#xa0;</i>&#xa0;Agregar</a>
					</div>
			</div>
		</div>

		<div class="grid-list" id="grid">
			
			<div class="box-overflow">
				<xsl:call-template name="menu_item">
					<xsl:with-param name="menus" select="content/menus"/>
				</xsl:call-template>
			</div>
		</div>
	</div>
</xsl:template>

<xsl:template name="menu_item">
	<xsl:param name="menus" />
	
	<xsl:for-each select="$menus/menu">
		<xsl:sort order="ascending" select="@order" data-type="number"/>
		<div class="menu" id="menu_{@menu_id}">
			<div class="thisMenu">
				<xsl:if test="menus/menu">
					<a href="#" class="openclose opened">&#xa0;</a>
				</xsl:if>
				<span class="right">
					<a class="btn" onclick="editMenu({@menu_id});return false;" href="?m={/xml/configuration/module/@name}&amp;action=edit&amp;menu_id={@menu_id}">Edit</a>
					<a class="btn" onclick="addSubMenu({@menu_id});return false;" href="?m={/xml/configuration/module/@name}&amp;action=BackDisplayAddChild&amp;menu_id={@menu_id}">Add SubMenu</a>

					<a class="btn" onclick="validate(this);return false;" href="{$adminroot}{$config/module/@name}/delete/{@menu_id}" id="{@menu_id}" >Delete</a>
				</span>


				<xsl:choose>
					<xsl:when test="@state = 0">
						<span class="status rounded" style="background:#007EFF;float:left;margin:8px 5px;">Inactivo</span>
					</xsl:when>
					<xsl:when test="@state = 1">
						<span class="status rounded" style="background:#25AD22;float:left;margin:8px 5px;">[Activo]</span>
					</xsl:when>
				</xsl:choose>


				<xsl:if test="@order!=0">
					<span><xsl:value-of select="@order" />.&#160;</span>
				</xsl:if>

				

				<a onclick="editMenu({@menu_id});return false;" href="?m={/xml/configuration/module/@name}&amp;action=edit&amp;menu_id={@menu_id}">
					<xsl:value-of select="name" />
				</a>
				<span class="label id">id <xsl:value-of select="@menu_id" /></span>
				
			</div>
			<xsl:if test="menus/menu">
				<div class="menu-childs cat_{@menu_id}">
				<xsl:call-template name="menu_item">
					<xsl:with-param name="menus" select="menus"/>
				</xsl:call-template>
				</div>
			</xsl:if>
		</div>
	</xsl:for-each>

</xsl:template>
</xsl:stylesheet>