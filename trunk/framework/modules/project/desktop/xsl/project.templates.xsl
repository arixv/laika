<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />



<xsl:template name="project.nav">
	<xsl:param name="active">info</xsl:param>

	<nav class="navbar navbar-inverse" role="navigation">
	    
	    <div class="navbar-header">
	        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".project-nav-collapse">
	            <span class="sr-only">Toggle navigation</span>
	            <span class="icon-bar">&#xa0;</span>
	            <span class="icon-bar">&#xa0;</span>
	            <span class="icon-bar">&#xa0;</span>
	        </button>
	        <a class="navbar-brand" href="#">
	        	 <xsl:value-of select="$content/object/title" />
	        </a>

	    </div>

	    <div class="collapse navbar-collapse project-nav-collapse">

	        <ul class="nav navbar-nav navbar-right ">
	        	<li>
	        		<xsl:if test="$active='dashboard'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
	        		<a href="/admin/project/dashboard/{$content/object/@id}">
	        			<i class="fa fa-dashboard">&#xa0;</i> Dashboard</a>
	        	</li>
	        	<li>
	        		<xsl:if test="$active='info'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
	        		<a href="/admin/project/edit/{$content/object/@id}">
	        			<i class="fa fa-edit">&#xa0;</i> Editar Datos</a>
	        	</li>
	        	<xsl:if test="$content/object/@state != 0">
		            <li>
		            	<xsl:if test="$active='partida'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
		            	<a href="/admin/project/list_partida/{$content/object/@id}">
		            		<i class="fa fa-inbox">&#xa0;</i>
		            		Partidas</a>
		            </li>
		            <li>
		            	<xsl:if test="$active='factura'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
		            	<a href="/admin/project/list_factura/{$content/object/@id}">
		            		<i class="fa fa-file-text-o">&#xa0;</i>
		            		Facturas
		            	</a>
		            </li>
	        	</xsl:if>
	             <li>
	            	<xsl:if test="$active='rubro'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
	            	<a href="/admin/project/list_resources/{$content/object/@id}">
	            		<i class="fa fa-list-ul">&#xa0;</i>
	            		 Recursos</a>
	            </li>
	        </ul>
	    </div><!-- /.navbar-collapse -->
	</nav>

</xsl:template>


<xsl:template name="form.edit.factura">

	<div class="form-group">
		<div class="row">

			<div class="col-sm-6">
				<label>Tipo de Factura</label>
        		<select name="type" class="form-control">
        			<option value="A">
        				<xsl:if test="$content/factura/type = 'A'" ><xsl:attribute name="selected" >selected</xsl:attribute></xsl:if>
        				A
        			</option>
        			<option value="B">
        				<xsl:if test="$content/factura/type = 'B'" ><xsl:attribute name="selected" >selected</xsl:attribute></xsl:if>
        				B
        			</option>
        			<option value="C">
        				<xsl:if test="$content/factura/type = 'C'" ><xsl:attribute name="selected" >selected</xsl:attribute></xsl:if>
        				C
        			</option>
        			<option value="Ticket">
        				<xsl:if test="$content/factura/type = 'Ticket'" ><xsl:attribute name="selected" >selected</xsl:attribute></xsl:if>
        				Ticket
        			</option>
        		</select>
			</div>

			<div class="col-sm-6">
            	<label>Fecha</label>
            	<div data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date="{$fechaActual}"  class="input-append date dpYears">
                		<input type="text" readonly="readonly" name="date" value="{$content/factura/date}" size="16" class="form-control default-date-picker" />
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

	<div class="form-group">
		<div class="row">

    		<div class="col-sm-6">
    				<label>Número</label>
    				<input type="text" name="number" value="{$content/factura/number}" class="form-control" />
    		</div>

    		<div class="col-sm-6">
        		<label>Monto</label>
        		<div class="input-group m-bot15">
    		    	<span class="input-group-addon btn-success">$</span>
        			<input type="text" name="amount" value="{$content/factura/amount}" class="form-control" />
        			<span class="input-group-addon btn-success">.00</span>
    			</div>
        	</div>
        </div>
	</div>

	<div class="form-group">
		<label>Descripción</label>
		<textarea name="description" class="form-control"  style="height:150px;"><xsl:value-of select="$content/factura/description"  /></textarea>
	</div>


	<div class="form-group">
		<div class="row">
			<div class="col-sm-6">
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

        
        </div>
	</div>


	<div class="form-group">
		<div class="row">
			<div class="col-sm-6">
        		<label>Estado </label> 
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

        	<div class="col-sm-6">
        		<label>Recurso</label>
        		<select class="populate" style="width:100%;" name="resource_id" id="resources">
        			<option value="0">Seleccionar</option>
        			<xsl:for-each select="$content/rubros/rubro">
        				<xsl:sort select="title" order="ascending" />
        				<optgroup label="{title}">
        					<xsl:for-each select="resources/resource">
        						<xsl:sort select="title" order="ascending" />
        						
        						<xsl:variable name="this_id"><xsl:value-of select="resource_id" /></xsl:variable>
        						<xsl:variable name="providerId" select="provider_id" />

        						<option value="{resource_id}">
        							<xsl:if test="$this_id = $content/factura/resource_id"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
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
</xsl:template>
</xsl:stylesheet>