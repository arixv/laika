<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />

<xsl:param name="project_id" />

<xsl:variable name="config" select="/xml/configuration" />
<xsl:variable name="content" select="/xml/content" />
<xsl:variable name="adminroot" select="$config/system/adminpath" />

	<xsl:template match="/xml">
		<div class="modal-dialog">
			<div class="modal-content">
				<form name="addRubro" role="form" action="/admin/?m=project&amp;action=BackAddRubro" method="post">
	        		<input type="hidden" name="project_id" value="{$project_id}" />
	                <div class="modal-header">
	                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
	                    <h4 class="modal-title">Agregar Rubro</h4>
	                </div>
	                <div class="modal-body">
	                	<div class="form-group">
	                		<label>Rubro</label>
	                		<select name="rubro_id" class="form-control" >
	                			<option value="">Seleccionar</option>
	                			<xsl:for-each select="$content/rubros/rubro">
	                				<option value="{@id}"><xsl:value-of select="title" /></option>
	                			</xsl:for-each>
	                		</select>
	                	</div>
	                	<div class="form-group">
	                		<button type="submit" class="btn btn-info">Guardar</button>

	                	</div>
	                </div>
	             </form>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>