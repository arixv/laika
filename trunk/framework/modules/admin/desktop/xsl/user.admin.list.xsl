<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:variable name="htmlHeadExtra">
	<script type="text/javascript" src="{$modPath}/desktop/js/users.js">&#xa0;</script>
</xsl:variable>
<xsl:param name="page" />
<xsl:param name="query" />

<xsl:template name="content">


<div class="col-sm-12">
	<section class="panel">
		<header class="panel-heading">Usuarios</header>

		<!-- <div class="list-header">
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
		</div> -->

		<table class="table  table-hover general-table" id="grid">
			<thead>
				<tr>
					<th class="p03">ID</th>
					<th class="p20">User</th>
					<th class="p10">Nivel de acceso</th>
					<th class="p20 center right">Acciones</th>
				</tr>
			</thead>
			
			<tbody>
				<xsl:for-each select="content/users/user">
					<tr id="user_{@user_id}">
						<td>
							<xsl:value-of select="@user_id" />
						</td>
						<td>
							<a href="{$config/system/adminpath}{$config/module/@name}/edit/{@user_id}/">
								<xsl:value-of select="username" />
							</a>
						</td>
						<td>
							<xsl:value-of select="@access" />
						</td>
						<td>
							<a class="btn btn-sm btn-info" href="{$config/system/adminpath}{$config/module/@name}/edit/{@user_id}/" title="Editar">
								<i class="fa fa-pencil" >&#xa0;</i> 
								Editar
							</a>
							<xsl:if test="username!='admin'">
								<a class="btn btn-sm btn-default" href="#" onclick="deleteUser({@user_id});return false;" title="Borrar usuario">
									<i class="fa fa-trash-o" >&#xa0;</i> 
									Borrar
								</a>
							</xsl:if>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		

	</section>

</div>

</xsl:template>
</xsl:stylesheet>