<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="print_type" />

<!-- PROJECT OBJECT -->
<xsl:variable name="object" select="$content/object" />

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
							<h1><xsl:value-of select="$object/title"/></h1>
						</div>
	 					<div class="form-group">
	 						<label class="col-md-3" >Descripción </label>
							<p><xsl:value-of select="$object/description"/></p>
						</div>
						<div class="form-group">
							<label class="col-md-3" >Cliente </label>
							<xsl:value-of select="$content/client/title" />
						</div>
						<div class="form-group">
							<label class="col-md-3" >Tipo</label>
							<xsl:value-of  select="$content/object/type" />
						</div>
						
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


		
		<section class="panel">
			<header class="panel-heading"><h2>Partidas</h2></header>
			<div class="panel-body">
				
				<table class="table table-striped">
					<thead>
						<tr>
							<th>#</th>
							<th>Fecha</th>
							<th>Descripción</th>
							<th>Monto</th>
							<th>Responsable</th>
							<th>Estado</th>
							<th>Progreso</th>
						
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="$content/partidas/partida">
							<tr id="partida_{id}">
								<td><xsl:value-of select="id" /></td>
								<td>
									<xsl:call-template name="fecha.formato.numerico">
										<xsl:with-param name="fecha" select="date" />
									</xsl:call-template>
								</td>
								<td><xsl:value-of select="description" /></td>
								<td>$ <xsl:value-of select="amount" /></td>
								<td><xsl:value-of select="responsable" /></td>
								<td><span class="label label-default label-mini">Pendiente</span></td>
								<td>
									

					                <xsl:value-of select="@progress" />%
					                
								</td>
								
							</tr>
						</xsl:for-each>
						
						
					</tbody>
				</table>
			</div>
		</section>


		

	</div>
</div>
</div>
</body>
</html>




</xsl:template>
</xsl:stylesheet>