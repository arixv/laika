<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="active" />
<xsl:param name="from_date" />
<xsl:param name="to_date" />


<xsl:variable name="htmlHeadExtra"></xsl:variable>



<xsl:template name="content">

<xsl:call-template name="reports.navigation">
		<xsl:with-param name="active">facturas</xsl:with-param>
</xsl:call-template>


<div class="row">
	<div class="col-sm-12">
		<section class="panel">
			<header class="panel-heading">
				Consultas por Factura
			</header>
			<div class="panel-body">
				<div class="position-center">
					<form name="facturas_report" action="{$adminroot}" method="get">
						<input type="hidden" name="m" value="reports" />
						<input type="hidden" name="action" value="BackReportFacturas" />
						<div class="form-group">
							<div class="row">
								<div class="col-sm-6">
									<label>Fecha desde</label>
									<div data-date-viewmode="years" data-date-format="dd-mm-yyyy" data-date=""  class="input-append date dpYears">
										<input type="text" name="start_date" size="16" class="form-control default-date-picker" />
									</div>
								</div>
								<div class="col-sm-6">
									<label>Fecha hasta</label>
									<div data-date-viewmode="years" data-date-format="dd-mm-yyyy" data-date=""  class="input-append date dpYears">
										<input type="text" name="end_date" size="16" class="form-control default-date-picker" />
									</div>
								</div>
							</div>
						</div>

					
						<div class="form-group">
							<div class="row">
								<div class="col-sm-6">
									<label>Tipo de Factura</label>
									<xsl:call-template name="factura.type.combo" />
								</div>
								<div class="col-sm-6">
									<label>Nro de Factura</label>
									<input type="text" name="number" class="form-control" />
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<div class="row">
								<div class="col-sm-6">
									<label>Monto</label>
									<input type="text"  class="form-control" />
								</div>
								<div class="col-sm-6">
									<label>Partida Asociada</label>
									<select class="form-control"><option>seleccionar</option></select>
								</div>
							</div>
						</div>

						<div class="form-group">
							<div class="row">
								<div class="col-sm-6">
									<label>Proveedor</label>
									<xsl:call-template name="providers.combo">
										<xsl:with-param name="providers" select="$content/providers" />
									</xsl:call-template>
								</div>
								<div class="col-sm-6">
									<label>Estado</label>
									<select class="form-control"><option>seleccionar</option></select>
								</div>
							</div>
						</div>

						<div class="form-group">
							<div class="row">
								<div class="col-sm-6">
									<label>Rubro</label>
									<select name="rubro_id" class="form-control">
										<option value="0">seleccionar</option>
										<xsl:for-each select="$content/rubros/rubro">
											<option value="{@id}"><xsl:value-of select="title" /></option>
										</xsl:for-each>
									</select>
								</div>
								<div class="col-sm-6">
									<label>Subrubro</label>
									<select class="form-control"><option>seleccionar</option></select>
								</div>
							</div>
						</div>

						<div class="form-group">
							<div class="row">
								<div class="col-sm-6">
									<label>Proyecto</label>
									<select name="project_id" class="form-control">
										<option value="" >Todos</option>
										<xsl:for-each select="$content/projects/object">
											<xsl:sort select="title" ordering="asending" />
											<option value="{@id}"><xsl:value-of select="title" /></option>
										</xsl:for-each>
									</select>
								</div>
								<div class="col-sm-6">
									<label>Creado por</label>
									<select name="creation_userid" class="form-control">
										<option value="" >Seleccionar</option>
										<xsl:for-each select="$content/clients/client">
											<xsl:sort select="title" ordering="asending" />
											<option value="{@id}"><xsl:value-of select="title" /></option>
										</xsl:for-each>
									</select>
								</div>
							</div>
						</div>


						<div class="form-group">
							<button type="submit" class="btn btn-info pull-right">Consultar</button>
						</div>
					</form>
				</div>
			</div>
		</section>	
	</div>
</div>


<script>
	$('.default-date-picker').datepicker({format: 'dd-mm-yyyy'});
    $('.dpYears').datepicker();
</script>


</xsl:template>
</xsl:stylesheet>