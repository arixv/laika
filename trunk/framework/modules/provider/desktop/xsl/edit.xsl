<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="calendar" />
<xsl:param name="type" />


<xsl:variable name="htmlHeadExtra">
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/jquery-multi-select/css/multi-select.css" />
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/select2/select2.css" />
	<script type="text/javascript" src="{$adminPath}/desktop/js/fuelux/js/spinner.min.js"></script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery-multi-select/js/jquery.multi-select.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery-multi-select/js/jquery.quicksearch.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/select2/select2.js">&#xa0;</script>
</xsl:variable>

<xsl:template name="content">


		<div class="row" >
			<div class="col-sm-12">
					<section class="panel">
						<header class="panel-heading wht-bg">
							<h4 class="gen-case">Editar Proveedor</h4>
						</header>
					</section>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<section class="panel">
					<form name="form"  action="/admin/?m={$config/module/@name}&amp;action=BackEdit" method="post">
						<input type="hidden" name="id" value="{$content/object/@id}" />
						<header class="panel-heading">Editar </header>
						<div class="panel-body">

							<div class="form-group">
								<select name="subrubro_id" id="subrubros" class="populate" style="width:100%;" >
		                			<option value="">Seleccionar SubRubro</option>
		                			<xsl:for-each select="$content/rubros/rubro">
		                				<xsl:sort select="title" order="ascending" />
		                				<optgroup label="{title}">
		                					<xsl:for-each select="rubros/rubro">
		                						<xsl:sort select="title" order="ascending" />
		                						<xsl:variable name="rubroId" select="@id" />
		                						<option value="{@id}">
		                							<xsl:if test="$rubroId = $content/object/@subrubro_id" >
		                								<xsl:attribute name="selected">selected</xsl:attribute>
		                							</xsl:if>
		                							<xsl:value-of select="title" />
		                						</option>
		                					</xsl:for-each>
		                				</optgroup>
		                			</xsl:for-each>
		                		</select>
				               <script>
								   $("#subrubros").select2();
								</script>
							</div>
							
							<div class="form-group">
								<label>Nombre</label>
								<input type="text" maxlength="200" name="title" class="form-control" value="{$content/object/title}" />
							</div>
							<div class="form-group">
								<label>Descripción</label>
								<textarea name="description" class="form-control" ><xsl:value-of select="$content/object/description" /><xsl:comment /></textarea>
							</div>
							<div class="form-group">
								<label>CUIT</label>
								<input type="text" maxlength="200" name="cuit" value="{$content/object/cuit}"  class="form-control" />
							</div>
							
							<div class="form-group">
								<label>Categoría AFIP</label>
								<select name="category" class="form-control" >
									<option value="">Seleccionar</option>
									<option value="Inscripto">
										<xsl:if test="$content/object/category = 'Inscripto'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
										Responsable Inscripto
									</option>
									<option value="Excento">
										<xsl:if test="$content/object/category = 'Excento'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
										Excento
									</option>
									<option value="Monotributista">
										<xsl:if test="$content/object/category = 'Monotributista'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
										Monotributista
									</option>
								</select>
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
							<div class="form-group">
								<label>Estado</label>
								<select class="form-control" name="state">
									<option value="0" >
										<xsl:if test="$content/object/@state = 0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
										Inactivo
									</option>
									<option value="1" ><xsl:if test="$content/object/@state = 1"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Activo</option>
								</select>
							</div>
							<button class="btn btn-info">Guardar</button>
						</div>
					</form>
				</section>
			</div>
		</div>
		
	

</xsl:template>
</xsl:stylesheet>