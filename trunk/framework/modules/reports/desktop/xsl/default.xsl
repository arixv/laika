<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="restaurant_id" />
<xsl:param name="beer_id" />
<xsl:param name="from_date" />
<xsl:param name="to_date" />


<xsl:variable name="htmlHeadExtra"></xsl:variable>


<xsl:template name="content">
	<div id="calendar-container"></div>

	<div class="content100" >
		<div class="list-header floatFix">
			<h2 class="techo">
				<xsl:value-of select="$config/module/@title" />
			</h2>
		 	

		</div>

	<div class="box-overflow">

		<div class="grid-list" id="grid">
			<table class="table">
				<tr>
					<td><h3>Reporte de Contactos</h3></td>
					<td><a href="/admin/reports/reporte_contacts" class="btn" ><i class="icon-eye-open">&#xa0;</i> Ver Reporte</a></td>
				</tr>
			</table>

		</div>
	</div>

		
</div>


</xsl:template>
</xsl:stylesheet>