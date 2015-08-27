<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="active" />
<xsl:param name="from_date" />
<xsl:param name="to_date" />



<xsl:variable name="htmlHeadExtra">
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/jquery-multi-select/css/multi-select.css" />
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/select2/select2.css" />
</xsl:variable>


<xsl:variable name="htmlFooterExtra">
	<script type="text/javascript" src="{$adminPath}/desktop/js/fuelux/js/spinner.min.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery-multi-select/js/jquery.multi-select.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery-multi-select/js/jquery.quicksearch.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/select2/select2.js">&#xa0;</script>
</xsl:variable>




<xsl:template name="content">

<xsl:call-template name="reports.navigation">
		<xsl:with-param name="active">providers</xsl:with-param>
</xsl:call-template>


<div class="row">
	<div class="col-sm-12">
		<section class="panel">
			<header class="panel-heading">
				Consultas por Proveedores
			</header>
			<div class="panel-body">
				<div class="position-center">
					<form name="facturas_report" action="{$adminroot}" method="get">
						<input type="hidden" name="m" value="reports" />
						<input type="hidden" name="action" value="BackReportProviders" />
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
									<label>Proveedor</label>
									<xsl:call-template name="providers.combo">
										<xsl:with-param name="providers" select="$content/providers" />
										<xsl:with-param name="multiple_select" select="'1'" />
									</xsl:call-template>
								</div>
								<div class="col-sm-6">
									<label>Proyecto</label>
									<xsl:call-template name="projects.combo">
										<xsl:with-param name="providers" select="$content/projects" />
										<xsl:with-param name="multiple_select" select="'1'" />
									</xsl:call-template>
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
							<button type="submit" class="btn btn-info pull-right">Consultar</button>
						</div>
					</form>
				</div>
			</div>
		</section>	
	</div>
</div>


<script type="text/javascript" >
	$(document).ready(function(){
		$('.default-date-picker').datepicker({format: 'dd-mm-yyyy'});
    	$('.dpYears').datepicker();
    	$("#provider").select2();
    	$("#project").select2();
	});
	
</script>


</xsl:template>
</xsl:stylesheet>