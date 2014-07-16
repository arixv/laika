<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="active" />
<xsl:param name="from_date" />
<xsl:param name="to_date" />


<xsl:variable name="htmlHeadExtra"></xsl:variable>



<xsl:template name="content">

<nav class="navbar navbar-inverse" role="navigation">
	    
	    <div class="navbar-header">
	        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".project-nav-collapse">
	            <span class="sr-only">Toggle navigation</span>
	            <span class="icon-bar">&#xa0;</span>
	            <span class="icon-bar">&#xa0;</span>
	            <span class="icon-bar">&#xa0;</span>
	        </button>
	        <a class="navbar-brand" href="#">Consultas</a>
	    </div>

	    <div class="collapse navbar-collapse project-nav-collapse">

	        <ul class="nav navbar-nav navbar-right ">
	        	<li>
	        		<xsl:if test="$active='projects'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
	        		<a href="/admin/reports/"><i class="fa fa-dashboard">&#xa0;</i> Proyectos</a>
	        	</li>
	            <li>
	            	<xsl:if test="$active='partidas'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
	            	<a href="/admin/reports/form_partidas"><i class="fa fa-inbox">&#xa0;</i>Partidas</a>
	            </li>
	            <li>
	            	<xsl:if test="$active='facturas'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
	            	<a href="/admin/reports/form_facturas"><i class="fa fa-file-text-o">&#xa0;</i>Facturas
	            	</a>
	            </li>
	        </ul>
	    </div><!-- /.navbar-collapse -->
	</nav>


<div class="row">
	<div class="col-sm-12">
		<section class="panel">
			<header class="panel-heading">
				Consultas por Factura
			</header>
			<div class="panel-body">
				<div class="position-center">
					<div class="form-group">
						<label>Fecha de inicio</label>
						<input type="text" class="form-control" />
					</div>
					<div class="form-group">
						<label>Fecha de fin</label>
						<input type="text" class="form-control" />
					</div>
					<div class="form-group">
						<label>Tipo de Factura</label>
						<select class="form-control"><option>seleccionar</option></select>
					</div>
					<div class="form-group">
						<label>Nro de Factura</label>
						<input type="text" class="form-control" />
					</div>
					<div class="form-group">
						<label>Monto</label>
						<input type="text" class="form-control" />
					</div>
					<div class="form-group">
						<label>Partida Asociada</label>
						<select class="form-control"><option>seleccionar</option></select>
					</div>
					<div class="form-group">
						<label>Proveedor</label>
						<select class="form-control"><option>seleccionar</option></select>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-info pull-right">Consultar</button>
					</div>
				</div>
			</div>
		</section>	
	</div>
</div>


</xsl:template>
</xsl:stylesheet>