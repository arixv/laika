<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="restaurant_id" />
<xsl:param name="beer_id" />
<xsl:param name="from_date" />
<xsl:param name="to_date" />


<xsl:variable name="htmlHeadExtra"></xsl:variable>


<xsl:template name="content">


<div class="col-sm-12">
	<section class="panel">
		<header class="panel-heading">
			<xsl:value-of select="$config/module/@title" />
		</header>
		<div class="panel-body">

			<table class="table">
				<tr>
					<td><h3>Reportes</h3></td>
					<td><a href="/admin/reports/reporte_contacts" class="btn btn-primary" ><i class="fa fa-eye">&#xa0;</i> Ver Reporte</a></td>
				</tr>
			</table>
		</div>
	</section>	
</div>


</xsl:template>
</xsl:stylesheet>