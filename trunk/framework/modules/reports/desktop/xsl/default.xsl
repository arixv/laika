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

		<section class="panel">
			<header class="panel-heading">
				Consultas por Proyecto
			</header>
			<div class="panel-body">

				<div class="position-center">
					<form name="project_report" action="/admin/?m=reports&amp;action=BackReportProjects" method="post">
						<div class="form-group ">
							<div class="row">
								<div class="col-sm-6">
									<label>Fecha de inicio</label>
									<div data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date=""  class="input-append date dpYears">
				                		<input type="text" readonly="readonly" name="start_date" size="16" class="form-control default-date-picker" />
				                	</div>
					            	
								</div>
								<div class="col-sm-6">
									<label>Fecha de fin</label>
									<div data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date=""  class="input-append date dpYears">
				                		<input type="text" readonly="readonly" name="end_date" size="16" class="form-control default-date-picker" />
				                	</div>
								</div>
								<script>
					            		$('.default-date-picker').datepicker({
									        format: 'yyyy-mm-dd'
									    });
									    $('.dpYears').datepicker();
									</script>
							</div>
						</div>
						
							

						<div class="form-group">
							<label>Proyecto</label>
							<select name="project_id" class="form-control">

								<option value="" >Todos</option>
								<xsl:for-each select="$content/projects/object">
									<xsl:sort select="title" ordering="asending" />
									<option value="{@id}"><xsl:value-of select="title" /></option>
								</xsl:for-each>
							</select>
						</div>
						<div class="form-group">
							<label>Cliente</label>
							<select class="form-control"><option>seleccionar</option></select>
						</div>
						<div class="form-group">
							<label>Tipo</label>
							<select class="form-control"><option>seleccionar</option></select>
						</div>
						<div class="form-group">
							<label>Estado</label>
							<select name="state" class="form-control">
								<option>seleccionar</option>
								<option value="0">Presupuesto</option>
								<option value="1">En Curso</option>
								<option value="2">Terminado</option>
								<option value="3">Cancelado</option>
							</select>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-info pull-right">Consultar</button>
						</div>
					</form>
				</div>
			</div>
		</section>	



</xsl:template>
</xsl:stylesheet>