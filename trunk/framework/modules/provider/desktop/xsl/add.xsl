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

		<div class="row">
			<div class="col-md-12">
				<section class="panel">
					<form name="form"  action="/admin/?m={$config/module/@name}&amp;action=BackAdd" method="post">
						<header class="panel-heading">Agregar </header>
						<div class="panel-body">
							<div class="form-group">
								<select name="subrubro_id" id="subrubros" class="populate" style="width:100%;" >
		                			<option value="">Seleccionar SubRubro</option>
		                			<xsl:for-each select="$content/rubros/rubro">
		                				<xsl:sort select="title" order="ascending" />
		                				<optgroup label="{title}">
		                					<xsl:for-each select="rubros/rubro">
		                						<xsl:sort select="title" order="ascending" />
		                						<option value="{@id}"><xsl:value-of select="title" /></option>
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
								<input type="text" maxlength="200" name="title" class="form-control" placeholder="Nombre" />
							</div>
							<div class="form-group">
								<label>Descripción</label>
								<input type="text" name="description" class="form-control" />
							</div>
							<div class="form-group">
								<label>CUIT</label>
								<input type="text" maxlength="200" name="cuit" placeholder="CUIT" class="form-control" />
							</div>
							<div class="form-group">
								<label>Categoría</label>
								<select name="category" class="form-control">
									<option value="Inscripto">Responsable Inscripto</option>
									<option value="Excento">Excento</option>
									<option value="Monotributista">Monotributista</option>
								</select>
							</div>
							<div class="form-group">
								<label>Dirección</label>
								<input type="text" maxlength="200" name="address" placeholder="Dirección" class="form-control" />
							</div>
							<div class="form-group">
								<label>Teléfono</label>
								<input type="text" maxlength="200" name="phone" placeholder="Telefono" class="form-control" />
							</div>
							<div class="form-group">
								<label>Email</label>
								<input type="text" maxlength="200" name="email" placeholder="Email" class="form-control" />
							</div>
							<div class="form-group">
								<label>Website</label>
								<input type="text" maxlength="200" name="website" placeholder="Website" class="form-control" />
							</div>
							<div class="form-group">
								<label>Estado</label>
								<select class="form-control" name="state">
									<option value="1" >Activo</option>
									<option value="0" >Inactivo</option>
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