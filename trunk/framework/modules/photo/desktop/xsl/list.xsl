<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="category_id" />
<xsl:param name="query" />
<xsl:param name="filter" />
<xsl:param name="state" />


<xsl:variable name="htmlHeadExtra">
	<script type="text/javascript" src="{$adminPath}/desktop/js/module.list.js">&#xa0;</script>
	<script type="text/javascript">
		var actions = {
			"categories"  : {"module": "multimedia", "method" : "BackDisplayGroupCategoryModal"},
			"delete"      : {"module": "multimedia", "method" : "BackDelete"},
			"changeState" : {"module": "multimedia", "method" : "BackChangeState"},
			"deleteGroup" : {"module": "multimedia", "method" : "BackDeleteGroup"}
		}
	</script>
</xsl:variable>


<xsl:template name="content">

	<div class="content100">


		<div class="list-header rounded floatFix">
			<h2 class="techo"><xsl:value-of select="$config/module/@title" /></h2>
			<div class="list-tools">

				<div class="btn-group">
						<a href="{$adminroot}{$modulename}/add" class="btn btn-inverse"><i class="icon-edit icon-white">&#xa0;</i>&#xa0;Agregar</a>
				</div>
				<xsl:if test="content/filter/group">
					<xsl:call-template name="filter.list">
						<xsl:with-param name="filter" select="content/filter" />
						<xsl:with-param name="isMultimedia">1</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
				<xsl:call-template name="search.box" />
				<xsl:call-template name="pagination.box" />
			</div>

			<div class="list-actions">
				<span class="left">
					<label for="all">Seleccionar todos</label>
					<input type="checkbox" name="all" id="all" class="checkAll" />
				</span>
				Elementos seccionados: 
				<a href="#" class="boton delete">Eliminar</a>
				<a href="#" class="boton categories">Categorizar</a>
			</div>
		</div>

		
		
		<div class="grid-box" id="grid">
	
			<div class="box-overflow">

				<xsl:if test="$query != ''">
					<div class="alert">
						<button class="close" data-dismiss="alert">×</button>
						Mostrando resultados de la búsqueda <strong><em>"<xsl:value-of select="$query"/>"</em></strong>
						<xsl:if test="$category_id != ''"> en la categoría <xsl:value-of select="//category[@category_id=$category_id]/name" /></xsl:if>
					</div>
			    </xsl:if>

			    <xsl:choose>
			    	<xsl:when test="not(content/collection/photo) and $query = ''">
						<div class="empty-list rounded">
			    			No se encontró ninguna imagen.<br/>
			    			Para cargar una nueva imagen hacé <a href="{$adminroot}{$modName}/add/">click aquí</a> o apretá la letra "n" de tu teclado.
			    		</div>
					</xsl:when>
					<xsl:otherwise>
						<ul class="list multimedia">
							<xsl:for-each select="content/collection/photo">
								<!--<xsl:sort order="descending" select="@photo_id" />-->
								<li class="floatFix" id="object_{@photo_id}" item_id="{@photo_id}">
									<ul class="multimedia-row">
										<xsl:if test="position() mod 2 = 0">
											<xsl:attribute name="class">alt</xsl:attribute>
										</xsl:if>
										<li class="p65 longbox">

											
											<!-- <xsl:variable name="ext">
												<xsl:choose>
													<xsl:when test="@preview = 1">_custom</xsl:when>
													<xsl:otherwise>_p</xsl:otherwise>
												</xsl:choose>
											</xsl:variable> -->
											<a href="/admin/photo/edit/{@photo_id}">
												<xsl:call-template name="photo">
													<xsl:with-param name="id" select="@photo_id" />
													<xsl:with-param name="suffix">_p</xsl:with-param>
													<xsl:with-param name="type" select="@type" />
												</xsl:call-template>
											</a>
												<!-- <xsl:call-template name="photo">
													<xsl:with-param name="id" select="@photo_id" />
													<xsl:with-param name="suffix">_p</xsl:with-param>
													<xsl:with-param name="type" select="@type" />
													<xsl:with-param name="class">dest</xsl:with-param>
												</xsl:call-template> -->
											


											<!-- <xsl:for-each select="categories/category">
												<xsl:value-of select="name" />
												<xsl:if test="position()!=last()">, </xsl:if>
											</xsl:for-each> -->

											<xsl:variable name="original">
												<xsl:call-template name="photo.original.src">
													<xsl:with-param name="id" select="@photo_id" />
													<xsl:with-param name="type" select="@type" />
												</xsl:call-template>
											</xsl:variable>
											<div class="quick">
												<a href="{$adminroot}{$modulename}/edit/{@photo_id}" class="botoncito" >Editar</a> 
												<!-- <a href="#" class="botoncito quickedit">Quick Edit</a>  -->
												<a href="{$original}" target="_blank" class="botoncito" >Ver</a> 
												<a class="botoncito deleteObject" href="#" title="Borrar">Borrar</a>
												<a href="#" class="icon-plus-sign more-data" style="vertical-align:middle;">&#xa0;</a>
											</div>

											<div class="data">
												<xsl:value-of select="title" />
												<span>
													<xsl:value-of select="summary" />
												</span>
											</div>
											
											

										</li>
										<li class="p25 sidebar">
											<div class="extra-data">
												<xsl:if test="categories/category">
													<h2><b>Categorías</b></h2>
													<xsl:for-each select="categories/category">
														<a href="{$adminroot}{$modName}/list/?categories={@category_id}"><xsl:value-of select="name" /></a>
														<xsl:if test="position() != last()">, </xsl:if>
													</xsl:for-each>
												</xsl:if>

												<h2><b>Imágen original</b></h2>
												<span>
												Dimensiones: <xsl:value-of select="@width" /> x <xsl:value-of select="@height" />
												</span>
												<span>
												Peso: 
												<xsl:choose>
													<xsl:when test="@weight='' or not(@weight)">
														--
													</xsl:when>
													<xsl:when test="@weight &gt; 1000000">
														<xsl:value-of select='format-number(@weight div 1000000, "#.##")' /> Mb
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select='format-number(@weight div 1000, "#.##")' /> Kb
													</xsl:otherwise>
												</xsl:choose>
												</span>
												<span>
												Formato: <xsl:value-of select="@type" />
												</span>
												<span>
												Subida por: 
												<xsl:choose>
													<xsl:when test="@creation_userid = -1">Import. Automática</xsl:when>
													<xsl:otherwise><xsl:value-of select="createdby" /></xsl:otherwise>
												</xsl:choose>, 
												<xsl:call-template name="fecha.formato.mensaje">
													<xsl:with-param name="fecha" select="@creation_date" />
												</xsl:call-template>
												
												</span>
											</div>
											<!-- <xsl:value-of select="@width" />
											<xsl:value-of select="@height" /> -->

											<input type="checkbox" name="check" class="check" />
										</li>
									</ul>
								</li>
							</xsl:for-each>
						</ul>
			    	</xsl:otherwise>
			    </xsl:choose>

			</div>	
		</div>

	</div>


</xsl:template>
</xsl:stylesheet>