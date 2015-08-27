<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:variable name="config" select="/xml/configuration" />
<xsl:variable name="content" select="/xml/content" />
<xsl:variable name="adminroot" select="$config/system/adminpath" />

	<xsl:template match="/xml">
		<!-- modal agregar rubros -->
			    <div class="modal-dialog">
			        <div class="modal-content">
			        	<form name="addRubro" role="form" action="/admin/?m=rubro&amp;action=BackAdd" method="post">
			                <div class="modal-header">
			                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
			                    <h4 class="modal-title">Agregar Rubro</h4>
			                </div>
			           		<div class="modal-body">
			            		
			                	

			                	<div class="form-group">
			                		<label>Nombre</label>
			                		<input type="text" name="title" class="form-control" />
			                	</div>

			                	<div class="form-group">
			                		<label>Rubro Padre</label>
			                		<select name="parent_id" class="form-control" >
			                			<option value="0">Seleccionar</option>
			                			<xsl:for-each select="$content/rubros/rubro">
			                				<option value="{@id}"><xsl:value-of select="title" /></option>
			                			</xsl:for-each>
			                		</select>
			                	</div>
			                	

			                	<div class="form-group" >
									<label>Sindicato</label>
			                		<select name="sindicato_id"  class="form-control" >
			                			<option value="0">- Sin Sindicato -</option>
			                			<xsl:for-each select="$content/sindicatos/sindicato">
			                				<option value="{id}">
			                					<xsl:value-of select="name" />
			                				</option>
			                			</xsl:for-each>
			                		</select>
			                	</div>

			



			                </div>
			                <div class="modal-footer">
			                	<button type="submit" class="btn btn-info">Guardar</button>
			                    <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">Cerrar</button>
			                </div>
			            </form>
			        </div>
			    </div>
			<!-- // modal agregar rubros -->
	</xsl:template>
</xsl:stylesheet>