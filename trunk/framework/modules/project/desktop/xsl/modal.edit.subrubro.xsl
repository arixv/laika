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
		                		<label>Descripción</label>
		                		<textarea name="description" class="form-control" style="height:100px;"><xsl:value-of select="$content/subrubro/description" /></textarea>
		                	</div>

		                	<div class="form-group">
		                		<div class="row">
		                			<div class="col-sm-6">
		                				<label>Cantidad</label>
		                				<input type="text" name="quantity" value="{$content/subrubro/quantity}" class="form-control" />
		                			</div>
				                	<div class="col-sm-6">
				                		<label>Costo Unidad</label>
				                		<div class="input-group m-bot15">
		                    		    	<span class="input-group-addon btn-success">$</span>
		                        			<input type="text" name="cost" value="{$content/subrubro/cost}" class="form-control" />
		                        			<span class="input-group-addon btn-success">.00</span>
		                    			</div>
				                	</div>
				                </div>
				            </div>

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

		                	


		                	<div class="form-group clearfix">
		                		<div class="row">
		                			<div class="col-sm-6">
				                		<label>Cantidad de Pagos</label>

				                		<div id="spinner">
					                		<div class="input-group">
					                			<input type="text" name="payments" value="{$content/subrubro/payments}" class="spinner-input form-control" maxlength="2" />
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

		                	<div class="form-group">
		                		<h4>Calendario de Pagos</h4>
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
		                				<tr>
		                					<td>Pago #1</td>
		                					<td>2014-06-17</td>
		                					<td>$ 100</td>
		                					<td>
		                						<div class="btn-group">
		                							<button class="btn btn-default btn-sm">Editar</button>
		                							<button class="btn btn-default btn-sm">Eliminar</button>
		                						</div>
		                					</td>
		                				</tr>
		                				<tr>
		                					<td>Pago #2</td>
		                					<td>2014-06-17</td>
		                					<td>$ 100</td>
		                					<td>
		                						<div class="btn-group">
		                							<button class="btn btn-default btn-sm">Editar</button>
		                							<button class="btn btn-default btn-sm">Eliminar</button>
		                						</div>
		                					</td>
		                				</tr>
		                				<tr>
		                					<td>&#xa0;</td>
		                					<td>&#xa0;</td>
		                					<td>&#xa0;</td>
		                					<td>
	                							<button class="btn btn-success btn-sm">Agregar Fecha Pago</button>
		                					</td>
		                				</tr>
		                			</tbody>
		                		</table>

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