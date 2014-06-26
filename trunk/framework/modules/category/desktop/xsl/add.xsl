<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />



<xsl:variable name="htmlHeadExtra">
</xsl:variable>


<xsl:template name="content">
	<div class="content100">
		<div id="msj"></div>

		<form name="addForm" action="?m={$config/module/@name}&amp;action=BackAdd" method="POST">

			<div class="box">
				<h2>Crear <xsl:value-of select="configuration/module/navigation/display" /></h2>

					<ul class="form" style="margin-bottom:30px;">
						<li class="floatFix">
							<label for="name">Nombre</label><input type="text" id="nombre" name="category_name" value=""/>
						</li>
						<!--<li class="floatFix">
													<label for="name">order</label><input type="text" id="hola" name="categoria_order" value="22122" />
												</li>-->
						<li class="floatFix">
							<label for="description">Categoría Superior</label>
							<select name="category_parent" id="category_parent">
								<option value="0">Sin Categoría Superior</option>
								<xsl:call-template name="categoria_item">
									<xsl:with-param name="categories" select="content/categories"/>
								</xsl:call-template>
							</select>
						</li>
					</ul>
					<p class="btn-group">
						<button class="btn" onclick="return false;" id="delete">Borrar</button>
						<button class="btn btn-inverse" type="submit">Guardar</button>
					</p>
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