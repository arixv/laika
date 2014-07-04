<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:template name="content">
<div class="row">
	<form name="form" action="/admin/?m={$config/module/@name}&amp;action=BackAdd" method="post">

	<div class="col-sm-8">
		<section class="panel">
			
				<input type="hidden" name="modToken" value="{$modToken}" />
				<header class="panel-heading">
					Nuevo Proyecto
				</header>

				<div class="panel-body">
					<div class="form-group">
						<label>Título</label>
						<input class="form-control" type="text" maxlength="200" name="title" placeholder="Titulo" />
					</div>
					<div class="form-group">
						<label>Descripción</label>
						<textarea class="form-control" type="text" maxlength="200" name="description" placeholder="Descripción" ><![CDATA[]]></textarea>
					</div>
					<div class="form-group">
						<label>Presupuesto</label>
						$ <input class="form-control" type="text" maxlength="200" name="budget" placeholder="" />
					</div>
					<div class="form-group">
							<label>Cliente</label>
							<select name="client_id" class="form-control" >
								<option value="">Seleccionar</option>
								<xsl:for-each select="$content/clients/object">
									<option  value="{@id}">
										<xsl:value-of select="title" />
									</option>
								</xsl:for-each>
							</select>
						</div>
					<div class="form-group">
						<label>Tipo</label>
						<select class="form-control" name="type">
							<option value="">Seleccionar</option>
						</select>
					</div>
					<div class="form-group">
						<label>Estado</label>
						<select name="state" class="form-control">
							<option value="0">Presupuesto</option>
							<option value="1">En curso</option>
							<option value="2">Finalizado</option>
						</select>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-info pull-right"><i class="fa fa-plus">&#xa0;</i>Crear</button>
			 		</div>

				</div>



		</section>
	</div>

	<div class="col-sm-4">
		<section class="panel">
			<header class="panel-heading">Información del Proyecto</header>
			<div class="panel-body">

				<div class="form-group">
					<label class="control-label col-xs-3">Inicio</label>
					<div class="col-md-8 col-xs-11">
						 <div data-date-viewmode="years" data-date-format="dd-mm-yyyy" data-date="12-02-2012"  class="input-append date dpYears" >
	                        <input type="text"  name="start_date" value="" size="16" class="form-control" />
							<span class="input-group-btn add-on">
								<button class="btn btn-primary" type="button"><i class="fa fa-calendar">&#xa0;</i></button>
	                        </span>
	                    </div>
	                    <!-- <span class="help-block">Select date</span> -->
	                </div>
				</div>

				<div class="form-group">
					<label class="control-label col-md-3">Fin</label>
					<div class="col-md-8 col-xs-11">
						 <div data-date-viewmode="years" data-date-format="yyyy-dd-mm" data-date=""  class="input-append date dpYears" >
	                        <input type="text" name="end_date" value="" size="16" class="form-control" />
							<span class="input-group-btn add-on">
								<button class="btn btn-primary" type="button"><i class="fa fa-calendar" >&#xa0;</i></button>
	                        </span>
	                    </div>
	                    <!-- <span class="help-block">Select date</span> -->
	                </div>
				</div>

				<!-- <div class="form-group">
					<label>Imprevistos (%)</label>
					<input type="text" name="imprevistos" class="form-control" value="" />
				</div>
				<div class="form-group">
					<label>Ganancia (%)</label>
					<input type="text" name="ganancia" class="form-control" value="" />
				</div>
				<div class="form-group">
					<label>Impuestos (%)</label>
					<input type="text" name="impuestos" class="form-control" value="" />
				</div> -->

			</div>
		</section>
	</div>
	</form>
</div>

</xsl:template>
</xsl:stylesheet>