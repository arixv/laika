<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:param name="active" />
<xsl:param name="from_date" />
<xsl:param name="to_date" />


<xsl:variable name="htmlHeadExtra"></xsl:variable>



<xsl:template name="content">

<xsl:call-template name="reports.navigation">
		<xsl:with-param name="active">partidas</xsl:with-param>
</xsl:call-template>




<div class="row">
	<div class="col-sm-12">
		<section class="panel">
			<header class="panel-heading">
				Consultas por Partidas
			</header>
			<div class="panel-body">
				<div class="position-center">
					<form name="project_report" action="{$adminroot}" method="get">
						<input type="hidden" name="m" value="reports" />
						<input type="hidden" name="action" value="BackReportPartidas" />
						<div class="form-group">
							<label>Fecha desde</label>
							<input type="text" name="start_date" class="form-control" />
						</div>
						<div class="form-group">
							<label>Fecha hasta</label>
							<input type="text" name="end_date" class="form-control" />
						</div>
						<div class="form-group">
							<label>Monto Mínimo</label>
							<input type="text" name="min_cost" class="form-control" />
						</div>
						<div class="form-group">
							<label>Estado</label>
							<select name="state" class="form-control">
								<option value="0">Pendiente</option>
								<option value="1">Terminada</option>
							</select>
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
	</div>
</div>

</xsl:template>
</xsl:stylesheet>