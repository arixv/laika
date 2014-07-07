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
		        	<form name="addSubRubro" role="form" action="/admin/?m=project&amp;action=BackAddSubRubro" method="post">
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
					               
					             
		                	</div>

		                	<script>
								   $("#subrubros").select2();
							</script>


		                	<div class="form-group">
		                		<label>Descripción</label>
		                		<input type="text" name="description" class="form-control" />
		                	</div>

		                	<div class="form-group">
		                		<label>Cantidad</label>
		                		<input type="text" name="quantity" class="form-control" />
		                	</div>

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
		                		<label>Costo Unidad</label>
		                		<input type="text" name="cost" class="form-control" />
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