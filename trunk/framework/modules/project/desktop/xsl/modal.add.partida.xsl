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
                    	<form name="addPartida" role="form" action="/admin/?m=project&amp;action=BackAddPartida" method="post">
                    		<input type="hidden" name="project_id" value="{$object/@id}" />
	                        <div class="modal-header">
	                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
	                            <h4 class="modal-title">Agregar Partida</h4>
	                        </div>
                       		<div class="modal-body">
                        		
	                        	<div class="form-group">
	                        		<label>Descripción</label>
	                        		<input type="text" name="description" class="form-control" />
	                        	</div>

	                        	<div class="form-group">
	                        		<label>Monto</label>
	                        		<input type="text" name="amount" class="form-control" />
	                        	</div>
	                        	<div class="form-group">
	                        		<label>Responsable</label>
	                        		<input type="text" name="responsable" class="form-control" />
	                        	</div>

	                        	<div class="form-group">
	                        		<label>Fecha</label>
	                        		<input type="text" name="fecha" class="form-control" />
	                        	</div>
	                        </div>
	                        <div class="modal-footer">
	                        	<button type="submit"  class="btn btn-info">Guardar</button>
	                            <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">Cerrar</button>
	                        </div>
                        </form>
                    </div>
                </div>

	</xsl:template>
</xsl:stylesheet>