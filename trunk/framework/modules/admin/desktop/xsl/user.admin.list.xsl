<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:variable name="htmlHeadExtra">
	<script type="text/javascript" src="{$modPath}/desktop/js/users.js">&#xa0;</script>
</xsl:variable>
<xsl:param name="page" />
<xsl:param name="query" />

<xsl:template name="content">

	<div class="content100">

		<div class="list-header">
			<h2 class="techo">Backend Users</h2>
			<!-- <div class="list-top floatFix">

				<div class="right">
					<xsl:call-template name="search.box" />
				</div>
			</div> -->
			<xsl:if test="$query != ''">
				<div class="alert">
					<button class="close" data-dismiss="alert">×</button>
					Mostrando resultados  
					para la búsqueda <strong><em>"<xsl:value-of select="$query"/>"</em></strong>
					<xsl:if test="$category_id != ''"> de la categoría <xsl:value-of select="//category[@category_id=$category_id]/name" /></xsl:if>
					(<xsl:value-of select="/xml/content/collection/@total" /> elementos encontrados)
				</div>
		    </xsl:if>

			<xsl:call-template name="pagination.box" />

			<div class="list-actions">
				<span class="left">
					<label for="all">Seleccionar todos</label>
					<input type="checkbox" name="all" id="all" class="checkAll" />
				</span>
				Elementos seccionados: 
				<a href="#" class="boton delete">Eliminar</a>
				<a href="#" class="boton categories">Categorizar</a>
				<a href="#" class="boton publish">Publicar</a>
				<a href="#" class="boton unpublish">Despublicar</a>
				<a href="#" class="boton duplicate">Duplicar</a>
			</div>
		</div>

		<div class="grid-list" id="grid">
			<ul class="list">
				<li class="head">
					<ul>
						<li class="p03">ID</li>
						<li class="p20">User</li>
						<li class="p10">Nivel de acceso</li>
						<li class="p20 center right">Acciones</li>
					</ul>
				</li>
			</ul>
			<div class="box-overflow">
				<ul class="list  simple">
					
					<xsl:for-each select="content/users/user">


						<li class="floatFix" id="user_{@user_id}">
							<ul>
								<xsl:if test="position() mod 2 = 0">
									<xsl:attribute name="class">floatFix alt</xsl:attribute>
								</xsl:if>
								<li class="p03">
									<xsl:value-of select="@user_id" />
								</li>
								<li class="p20">
									<h2>
										<a href="{$config/system/adminpath}{$config/module/@name}/edit/{@user_id}/">
										<xsl:value-of select="username" />
										</a>
									</h2>
									
									<xsl:value-of select="name" />&#xa0;<xsl:value-of select="lastname" />
									<br/>
									<a href="mailto:{email}"><xsl:value-of select="email" /></a>
									
								</li>
								<li class="p10">
									<xsl:value-of select="@access" />
								</li>
								<li class="p20 center right">
									<a class="btn" href="{$config/system/adminpath}{$config/module/@name}/edit/{@user_id}/" title="Editar">Editar</a>
									<xsl:if test="username!='admin'">
										<a class="btn" href="#" onclick="deleteUser({@user_id});return false;" title="Borrar usuario">Borrar</a>
									</xsl:if>
								</li>
							</ul>
						</li>
					</xsl:for-each>
				</ul>
			</div>
		</div>

	</div>


</xsl:template>
</xsl:stylesheet>