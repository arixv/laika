<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />


<xsl:variable name="htmlHeadExtra">
</xsl:variable>

<xsl:variable name="htmlFooterExtra">
	<script type="text/javascript" src="{$modPath}/desktop/js/project.edit.js"  >&#xa0;</script>
</xsl:variable>


<xsl:template name="content">

	<xsl:variable name="object" select="$content/object" />

	<xsl:call-template name="project.nav">
		<xsl:with-param name="active" >partida</xsl:with-param>
	</xsl:call-template>



<!-- PARTIDAS -->
<div class="row"  id="partidas" >
	<div class="col-sm-12">

		<h1>
			<a href="#modal"  class="btn btn-info pull-right btn-add-partida" project-id="{$content/object/@id}" data-toggle="modal" >Agregar Partidas</a>
			Partidas
		</h1>
		<section class="panel">

			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>#</th>
							<th>Fecha</th>
							<th>Descripción</th>
							<th>Monto</th>
							<th>Responsable</th>
							<th>Estado</th>
							<th>Progreso</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="$content/partidas/partida">
							<tr id="partida_{id}">
								<td><xsl:value-of select="id" /></td>
								<td><xsl:value-of select="date" /></td>
								<td><xsl:value-of select="description" /></td>
								<td>$ <xsl:value-of select="amount" /></td>
								<td><xsl:value-of select="responsable" /></td>
								<td><span class="label label-success label-mini">Pendiente</span></td>
								<td>
									<div class="progress progress-striped progress-sm">
										<xsl:variable name="progress_color">
											<xsl:choose>
												<xsl:when test="@progress &gt; 80" >progress-bar-success</xsl:when>
												<xsl:when test="@progress &lt; 80 and @progress &gt;= 50" >progress-bar-warning</xsl:when>
												<xsl:when test="@progress &lt; 50" >progress-bar-danger</xsl:when>
											</xsl:choose>
										</xsl:variable>
					                    <div class="progress-bar {$progress_color}" role="progressbar" aria-valuenow="{@progress}" aria-valuemin="0" aria-valuemax="100" style="width: {@progress}%;">
					                        <span class="sr-only" ><xsl:value-of select="@progress" />% Completado</span>
					                    </div>
					                </div>
								</td>
								<td>
									<div class="btn-group">
										<button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm">
											Acciones
											<span class="caret">&#xa0;</span>
										</button>

										<ul role="menu" class="dropdown-menu">
			                               <li><a href="#" class="btn-edit-partida" project-id="{$object/@id}" partida-id="{id}" ><i class="fa fa-edit">&#xa0;</i>Editar</a></li>
			                                <!-- <li><a href="#"><i class="fa fa-copy">&#xa0;</i>Duplicar</a></li> -->
			                                <li class="divider"></li>
			                                <li><a href="#" class="btn-delete-partida" partida-id="{id}" ><i class="fa fa-trash-o">&#xa0;</i>Eliminar</a></li>
			                            </ul>
									</div>
								</td>
							</tr>
						</xsl:for-each>
						
						
					</tbody>
				</table>
			</div>

			

		</section>



	</div>
</div>
<!-- //PARTIDAS -->

<div id="modal" class="modal fade" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>
	
</xsl:template>
</xsl:stylesheet>