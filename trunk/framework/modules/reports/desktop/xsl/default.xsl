<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="restaurant_id" />
<xsl:param name="beer_id" />
<xsl:param name="from_date" />
<xsl:param name="to_date" />


<xsl:variable name="htmlHeadExtra"></xsl:variable>


<xsl:template name="content">

<div class="row">
	<div class="col-sm-6">
		<section class="panel">
			<header class="panel-heading">
				Consultas por Proyecto
			</header>
			<div class="panel-body">
				<div class="form-group">
					<label>Fecha de inicio</label>
					<input type="text" class="form-control" />
				</div>
				<div class="form-group">
					<label>Fecha de fin</label>
					<input type="text" class="form-control" />
				</div>
				<div class="form-group">
					<label>Proyecto</label>
					<select class="form-control"><option>seleccionar</option></select>
				</div>
				<div class="form-group">
					<label>Cliente</label>
					<select class="form-control"><option>seleccionar</option></select>
				</div>
				<div class="form-group">
					<label>Tipo</label>
					<select class="form-control"><option>seleccionar</option></select>
				</div>
				<div class="form-group">
					<label>Estado</label>
					<select class="form-control"><option>seleccionar</option></select>
				</div>
				<div class="form-group">
					<button type="submit" class="btn btn-info pull-right">Consultar</button>
				</div>
			</div>
		</section>	
	</div>
	<div class="col-sm-6">
		<section class="panel">
			<header class="panel-heading">
				Consultas por Factura
			</header>
			<div class="panel-body">
				<div class="form-group">
					<label>Fecha de inicio</label>
					<input type="text" class="form-control" />
				</div>
				<div class="form-group">
					<label>Fecha de fin</label>
					<input type="text" class="form-control" />
				</div>
				<div class="form-group">
					<label>Tipo de Factura</label>
					<select class="form-control"><option>seleccionar</option></select>
				</div>
				<div class="form-group">
					<label>Nro de Factura</label>
					<input type="text" class="form-control" />
				</div>
				<div class="form-group">
					<label>Monto</label>
					<input type="text" class="form-control" />
				</div>
				<div class="form-group">
					<label>Partida Asociada</label>
					<select class="form-control"><option>seleccionar</option></select>
				</div>
				<div class="form-group">
					<label>Proveedor</label>
					<select class="form-control"><option>seleccionar</option></select>
				</div>
				<div class="form-group">
					<button type="submit" class="btn btn-info pull-right">Consultar</button>
				</div>
			</div>
		</section>	
	</div>
</div>

<div class="row">
	<div class="col-sm-6">
		<section class="panel">
			<header class="panel-heading">
				Consultas por Partidas
			</header>
			<div class="panel-body">
				<div class="form-group">
					<label>Fecha de inicio</label>
					<input type="text" class="form-control" />
				</div>
				<div class="form-group">
					<label>Proyecto</label>
					<select class="form-control"><option>seleccionar</option></select>
				</div>
				<div class="form-group">
					<label>Estado</label>
					<select class="form-control"><option>seleccionar</option></select>
				</div>
				<div class="form-group">
					<button type="submit" class="btn btn-info pull-right">Consultar</button>
				</div>
			</div>
		</section>	
	</div>
</div>

</xsl:template>
</xsl:stylesheet>