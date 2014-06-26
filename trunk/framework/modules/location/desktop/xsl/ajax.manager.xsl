<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />

<xsl:param name="call" />
<xsl:param name="id" />

<xsl:variable name="config" select="/xml/configuration" />
<xsl:variable name="adminroot" select="$config/system/adminpath" />

<!--
	Este archivo, recibe por parametro a que template tiene que llamar, para imprimirlo.
	Se utiliza cuando se hace un llamado con ajax para obtener un bloque de html 
	que resulta de un template. Evitando cargar el layout, y sin pisar el match='/'
-->

<xsl:template match="/xml">
	<xsl:choose>
		<xsl:when test="$call='item.edit'">
			<xsl:call-template name="item.edit">
				<xsl:with-param name="id" select="$id" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$call='item.add'">
			<xsl:call-template name="item.add">
				<xsl:with-param name="id" select="$id" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$call='option.items'">
			<xsl:call-template name="option.item">
				<xsl:with-param name="locations" select="content/locations"/>
				<xsl:with-param name="id" select="$id"/>
				<xsl:with-param name="parent" select="content/location/@parent"/>
				<xsl:with-param name="order" select="content/location/@order"/>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
	
</xsl:template>


<xsl:template name="item.edit">
	<xsl:param name="id" />
	<!--<textarea><xsl:copy-of select="/"/></textarea>-->
	<form name="item_edit_{$id}" method="post" action="{$adminroot}location/edit">
		<input type="hidden" name="id" value="{$id}" />
		<ul class="form floatFix categories">
			<li>
				<label>Nombre</label>
				<input type="text" name="location_name" value="{content/location/name}" />
			</li>
			<li class="floatFix">
				<label for="description">Padre</label>


				<select name="location_parent" id="location_parent">
					<option value="0">Sin Padre</option>
					<xsl:call-template name="option.item">
						<xsl:with-param name="locations" select="content/locations"/>
						<xsl:with-param name="id" select="content/location/@id"/>
						<xsl:with-param name="parent" select="content/location/@parent"/>
						<xsl:with-param name="order" select="content/location/@order"/>
					</xsl:call-template>
				</select>
			</li>
		<li class="floatFix">
			<label for="description">Orden</label>
			<select name="location_order" id="location_order">
				<xsl:call-template name="combo.item.incremental">
					<xsl:with-param name="start">0</xsl:with-param>
					<xsl:with-param name="end">100</xsl:with-param>
					<xsl:with-param name="selected" select="content/location/@order" />
				</xsl:call-template>
			</select>
		</li>
		<li class="botones">
			<button class="btn btn-inverse">Guardar</button>
			&#xa0;&#xa0;
			<button class="btn cancel" onclick="return false;">Cancelar</button>
		</li>
	</ul>
	</form>
</xsl:template>


<xsl:template name="item.add">
	<xsl:param name="id" />
	<!--<textarea><xsl:copy-of select="/"/></textarea>-->
	<form name="agregar_sublocation_{$id}" action="{$adminroot}?m=location&amp;action=BackAdd" method="POST">
		<input type="hidden" name="location_parent" value="{$id}" />
		<ul class="form floatFix">
			<li>
				<label>Nombre</label>
				<input type="text" name="location_name" value="" />
			</li>
			<li class="botones">
				<button class="btn btn-inverse">Guardar</button>&#xa0;&#xa0;
				<button class="btn cancel" onclick="return false;">Cancelar</button>
			</li>
		</ul>
	</form>
</xsl:template>

<xsl:template name="option.item">
	<xsl:param name="locations" />
	<xsl:param name="id" />
	<xsl:param name="parent" />
	<xsl:param name="order" />
<!-- 		<xsl:choose>
			<xsl:when test="$parent!=0">
 -->			<xsl:for-each select="$locations/location[@id != $id]">
 					<xsl:sort select="name" data-type="text" order="ascending" />
					<option value="{@id}">
						<!-- <xsl:if test="@parent!=0">
							<xsl:attribute name="style">padding-left:<xsl:value-of select="$order"/>px</xsl:attribute>
						</xsl:if> -->
						<xsl:if test="/xml/content/location/@parent = @id">
							<xsl:attribute name="selected">selected</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="name" />
					</option>
					<xsl:if test="count(locations/location)>0">
						<xsl:call-template name="option.item">
							<xsl:with-param name="locations" select="locations"/>
							<xsl:with-param name="order" select="$order + 8"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:for-each>
<!-- 			</xsl:when>
			<xsl:otherwise>
				<option>test</option>
			</xsl:otherwise>
		</xsl:choose>
 -->
</xsl:template>

</xsl:stylesheet>