<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:variable name="htmlHeadExtra"/>

<xsl:template name="content">
	<div class="content100">
		<div id="msj"></div>

		<form name="add" action="{$adminroot}?m={$config/module/@name}&amp;action=BackAdd" method="POST">

			
			<div class="box">
				<h2>Agregar Menu <xsl:value-of select="configuration/module/navigation/display" /></h2>

				<div class="controles floatFix">
					<div class="right"><button class="btn" type="reset" id="delete">Cancelar</button>&#160;</div>
					<div class="right"><button class="btn btn-inverse" type="submit">Guardar</button>&#160;</div>
				  </div>

					<ul class="form" style="margin-bottom:30px;">
						<li class="floatFix">
							<label for="name">Name</label><input type="text" id="nombre" name="menu_name" value=""/>
						</li>
						<li class="floatFix">
							<label for="name">URL</label><input type="text" id="url" name="menu_url" value=""/>
						</li>
						<li class="floatFix">
							<label for="description">Parent Menu</label>
							<select name="menu_parent" id="menu_parent">
								<option value="0">No Parent Menu</option>
								<xsl:call-template name="menu_item">
									<xsl:with-param name="menus" select="content/menus"/>
								</xsl:call-template>
							</select>
						</li>
					</ul>
			</div>
		</form>

	</div>
</xsl:template>

<xsl:template name="menu_item">
	<xsl:param name="menus" />
	<xsl:param name="profundidad" select='8' />
		<xsl:for-each select="$menus/menu">
			<option value="{@menu_id}">
				<xsl:if test="@parent!=0">
					<xsl:attribute name="style">padding-left:<xsl:value-of select="$profundidad"/>px</xsl:attribute>
				</xsl:if>
				<xsl:if test="/xml/content/menu/@parent = @id">
					<xsl:attribute name="selected">selected</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="name" />
			</option>
			<xsl:if test="count(menus/menu)>0">
				<xsl:call-template name="menu_item">
					<xsl:with-param name="menus" select="menus"/>
					<xsl:with-param name="profundidad" select="$profundidad + 8"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
</xsl:template>

</xsl:stylesheet>