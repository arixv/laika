<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="type" />

<!-- HEAD EXTRA -->
<xsl:variable name="htmlHeadExtra">
	<script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script>
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/jquery-multi-select/css/multi-select.css" />
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/select2/select2.css" />
	<script type="text/javascript" src="{$adminPath}/desktop/js/select2/select2.js">&#xa0;</script>
</xsl:variable>

<!-- FOOTER EXTRA -->
<xsl:variable name="htmlFooterExtra">

</xsl:variable>


<xsl:template name="content">

<div class="row">
		<div class="col-sm-12">		
			<ul class="breadcrumb">
		        <li ><a href="{$adminroot}{$modName}/list/"><i class="fa fa-home">&#xa0;</i> Ir al listado de Cobros</a></li>
		    </ul>
		</div>
</div>

<form name="editCobro" role="form" action="/admin/?m=cobros&amp;action=BackEdit" method="post">
	<input type="hidden" name="id" value="{$content/cobro/id}" />
					<div class="row" >
						<div class="col-sm-12">
								<section class="panel">
									<header class="panel-heading wht-bg">
										<div class="form-group">
											<button type="submit" class="btn btn-info pull-right">Guardar</button>
										</div>
										<h4 class="gen-case">Editar Cobro</h4>
									</header>
									<div class="panel-body">
										<div class="form-group">
						<div class="row">

							<div class="col-sm-6">
								<label>Tipo</label>
				        		<select name="type" class="form-control">
				        			<option value="A">
				        				<xsl:if test="$content/cobro/type = 'A'" ><xsl:attribute name="selected" >selected</xsl:attribute></xsl:if>
				        				A
				        			</option>
				        			<option value="B">
				        				<xsl:if test="$content/cobro/type = 'B'" ><xsl:attribute name="selected" >selected</xsl:attribute></xsl:if>
				        				B
				        			</option>
				        			<option value="C">
				        				<xsl:if test="$content/cobro/type = 'C'" ><xsl:attribute name="selected" >selected</xsl:attribute></xsl:if>
				        				C
				        			</option>
				        			<option value="Ticket">
				        				<xsl:if test="$content/cobro/type = 'Ticket'" ><xsl:attribute name="selected" >selected</xsl:attribute></xsl:if>
				        				Ticket
				        			</option>
				        		</select>
							</div>

							<div class="col-sm-6">
				            	<label>Fecha</label>

				               <!--  <xsl:variable name="$thisfecha">
				                    <xsl:call-template name="fecha.formato.numerico">
				                        <xsl:with-param name="fecha" select="$content/cobro/date" />
				                    </xsl:call-template>
				                </xsl:variable> -->
				                
				            	<div data-date-viewmode="years" data-date-format="dd-mm-yyyy" data-date=""  class="input-append date dpYears">
				                    <xsl:variable name="date">
				                        <xsl:call-template name="fecha.formato.numerico">
				                            <xsl:with-param name="fecha" select="$content/cobro/date" />
				                        </xsl:call-template>
				                    </xsl:variable>
				                		<input type="text" readonly="readonly" name="date" value="{$date}" size="16" class="form-control default-date-picker" />
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

					<div class="form-group">
						<div class="row">

				    		<div class="col-sm-6">
				    				<label>Número</label>
				    				<input type="text" name="number" value="{$content/cobro/number}" class="form-control" />
				    		</div>

				    		<div class="col-sm-6">
				        		<label>Monto</label>
				        		<div class="input-group m-bot15">
				    		    	<span class="input-group-addon btn-success">$</span>
				        			<input type="text" name="amount" value="{$content/cobro/amount}" class="form-control" />
				        			<span class="input-group-addon btn-success">.00</span>
				    			</div>
				        	</div>
				        </div>
					</div>

					<div class="form-group">
						<div class="row">
							<div class="col-sm-6">
				        		<label>Estado </label> 
				        		<select name="state" class="form-control">
				        			<option value="">Seleccionar</option>
				        			<option value="0">
				        				<xsl:if test="$content/cobro/state = 0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
				        				Pendiente
				        			</option>
				        			<option value="1">
				        				<xsl:if test="$content/cobro/state = 1"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Pagada
				        			</option>
				        		</select>
				        	</div>

				        	<div class="col-sm-6">
				        		<label>Proveedor</label>
				        		<select class="populate" style="width:100%;" name="provider_id" id="provider">
				        			<option value="0">Seleccionar</option>
				        			<xsl:for-each select="$content/providers/object">
				        				<xsl:sort select="title" order="ascending" />
			        						<xsl:variable name="providerId" select="@id" />
			        						<option value="{@id}">
			        							<xsl:if test="$providerId = $content/cobro/provider_id"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			        							<xsl:value-of select="title" /> 
			        						</option>
				        			</xsl:for-each>
				        		</select>
				        		 <script>
								   $("#provider").select2();
								</script>
				        	</div>


				        </div>
					</div>

					<div class="form-group">
						<label>Descripción</label>
						<textarea name="description" class="form-control" placeholder="Ingrese la descripción"  style="height:150px;"><xsl:value-of select="$content/cobro/description"  />&#xa0;</textarea>
					</div>








				</div>
			</section>
		</div>
	</div>
</form>




<div id="modal" class="modal fade" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>

</xsl:template>
</xsl:stylesheet>