<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="universidad_id" />
<xsl:param name="from_date" />
<xsl:param name="to_date" />


<xsl:variable name="htmlHeadExtra">
	<xsl:call-template name="js.cal" />
	<script type="text/javascript" src="{$adminPath}/desktop/js/module.list.js">&#xa0;</script>
	<script type="text/javascript" src="{$modPath}/desktop/js/reports.js">&#xa0;</script>
</xsl:variable>


<xsl:template name="content">
	<div id="calendar-container"></div>

	<div class="content100" >
		<div class="list-header floatFix">
			<h2 class="techo">
				Reporte de Contactos
			</h2>

			<div class="list-tools floatFix">

				<a href="/admin/{$config/module/@name}" class="btn left " style="margin-right:10px;"><i class="icon-chevron-left">&#xa0;</i>&#xa0;Volver</a>




			 	<form method="get" class="form-inline" action="{$adminroot}{$modulename}/reporte_contacts/">
			 		<input type="hidden" name="search" value="1" />
		                <select name="universidad" style="width:120px;">
							<option value="">-Todas las Universidades-</option>
							<xsl:for-each select="$content/universities/object">
								<option value="{@id}">
									<xsl:if test="@id=$universidad_id"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="title" />
								</option>
							</xsl:for-each>
						</select>

	                	<input type="text"  class="input-small" id="from_date" name="from_date" value="{$from_date}" placeholder="Fecha Inicio" />
	                	<a href="#" id="from_date_trigger" class="btn" style="display:inline-block;margin-left:-5px;margin-right:5px;" onclick="return false;">
	                        <i class="icon icon-calendar">&#xa0;</i>
	                     </a>
	                
	                	<input type="text"  class="input-small" id="to_date" name="to_date" value="{$to_date}"  placeholder="Fecha Fin"/>
	                	<a href="#" id="to_date_trigger" class="btn" style="display:inline-block;margin-left:-5px;margin-right:5px;" onclick="return false;">
	                        <i class="icon icon-calendar">&#xa0;</i>
	                     </a>
	                
	              	<button class="btn btn-inverse"><i class="icon-filter icon-white">&#xa0;</i>&#xa0;Filtrar</button>

	              	<xsl:if test="$content/report/item">
	              		<a href="/admin/{$config/module/@name}/report_contacts_download/?universidad={$universidad_id}&amp;from_date={$from_date}&amp;to_date={$to_date}" class="btn btn-inverse" style="margin-left:20px;">
							<i class="icon-download icon-white">&#xa0;</i>&#xa0;Descargar
						</a>
					</xsl:if>
				</form>




			</div>

		</div>

	<div class="box-overflow">

		<xsl:if test="$content/report/item">

			<div class="grid-list" id="grid">
					<table class="table">
						<thead>
							<th>Nombre</th>
							<th>Apellido</th>
							<th>Email</th>
							<th>Phone</th>
							<th>Ubicación</th>
							<th>Comentario</th>
							<th>Newsletter</th>
							<th>Carrera</th>
							<th>Tipo</th>
							<th>Universidad</th>
							<th>Fecha</th>
						</thead>
						<xsl:for-each select="$content/report/item">
							<tr class="floatFix">
								<td><xsl:value-of select="contact_name" /></td>
								<td><xsl:value-of select="contact_lastname" /></td>
								<td><xsl:value-of select="contact_email" /></td>
								<td><xsl:value-of select="contact_phone" /></td>
								<td><xsl:value-of select="sublocation_name" />, <xsl:value-of select="location_name" /></td>
								<td><xsl:value-of select="contact_comment" /></td>
								<td><xsl:value-of select="recibir_newsletter" /></td>
								<td><xsl:value-of select="carrera_title" /></td>
								<td><xsl:value-of select="carrera_type_name" /></td>
								<td><xsl:value-of select="universidad_title" /></td>
								<td><xsl:value-of select="contact_date" /></td>

							</tr>
						</xsl:for-each>
						
					</table>
			</div>
		</xsl:if>

	</div>

		
</div>


</xsl:template>
</xsl:stylesheet>