<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="calendar" />
<xsl:param name="type" />


<xsl:variable name="htmlHeadExtra">
</xsl:variable>


<xsl:template name="content">

		<div class="row">
			<div class="col-md-12">
				<section class="panel">
					<form name="form"  action="/admin/?m={$config/module/@name}&amp;action=BackEdit" method="post">
						<input type="hidden" name="id" value="{$content/object/@id}" />
						<header class="panel-heading">Editar </header>
						<div class="panel-body">
							<div class="form-group">
								<label>Nombre</label>
								<input type="text" maxlength="200" name="title" class="form-control" value="{$content/object/title}" />
							</div>
							<div class="form-group">
								<label>CUIT</label>
								<input type="text" maxlength="200" name="cuit" value="{$content/object/cuit}"  class="form-control" />
							</div>
							<div class="form-group">
								<label>Dirección</label>
								<input type="text" maxlength="200" name="address" value="{$content/object/address}"  class="form-control" />
							</div>
							<div class="form-group">
								<label>Teléfono</label>
								<input type="text" maxlength="200" name="phone" value="{$content/object/phone}"  class="form-control" />
							</div>
							<div class="form-group">
								<label>Email</label>
								<input type="text" maxlength="200" name="email" value="{$content/object/email}"  class="form-control" />
							</div>
							<div class="form-group">
								<label>Website</label>
								<input type="text" maxlength="200" name="website" value="{$content/object/website}"  class="form-control" />
							</div>
							<button class="btn btn-info">Guardar</button>
						</div>
					</form>
				</section>
			</div>
		</div>
		
	

</xsl:template>
</xsl:stylesheet>