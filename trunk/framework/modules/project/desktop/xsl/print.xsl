<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="print_type" />

<!-- PROJECT OBJECT -->
<xsl:variable name="object" select="$content/object" />

<!-- TOTAL ESTIMATE -->
<xsl:variable name="total_estimate">
<xsl:value-of select="$content/estimate/total" />
</xsl:variable>

<!-- IMPREVISTOS -->
<xsl:variable name="total_imprevistos">
<xsl:value-of select="ceiling($total_estimate * $object/imprevistos div 100)" />
</xsl:variable>

<!-- GANANCIAS -->
<xsl:variable name="total_ganancia">
<xsl:value-of select="ceiling(($total_estimate + $total_imprevistos) * $object/ganancia div 100)" />
</xsl:variable>

<!-- IMPUESTOS -->
<xsl:variable name="total_impuestos">
<xsl:value-of select="ceiling(($total_ganancia + $total_imprevistos + $total_estimate) * $object/impuestos div 100)" />
</xsl:variable>

<xsl:variable name="subtotal_neto">
	<xsl:value-of select="$total_estimate + $total_imprevistos + $total_ganancia + $total_impuestos" />
</xsl:variable>

<xsl:variable name="iva"><xsl:value-of select="ceiling($subtotal_neto * $object/iva div 100)" /></xsl:variable>

<!-- HEAD EXTRA -->
<xsl:variable name="htmlHeadExtra">
	<script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script>
	<script src="{$modPath}/desktop/js/project.edit.js" type="text/javascript">&#xa0;</script>
</xsl:variable>

<!-- FOOTER EXTRA -->
<xsl:variable name="htmlFooterExtra">

</xsl:variable>


<xsl:template match="/xml">

<html>
	<head>
		<link rel="stylesheet" type="text/css" href="/framework/modules/admin/desktop/bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="/framework/modules/project/desktop/css/print.css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	</head>
<body>	
	<div class="container">
		<div class="row" >
			<div class="col-md-12">

			<section class="panel">
				<div class="panel-body">
						<div class="form-group" >
							<h1>El Perro en La Luna</h1>
						</div>
						<div class="form-group" >
							<label>Presupuesto&#xa0;</label> <xsl:value-of select="$object/title"/>
						</div>
						<xsl:if test="$content/object/description !='' ">
		 					<div class="form-group">
		 						<label>Descripción&#xa0;</label>
								<xsl:value-of select="$content/object/description"/>
							</div>
						</xsl:if>
						<div class="form-group">
							<label>Cliente&#xa0;</label>
							<xsl:value-of select="$content/client/title" />
						</div>

						<xsl:if test="$content/object/type !='' ">
							<div class="form-group">
								<label>Tipo&#xa0;</label>
								<xsl:value-of  select="$content/object/type" />
							</div>
						</xsl:if>
						
						<xsl:choose>
							<xsl:when test="$content/object/type = 'TV'">
								
								<div class="form-group">
									<label class="col-md-3" >Cantidad de Programas</label>
									<xsl:value-of select="$object/type_option_programas" />
								</div>
								<div class="form-group">
									<label class="col-md-3" >Segundaje de Programas</label>
									<xsl:value-of select="$object/type_option_segundaje" />
								</div>								
							</xsl:when>
							<xsl:when test="$content/object/type = 'Publicidad'">
								
									<div class="form-group">
										<label class="col-md-3" >Producto</label>
										<xsl:value-of select="$content/object/type_option_producto" />
									</div>
									<div class="form-group">
										<label class="col-md-3" >Duración</label>
										<xsl:value-of select="$content/object/type_option_duracion" />
									</div>
									<div class="form-group">
										<label class="col-md-3" >Medio</label>
										<xsl:value-of select="$content/object/type_option_medio" />
									</div>
								
							</xsl:when>
							<xsl:when test="$content/object/type = 'Servicio'">
									<div class="form-group">
										<label class="col-md-3" >Producto</label>
										<xsl:value-of select="$content/object/type_option_tipo_servicio" />
									</div>
							</xsl:when>
						</xsl:choose>
			</div>
		</section>


		<xsl:if test="$print_type!='client'">
			<section class="panel">
				<header class="panel-heading"><h2>Información</h2></header>
					<div class="panel-body">
				
					<div class="form-group">
						<label class="col-md-3" >Estado</label>
						<h4><span class="label label-{$content/states/state[id=$object/@state]/label}"><xsl:value-of select="$content/states/state[id=$object/@state]/name" /></span></h4>
					</div>
					<div class="form-group">
	                	<label class="col-md-3" >Creado por </label> <xsl:value-of select="$content/project_owner/name" />&#xa0;<xsl:value-of select="$content/project_owner/lastname" />
	                </div>

	                <div class="form-group">
	                	<label class="col-md-3" >Fecha Inicio</label>
	                	<xsl:variable name="fechaInicio">
	                		<xsl:choose>
	                			<xsl:when test="$content/object/@start_date = '0000-00-00'"></xsl:when>
	                			<xsl:otherwise><xsl:call-template name="fecha.formato.numerico"><xsl:with-param name="fecha" select="$content/object/@start_date" /></xsl:call-template></xsl:otherwise>
	                		</xsl:choose>
	                	</xsl:variable>
		        			<xsl:value-of select="$fechaInicio" />
	                </div>
	                <div class="form-group">
	                	<label class="col-md-3" >Fecha Fin</label>
	                	<xsl:variable name="fechaFin">
	                		<xsl:choose>
	                			<xsl:when test="$content/object/@end_date = '0000-00-00'"></xsl:when>
	                			<xsl:otherwise><xsl:call-template name="fecha.formato.numerico"><xsl:with-param name="fecha" select="$content/object/@end_date" /></xsl:call-template></xsl:otherwise>
	                		</xsl:choose>
	                	</xsl:variable>
	                	<xsl:value-of select="$fechaFin" />
	                	
	                </div>
				</div>
			</section>
		</xsl:if>

		<section class="panel">
			<header class="panel-heading"><h2>Estimación</h2></header>
			<div class="panel-body">
				<table class="table">
					<tr>
						<td><label>SUBTOTAL RECURSOS</label> </td>
						<td>$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="$content/estimate/total" /></xsl:call-template></td>
					</tr>	
					
					<xsl:if test="$object/@state != 0 and $print_type != 'client'">
						<tr>
							<td><label class="text-danger">SUBTOTAL RECURSOS REAL</label></td>
							<td><b class="text-danger">$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="$content/real/total" /></xsl:call-template></b></td>	
						</tr>	
					</xsl:if>

	                <tr>
						<td><label>Imprevistos</label></td>
						<td>$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="$total_imprevistos" /></xsl:call-template></td>
					</tr>
					<tr>
						<td><label>Ganancia</label></td>
						<td>$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="$total_ganancia" /></xsl:call-template></td>
					</tr>
					<tr>
						<td><label>Impuestos</label></td>
						<td>$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="ceiling($total_impuestos)" /></xsl:call-template></td>
					</tr>

					<tr>
						<td><label>IVA</label></td>
						<td>$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="ceiling($subtotal_neto * $object/iva div 100)" /></xsl:call-template></td>
					</tr>
				

					<tr>
						<td><label>Total</label></td>
						<td><h4 class="">$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="$subtotal_neto + $iva" /></xsl:call-template></h4></td>
					</tr>
				</table>
			</div>
		</section>


		<!-- RECURSOS -->

		<section class="panel">
			<header class="panel-heading"><h2>Recursos</h2></header>
		</section>

			<xsl:for-each select="$content/resources/rubro">
					<section class="panel" id="rubro_{id}" >

						<header class="panel-heading wht-bg">
							<h5>
								<span class="fa fa-arrows-v">&#xa0;</span>
								<xsl:value-of select="title" />
								&#xa0;
								<strong class="badge bg-info">Total Estimado&#xa0;$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="./resources/estimate_total" /></xsl:call-template></strong>
								<xsl:if test="$content/object/@state != 0 and $print_type!='client' " >
									<strong class="badge bg-important">Total Real&#xa0;$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="./resources/total" /></xsl:call-template></strong>
								</xsl:if>
							</h5>
						</header>

						<div class="panel-body">
							<table class="table table-bordered table-striped table-condensed">
								<thead>
									<tr>
										<th>Nombre</th>
										<xsl:if test="$print_type!='client'">
											<th>Proveedor</th>
										</xsl:if>

										<xsl:if test="$content/object/@state != 0 and $print_type != 'client'">
											<th class="numeric" style="background:#E2E2E2;" >Unidades<br/>Estimadas</th>
											<th class="numeric" style="background:#E2E2E2;" >Cantidad<br/>Estimada</th>
											<th class="numeric" style="background:#E2E2E2;" >Costo<br/>Estimado</th>
										</xsl:if>
										<th class="numeric" style="background:#E2E2E2;" >Subtotal<br/>Estimado</th>

										<xsl:if test="$content/object/@state != 0 and $print_type != 'client'">
											<th class="numeric" >Unidades<br/>Real</th>
											<th class="numeric" >Cantidad<br/>Real</th>
											<th class="numeric" >Costo<br/>Real</th>
											<th class="numeric" >Subtotal<br/>Real</th>
										</xsl:if>

									</tr>
								</thead>
								<tbody>
									<xsl:for-each select="./resources/resource">
										<xsl:variable name="thisProvider" select="provider_id" />
										
										<tr id="resource_{resource_id}">
											
											<td><xsl:value-of select="title" /></td>
											
											<xsl:if test="$print_type!='client'">
												<td><xsl:value-of select="$content/providers/object[@id = $thisProvider]/title" /></td>
												<td class="numeric" ><xsl:value-of select="estimate_units" /></td>
												<td class="numeric" ><xsl:value-of select="estimate_quantity" />&#xa0;<xsl:value-of select="concept" /></td>
												<td class="numeric" >$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="estimate_cost" /></xsl:call-template></td>
											</xsl:if>
											
											
											<td class="numeric">$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="estimate_subtotal" /></xsl:call-template></td>
											
											<xsl:if test="$content/object/@state != 0 and $print_type!='client'" >
												<td ><xsl:value-of select="units" /></td>
												<td ><xsl:value-of select="quantity" />&#xa0;<xsl:value-of select="concept" /></td>
												<td class="numeric" >$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="cost" /></xsl:call-template></td>
												<td class="numeric" >$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="subtotal" /></xsl:call-template></td>
											</xsl:if>
											
										</tr>
										<xsl:if test="sindicato_name != '' and $print_type!='client'" >
											<tr>
												<td colspan="4" >
													<p style="text-align:right" ><b>Sindicato:&#xa0;<xsl:value-of select="sindicato_name" />&#xa0;<xsl:value-of select="sindicato_percentage" />%</b></p>
												</td>
												<td>
													$&#xa0;<xsl:call-template name="format.price"><xsl:with-param name="amount" select="(subtotal * sindicato_percentage div 100)" /></xsl:call-template>
												</td>
												<td colspan="3"></td>
											</tr>
										</xsl:if>
									</xsl:for-each>
								</tbody>
							</table>
						</div>
					</section>
				</xsl:for-each>

		<!-- //RECURSOS -->

	</div>
</div>
</div>
<script>print();</script>
</body>
</html>




</xsl:template>
</xsl:stylesheet>