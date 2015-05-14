<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="sort"/>

<xsl:variable name="htmlHeadExtra">
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/jquery-multi-select/css/multi-select.css" />
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/select2/select2.css" />
	<script type="text/javascript" src="{$adminPath}/desktop/js/module.list.js">&#xa0;</script>

	<script type="text/javascript">
		$(document).ready(function(){

			$('table th a').click(function(e){
				e.preventDefault();
				var sort = $(this).attr('data-sort');
				$('#list_form').find('input[name="sort"]').val(sort);
				$('#list_form').submit();
			});

		});
	</script>

</xsl:variable>




<xsl:variable name="htmlFooterExtra">
	<script type="text/javascript" src="{$adminPath}/desktop/js/fuelux/js/spinner.min.js"></script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery-multi-select/js/jquery.multi-select.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery-multi-select/js/jquery.quicksearch.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/select2/select2.js">&#xa0;</script>
	<script type="text/javascript" src="{$modPath}/desktop/js/sindicatos.js"  >&#xa0;</script>
</xsl:variable>



<xsl:template name="content">
	<form name="list" id="list_form" action="{$adminroot}{$modulename}/list/" method="get">
		<input type="hidden" name="sort" value="{$sort}" />
	</form>


<!-- COBROS -->
<div class="row">
	<div class="col-sm-12">
			
		<section class="panel">
			<header class="panel-heading wht-bg">
               <h4 class="gen-case">Sindicatos</h4>
            </header>

			<div class="panel-body">

				<div class="mail-option">

					<div class="pull-right">
						<a href="#modal" class="btn btn-add btn-info"  data-toggle="modal" >Agregar Sindicato</a>
					</div>
                           
				</div>
				
				<table class="table table-striped">
					<thead>
						<tr>
							<th>
								<a href="#" data-sort="name" >Nombre</a>
								<xsl:if test="$sort = 'name'"><i class="fa fa-caret-down"></i></xsl:if>
							</th>
							<th>
								Porcentaje
							</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="$content/sindicatos/sindicato">
							
							<tr id="item_{id}">
								<td><xsl:value-of select="name" /></td>
								<td><xsl:value-of select="percentage"/>%</td>
								<td>
									<div class="btn-group">
										<button data-toggle="dropdown" data-id="{id}" class="btn btn-primary btn-edit dropdown-toggle btn-sm">
											<i class="fa fa-edit">&#xa0;</i>
											Editar
										</button>
										<button data-toggle="dropdown" data-id="{id}" class="btn btn-primary btn-delete dropdown-toggle btn-sm">
											<i class="fa fa-trash-o">&#xa0;</i>
											Eliminar
										</button>

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
<!-- //COBROS -->


<div id="modal" class="modal fade" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>
	
</xsl:template>
</xsl:stylesheet>