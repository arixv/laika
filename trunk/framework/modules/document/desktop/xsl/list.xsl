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
			<div class="list-tools">
				<xsl:if test="content/filter/group">
					<xsl:call-template name="filter.list">
						<xsl:with-param name="filter" select="content/filter" />
						<xsl:with-param name="isMultimedia">1</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
				<xsl:call-template name="search.box" />
				<xsl:call-template name="pagination.box" />
			</div>

			<div class="list-actions rounded">
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
			    	<xsl:when test="not(content/collection/document) and $query = ''">
			    		<div class="empty-list rounded">
			    			No se encontró ningun documento.<br/>
			    			Para cargar un nuevo documento hacé <a href="{$adminroot}{$modName}/add/">click aquí</a> o apretá la letra "n" de tu teclado.
			    		</div>
			    	</xsl:when>
			    	<xsl:otherwise>
						<ul class="list multimedia video">
							<xsl:for-each select="content/collection/document">
								<!--<xsl:sort order="descending" select="@document_id" />-->
								<li class="floatFix" id="object_{@document_id}" item_id="{@document_id}">
									<ul class="multimedia-row">
										<xsl:if test="position() mod 2 = 0">
											<xsl:attribute name="class">alt</xsl:attribute>
										</xsl:if>
										<li class="p65 longbox">
											<a href="{$adminroot}{$modName}/edit/{@document_id}">
												<img src="{$modPath}/desktop/imgs/{@type}.png" alt="" class="file-icon"/>
											</a>
											<h2>
												<a href="{$adminroot}{$modName}/edit/{@document_id}">
													<xsl:value-of select="title" />
												</a>
											</h2>
											<p>
												Tipo: <xsl:value-of select="@type" /><br/>
												<xsl:if test="@duration != ''">
													Duración: <xsl:value-of select="@duration" /><br/>
												</xsl:if>
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
											</p>

											<div class="quick">
												<a href="{$adminroot}{$modulename}/edit/{@document_id}" class="botoncito" >Editar</a> 
												<a href="{$adminroot}?m={$modName}&amp;action=Download&amp;document_id={@document_id}" class="botoncito" >Ver</a>
												<a class="botoncito deleteObject" href="#" title="Borrar">Borrar</a>
											</div>

											<!-- <div class="data">
												<xsl:value-of select="title" />
												<span>
													<xsl:value-of select="summary" />
												</span>
											</div> -->
										</li>
										<li class="p25 sidebar">
											
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