<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="calendar" />
<xsl:param name="type" />

<xsl:variable name="photo" select="/xml/content/photo" /> 

<xsl:variable name="htmlHeadExtra">
</xsl:variable>


<xsl:template name="content">
	<div class="content100 showTools">
		


		<form name="edit" action="{$adminroot}{$config/module/@name}/edit/" method="post">
			<input type="hidden" name="photo_id" value="{$photo/@photo_id}" />
			<xsl:if test="$photo/@preview = 1">
				<input type="hidden" name="photo_preview" value="1" />
			</xsl:if>
		
			<div class="list-header rounded floatFix">
				<h2 class="techo">Editar Imágen</h2>
				<div class="right"><!-- 
					 --><button type="submit" class="btn btn-inverse save"><span>Guardar</span></button>&#xa0;<!-- 
				 --></div>

				
				<a href="{$adminroot}{$config/module/@name}/list" class="btn left" ><i class="icon icon-chevron-left">&#xa0;</i>&#xa0;Volver</a>
			</div>
			
			<div class="edit-body">
		
					<div id="tools">
						<div class="padding">
							<span class="stop"></span>
							<ul id="sorteable-0">
								<li class="header">
									<h3>Foto</h3>
								</li>
								<li class="collapsable" style="text-align:center;">
									<xsl:call-template name="photo">
										<xsl:with-param name="id" select="$photo/@photo_id"/>
										<xsl:with-param name="type" select="$photo/@type"/>
										<xsl:with-param name="suffix">_p</xsl:with-param>
									</xsl:call-template>
									<br/>
									<span class="item-lista">

									<a target="blank" class="btn btn-inverse" href="{$config/domain}/{$config/module/options/group[@name='folders']/source}/{substring($photo/@photo_id,string-length($photo/@photo_id),1)}/{$photo/@photo_id}.{$photo/@type}">Ver foto original</a>
									</span>
								</li>
							</ul>
							<ul id="sorteable-1">
								<li class="header">
									<h3>Preview</h3>
								</li>
								<li class="collapsable" style="text-align:center;">
									<xsl:call-template name="photo">
										<xsl:with-param name="id" select="$photo/@photo_id"/>
										<xsl:with-param name="type" select="$photo/@type"/>
										<xsl:with-param name="suffix">_t</xsl:with-param>
									</xsl:call-template>
									<!-- <xsl:choose>
										<xsl:when test="$photo/@preview and $photo/@preview=1">
											<img src="{$config/domain}/{$config/module/options/folders/generated}/{substring($photo/@photo_id,string-length($photo/@photo_id),1)}/{$photo/@photo_id}_custom.{$photo/@type}?var={$horaActual}" />
										</xsl:when>
										<xsl:otherwise>
											<img src="{$config/domain}/{$config/module/options/folders/generated}/{substring($photo/@photo_id,string-length($photo/@photo_id),1)}/{$photo/@photo_id}_t.{$photo/@type}" />
										</xsl:otherwise>
									</xsl:choose> -->
								</li>
							</ul>
							<ul id="sorteable-2">
								<li class="header">
									<h3>Dimensiones (pixeles)</h3>
								</li>
								<li class="collapsable">
									<xsl:choose>
										<xsl:when test="$photo/@width != ''">
											<label> <xsl:value-of select="$photo/@width" />px
											x
											 <xsl:value-of select="$photo/@height" />px</label>
										</xsl:when>
									</xsl:choose>
								</li>
							</ul>

							<xsl:if test="$config/module/options/group[@name='categories']">
								<xsl:for-each select="$config/module/options/group[@name='categories']/option[@type='parent']">
								<ul id="sorteable-{position() + 2}">
									<li class="header">
										<h3><xsl:value-of select="@display" /></h3>
									</li>
									<li class="collapsable">
										<xsl:call-template name="multimedia.categories">
											<xsl:with-param name="categories" select="$photo/categories" />
											<xsl:with-param name="mid" select="$photo/@photo_id" />
											<xsl:with-param name="parent" select="@value" />
										</xsl:call-template>
									</li>
								</ul>
								</xsl:for-each>
							</xsl:if>
							<span class="stop"></span>
						</div>
					</div>

					<div class="box">
						<ul class="form photo-edit">
							<li>
								<label>Titulo</label>
								<input type="text" name="photo_title" value="{$photo/title}" />
							</li>
							<li>
								<label>Epigrafe</label>
								<textarea name="photo_summary"><xsl:value-of select="$photo/summary" />&#xa0;</textarea>
							</li>
							<li>
								<label>Tags</label>
								<input type="text" name="photo_tags" value="{$photo/tags}" />
							</li>
						</ul>
					</div>
		
					<!-- <div class="box" style="margin-top:15px;">
						<ul class="form photo-edit">
							<li>
								<label>Crear Preview</label>
								<xsl:choose>
									<xsl:when test="not($photo/@preview)">
										<p>
											Esta imagen posee un preview autogenerado.<br/>
											Para generar uno personalizado, selecciona una parte de la imagen
										</p>
									</xsl:when>
									<xsl:otherwise>
										<p>
											Para crear un nuevo preview, seleccioná una parte de la imagen.
											
										</p>
									</xsl:otherwise>
								</xsl:choose>

								<div class="source">
									<img id="cropimage" src="{$config/domain}/{$config/module/options/group[@name='folders']/source}/{substring($photo/@photo_id,string-length($photo/@photo_id),1)}/{$photo/@photo_id}.{$photo/@type}" />
									<br/>
									<button class="boton azul" onclick="cropImage();return false;">Create Preview</button>
								</div>

							</li>
						</ul>
					</div> -->
				</div>
			</form>
			<!-- //form -->

		
			<!-- <form name="imagecrop" action="?m={$config/module/@name}&amp;action=BackCreatePreview" method="post" onsubmit="return checkCoords();">
				<input type="hidden" name="original_id" value="{$photo/@photo_id}"/>
				<xsl:choose>
					<xsl:when test="$photo/@width != ''">
						<input type="hidden" name="original_width" value="{$photo/@width}"/>
						<input type="hidden" name="original_height" value="{$photo/@height}"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="original_width" value="{$width}"/>
						<input type="hidden" name="original_height" value="{$height}"/>
					</xsl:otherwise>
				</xsl:choose>
				
				<input type="hidden" id="x" name="x" />
				<input type="hidden" id="y" name="y" />
				<input type="hidden" id="w" name="w" />
				<input type="hidden" id="h" name="h" />
			</form> -->
	</div>

</xsl:template>
</xsl:stylesheet>