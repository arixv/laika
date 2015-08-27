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
							<h1>Partida #<xsl:value-of select="$content/partida/id" /></h1>
						</div>
						
						

						<div class="form-group">
                			<label>Fecha del pedido</label>
                			<p><xsl:value-of select="$content/partida/date" /></p>
                    	</div>
                    	
						<div class="form-group">
                    		<label>Solicitante</label>
                    		<p><xsl:value-of select="$content/partida/responsable" /></p>
                        </div>

						<div class="form-group">
                    		<label>Descripción</label>
                    		<p><xsl:value-of select="$content/partida/description" /></p>
                    	</div>

                    	<div class="form-group">
                    		<label>Monto</label>
                    		<p>$ <xsl:value-of select="$content/partida/amount" /></p>
                    	</div>

                    	<div class="form-group">
                    		<label>Rendido</label>
                    		<p>$ <xsl:value-of select="$content/partida/@total_facturado" /></p>
                    	</div>

				</div>
		</section>


		
		<section class="panel">
			<header class="panel-heading"><h2>Facturas</h2></header>
			<div class="panel-body">
				
				<table class="table table-striped">
					<thead>
						<tr>
							<th>#</th>
							<th>Fecha</th>
							<th>Descripción</th>
							<th>Monto</th>
							<th>Estado</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="$content/facturas/object">
							<tr id="partida_{id}">
								<td><xsl:value-of select="id" /></td>
								<td>
									<xsl:call-template name="fecha.formato.numerico">
										<xsl:with-param name="fecha" select="date" />
									</xsl:call-template>
								</td>
								<td><xsl:value-of select="description" /></td>
								<td>$ <xsl:value-of select="amount" /></td>
								<td>
									<xsl:choose>
										<xsl:when test="state = 1">
											<span class="label label-success label-mini">PAGADA</span>
										</xsl:when>
										<xsl:when test="state = 0">
											<span class="label label-default label-mini">PENDIENTE</span>
										</xsl:when>
									</xsl:choose>
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