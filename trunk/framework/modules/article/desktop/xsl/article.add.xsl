<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="calendar" />
<xsl:param name="type" />


<xsl:variable name="htmlHeadExtra">

<!-- 	<xsl:call-template name="js.cal" />
	<script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script>
 --></xsl:variable>


<xsl:template name="content">

	<div class="content100">

		<form name="add" action="{$adminroot}{$config/module/@name}/insert/" method="post">
			<input type="hidden" name="modToken" value="{$modToken}" />

			<div class="list-header floatFix">
				<h2 class="techo">Nuevo Articulo</h2>
			</div>


			<div class="edit-body">
				<div class="box-overflow">


					<div class="box">

						<ul class="form addNota">
							<li>
								<input type="text" maxlength="200" name="article_title" placeholder="Titulo" />
							</li>
							<li>
								<a href="javascript:history.back();" class="btn">Cancelar</a>&#xa0;
								<button type="submit" class="btn btn-inverse">
									<i class="icon-plus icon-white">&#xa0;</i>&#xa0;Agregar</button>
							</li>
							<!-- 
							<li>
								<label>Volanta</label>
								<input type="text" name="article_header" />
							</li>
							<li>
								<label>External Link</label>
								<input type="text" maxlength="200" name="article_externallink" />
							</li> 
							<li>
								<label>Bajada</label>
								<textarea name="article_summary" id="article_summary"><xsl:comment/></textarea>
							</li>
							<li>
								<label>Contenido</label>
								<textarea name="article_content" id="article_content"><xsl:comment/></textarea>
							</li>
							<li>
								<label>Tags (separados por comma)</label>
								<input type="text" name="article_tags" value=""/>
							</li>-->
						</ul>
					</div>
				</div>
			</div>

		</form>
	</div>


</xsl:template>
</xsl:stylesheet>