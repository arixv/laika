<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<!-- FOOTER EXTRA -->
<xsl:variable name="htmlFooterExtra">
	<script type="text/javascript">
		$(document).ready(function(){
			$("select[name='type']").change(function(){
				$(".type_options").css({'display':'none'});
				$("#"+$(this).val()).css({'display':'block'});
			});
		});
	</script>
</xsl:variable>

<xsl:template name="content">
<div class="row">
	<form name="form" action="/admin/?m={$config/module/@name}&amp;action=BackAdd" method="post">

	<div class="col-sm-8">
		<section class="panel">
			
				<input type="hidden" name="modToken" value="{$modToken}" />
				<input type="hidden" name="creation_userid" value="{$config/user/@user_id}" />
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
							<option value="TV">TV</option>
							<option value="Publicidad">Publicidad</option>
							<option value="Servicio">Servicio de Producción</option>
						</select>
					</div>
					

					<div class="type_options" id="TV" style="display:none;">
						<div class="form-group">
							<label>Cantidad de Programas</label>
							<input type="text" name="type_option_programas" class="form-control" />
						</div>
						<div class="form-group">
							<label>Segundaje de Programas</label>
							<input type="text" name="type_option_segundaje" class="form-control" />
						</div>
					</div>


					<div class="type_options" id="Publicidad" style="display:none;">
						<div class="form-group">
							<label>Producto</label>
							<input type="text" name="type_option_producto" class="form-control" />
						</div>
						<div class="form-group">
							<label>Duración</label>
							<input type="text" name="type_option_duracion" class="form-control" />
						</div>
						<div class="form-group">
							<label>Medio</label>
							<input type="text" name="type_option_medio" class="form-control" />
						</div>
					</div>


					<div class="type_options" id="Servicio" style="display:none;">
						<div class="form-group">
							<label>Producto</label>
							<input type="text" name="type_option_tipo_servicio" class="form-control" />
						</div>
					</div>


					<!-- <div class="form-group">
						<label>Estado</label>
						<select name="state" class="form-control">
							<option value="0">Presupuesto</option>
							<option value="1">En curso</option>
							<option value="2">Finalizado</option>
						</select>
					</div> -->

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
					<div class="row">
						<label class="control-label col-xs-3">Fecha Inicio</label>
						<div class="col-md-8 col-xs-11">
							 <div data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date=""  class="input-append date dpYears">
		                        <input type="text" readonly="readonly"  name="start_date" value="" size="16" class="form-control default-date-picker" />
		                    </div>
		                </div>
		            </div>
				</div>

				<div class="form-group">
					<div class="row">
						<label class="control-label col-md-3">Fecha Fin</label>
						<div class="col-md-8 col-xs-11">
							 <div data-date-viewmode="years" data-date-format="yyyy-dd-mm" data-date=""  class="input-append date dpYears" >
		                        <input type="text" readonly="readonly"  name="end_date" value="" size="16" class="form-control default-date-picker" />
		                    </div>
		                    <!-- <span class="help-block">Select date</span> -->
		                </div>
		        	</div>        
				</div>

				<div class="form-group">
					<label>Imprevistos (%)</label>
					<input type="text" name="imprevistos" class="form-control" value="3" maxsize="2" />
				</div>
				<div class="form-group">
					<label>Ganancia (%)</label>
					<input type="text" name="ganancia" class="form-control" value="20" maxsize="2" />
				</div>
				<div class="form-group">
					<label>Impuestos (%)</label>
					<input type="text" name="impuestos" class="form-control" value="1.2" maxsize="2" />
				</div>

			</div>
		</section>
	</div>
	</form>
</div>

<script>
	$('.default-date-picker').datepicker({
        format: 'yyyy-mm-dd'
    });
    $('.dpYears').datepicker();
</script>

</xsl:template>
</xsl:stylesheet>