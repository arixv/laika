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
		        	<form name="editResource" role="form" action="/admin/?m=project&amp;action=BackEditResource" method="post">
		        		<input type="hidden" name="resource_id" value="{$content/resource/resource_id}" />
		        		<input type="hidden" name="project_id" value="{$project_id}" />
		        		<input type="hidden" name="rubro_id" value="{$content/resource/rubro_id}" />
		        		<input type="hidden" name="subrubro_id" value="{$content/resource/subrubro_id}" />
		                <div class="modal-header">
		                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
		                    <h4 class="modal-title">Editar</h4>
		                </div>
		           		<div class="modal-body">
		            		
		            		
		                	<div class="form-group">
		                		<label>Proveedor</label>
		                		<select name="provider_id" class="form-control">
                        			<option value="0">Seleccionar</option>
                        			<xsl:for-each select="$content/providers/object">
                        				<option value="{@id}">
                        					<xsl:if test="$content/resource/provider_id = @id">
                        						<xsl:attribute name="selected">selected</xsl:attribute>
                        					</xsl:if>
                        					<xsl:value-of select="title" />
                        				</option>
                        			</xsl:for-each>
                        		</select>
		                	</div>

		                	<div class="form-group">
		                		<label>Aclaraciones / Comentarios</label>
		                		<textarea name="description" class="form-control" ><xsl:value-of select="$content/resource/description" /></textarea>
		                	</div>

		                	<xsl:choose>
		                		<xsl:when test="$content/project/@state = 0">
				                	<div class="form-group">
				                		<div class="row">
			                				<div class="col-sm-12">
			                					<hr/>
			                					<h5><b>Valores de Estimación</b></h5>
			                				</div>
			                			</div>
				                		<div class="row">
				                			<div class="col-sm-3">
					                				<label>Unidades</label>
					                				<input type="text" name="estimate_units" class="form-control"  value="{$content/resource/estimate_units}" />
					                		</div>

				                			<div class="col-sm-3">
				                				<label>Cantidad</label>
				                				<input type="text" id="estimate_quantity" name="estimate_quantity" value="{$content/resource/estimate_quantity}" class="form-control" />
				                			</div>

				                			<div class="col-sm-3">

					                			<label>Concepto</label>
					                			<xsl:call-template name="resource.concept.combo">
					                				<xsl:with-param name="concept" select="$content/resource/concept" />
					                			</xsl:call-template>
						                		
						                	</div>

						                	<div class="col-sm-3">
						                		<label>Costo </label>
						                		<div class="input-group m-bot15">
				                    		    	<span class="input-group-addon btn-success">$</span>
				                        			<input type="text" id="estimate_cost" name="estimate_cost" value="{$content/resource/estimate_cost}" class="form-control" />
				                    			</div>
						                	</div>
						                </div>
						            </div>
								</xsl:when>
								<xsl:otherwise>
										
										 <div class="form-group">
											<div class="row">
					                			<div class="col-sm-12">
					                				<hr/>
					                				<h5>Estimación</h5>
					                			</div>
					                		</div>
					                		<div class="row">
					                			<div class="col-sm-4">
					                				<label>Unidades</label>
					                				<input type="text" class="form-control" readonly="readonly" value="{$content/resource/estimate_units}" />
					                			</div>
					                			<div class="col-sm-4">
					                				<label>Cantidad</label>
					                				<input type="text" class="form-control" readonly="readonly" value="{$content/resource/estimate_quantity}" />
					                			</div>
							                	<div class="col-sm-4">
							                		<label>Costo</label>
							                		<input type="text" class="form-control" readonly="readonly" value="{$content/resource/estimate_cost}" />
							                	</div>
							                </div>
							            </div>


										<div class="form-group">
											<div class="row">
					                			<div class="col-sm-12">
					                				<hr/>
					                				<h5>Valores Reales</h5>
					                			</div>
					                		</div>
					                		<div class="row">
					                			<div class="col-sm-4">
					                				<label>Unidad Real</label>
					                				<input type="text" id="units" name="units" value="{$content/resource/units}" class="form-control" />
					                			</div>
					                			<div class="col-sm-4">
					                				<label>Cantidad Real</label>
					                				<input type="text" id="quantity" name="quantity" value="{$content/resource/quantity}" class="form-control" />
					                			</div>
							                	<div class="col-sm-4">
							                		<label>Costo Unidad Real</label>
							                		<div class="input-group m-bot15">
					                    		    	<span class="input-group-addon btn-success">$</span>
					                        			<input type="text" id="cost" name="cost" value="{$content/resource/cost}" class="form-control" />
					                    			</div>
							                	</div>
							                </div>
							            </div>

							           
								</xsl:otherwise>
							</xsl:choose>

		                	<div class="form-group">
		                		<div class="row">
		                			<div class="col-sm-6">
		                				<xsl:variable name="fechaInicio">
		                					<xsl:choose>
		                						<xsl:when test="$content/resource/start_date = '0000-00-00'" ></xsl:when>
		                						<xsl:otherwise>
		                							<xsl:call-template name="fecha.formato.numerico">
		                								<xsl:with-param name="fecha" select="$content/resource/start_date" />
		                							</xsl:call-template>
		                						</xsl:otherwise>
		                					</xsl:choose>
		                				</xsl:variable>
		                				<label>Fecha de Inicio</label>
		                				<div data-date-viewmode="years" data-date-format="dd-mm-yyyy" data-date=""  class="input-append date dpYears">
			                        		<input type="text" name="start_date" value="{$fechaInicio}" size="16" class="form-control default-date-picker" />
				                        </div>
			                        	

		                			</div>
		                			<div class="col-sm-6">
		                				<xsl:variable name="fechaFin">
		                					<xsl:choose>
		                						<xsl:when test="$content/resource/end_date = '0000-00-00'" ></xsl:when>
		                						<xsl:otherwise>
		                							<xsl:call-template name="fecha.formato.numerico"><xsl:with-param name="fecha" select="$content/resource/end_date" /></xsl:call-template>
		                						</xsl:otherwise>
		                					</xsl:choose>
		                				</xsl:variable>
				                		<label>Fecha de Fin</label>
				                		<div data-date-viewmode="years" data-date-format="dd-mm-yyyy" data-date="{$fechaFin}"  class="input-append date dpYears">
			                        		<input type="text"  name="end_date" value="{$fechaFin}" size="16" class="form-control default-date-picker" />
				                        </div>
			                        	<script>
			                        		$('.default-date-picker').datepicker({
										        format: 'dd-mm-yyyy'
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
					                			<input type="text" name="payments" id="payments" value="{$content/resource/payments}" class="spinner-input form-control" maxlength="2" />
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
			                					<xsl:if test="$content/resource/payment_type = 'Iguales'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			                					Iguales
			                				</option>
			                				<option value="Diferentes">
			                					<xsl:if test="$content/resource/payment_type = 'Diferentes'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
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
		                				<xsl:for-each select="$content/resource/payments_list/payment">
		                					<xsl:variable name="paymentDate">
		                						<xsl:call-template name="fecha.formato.numerico">
		                							<xsl:with-param name="fecha" select="date" />
		                						</xsl:call-template>
		                					</xsl:variable>
			                				<tr id="payment_{id}">
			                					<td>Pago #<xsl:value-of select="position()" /></td>
			                					<td>
			                						<div data-date-viewmode="years" data-date-format="dd-mm-yyyy" data-date="{$paymentDate}"  class="input-append date dpYears">
			                        					<input type="text"  name="payments_dates" value="{$paymentDate}" size="16" class="form-control default-date-picker" />
				                     			    </div>
			                					</td>
			                					<td>
			                						<input type="text" class="form-control" name="payments_values" value="{value}"  />
			                					</td>
			                					<td>
			                						<a href="#" data-id="{id}" data-project-id="{project_id}" data-subrubro-id="{subrubro_id}" class="btn btn-default btn-sm btn-delete-payment" >Eliminar</a>
			                					</td>
			                				</tr>
		                				</xsl:for-each>
		                			</tbody>

		                		</table>

		                		<script type="text/javascript">
		                			$('.btn-delete-payment').click(function(e){
		                				e.preventDefault();
		                				var id = $(this).attr("data-id");
		                				var project_id = $(this).attr("data-project-id");

		                				$.ajax({
		                					'url':'/admin/project/delete_payment/'+id+'/project/'+project_id,
		                					'success':function(result){
		                						$('#payment_'+id).remove();
		                					}
		                				});
		                				
		                			});
		                		</script>

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