<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:template name="content">

	<div class="content100">

		<form name="page" action="/admin/?m={$config/module/@name}&amp;action=BackAdd" method="post">
			<input type="hidden" name="modToken" value="{$modToken}" />
			<div class="list-header floatFix">
				

				<h2 class="techo">Nueva Página</h2>
			</div>

			<div class="edit-body">
				<div class="box-overflow">
					<div class="box">
						<ul class="form addNota">
							<li>
								<label>Title</label>
								<input type="text" maxlength="200" name="page_title" placeholder="Titulo" />
							</li>
							<li>
								
								<a href="javascript:history.back();" class="btn">Cancel</a>&#xa0;
								<button type="submit" class="btn btn-inverse"><i class="icon-plus icon-white">&#xa0;</i>&#xa0;Add</button>
					 
					 		</li>
						</ul>
					</div>
				</div>
			</div>


		</form>
	</div>


</xsl:template>
</xsl:stylesheet>