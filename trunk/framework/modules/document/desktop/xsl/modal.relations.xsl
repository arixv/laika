<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />


<xsl:variable name="cellsPerRow">3</xsl:variable>
<xsl:param name="object_id" />
<xsl:param name="type_id" />
<xsl:param name="category_id" />
<xsl:param name="parent_id" />
<xsl:param name="pagenumber" />
<xsl:param name="edit" />
<xsl:param name="parent" />
<xsl:param name="request_uri" />
<xsl:param name="isSearch" />
<xsl:param name="query" />

<xsl:variable name="config" select="/xml/configuration" />
<xsl:variable name="adminroot" select="$config/system/adminpath" />

<xsl:variable name="method"><!-- 
 	--><xsl:choose><!-- 
	 --><xsl:when test="$isSearch = 1">BackModalSearch</xsl:when><!-- 
	 --><xsl:otherwise>BackDisplayRelationModal</xsl:otherwise><!-- 
 --></xsl:choose><!-- 
--></xsl:variable>
<xsl:variable name="thisURL">
	?m=<xsl:value-of select="$config/module/@name"/>&amp;action=<xsl:value-of select="$method"/>&amp;object_id=<xsl:value-of select="$object_id" />&amp;type_id=<xsl:value-of select="$type_id" />&amp;parent=<xsl:value-of select="$parent_id" />&amp;q=<xsl:value-of select="$query"/>
</xsl:variable>



<xsl:template match="/xml">


<html>
	<head>

		<xsl:call-template name="htmlHead" />
		
		<link rel="stylesheet" type="text/css" href="{$modPath}/desktop/css/document.css" />
		
		<script type="text/javascript" src="{$modPath}/desktop/js/upload.handler.js">&#xa0;</script>
		<script type="text/javascript" src="{$modPath}/desktop/js/modals.js">&#xa0;</script>
		<script type="text/javascript">
			$(document).ready(function(){
				$(this).layout();
				var wh = $(window).height();
				wh = wh - 95;
				$('#grid, #upload-container').attr('style', 'height:'+wh+'px');
				setSlider($('#grid'));
			});
			function clodeModal(responseText, statusText, xhr, $form){
				parent.layer.Remove();
			}
		</script>
		<script type="text/javascript">
			default_categories = [<!-- 
				 --><xsl:for-each select="$config/module/options/group[@name='categories']/option[@type='default']"><!-- 
				 	-->"<xsl:value-of select="@value" />"<!-- 
				 	--><xsl:if test="position() != last()">, </xsl:if><!-- 
				 --></xsl:for-each><!-- 
			 -->];
			 modpath = "<xsl:value-of select="$modPath" />";
		</script>
	</head>
	<body class="mdn_modal">

		<div class="modal-header">
			<div class="search">
				<form name="search" action="{$adminroot}?m=document&amp;action=BackModalSearch" method="post">
					<input type="text" name="q" value="Buscar" />
					<input type="hidden" name="object_id" value="{$object_id}" />
					<input type="hidden" name="category_id" value="{$category_id}" />
					<button type="submit">Buscar</button>
				</form>
			</div>
			<h3>Documentos Relacionados</h3>
		</div>


		<!-- <div id="output1"></div> -->


		<div id="modalbody">
			<div class="padding">

				<xsl:if test="$isSearch = 1">
					<a href="{$adminroot}?m={$modName}&amp;action=BackDisplayRelationModal&amp;object_id={$object_id}&amp;type_id=1&amp;category_id={$category_id}" style="display:block;background:#3a3a3a;color:#fff;padding:5px 10px;margin:0 0 10px 0;">« Resultados de "<xsl:value-of select="$query"/>". Volver al listado</a>
				</xsl:if>

				<div class="list-header floatFix">
					<div class="list-tools">
						<xsl:call-template name="multimedia.filter.list">
							<xsl:with-param name="filter" select="content/filter" />
						</xsl:call-template>
						<xsl:if test="$isSearch != 1">
							<button href="#" class="btn upload" style="margin:0 0 0 5px;"><i class="icon-upload"></i> Subir</button>
						</xsl:if>
						<xsl:call-template name="modal.pagination" />
					</div>
					<div class="uplaod-tools" style="display:none;">
						<button href="#" class="btn back"><i class="icon-chevron-left"></i> Volver al listado</button>
					</div>
				</div>
				

				<!-- <ul class="mdn_tab">
					<xsl:choose>
						<xsl:when test="$edit = 1">
							<li class="listado">Fotos</li>
							<li class="carga activo">Subir fotos</li>
						</xsl:when>
						<xsl:otherwise>
							<li class="listado activo">Fotos</li>
							<li class="carga">Subir fotos</li>
						</xsl:otherwise>
					</xsl:choose>
				</ul> -->
				
				<div id="grid" class="grid-list">

					<ul class="list">
						<li>
							<xsl:for-each select="content/documents/document">
								<xsl:variable name="thisID" select="@document_id" />
								<ul class="list-row" item_id="{@document_id}">
									<!-- <xsl:if test="position() mod 2 = 0">
										<xsl:attribute name="class">alt</xsl:attribute>
									</xsl:if> -->
								<li id="document-{@document_id}" class="longbox" style="padding-left:15px;">
									
									<img src="{$modPath}/desktop/imgs/{@type}.png" class="file-icon" />
									
									<div class="data-column">
										<h4 style="overflow:hidden;"><xsl:value-of select="title" /></h4>
										<p style="margin:0;">
											<xsl:value-of select="summary" disable-output-escaping="yes"/>
										</p>
										<span>Tipo: <xsl:value-of select="@type"/></span><br/>
										<span>Peso: 
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
										<br/>
										<!-- <span>Dimensiones: <xsl:value-of select="@width"/> x <xsl:value-of select="@height"/></span> -->
										<xsl:if test="$parent = 1">
											<span>Categoría: 
												<xsl:for-each select="categorias/categoria">
													<xsl:value-of select="name"/>
													<xsl:if test="position()!=last()">, </xsl:if>
												</xsl:for-each>
											</span>
										</xsl:if>
									</div>
								</li>
								<li class="sidebar">
									<xsl:choose>
										<xsl:when test="not($thisID = //object/documents//document/@document_id)">
											<a href="#" onclick="parent.multimedia.setRelation({$object_id},{@document_id},{@type_id})" class="boton right">Relacionar</a>
										</xsl:when>
										<xsl:otherwise>
											<span class="right">Ya relacionado</span>
										</xsl:otherwise>
									</xsl:choose>
								</li>
								</ul>
							</xsl:for-each>
						</li>
					</ul>
				</div>

				<div id="upload" style="display:none">
					<xsl:call-template name="upload.flash" />
				</div>
			</div>
		</div>
		
		<xsl:if test="$debug=1">
			<xsl:call-template name="debug" />
		</xsl:if>


	</body>
</html>

</xsl:template>


<xsl:template name="modal.pagination">
	<xsl:call-template name="pagination">
		<xsl:with-param name="total" select="content/documents/@total" />
		<xsl:with-param name="display" select="content/documents/@display" />
		<xsl:with-param name="currentPage" select="content/documents/@currentPage" />
		<xsl:with-param name="url"><xsl:value-of select="$thisURL"/>&amp;category_id=<xsl:value-of select="$category_id" /></xsl:with-param>
	</xsl:call-template>
</xsl:template>



<xsl:template name="upload.flash">

	<xsl:variable name="fileTypes"><!--
		--><xsl:for-each select="$config/module/options/group[@name='acepted_files']/option"><!--
			-->*.<xsl:value-of select="."/><!--
			--><xsl:if test="position()!=last()">;</xsl:if><!--
		--></xsl:for-each><!--
	--></xsl:variable>
	
	<xsl:call-template name="swf.upload">
		<xsl:with-param name="uploadLimit"><xsl:value-of select="$config/module/options/group[@name='acepted_files']/@sizelimit" /></xsl:with-param>
			<xsl:with-param name="filesLimit"><xsl:value-of select="$config/module/options/group[@name='acepted_files']/@limit" /></xsl:with-param>
			<xsl:with-param name="filesTypes"><xsl:value-of select="$fileTypes" /></xsl:with-param>
			<xsl:with-param name="filesTypesDescription">Archivos permitidos (<xsl:value-of select="$fileTypes" />)</xsl:with-param>
			<xsl:with-param name="module"><xsl:value-of select="$config/module/@name" /></xsl:with-param>
			<xsl:with-param name="action">BackUpload</xsl:with-param>
			<xsl:with-param name="mode">standalone</xsl:with-param>

		<!--Nombre de la funcion de javascript para manejar el resultado del upload-->
		<xsl:with-param name="handler">UploadHandler</xsl:with-param>
		<xsl:with-param name="callback"><xsl:value-of select="$adminroot"/>?m=<xsl:value-of select="$config/module/@name" />&amp;action=BackUpdateBundle</xsl:with-param>
		<!-- <xsl:with-param name="redirect">index.php?m=photo&amp;action=BackDisplayModalUpdate</xsl:with-param> -->
		<xsl:with-param name="post_params">url=<xsl:value-of select="$request_uri"/>|category_id=<xsl:value-of select="$category_id" />|parent=<xsl:value-of select="$parent_id" /></xsl:with-param>
	</xsl:call-template>
</xsl:template>


<xsl:template name="multimedia.filter.list">
	<xsl:param name="filter" />

	<xsl:if test="$filter/group">
		<xsl:for-each select="$filter/group">
			<div class="filters btn-group">
				<button class="btn dropdown-toggle" data-toggle="dropdown"><xsl:value-of select="@name" />&#xa0;
				<xsl:if test="$category_id != '' and .//category[@category_id=$category_id]"> &#x02192; <xsl:value-of select=".//category[@category_id=$category_id]/name" />&#xa0;</xsl:if>
				<span class="caret">&#xa0;</span></button>
				<ul class="dropdown-menu">
			    	<xsl:for-each select="category">
						<xsl:call-template name="multimedia.filter.item" />
					</xsl:for-each>
					<li class="divider">&#xa0;</li>
					<li>
						<a>
							<xsl:attribute name="href"><xsl:value-of select="$thisURL"/></xsl:attribute>
							Todas
						</a>
					</li>
				</ul>
			</div>
		</xsl:for-each>
	</xsl:if>
</xsl:template>


<xsl:template name="multimedia.filter.item">
	<xsl:param name="prefix" />
		<li>
			<xsl:if test="@category_id = $category_id">
				<xsl:attribute name="class">active</xsl:attribute>
			</xsl:if>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="$thisURL"/>&amp;category_id=<xsl:value-of select="@category_id"/></xsl:attribute>
				<xsl:if test="$prefix != ''"><xsl:value-of select="$prefix" /></xsl:if>
				<xsl:value-of select="name" />
			</a>
		</li>
		<xsl:if test="categories/category">
			<xsl:for-each select="categories/category">
				<xsl:call-template name="multimedia.filter.item">
					<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/>- </xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>
</xsl:template>

</xsl:stylesheet>