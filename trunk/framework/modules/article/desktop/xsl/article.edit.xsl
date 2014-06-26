<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="calendar" />
<xsl:param name="type" />

<xsl:variable name="htmlHeadExtra">

	<xsl:call-template name="js.cal" />
	<script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script>

	<xsl:call-template name="tiny_mce">
		<xsl:with-param name="elements">article_summary,article_content</xsl:with-param>
		<xsl:with-param name="width">500</xsl:with-param>
		<xsl:with-param name="object_id" select="$content/object/@id" />
		<xsl:with-param name="object_typeid" select="$content/object/@typeid" />
	</xsl:call-template>


</xsl:variable>

<xsl:template name="content">

	<xsl:variable name="object" select="$content/object" />

	<div class="content100 showTools">
		
		<form name="edit" action="{$adminroot}{$config/module/@name}/edit/" method="post">
		<input type="hidden" name="modToken" value="{$modToken}" />
		<input type="hidden" name="article_id" value="{$object/@id}" />
		<input type="hidden" name="modification_userid" value="{$config/user/@user_id}" />
		<input type="hidden" name="modification_usertype" value="backend" />

		<div class="list-header floatFix">
			<div class="buttons">
				 <a href="{$adminroot}{$modName}/return/" class="btn"><i class="icon-chevron-left">&#160;</i>Volver</a>
				 <a href="/{$config/site/preffix}/notas/{$object/@id}/{$object/object_shorttitle}" target="_blank" class="btn save-back"><i class="icon-globe">&#160;</i>Ver Online</a>
				 <a href="{$adminroot}{$modName}/clear_object_cache/{$object/@id}" class="btn"><i class="icon-off">&#160;</i>Borrar Caché</a>
				 <button type="submit" class="btn btn-inverse save"><span>Guardar</span></button>
			</div>

			<h2 class="techo">Editar Artículo</h2>
		</div>

		<!-- LANG: <xsl:value-of select="$lang/publish" /> -->
		<!-- <xsl:copy-of select="$lang" /> -->

		<div class="edit-body">
			<div class="box-overflow">
			
				<div id="tools">
					<div class="padding">

						<ul id="sorteable-0" class="rounded">
							<xsl:call-template name="tool.publishing">
								<xsl:with-param name="object_id" select="$object/@id" />
								<xsl:with-param name="state" select="$object/@state" />
								<xsl:with-param name="date_field" select="'creation_date'" />
								<xsl:with-param name="date_value" select="$object/@creation_date" />
								<xsl:with-param name="modified_value" select="$object/@modification_date" />
								<xsl:with-param name="createdby" select="$object/createdby" />
								<xsl:with-param name="modifiedby" select="$object/modifiedby" />
							</xsl:call-template>
						</ul>

						<ul id="sorteable-1" class="rounded">
							<xsl:call-template name="tool.metainformation">
								<xsl:with-param name="metatitle_field" select="'article_metatitle'" />
								<xsl:with-param name="metadescription_field" select="'article_metadescription'" />
								<xsl:with-param name="metatitle" select="$object/metatitle" />
								<xsl:with-param name="title"  select="$object/title"/>
								<xsl:with-param name="metadescription" select="$object/metadescription"  />
								<xsl:with-param name="summary" select="$object/summary" />
							</xsl:call-template>
						</ul>
						
						<xsl:call-template name="tool.categories">
							<xsl:with-param name="categories" select="$object/categories" />
							<xsl:with-param name="object_id" select="$object/@id" />
						</xsl:call-template>


						<xsl:call-template name="multimedia.relations">
							<xsl:with-param name="configuration" select="$config/module/options/group[@name='multimedias']" />
							<xsl:with-param name="multimedias" select="$object/multimedias" />
							<xsl:with-param name="object_id" select="$object/@id" />
							<xsl:with-param name="position" select="100" />
						</xsl:call-template>
						
						<xsl:call-template name="object.relations">
							<xsl:with-param name="objects" select="$config/module/options/group[@name='relations']" />
							<xsl:with-param name="relations" select="$object/relations" />
							<xsl:with-param name="object_id" select="$object/@id" />
							<xsl:with-param name="position" select="200" />
						</xsl:call-template>

						
					</div>
				</div>

				<div class="box">
					<ul class="form addNota">
						<li>
							<label>Título</label>
							<input type="text" maxlength="200" name="article_title" value="{$object/title}"/>
						</li>
						<li>
							<label>Volanta</label>
							<input type="text" name="article_header" value="{$object/header}"/>
						</li>
						<li>
							<label>Bajada</label>
							<textarea name="article_summary" id="article_summary">
								<xsl:apply-templates select="$object/summary" />
								<!-- Este tag hace falta para que si no hay childs no se cierre inline y rompa en html5 -->
								<xsl:comment />
							</textarea>
						</li>
						<li>
							<label>Contenido</label>
							<textarea name="article_content" id="article_content">
								<xsl:apply-templates select="$object/content"/>
								<!-- Este tag hace falta para que si no hay childs no se cierre inline y rompa en html5 -->
								<xsl:comment />
							</textarea>
						</li>
						<li>
							<label>Tags (separados por coma)</label>
							<input type="text" name="article_tags" value="{$object/tags}"/>
						</li>
					</ul>
				</div>
			</div>
		</div>

		</form>
	</div>


</xsl:template>
</xsl:stylesheet>