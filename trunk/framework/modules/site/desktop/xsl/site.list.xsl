<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />

<xsl:param name="calendar" />
<xsl:param name="type" />
<xsl:param name="pagenumber" />
<xsl:param name="query" />
<xsl:param name="filter" />
<xsl:param name="state" >0</xsl:param>
<xsl:param name="category_id" />
<xsl:param name="site" />

<xsl:variable name="htmlHeadExtra">
	<script type="text/javascript" src="{$adminPath}/desktop/js/module.list.js">&#xa0;</script>
</xsl:variable>


<xsl:template name="content">
	<div class="content100">

	<xsl:variable name="collection" select="$content/collection" />

		<div class="list-header floatFix">
			
			
			<h2 class="techo">
				<xsl:value-of select="$config/module/@title" />&#xa0;
			</h2>

				<div class="list-tools">
					<xsl:call-template name="search.box" />
				</div>
				
		
		</div>

	<div class="box-overflow">
		<div class="grid-list" id="grid">

			<xsl:if test="$query != ''">
				<div class="alert">
					<button class="close" data-dismiss="alert">×</button>
					Mostrando resultados  
					para la búsqueda <strong><em>"<xsl:value-of select="$query"/>"</em></strong>
					<xsl:if test="$category_id != ''"> de la categoría <xsl:value-of select="//category[@category_id=$category_id]/name" /></xsl:if>
					<xsl:variable name="found">
						<xsl:choose>
							<xsl:when test="$collection/@total !=''">
								<xsl:value-of select="$collection/@total" />
							</xsl:when>
							<xsl:otherwise>0</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					(<xsl:value-of select="$found" /> elementos encontrados)
				</div>
		    </xsl:if>

		    <xsl:choose>
		    	<xsl:when test="not($collection/site) and $query = ''">
		    		<div class="empty-list rounded">
			    			No se encontró ningun elemento.<br/>
			    			Para cargar uno nuevo hacé <a href="{$adminroot}{$modName}/add/">click aquí</a> o apretá la letra "n" de tu teclado.
			    		</div>
		    	</xsl:when>
		    	<xsl:otherwise>
					<ul class="list">
						<xsl:for-each select="$collection/site">
							<!-- <xsl:sort order="descending" select="@date" /> -->

							<li class="floatFix" id="object_{id}" item_id="{id}">
								<ul class="list-row">
									<xsl:if test="position() mod 2 = 0">
										<xsl:attribute name="class">alt</xsl:attribute>
									</xsl:if>
									<li class="p10">
										<xsl:value-of select="id" />
									</li>
									<li class="p25">									
										

										<h2>
											<a href="{$adminroot}{$modulename}/edit/{@id}">
												<xsl:value-of select="title" />
											</a>
										</h2>
										<span class="date">
											<xsl:variable name="date">
												<xsl:call-template name="fecha.formato.numerico">
													<xsl:with-param name="fecha" select="@creation_date" />
												</xsl:call-template>
											</xsl:variable>
											<!-- <xsl:value-of select="$date" /> -->
										</span>
										

									
									

										<div class="btn-group quick">
											<a href="{$adminroot}{$modulename}/edit/{id}" class="btn btn-small" >
												<i class="icon-edit">&#xa0;</i>
												Editar
											</a> 
											<a class="btn btn-small  deleteObject" href="#" title="Borrar">
												<i class="icon-remove">&#xa0;</i>
												Borrar
											</a>
										</div>

										<xsl:for-each select="categories/category[not(@parent=1)]">
											<xsl:sort order="ascending" select="@order" data-type="number"/>
											<span class="cat">
												<a href="{$adminroot}{$modName}/list/?categories={@category_id}"><xsl:value-of select="name" /></a>
											</span>
											<!-- <xsl:if test="position()!=last()">, </xsl:if> -->
										</xsl:for-each>



									</li>


									<li class="p25 ">

										<xsl:value-of select="analytics" />
										
									</li>

									<li class="p25 ">

										<xsl:value-of select="eplanning" />
										
									</li>
								</ul>
							</li>
						</xsl:for-each>
					</ul>
				</xsl:otherwise>
			</xsl:choose>
		</div>

		</div>

		<div style="margin:10px 5px;">
		 		<xsl:call-template name="pagination.box" /> 
		 	</div>
		
	</div>


</xsl:template>
</xsl:stylesheet>