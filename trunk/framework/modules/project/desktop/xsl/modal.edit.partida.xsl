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
	                        		<label>Fecha del pedido</label>
	                        		<div data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date="{$content/partida/date}"  class="input-append date dpYears" >
		                        			<input type="text" readonly="readonly" value="{$content/partida/date}" name="date" size="16" class="form-control default-date-picker" />
		                        	</div>
		                        	
		                        	<script>
		                        		$('.default-date-picker').datepicker({
									        format: 'yyyy-mm-dd'
									    });
									    $('.dpYears').datepicker();
									</script>
	                        	</div>

                        		<div class="form-group">
	                        		<label>Solicitante</label>
	                        		<input type="text" name="responsable" value="{$content/partida/responsable}" class="form-control" />
	                        	</div>

	                        	<div class="form-group">
	                        		<label>Descripción</label>
	                        		<textarea name="description"  class="form-control" style="height:150px;"><xsl:value-of select="$content/partida/description" /></textarea>
	                        	</div>

	                        	<div class="form-group">
	                        		<label>Monto</label>
	                        		<div class="input-group m-bot15">
                            		    <span class="input-group-addon btn-success">$</span>
                                		<input type="text" name="amount" value="{$content/partida/amount}" class="form-control" />
                                		<span class="input-group-addon btn-success">.00</span>
                            		</div>
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