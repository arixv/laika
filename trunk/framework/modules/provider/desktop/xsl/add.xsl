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
					<form name="form"  action="/admin/?m={$config/module/@name}&amp;action=BackAdd" method="post">
						<header class="panel-heading">Agregar </header>
						<div class="panel-body">
							<div class="form-group">
								<label>Nombre</label>
								<input type="text" maxlength="200" name="title" class="form-control" placeholder="Nombre" />
							</div>
							<div class="form-group">
								<label>Descripción</label>
								<textearea name="description" class="form-control" ><xsl:comment /></textarea>
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
							<button class="btn btn-info">Guardar</button>
						</div>
					</form>
				</section>
			</div>
		</div>
		
	

</xsl:template>
</xsl:stylesheet>