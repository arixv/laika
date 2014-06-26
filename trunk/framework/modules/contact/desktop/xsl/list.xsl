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
<xsl:param name="start_date" />
<xsl:param name="end_date" />
<xsl:param name="university" />
<xsl:param name="carrera" />

<xsl:variable name="htmlHeadExtra">
	<xsl:call-template name="js.cal" />
	<script type="text/javascript" src="{$adminPath}/desktop/js/module.list.js">&#xa0;</script>
	<script type="text/javascript" src="{$modPath}/desktop/js/script.contact.js">&#xa0;</script>

</xsl:variable>


<xsl:template name="content">
	<div class="content100">

	<xsl:variable name="collection" select="$content/collection" />

	<div class="list-header floatFix">

			<div class="right"><xsl:call-template name="search.box" /></div>

			<h2 class="techo">
				<xsl:value-of select="$config/module/@title" />&#xa0;
			</h2>


				<div class="list-tools">

						<form method="get" action="/admin/contact/list">

								<div class="btn-group">
									<!-- university -->
					                <select name="university" style="width:150px;">
										<option value="">Universidad</option>
										<xsl:for-each select="$context/universidades/object">
											<option value="{@id}">
												<xsl:if test="$university = @id"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
												<xsl:value-of select="title" />
											</option>
										</xsl:for-each>
									</select>
								</div>

								<!-- <div class="btn-group">
					                <select name="university" style="width:150px;">
										<option value="">Carrera</option>
										<xsl:for-each select="$context/carreras/object">
											<option value="{@id}">
												<xsl:if test="$carrera = @id"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
												<xsl:value-of select="title" />
											</option>
										</xsl:for-each>
									</select>
								</div> -->

								<div class="btn-group">
									<input style="width:100px;float:left;" placeholder="Desde" type="text" name="start_date" value="{$start_date}" id="calendar-field-start" />
									<a href="#" id="calendar-trigger-start" class="btn" style="float:left;" onclick="return false;"><i class="icon icon-calendar">&#xa0;</i></a>
								</div>


								<div class="btn-group">
									<input style="width:100px;float:left;" type="text" placeholder="Hasta" name="end_date" value="{$end_date}" id="calendar-field-end" />
									<a href="#" id="calendar-trigger-end" class="btn" style="float:left;" onclick="return false;"><i class="icon icon-calendar">&#xa0;</i></a>
								</div>
							


								<div class="btn-group">
					              	<button class="btn btn-inverse">Filtrar</button>
					            </div>
						</form>
				</div>
				


				<div class="list-actions">
					<span class="left">
						<label for="all">Seleccionar todos</label>
						<input type="checkbox" name="all" id="all" class="checkAll" />
					</span>
					
					<div class="btn-group">
						<a href="#" class="btn delete">Eliminar</a>
					</div>
				</div>


				<div class="right">
					<xsl:call-template name="pagination.box" />
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
		    	<xsl:when test="not($collection/object) and $query = ''">
		    		<div class="empty-list rounded">
			    			No se encontró ningun elemento.<br/>
			    			Para cargar uno nuevo hacé <a href="{$adminroot}{$modName}/add/">click aquí</a> o apretá la letra "n" de tu teclado.
			    		</div>
		    	</xsl:when>
		    	<xsl:otherwise>
					<ul class="list">
						<xsl:for-each select="$collection/object">
							<!-- <xsl:sort order="descending" select="@date" /> -->

							<li class="floatFix" id="object_{@id}" item_id="{@id}">
								<ul class="list-row">
									<xsl:if test="position() mod 2 = 0">
										<xsl:attribute name="class">alt</xsl:attribute>
									</xsl:if>
									<li class="p20 longbox">									
										
										<div class="left" style="width:50%;">
											<h2><xsl:value-of select="name" />&#160;<xsl:value-of select="lastname" /></h2>
											<p><xsl:value-of select="@date"/></p>
											<input type="checkbox" name="item_{@id}" class="check"/>
											<div class="btn-group quick">
												<a class="btn btn-small" href="{$adminroot}{$modName}/edit/{@id}" title="Borrar"><i class="icon-edit">&#xa0;</i>&#xa0;Ver Datos</a>
												<a class="btn btn-small  deleteObject" href="#" title="Borrar"><i class="icon-trash">&#xa0;</i>&#xa0;Borrar</a>
											</div>
										
											<xsl:variable name="thisLocation" select="location" />
											<p>Ubicación: <xsl:value-of select="$context/locations//location[@id=$thisLocation]/name" /></p>
											
										</div>

										<div class="left" style="width:50%;">
											<xsl:if test="carrera_title"><h2><xsl:value-of select="carrera_title" /></h2></xsl:if>
											<xsl:if test="universidad_title"><h2><xsl:value-of select="universidad_title" /></h2></xsl:if>
										</div>
									</li>

									

									<li class="p25 sidebar">

										
											<span class="right" style="margin:0 10px 0 0;">
												Contacto Recibido <xsl:value-of select="publishedby" />&#xa0;<!-- 
											 --><abbr class="timeago" title="{date}"><xsl:value-of select="date"/></abbr>
											</span>
										

										
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