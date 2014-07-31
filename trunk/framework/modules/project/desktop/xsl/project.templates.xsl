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
	        		<xsl:if test="$active='info'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>

	        		<a href="/admin/project/edit/{$content/object/@id}">
	        			<i class="fa fa-dashboard">&#xa0;</i> Info</a>
	        	</li>
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
	             <li>
	            	<xsl:if test="$active='rubro'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
	            	<a href="/admin/project/list_rubro/{$content/object/@id}">
	            		<i class="fa fa-list-ul">&#xa0;</i>
	            	Recursos</a>
	            </li>
	        </ul>
	    </div><!-- /.navbar-collapse -->
	</nav>

</xsl:template>
</xsl:stylesheet>