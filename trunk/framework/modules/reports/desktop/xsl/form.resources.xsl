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
		<xsl:with-param name="active">resources</xsl:with-param>
</xsl:call-template>


<div class="row">
	<div class="col-sm-12">
		<section class="panel">
			<header class="panel-heading">
				Consultas por Recursos
			</header>
			<div class="panel-body">
				<div class="position-center">
					<form name="facturas_report" action="{$adminroot}" method="get">
						<input type="hidden" name="m" value="reports" />
						<input type="hidden" name="action" value="BackReportResources" />
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
									<label>Costo Mínimo</label>
									<input type="text" name="min_cost" class="form-control" />
								</div>
								<div class="col-sm-6">
									<label>Costo Máximo</label>
									<input type="text" name="max_cost" class="form-control" />
								</div>
							</div>
						</div>

						<div class="form-group">
							<div class="row">
								<div class="col-sm-6">
									<label>Proveedor</label>
									<select name="providers[]" id="providers" multiple="multiple" class="populate" style="width:100%" >
										<option value="" >Todos</option>
										<xsl:for-each select="$content/providers/object">
											<option value="{@id}"><xsl:value-of select="title" /></option>
										</xsl:for-each>
									</select>	
								</div>
								<div class="col-sm-6">
									<label>Proyecto</label>
									<select name="projects[]" id="projects"  multiple="multiple" class="populate" style="width:100%" >
										<option value="" >Todos</option>
										<xsl:for-each select="$content/projects/object">
											<xsl:sort select="title" ordering="asending" />
											<option value="{@id}"><xsl:value-of select="title" /></option>
										</xsl:for-each>
									</select>
								</div>
							</div>
						</div>

						
						<div class="form-group">
							<div class="row">
								<div class="col-sm-6">
									<label>Subrubro</label>
	                        		<select multiple="multiple" name="subrubros[]" id="subrubros" class="populate" style="width:100%;" >
			                			<option value="">Seleccionar Subrubro</option>
			                			<xsl:for-each select="$content/rubros/rubro">
			                				<xsl:sort select="title" order="ascending" />
			                				<optgroup label="{title}">
			                					<xsl:for-each select="rubros/rubro">
			                						<xsl:sort select="title" order="ascending" />
			                						<option value="{@id}">
			                							<xsl:value-of select="title" />
			                						</option>
			                					</xsl:for-each>
			                				</optgroup>
			                			</xsl:for-each>
			                		</select>
								</div>

								<div class="col-sm-6">
									<label>Sindicato</label>
									<select name="sindicatos[]" id="sindicatos" multiple="multiple" class="populate" style="width:100%">
										<option value="" >Todos</option>
										<xsl:for-each select="$content/sindicatos/sindicato">
											<xsl:sort select="title" ordering="asending" />
											<option value="{id}"><xsl:value-of select="name" /></option>
										</xsl:for-each>
									</select>
								</div>


																
							</div>
						</div>

						<div class="form-group">
							<div class="row">
								<div class="col-sm-6">
									<label>Concepto</label>
									<xsl:call-template name="resource.concept.combo" />
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



<script type="text/javascript">
	$(document).ready(function(){
		$('.default-date-picker').datepicker({format: 'dd-mm-yyyy'});
	    $('.dpYears').datepicker();
		$("#subrubros").select2();
		$("#sindicatos").select2();
		$("#projects").select2();
		$("#providers").select2();
	});
</script>


</xsl:template>
</xsl:stylesheet>