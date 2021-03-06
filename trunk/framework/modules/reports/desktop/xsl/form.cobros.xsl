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
		<xsl:with-param name="active">cobros</xsl:with-param>
</xsl:call-template>


<div class="row">
	<div class="col-sm-12">
		<section class="panel">
			<header class="panel-heading">
				Consultas por Cobros
			</header>
			<div class="panel-body">
				<div class="position-center">
					<form name="cobros_report" action="{$adminroot}" method="get">
						<input type="hidden" name="m" value="reports" />
						<input type="hidden" name="action" value="BackReportCobros" />
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
									<label>Tipo</label>
									<xsl:call-template name="factura.type.combo" />
								</div>
								<div class="col-sm-6">
									<label>Nro</label>
									<input type="text" name="number" class="form-control" />
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<div class="row">
								<div class="col-sm-6">
									<label>Monto Minimo</label>
									<input type="text" name="min_amount"  class="form-control" />
								</div>
								<div class="col-sm-6">
									<label>Monto Maximo</label>
									<input type="text" name="max_amount"  class="form-control" />
								</div>
							</div>
						</div>

						<div class="form-group">
							<div class="row">
								<div class="col-sm-6">
									<label>Estado</label>
									<select class="form-control" name="state">
										<option value="" >seleccionar</option>
										<option value="0" >Pendiente</option>
										<option value="1" >Pagada</option>
									</select>
								</div>
							</div>
						</div>

						<div class="form-group">
							<div class="row">
								
								<div class="col-sm-6">
									<label>Creado Por</label>
									<select name="creation_userid" class="form-control">
										<option value="" >seleccionar</option>
										<xsl:for-each select="$content/users/user">
											<xsl:sort select="title" order="ascending" />
											<option  value="{@user_id}">
												<xsl:value-of select="username" />
											</option>
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