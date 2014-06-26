<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="message" />
<xsl:param name="pass" />
<xsl:variable name="htmlHeadExtra">
	<!-- <script src="{$modPath}/desktop/js/users.js" type="text/javascript">&#xa0;</script> -->
	<!-- <script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script> -->
</xsl:variable>



<xsl:template name="content">

	<div class="content100 showTools">


		<form name="user" action="/admin/?m={$config/module/@name}&amp;action=BackConsole" method="post">
			
			<div class="list-header rounded floatFix">
				<h2 class="techo">Console</h2>
			</div>

			
			<div class="edit-body">
				<div class="box-overflow">
				

					<div class="box">

						<ul class="form">
							<li>
								<label>Script</label>
								<textarea name="console_script" >&#xa0;</textarea>
							</li>
							<li>
								<button type="submit" class="btn btn-inverse save"><span>Ejecutar</span></button>
							</li>
						</ul>
					</div>
				</div>
			</div>

		</form>
	</div>


</xsl:template>
</xsl:stylesheet>