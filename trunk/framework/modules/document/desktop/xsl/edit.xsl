<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="calendar" />
<xsl:param name="type" />

<xsl:variable name="document" select="/xml/content/document" />
<xsl:variable name="documentfile">
	<xsl:value-of select="$config/system/images_domain"/>/<xsl:value-of select="$config/module/options/group[@name='folders']/option[@name='target']"/>/<xsl:value-of select="substring($document/@document_id,string-length($document/@document_id),1)"/>/<xsl:value-of select="$document/@document_id"/>.<xsl:value-of select="$document/@type"/>
</xsl:variable>

<xsl:variable name="htmlHeadExtra">
	<!-- <script type="text/javascript" src="{$modPath}/desktop/player/jwplayer.js">&#xa0;</script> -->
	<script>
		modpath   = "<xsl:value-of select="$modPath" />";
		videofile = "<xsl:value-of select="$documentfile" />";

	</script>
</xsl:variable>


<xsl:template name="content">

	<div class="content100 showTools">

		

		<form name="edit" action="{$adminroot}{$config/module/@name}/edit/" method="post">
		<input type="hidden" name="document_id" value="{$document/@document_id}" />

		<div class="list-header rounded floatFix">
			<span class="right"><!-- 
				 --><a href="javascript:history.back();" class="btn">Cancelar</a>&#xa0;<!-- 
				 --><button type="submit" name="back" value="1" class="btn save-back"><span>Guardar y volver</span></button>&#xa0;<!-- 
				 --><button type="submit" class="btn btn-primary save"><span>Guardar</span></button>&#xa0;<!-- 
				 
			 --></span>

			<h2 class="techo">Editar Video</h2>
		</div>

		<div class="edit-body">
			<div class="box-overflow">
		
		
				<div id="tools">
					<div class="padding">
						
						<ul id="sorteable-1">
							<li class="header">
								<h3>Datos del documento</h3>
							</li>
							<li class="collapsable" id="publishing">
								<p class="row">
									<img src="{$modPath}/desktop/imgs/{$document/@type}.png" alt="" style="float:left;margin:0 10px 0 0;"/>
									<b>Tipo: </b> <span style="text-transform:uppercase"><xsl:value-of select="$document/@type" /></span><br/>
									<b>Peso: </b>
									<xsl:choose>
										<xsl:when test="$document/@weight='' or not($document/@weight)">
											--
										</xsl:when>
										<xsl:when test="$document/@weight &gt; 1000000">
											<xsl:value-of select='format-number($document/@weight div 1000000, "#.##")' /> Mb
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select='format-number($document/@weight div 1000, "#.##")' /> Kb
										</xsl:otherwise>
									</xsl:choose>
								</p>

								<p class="row">
									<a href="{$adminroot}?m={$modName}&amp;action=Download&amp;document_id={$document/@document_id}" class="botoncito right">Descargar</a>
								</p>
							</li>
						</ul>
						<!-- <ul id="sorteable-0">
							<li class="header">
								<h3>Preview</h3>
							</li>
							<li class="collapsable" style="text-align:center;">
								
							</li>
						</ul> -->
						<xsl:if test="$config/module/options/group[@name='categories']/option">
							<xsl:for-each select="$config/module/options/group[@name='categories']/option[@type='parent']">
								<ul id="sorteable-{position() + 2}">
									<li class="header">
										<h3><xsl:value-of select="@title" /></h3>
									</li>
									<li class="collapsable">
										<xsl:call-template name="multimedia.categories">
											<xsl:with-param name="categories" select="$document/categories" />
											<xsl:with-param name="mid" select="$document/@document_id" />
											<xsl:with-param name="parent" select="@value" />
										</xsl:call-template>
									</li>
								</ul>
								</xsl:for-each>
						</xsl:if>

					</div>
				</div>
				
				
				<div class="box">
					<ul class="form photo-edit">
						<li>
							<label>Titulo</label>
							<input type="text" name="document_title" value="{$document/title}" />
						</li>

						<li>
							<label>Tags</label>
							<input type="text" name="document_tags" value="{$document/tags}" />
						</li>
					</ul>
					
				</div>

			</div>
		</div>
		</form>
		
	</div>


</xsl:template>
</xsl:stylesheet>