<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:template name="content">
<div class="row">
	<div class="col-sm-8">
		<section class="panel">
			<form name="form" action="/admin/?m={$config/module/@name}&amp;action=BackAdd" method="post">
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
						<label>Cliente</label>
						<select class="form-control" name="client">
							<option value="">Seleccionar</option>
						</select>
					</div>
					<div class="form-group">
						<label>Tipo</label>
						<select class="form-control" name="type">
							<option value="">Seleccionar</option>
						</select>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-info pull-right"><i class="fa fa-plus">&#xa0;</i>Crear</button>
			 		</div>

				</div>


			</form>
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
	                        <input type="text" readonly="" value="12-02-2012" size="16" class="form-control" />
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
						 <div data-date-viewmode="years" data-date-format="dd-mm-yyyy" data-date="12-02-2012"  class="input-append date dpYears" >
	                        <input type="text" readonly="" value="12-02-2012" size="16" class="form-control" />
							<span class="input-group-btn add-on">
								<button class="btn btn-primary" type="button"><i class="fa fa-calendar">&#xa0;</i></button>
	                        </span>
	                    </div>
	                    <!-- <span class="help-block">Select date</span> -->
	                </div>
				</div>

				<div class="form-group">
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
				</div>

			</div>
		</section>
	</div>

</div>

</xsl:template>
</xsl:stylesheet>