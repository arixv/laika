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

                    	<form name="addPartida" role="form" action="/admin/?m=project&amp;action=BackEditFactura" method="post">
                    		<input type="hidden" name="project_id" value="{$project_id}" />
                    		<input type="hidden" name="factura_id" value="{$content/factura/id}" />

	                        <div class="modal-header">
	                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
	                            <h4 class="modal-title">Editar Factura</h4>
	                        </div>
	                        <div class="modal-body">

	                        	<div class="form-group">
	                        		<label>Nro de Factura</label>
	                        		<input type="text" name="number" value="{$content/factura/number}" class="form-control" />
	                        	</div>

	                        	<div class="form-group">
	                        		<label>Monto</label>
	                        		<div class="input-group m-bot15">
                            		    <span class="input-group-addon btn-success">$</span>
                                		<input type="text" name="amount" value="{$content/factura/amount}" class="form-control" />
                                		<span class="input-group-addon btn-success">.00</span>
                            		</div>
	                        	</div>

	                        	<div class="form-group">
	                        		<label>Descripción</label>
	                        		<input type="text" name="description" value="{$content/factura/description}"  class="form-control" />
	                        	</div>


	                        	<div class="form-group">
	                        		<label>Partida Asociada</label>
	                        		<select name="partida_id" class="form-control">
	                        			<option value="0">Seleccionar</option>
	                        			<xsl:for-each select="$content/partidas/partida">
	                        				<xsl:variable name="this_id"><xsl:value-of select="id" /></xsl:variable>
	                        				<option value="{$this_id}">
		                        				<xsl:if test="$this_id = $content/factura/partida_id" >
		                        					<xsl:attribute name="selected">selected</xsl:attribute>
		                        				</xsl:if> 
	                        					<xsl:value-of select="description" />
	                        				</option>
	                        			</xsl:for-each>
	                        		</select>
	                        	</div>

	                        	<div class="form-group">
	                        		<label>Tipo de Factura</label>
	                        		<select name="type" class="form-control">
	                        			<option value="A">A</option>
	                        			<option value="B">B</option>
	                        			<option value="C">C</option>
	                        			<option value="Ticket">Ticket</option>
	                        		</select>
	                        	</div>

	                        	<div class="form-group">
	                        		<label>Proveedor</label>

	                        		<select name="provider_id" class="form-control">
	                        			<option value="0">Seleccionar</option>
	                        			<xsl:for-each select="$content/providers/object">
	                        				<xsl:variable name="this_id"><xsl:value-of select="@id"/></xsl:variable>
	                        				<option value="{$this_id}">
	                        				<xsl:if test="$this_id = $content/factura/provider_id" >
	                        					<xsl:attribute name="selected">selected</xsl:attribute>
	                        				</xsl:if>
	                        				<xsl:value-of select="title" /></option>
	                        			</xsl:for-each>
	                        		</select>

	                        	</div>

	                        	<div class="form-group">
	                        		<label>Estado</label>
	                        		<select name="state" class="form-control">
	                        			<option value="">Seleccionar</option>
	                        			<option value="0">
	                        				<xsl:if test="$content/factura/state = 0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
	                        				Pendiente
	                        			</option>
	                        			<option value="1">
	                        				<xsl:if test="$content/factura/state = 1"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Pagada
	                        			</option>
	                        		</select>
	                        	</div>


	                        	<div class="form-group">
	                        		<label>Rubro</label>
	                        		<select class="form-control rubro" name="rubro_id" >
	                        			<option value="0">Seleccionar</option>
	                        			<xsl:for-each select="$content/rubros/rubro">
	                        				<xsl:variable name="this_id"><xsl:value-of select="id" /></xsl:variable>
	                        				<option value="{$this_id}">
												<xsl:if test="$this_id = $content/factura/rubro_id"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
	                        					<xsl:value-of select="title" />
	                        				</option>
	                        			</xsl:for-each>
	                        		</select>
	                        	</div>

	                        	<div class="form-group">
	                        		<label>Subrubro</label>
	                        		<select class="form-control" name="subrubro_id" id="subrubro">
	                        			<option value="0">Seleccionar</option>
	                        			<!-- <xsl:for-each select="$content/rubros/rubro">
	                        				<xsl:variable name="this_id"><xsl:value-of select="id" /></xsl:variable>
	                        				<option value="{$this_id}">
												<xsl:if test="$this_id = $content/factura/rubro_id"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
	                        					<xsl:value-of select="title" />
	                        				</option>
	                        			</xsl:for-each> -->
	                        		</select>
	                        	</div>


	                        	<div class="form-group">
	                        		<label>Fecha</label>
	                        		<input type="text" name="date" value="{$content/factura/date}"  class="form-control" />
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