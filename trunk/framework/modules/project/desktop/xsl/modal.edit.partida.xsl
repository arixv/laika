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
                    	<form name="addPartida" role="form" action="/admin/?m=project&amp;action=BackEditPartida" method="post">
                    		<input type="hidden" name="project_id" value="{$project_id}" />
                    		<input type="hidden" name="partida_id" value="{$content/partida/id}" />
	                        <div class="modal-header">
	                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
	                            <h4 class="modal-title">Agregar Partida</h4>
	                        </div>
                       		<div class="modal-body">
                        		
	                        	<div class="form-group">
	                        		<label>Descripción</label>
	                        		<input type="text" name="description" value="{$content/partida/description}" class="form-control" />
	                        	</div>

	                        	<div class="form-group">
	                        		<label>Monto</label>
	                        		<input type="text" name="amount" value="{$content/partida/amount}" class="form-control" />
	                        	</div>
	                        	<div class="form-group">
	                        		<label>Responsable</label>
	                        		<input type="text" name="responsable" value="{$content/partida/responsable}" class="form-control" />
	                        	</div>

	                        	<div class="form-group">
	                        		<label>Fecha</label>
	                        		<input type="text" name="date" value="{$content/partida/date}" class="form-control" />
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