<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="active" />
<xsl:param name="from_date" />
<xsl:param name="to_date" />


<xsl:variable name="htmlHeadExtra"></xsl:variable>



<xsl:template name="content">

	<xsl:call-template name="reports.navigation">
		<xsl:with-param name="active">projects</xsl:with-param>
	</xsl:call-template>

	

		<section class="panel">
			<header class="panel-heading">
				Consultas por Proyecto
			</header>
			<div class="panel-body">

				<div class="position-center">
					<form name="project_report" action="{$adminroot}" method="get">
						<input type="hidden" name="m" value="reports" />
						<input type="hidden" name="action" value="BackReportProjects" />
						<div class="form-group ">
							<div class="row">
								<div class="col-sm-6">
									<label>Fecha de inicio</label>
									<div data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date=""  class="input-append date dpYears">
				                		<input type="text"  name="start_date" size="16" class="form-control default-date-picker" />
				                	</div>
					            	
								</div>
								<div class="col-sm-6">
									<label>Fecha de fin</label>
									<div data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date=""  class="input-append date dpYears">
				                		<input type="text"  name="end_date" size="16" class="form-control default-date-picker" />
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
							<div class="row">
								<div class="col-sm-6">
									<label>Proyecto</label>
									<select name="project_id" class="form-control">
										<option value="" >Todos</option>
										<xsl:for-each select="$content/projects/object">
											<xsl:sort select="title" ordering="asending" />
											<option value="{@id}"><xsl:value-of select="title" /></option>
										</xsl:for-each>
									</select>
								</div>
								<div class="col-sm-6">
									<label>Cliente</label>
									<select name="client_id" class="form-control" >
										<option value="">Seleccionar</option>
										<xsl:for-each select="$content/clients/object">
											<xsl:sort select="title" order="ascending" />
											<option  value="{@id}">
												<xsl:value-of select="title" />
											</option>
										</xsl:for-each>
									</select>
								</div>
							</div>
						</div>

						
						<div class="form-group">
							<div class="row">
								<div class="col-sm-6">
									<label>Tipo</label>
									<select class="form-control" name="type">
										<option value="">Seleccionar</option>
										<option value="TV">TV</option>
										<option value="Publicidad">Publicidad</option>
										<option value="Servicio">Servicio de Producción</option>
									</select>
								</div>
								<div class="col-sm-6">
									<label>Estado</label>
									<select name="state" class="form-control">
										<option value="" >seleccionar</option>
										<option value="0">Presupuesto</option>
										<option value="1">En Curso</option>
										<option value="2">Terminado</option>
										<option value="3">Cancelado</option>
									</select>
								</div>
							</div>
						</div>

						
						<div class="form-group">
							<label>Creado Por</label>
							<select name="creation_userid" class="form-control">
								<option value="" >seleccionar</option>
								<xsl:for-each select="$content/users/user">
									<xsl:sort select="title" order="ascending" />
									<option  value="{@user_id}">
										<xsl:value-of select="username" />
									</option>
								</xsl:for-each>
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