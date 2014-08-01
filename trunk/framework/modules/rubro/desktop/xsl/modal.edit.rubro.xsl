<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />

<xsl:param name="rubro_id" />

<xsl:variable name="config" select="/xml/configuration" />
<xsl:variable name="content" select="/xml/content" />
<xsl:variable name="adminroot" select="$config/system/adminpath" />

	<xsl:template match="/xml">
 			<div class="modal-dialog">
		        <div class="modal-content">
		        	<form id="editRubro" name="editRubro" role="form" action="/admin/?m=rubro&amp;action=BackEdit" method="post">
		        		<input type="hidden" name="m" value="rubro" />
		        		<input type="hidden" name="action" value="BackEdit" />
		        		<input type="hidden" name="id" value="{$content/rubro/@id}" />
		                <div class="modal-header">
		                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
		                    <h4 class="modal-title">Editar</h4>
		                </div>
		           		<div class="modal-body">

		                	<div class="form-group">
		                		<label>Rubro Padre</label>
		                		<select name="parent_id"  class="form-control" >
		                			<option value="0">- Sin Rubro Padre-</option>
		                			<xsl:for-each select="$content/rubros/rubro">
		                				<xsl:variable name="thisId"><xsl:value-of select="@id" /></xsl:variable>
		                				<option value="{$thisId}">
		                					<xsl:if test="$thisId = $content/rubro/@parent_id">
		                						<xsl:attribute name="selected">selected</xsl:attribute>
		                					</xsl:if>
		                					<xsl:value-of select="title" />
		                				</option>
		                			</xsl:for-each>
		                		</select>
		                	</div>

		                	<div class="form-group">
		                		<label>Titulo</label>
		                		<input type="text" name="title" value="{$content/rubro/title}" class="form-control" />
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