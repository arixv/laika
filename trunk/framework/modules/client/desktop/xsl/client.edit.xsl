<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="calendar" />
<xsl:param name="type" />
<xsl:variable name="htmlHeadExtra">
<xsl:call-template name="js.cal" />
<script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script>
</xsl:variable>

<xsl:template name="content">

	<xsl:variable name="object" select="$content/object" />
	
	<div class="row">
		<div class="col-md-12">
		
		<form name="edit" action="{$adminroot}{$config/module/@name}/edit/" method="post">
			<input type="hidden" name="modToken" value="{$modToken}" />
			<input type="hidden" name="id" value="{$object/@id}" />
			<input type="hidden" name="modification_userid" value="{$config/user/@user_id}" />

			<section class="panel">
				<!-- <span class="right">
					 <a href="{$adminroot}{$modName}/return/" class="boton">Volver sin guardar</a>&#xa0;
					 <button type="submit" name="back" value="1" class="boton save-back"><span>Guardar y volver</span></button>&#xa0;
					 <button type="submit" class="boton color"><span>Guardar</span></button>&#xa0;
				 </span> -->
				<header class="panel-heading">Edición</header>
	
				<div class="panel-body">
			
					
					<div class="form-group">
						<label>Nombre</label>
						<input type="text" maxlength="200" name="title" value="{$object/title}" class="form-control" />
					</div>
					<div class="form-group">
						<label>CUIT</label>
						<input type="text" maxlength="200" name="cuit" value="{$object/cuit}" class="form-control" />
					</div>
					<div class="form-group">
						<label>Dirección</label>
						<input type="text" maxlength="200" name="address" value="{$object/address}" class="form-control" />
					</div>
					<div class="form-group">
						<label>Teléfono</label>
						<input type="text" maxlength="200" name="phone" value="{$object/phone}" class="form-control" />
					</div>
					<div class="form-group">
						<label>Email</label>
						<input type="text" maxlength="200" name="email" value="{$object/email}" class="form-control" />
					</div>
					<div class="form-group">
						<label>Website</label>
						<input type="text" maxlength="200" name="website" value="{$object/website}" class="form-control" />
					</div>
					
					<button type="submit" class="btn btn-info">Guardar</button>

			</div>
		</section>

		</form>
	
	</div> 
</div>


</xsl:template>
</xsl:stylesheet>