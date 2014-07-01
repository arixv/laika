<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="calendar" />
<xsl:param name="type" />

<xsl:variable name="htmlHeadExtra">

	<xsl:call-template name="js.cal" />
	<script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script>

	<xsl:call-template name="tiny_mce">
		<xsl:with-param name="elements">page_content</xsl:with-param>
		<xsl:with-param name="width">100%</xsl:with-param>
		<xsl:with-param name="object_id" select="$content/object/@id" />
		<xsl:with-param name="object_typeid" select="$content/object/@typeid" />
	</xsl:call-template>

</xsl:variable>

<xsl:template name="content">

<xsl:variable name="object" select="$content/object" />

<form name="edit" action="{$adminroot}{$modName}/edit/" method="post">

	<div class="col-sm-8">
		<section class="panel">
			
			<header class="panel-heading wht-bg"><h4 class="gen-case">Editar Página</h4></header>
			
			<div class="panel-body">
				
					<input type="hidden" name="modToken" value="{$modToken}" />
					<input type="hidden" name="page_id" value="{$object/@id}" />
					<input type="hidden" name="modification_userid" value="{$config/user/@user_id}" />
					<input type="hidden" name="modification_usertype" value="backend" />
						
					<div class="form-group" >
						<label>Title</label>
						<input type="text" maxlength="200" class="form-control" name="page_title" value="{$object/title}"/>
					</div>
					<div class="form-group" >
						<label>Url</label>
						<input type="text" maxlength="200" class="form-control" name="page_shorttitle" value="{$object/shorttitle}"/>
					</div>
					<div class="form-group">
						<label>Content</label>
						<textarea name="page_content" id="page_content" class="form-control">
							<xsl:apply-templates select="$object/content"/>
							<xsl:comment />
						</textarea>
					</div>
					<div class="form-group">
						<label>Tags (separados por coma, solo para busquedas)</label>
						<input type="text" name="page_tags" value="{$object/tags}" class="form-control" />
					</div>
						

			
		</div>
	</section>
</div>

	<div class="col-sm-4">

				<xsl:call-template name="tool.publishing">
					<xsl:with-param name="object_id" select="$object/@id" />
					<xsl:with-param name="state" select="$object/@state" />
					<xsl:with-param name="date_field" select="'creation_date'" />
					<xsl:with-param name="date_value" select="$object/@creation_date" />
				</xsl:call-template>

				
				<xsl:call-template name="tool.metainformation">
					<xsl:with-param name="metatitle_field" select="'page_metatitle'" />
					<xsl:with-param name="metadescription_field" select="'page_metadescription'" />
					<xsl:with-param name="metatitle" select="$object/metatitle" />
					<xsl:with-param name="title"  select="$object/title"/>
					<xsl:with-param name="metadescription" select="$object/metadescription"  />
					<xsl:with-param name="summary" select="$object/summary" />
				</xsl:call-template>

				
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
</form>
</xsl:template>
</xsl:stylesheet>