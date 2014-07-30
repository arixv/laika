<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />

<xsl:param name="project_id" />
<xsl:param name="rubro_id" />

<xsl:variable name="config" select="/xml/configuration" />
<xsl:variable name="content" select="/xml/content" />
<xsl:variable name="adminroot" select="$config/system/adminpath" />

	<xsl:template match="/xml">
 			<div class="modal-dialog">
		        <div class="modal-content">
		        	<form name="addSubRubro" role="form" action="/admin/?m=project&amp;action=BackEditSubRubro" method="post">
		        		<input type="hidden" name="project_id" value="{$project_id}" />
		        		<input type="hidden" name="rubro_id" value="{$content/subrubro/rubro_id}" />
		        		<input type="hidden" name="subrubro_id" value="{$content/subrubro/subrubro_id}" />
		                <div class="modal-header">
		                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
		                    <h4 class="modal-title">Editar</h4>
		                </div>
		           		<div class="modal-body">
		            		
		            		<div class="form-group">
		                		<label>Concepto</label>
		                		<select name="concept" class="form-control">
		                			<option value="Unidad">Unidad</option>
		                			<option value="Mensual">Mensual</option>
		                			<option value="Diario">Diario</option>
		                			<option value="Global">Global</option>
		                			<option value="Programas">Programas</option>
		                		</select>
		                	</div>

		                	<div class="form-group">
		                		<label>Proveedor</label>
		                		<select name="provider_id" class="form-control">
                        			<option value="0">Seleccionar</option>
                        			<xsl:for-each select="$content/providers/object">
                        				<option value="{@id}">
                        					<xsl:if test="$content/subrubro/provider_id = @id">
                        						<xsl:attribute name="selected">selected</xsl:attribute>
                        					</xsl:if>
                        					<xsl:value-of select="title" />
                        				</option>
                        			</xsl:for-each>
                        		</select>
		                	</div>

		                	<div class="form-group">
		                		<label>Descripción</label>
		                		<textarea name="description" class="form-control" style="height:100px;"><xsl:value-of select="$content/subrubro/description" /></textarea>
		                	</div>

		                	<xsl:choose>
		                		<xsl:when test="$content/project/@state = 0">
				                	<div class="form-group">
				                		<div class="row">
				                			<div class="col-sm-6">
				                				<label>Cantidad Estimada</label>
				                				<input type="text" id="estimate_quantity" name="estimate_quantity" value="{$content/subrubro/estimate_quantity}" class="form-control" />
				                			</div>
						                	<div class="col-sm-6">
						                		<label>Costo Unidad Estimado</label>
						                		<div class="input-group m-bot15">
				                    		    	<span class="input-group-addon btn-success">$</span>
				                        			<input type="text" id="estimate_cost" name="estimate_cost" value="{$content/subrubro/estimate_cost}" class="form-control" />
				                        			<span class="input-group-addon btn-success">.00</span>
				                    			</div>
						                	</div>
						                </div>
						            </div>
								</xsl:when>
								<xsl:otherwise>
										
										<div class="form-group">
					                		<div class="row">
					                			<div class="col-sm-6">
					                				<label>Cantidad Real</label>
					                				<input type="text" id="quantity" name="quantity" value="{$content/subrubro/quantity}" class="form-control" />
					                				<br/>
					                				<strong class="badge bg-info">Cantidad Estimada: <xsl:value-of select="$content/subrubro/estimate_quantity" /></strong>
					                			</div>
							                	<div class="col-sm-6">
							                		<label>Costo Unidad Real</label>
							                		<div class="input-group m-bot15">
					                    		    	<span class="input-group-addon btn-success">$</span>
					                        			<input type="text" id="cost" name="cost" value="{$content/subrubro/cost}" class="form-control" />
					                        			<span class="input-group-addon btn-success">.00</span>
					                    			</div>
							                	</div>
							                </div>
							            </div>

							            <div class="form-group">
					                		<div class="row">
					                			<div class="col-sm-6">
					                				
					                				
					                			</div>
							                	<div class="col-sm-6">
							                		<strong class="badge bg-info">Costo Estimado: <xsl:value-of select="$content/subrubro/estimate_cost" /></strong>
							                	</div>
							                </div>
							            </div>
								</xsl:otherwise>
							</xsl:choose>

		                	<div class="form-group">
		                		<div class="row">
		                			<div class="col-sm-6">
		                				<label>Fecha de Inicio</label>
		                				<div data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date="{$fechaActual}"  class="input-append date dpYears">
			                        		<input type="text" readonly="readonly" name="start_date" value="{$content/subrubro/start_date}" size="16" class="form-control default-date-picker" />
				                        </div>
			                        	

		                			</div>
		                			<div class="col-sm-6">
				                		<label>Fecha de Fin</label>
				                		<div data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date="{$fechaActual}"  class="input-append date dpYears">
			                        		<input type="text" readonly="readonly" name="end_date" value="{$content/subrubro/end_date}" size="16" class="form-control default-date-picker" />
				                        </div>
			                        	<script>
			                        		$('.default-date-picker').datepicker({
										        format: 'yyyy-mm-dd'
										    });
										    $('.dpYears').datepicker();
										</script>
		        		        	</div>
		        		        </div>
		        		    </div>

		                	

						<xsl:if test="$content/project/@state != 0">

		                	<div class="form-group clearfix">
		                		<div class="row">
		                			<div class="col-sm-6">
				                		<label>Cantidad de Pagos</label>

				                		<div id="spinner">
					                		<div class="input-group">
					                			<input type="text" name="payments" id="payments" value="{$content/subrubro/payments}" class="spinner-input form-control" maxlength="2" />
						                		<div class="spinner-buttons input-group-btn">
				                                    <button type="button" class="btn btn-success spinner-up">
				                                        <i class="fa fa-angle-up">&#xa0;</i>
				                                    </button>
				                                    <button type="button" class="btn btn-success spinner-down">
				                                        <i class="fa fa-angle-down">&#xa0;</i>
				                                    </button>
				                                </div>
				                            </div>
										</div>
										<script type="text/javascript">
											$('#spinner').spinner({value:1, min: 1, max: 50});
										</script>
				                	</div>

		                			<div class="col-sm-6">
			                			<label>Forma de Pago</label>
			                			<select name="payment_type" class="form-control">
			                				<option value="Iguales">
			                					<xsl:if test="$content/subrubro/payment_type = 'Iguales'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			                					Iguales
			                				</option>
			                				<option value="Diferentes">
			                					<xsl:if test="$content/subrubro/payment_type = 'Diferentes'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			                					Diferentes
			                				</option>
			                			</select>
				                	</div>
			                	</div>
			                </div>

			                <hr/>


			                <!-- <a href="#" onclick="$('#form_add_pago').slideDown();" class="pull-right btn btn-success btn-sm">Agregar Fecha Pago</a> -->
		                	<h4><a href="#" class="btn btn-success btn-sm pull-right" onclick="PaymentCalendar();" >Generar Calendario Pagos</a> Calendario de Pagos</h4>


		                	<div class="form-group" id="payment_calendar" >

		                		<table class="table table-stripped">
		                			<thead>
		                				<tr>
		                					<th>Nro Pago</th>
		                					<th>Fecha</th>
		                					<th>Valor</th>
		                					<th>Acciones</th>
		                				</tr>
		                			</thead>
		                			<tbody>
		                				<xsl:for-each select="$content/subrubro/payments_list/payment">
			                				<tr id="payment_{position()}">
			                					<td>Pago #<xsl:value-of select="position()" /></td>
			                					<td><input type="text" class="form-control" name="payments_dates" value="{date}"  /></td>
			                					<td><input type="text" class="form-control" name="payments_values" value="{value}"  /></td>
			                					<td>
			                							<a onclick="$('#payment_{position()}').remove();" class="btn btn-default btn-sm">Eliminar</a>
			                					</td>
			                				</tr>
		                				</xsl:for-each>
		                			</tbody>

		                		</table>

		                		

		                	</div>
		                	
		                </xsl:if>
		                	


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