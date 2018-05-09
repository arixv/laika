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
		        	<form name="addResource" role="form" action="/admin/?m=project&amp;action=BackAddResource" method="post">
		        		<input type="hidden" name="project_id" value="{$project_id}" />
		        		<input type="hidden" name="rubro_id" value="{$rubro_id}" />
		                <div class="modal-header">
		                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
		                    <h4 class="modal-title">Agregar SubRubro</h4>
		                </div>
		           		<div class="modal-body">
		            		
		           			<div class="form-group clearfix">
		           				
		                		<select name="subrubro_id" id="subrubros" class="populate" style="width:100%;" >
		                			<option value="">Seleccionar SubRubro</option>
		                			<xsl:for-each select="$content/rubros/rubro">
		                				<xsl:sort select="title" order="ascending" />
		                				<optgroup label="{title}">
		                					<xsl:for-each select="rubros/rubro">
		                						<xsl:sort select="title" order="ascending" />
		                						<option value="{@id}"><xsl:value-of select="title" /></option>
		                					</xsl:for-each>
		                				</optgroup>
		                			</xsl:for-each>
		                		</select>
				               <script>
								   $("#subrubros").select2();
								</script>
					             
		                	</div>

		                	<div class="form-group">
		                		<label>Proveedor</label>
		                		<select name="provider_id" class="form-control">
                        			<option value="0">Seleccionar</option>
                        			<xsl:for-each select="$content/providers/object">
                        				<option value="{@id}"><xsl:value-of select="title" /></option>
                        			</xsl:for-each>
                        		</select>
		                	</div>


		                	<div class="form-group">
		                		<label>Aclaraciones / Comentarios</label>
		                		<textarea name="description" class="form-control" ></textarea>
		                	</div>


		               <xsl:choose>

		               		<!-- IF PROJECT IS IN BUDGET STATE -->
		               		<xsl:when test="$content/project/@state = 0">
			                	<div class="form-group">
			                		<div class="row">
			                			<div class="col-sm-12">
			                				<hr/>
			                				<h5>Estimación</h5>
			                			</div>
			                		</div>
			                		<div class="row">
			                			<div class="col-sm-3">
			                				<label>Unidad</label>
			                				<input type="text" id="estimate_units" name="estimate_units" class="form-control" />
			                			</div>
			                			<div class="col-sm-3">
			                				<label>Cantidad</label>
			                				<input type="text" id="estimate_quantity" name="estimate_quantity" class="form-control" />
			                			</div>
			                			<div class="col-sm-3">
					                		<label>Concepto</label>
					                		<xsl:call-template name="resource.concept.combo" />
					                	</div>
			                			<div class="col-sm-3">
					                		<label>Unitario</label>
					                		<div class="input-group m-bot15">
			                    		    	<span class="input-group-addon btn-success">$</span>
			                        			<input type="text" id="estimate_cost" name="estimate_cost" value="" class="form-control" />
			                    			</div>
					                	</div>
			                		</div>
			                	</div>
			                </xsl:when>
			                <!-- // IF PROJECT IS IN BUDGET STATE -->


			                <!-- IF PROJECT IS IN PROGRESS STATE -->
			                <xsl:otherwise>

			                	<input type="hidden" name="estimate_quantity" value="0" />
			                	<input type="hidden" name="estimate_cost" value="0" />

			                	<div class="form-group">
			                		<div class="row">
			                			<div class="col-sm-6">
			                				<label>Cantidad Real</label>
			                				<input type="text" id="quantity" name="quantity" class="form-control" />
			                			</div>
			                			<div class="col-sm-6">
					                		<label>Costo Unidad Real</label>
					                		<div class="input-group m-bot15">
			                    		    	<span class="input-group-addon btn-success">$</span>
			                        			<input type="text" id="cost" name="cost" value="" class="form-control" />
			                        			<span class="input-group-addon btn-success">.00</span>
			                    			</div>
					                	</div>
			                		</div>
			                	</div>
			                </xsl:otherwise>

			                <!-- // IF PROJECT IS IN PROGRESS STATE -->
			            </xsl:choose>


		              <!--   <xsl:if test="$content/project/@state != 0">
		                	
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
						                			<input type="text" id="payments" name="payments" value="" class="spinner-input form-control" maxlength="2" />
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
				                			<select id="payment_type" name="payment_type" class="form-control">
				                				<option value="Iguales">
				                					Iguales
				                				</option>
				                				<option value="Diferentes">
				                					Diferentes
				                				</option>
				                			</select>
					                	</div>
				                	</div>
				                </div>
				         </xsl:if> -->

		                	
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