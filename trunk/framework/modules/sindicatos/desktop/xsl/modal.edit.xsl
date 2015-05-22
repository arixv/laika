<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />



<xsl:variable name="config" select="/xml/configuration" />
<xsl:variable name="content" select="/xml/content" />
<xsl:variable name="adminroot" select="$config/system/adminpath" />

	<xsl:template match="/xml">
		<div class="modal-dialog">
			<div class="modal-content">
				<form name="addRubro" role="form" action="/admin/?m=sindicatos&amp;action=BackEdit" method="post">
	        		<input type="hidden" name="id" value="{$content/sindicato/id}" />
	                <div class="modal-header">
	                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
	                    <h4 class="modal-title">Editar Sindicato</h4>
	                </div>
	                <div class="modal-body">
	                	<div class="form-group">
	                		<label>Nombre</label>
	                		<input type="text" name="name" value="{$content/sindicato/name}" class="form-control" />
	                	</div>
	                	<div class="form-group">
	                		<label>Porcentaje</label>
	                		<input type="text" name="percentage" value="{$content/sindicato/percentage}" class="form-control" />
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