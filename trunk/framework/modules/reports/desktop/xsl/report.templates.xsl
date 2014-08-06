<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />



<xsl:template name="reports.navigation">
	<xsl:param name="active">info</xsl:param>

    <nav class="navbar navbar-inverse" role="navigation">
	    
	    <div class="navbar-header">
	        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".project-nav-collapse">
	            <span class="sr-only">Toggle navigation</span>
	            <span class="icon-bar">&#xa0;</span>
	            <span class="icon-bar">&#xa0;</span>
	            <span class="icon-bar">&#xa0;</span>
	        </button>
	        <a class="navbar-brand" href="#">Reportes</a>
	    </div>

	    <div class="collapse navbar-collapse project-nav-collapse">

	        <ul class="nav navbar-nav navbar-right ">
	        	<li>
	        		<xsl:if test="$active='projects'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
	        		<a href="/admin/reports/">Proyectos</a>
	        	</li>
	            <li>
	            	<xsl:if test="$active='partidas'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
	            	<a href="/admin/reports/form_partidas">Partidas</a>
	            </li>
	            <li>
	            	<xsl:if test="$active='facturas'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
	            	<a href="/admin/reports/form_facturas">Facturas</a>
	            </li>
	            <li>
	            	<xsl:if test="$active='resources'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
	            	<a href="/admin/reports/form_resources" >Recursos</a>
	            </li>
	             <li>
	            	<xsl:if test="$active='providers'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
	            	<a href="/admin/reports/form_providers" >Proveedores</a>
	            </li>
	        </ul>
	    </div><!-- /.navbar-collapse -->
	</nav>


</xsl:template>
</xsl:stylesheet>