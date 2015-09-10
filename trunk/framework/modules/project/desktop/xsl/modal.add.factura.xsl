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

                    	<form name="addPartida" role="form" action="{$adminroot}?m={$modName}&amp;action=BackAddFactura" method="post">
                    		<input type="hidden" name="project_id" value="{$project_id}" />
                    		<input type="hidden" name="redirect" value="{$adminroot}{$modName}{$redirect}" />

	                        <div class="modal-header">
	                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
	                            <h4 class="modal-title">Agregar Factura</h4>
	                        </div>
	                        <div class="modal-body">

	                        	<div class="form-group clearfix">
	                        		<div class="row">
	                        			<div class="col-sm-6">
	                        				<label class="">Tipo de Factura</label>
				                             <xsl:call-template name="factura.type.combo" />
				                        </div>
	                        	
	                           			<div class="col-sm-6">
				                        	<label>Fecha</label>
				                        	<div data-date-viewmode="years" data-date-format="dd-mm-yyyy" data-date=""  class="input-append date dpYears">
					                        	<input type="text" name="date" size="16" class="form-control default-date-picker" />
					                        </div>
										</div>

				                        	<script>
				                        		$('.default-date-picker').datepicker({
											        format: 'dd-mm-yyyy'
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
			                        				<xsl:variable name="partidaId" ><xsl:value-of select="id" /></xsl:variable>
			                        				<option value="{$partidaId}">
			                        					<xsl:if test="$partidaId = $partida_id" ><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			                        						<xsl:value-of select="description" /> 
			                        				</option>
			                        			</xsl:for-each>
			                        		</select>
			                        	</div>
			                        	<!-- <div class="col-sm-6">
			                        		<label>Proveedor</label>
			                        		<select name="provider_id" class="form-control">
			                        			<option value="0">Seleccionar</option>
			                        			<xsl:for-each select="$content/providers/object">
			                        				<option value="{@id}"><xsl:value-of select="title" /></option>
			                        			</xsl:for-each>
			                        		</select>
			                        	</div> -->
			                        </div>
	                        	</div>

	                    
	                        	<div class="form-group">
	                        		<div class="row">
	                        			<div class="col-sm-6">
	                        				<label>Estado</label>
			                        		<select name="state" class="form-control">
			                        			<option value="">Seleccionar</option>
			                        			<option value="0">Pendiente</option>
			                        			<option value="1" selected="selected" >Pagada</option>
			                        		</select>
			                        	</div>
			                        	<div class="col-sm-6">
			                        		<label>Recurso</label>
			                        		<select name="resource_id" id="resources" class="populate" style="width:100%;" >
					                			<option value="">Seleccionar Recurso</option>
					                			<xsl:for-each select="$content/rubros/rubro">
					                				<xsl:sort select="title" order="ascending" />
					                				<optgroup label="{title}">
					                					<xsl:for-each select="resources/resource">
					                						<xsl:sort select="title" order="ascending" />
					                						<xsl:variable name="providerId" select="provider_id" />
					                						<option value="{resource_id}">
					                							<xsl:value-of select="title" /> (<xsl:value-of select="$content/providers/object[@id=$providerId]/title" />)
					                						</option>
					                					</xsl:for-each>
					                				</optgroup>
					                			</xsl:for-each>
					                		</select>
							               <script>
											   $("#resources").select2();
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