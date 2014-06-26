<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />



<xsl:variable name="htmlHeadExtra">
</xsl:variable>


<xsl:template name="content">
	<div class="content100">

		<div id="msj"></div>

		<div class="list-header">
			<h2 class="techo">Nueva Ubicación</h2>
			<div class="list-tools">
				<div class="btn-group">
					<a href="{$adminroot}{$modulename}" class="btn"><i class="icon-chevron-left">&#xa0;</i>&#xa0;Volver</a>
				</div>
			</div>
		</div>

		<form name="add" action="{$adminroot}{$config/module/@name}/insert/" method="post">

			<div class="edit-body">
				

					<ul class="form" >
						<li class="floatFix">
							<input type="text" id="nombre" name="location_name" placeholder="Nombre"/>
						</li>
						<li class="floatFix">
							<label for="description">Ubicación Padre</label>
							<select name="location_parent" id="location_parent">
								<option value="0">Sin Ubicación Padre</option>
								<xsl:for-each select="$content/locations//location">
									<option value="{@id}"><xsl:value-of select="name" /></option>
								</xsl:for-each>
							</select>
						</li>
						<li>
							<a href="{$adminroot}{$modulename}" class="btn">Cancelar</a>
							<button class="btn btn-inverse" type="submit">Crear</button>

						</li>
					</ul>
			</div>
		</form>

	</div>
</xsl:template>


<xsl:template name="categoria_item">
	<xsl:param name="categorias" />
	<xsl:param name="profundidad" select='8' />
		<xsl:for-each select="$categorias/categoria">
			<option value="{@category_id}">
				<xsl:if test="@parent!=0">
					<xsl:attribute name="style">padding-left:<xsl:value-of select="$profundidad"/>px</xsl:attribute>
				</xsl:if>
				<xsl:if test="/xml/content/categoria/@parent = @id">
					<xsl:attribute name="selected">selected</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="name" />
			</option>
			<xsl:if test="count(categorias/categoria)>0">
				<xsl:call-template name="categoria_item">
					<xsl:with-param name="categories" select="categorias"/>
					<xsl:with-param name="profundidad" select="$profundidad + 8"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
</xsl:template>


</xsl:stylesheet>