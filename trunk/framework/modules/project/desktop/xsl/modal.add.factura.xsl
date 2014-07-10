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

                    	<form name="addPartida" role="form" action="/admin/?m=project&amp;action=BackAddFactura" method="post">
                    		<input type="hidden" name="project_id" value="{$project_id}" />

	                        <div class="modal-header">
	                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
	                            <h4 class="modal-title">Agregar Factura</h4>
	                        </div>
	                        <div class="modal-body">

	                        	<div class="form-group clearfix">
	                        		<div class="row">
	                        			<div class="col-sm-6">
	                        				<label class="">Tipo de Factura</label>
				                             <select name="type" class="form-control">
			                        			<option value="A">A</option>
			                        			<option value="B">B</option>
			                        			<option value="C">C</option>
			                        			<option value="Ticket">Ticket</option>
			                        			<option value="Sin Comprobante">Sin Comprobante</option>
			                        		</select> 
				                        </div>
	                        	
	                           			<div class="col-sm-6">
				                        	<label>Fecha</label>
				                        	<div data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date=""  class="input-append date dpYears">
					                        		<input type="text" readonly="readonly" name="date" size="16" class="form-control default-date-picker" />
					                        		</div>
					                        	</div>

				                        	<script>
				                        		$('.default-date-picker').datepicker({
											        format: 'yyyy-mm-dd'
											    });
											    $('.dpYears').datepicker();
											</script>
	                        			</div>
	                        	</div>

	                        	<div class="form-group">
	                        		<div class="row">
		                        		<div class="col-sm-6">
		                        			<label>Número</label>
		                        			<input type="text" name="number" class="form-control" />
		                        		</div>
		                        		<div class="col-sm-6">
		                        	    	<label>Monto</label>
			                        		<div class="input-group m-bot15">
		                            		    <span class="input-group-addon btn-success">$</span>
		                                		<input type="text" name="amount" class="form-control" />
		                                		<span class="input-group-addon btn-success">.00</span>
		                            		</div>
		                            	</div>
		                            </div>
	                        	</div>

	                        	<div class="form-group">
	                        		<label>Descripción</label>
	                        		<textarea name="description" class="form-control" style="height:150px" ></textarea>
	                        	</div>


	                        	<div class="form-group">
	                        		<div class="row">
	                        			<div class="col-sm-6">
	                        				<label>Partida Asociada</label>
			                        		<select name="partida_id" class="form-control">
			                        			<option value="0">Seleccionar</option>
			                        			<xsl:for-each select="$content/partidas/partida">
			                        				<option value="{id}"><xsl:value-of select="description" /></option>
			                        			</xsl:for-each>
			                        		</select>
			                        	</div>
			                        	<div class="col-sm-6">
			                        		<label>Proveedor</label>
			                        		<select name="provider_id" class="form-control">
			                        			<option value="0">Seleccionar</option>
			                        			<xsl:for-each select="$content/providers/object">
			                        				<option value="{@id}"><xsl:value-of select="title" /></option>
			                        			</xsl:for-each>
			                        		</select>
			                        	</div>
			                        </div>
	                        	</div>

	                    
	                        	<div class="form-group">
	                        		<div class="row">
	                        			<div class="col-sm-6">
	                        				<label>Estado</label>
			                        		<select name="state" class="form-control">
			                        			<option value="">Seleccionar</option>
			                        			<option value="0">Pendiente</option>
			                        			<option value="1">Pagada</option>
			                        		</select>
			                        	</div>
			                        	<div class="col-sm-6">
			                        		<label>Rubro</label>
			                        		<select name="subrubro_id" id="subrubros" class="populate" style="width:100%;" >
					                			<option value="">Seleccionar SubRubro</option>
					                			<xsl:for-each select="$content/rubros/rubro">
					                				<xsl:sort select="title" order="ascending" />
					                				<optgroup label="{title}">
					                					<xsl:for-each select="subrubros/subrubro">
					                						<xsl:sort select="title" order="ascending" />
					                						<option value="{subrubro_id}"><xsl:value-of select="title" /></option>
					                					</xsl:for-each>
					                				</optgroup>
					                			</xsl:for-each>
					                		</select>
							               <script>
											   $("#subrubros").select2();
											</script>
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