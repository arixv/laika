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

	<div class="content100 showTools">

		<form name="add" action="{$adminroot}{$config/module/@name}/insert/" method="post">
			<input type="hidden" name="modToken" value="{$modToken}" />

			<div class="list-header floatFix">
				<h2 class="techo">Nuevo País</h2>
			</div>


			<div class="edit-body">
				<div class="box-overflow">
					<div class="box">
						<ul class="form addNota">
							<li>
								<input type="text" maxlength="200" name="country_title" value="Nombre" />
							</li>
							<li>
								<a href="javascript:history.back();" class="btn">Cancel</a>&#xa0;
								<button type="submit" class="btn btn-inverse">
									<i class="icon-plus icon-white">&#xa0;</i>&#xa0;Add</button>
							</li>
						</ul>
					</div>
				</div>
			</div>

		</form>
	</div>


</xsl:template>
</xsl:stylesheet>