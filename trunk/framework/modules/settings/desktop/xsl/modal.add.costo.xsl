<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />

<xsl:param name="project_id" />
<xsl:param name="partida_id" />
<xsl:param name="redirect" />

<xsl:variable name="config" select="/xml/configuration" />
<xsl:variable name="content" select="/xml/content" />
<xsl:variable name="adminroot" select="$config/system/adminpath" />

	<xsl:template match="/xml">

                <div class="modal-dialog">
                    <div class="modal-content">

                    	<form name="addPartida" role="form" action="{$adminroot}?m={$modName}&amp;action=BackAddCosto" method="post">
                    		<input type="hidden" name="redirect" value="{$adminroot}{$modName}{$redirect}" />

	                        <div class="modal-header">
	                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
	                            <h4 class="modal-title">Agregar Costo Operativo</h4>
	                        </div>
	                        <div class="modal-body">

	                        	<div class="form-group clearfix">
	                        		<div class="row">
	                        			<div class="col-sm-12 col-md-12">
	                        				<label class="">Titulo / Descripción</label>
				                            <input type="text" class="form-control" name="title"  />
				                        </div>
	                        	
	                           			<div class="col-sm-12 col-md-12">
				                        	<label>Monto</label>
			                        		<div class="input-group m-bot15">
		                            		    <span class="input-group-addon btn-success">$</span>
		                                		<input type="text" name="amount" class="form-control" />
		                            		</div>
										</div>

	                        			</div>
	                        	</div>

	                            
	                        </div>
	                        <div class="modal-footer">
	                        	<button class="btn btn-info">Guardar</button>
	                            <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">Cerrar</button>
	                        </div>
	                    </form>
                    </div>
                </div>
	</xsl:template>
</xsl:stylesheet>