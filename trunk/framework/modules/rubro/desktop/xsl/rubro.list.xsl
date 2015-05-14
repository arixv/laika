<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />



<xsl:variable name="htmlHeadExtra">
	 	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/fuelux/css/tree-style.css" />
</xsl:variable>


<xsl:variable name="htmlFooterExtra">
	<script type="text/javascript" src="{$adminPath}/desktop/js/tree.js">&#xa0;</script>
	<script type="text/javascript" src="{$modPath}/desktop/js/rubro.js"  >&#xa0;</script>
</xsl:variable>

<xsl:template name="content">
<div class="row">
	<div class="col-sm-12">

		<a href="#" class="btn btn-info btn-add-rubro pull-right">Agregar Rubro</a>
		<h1><xsl:value-of select="$config/module/@title" /></h1>
			

		<xsl:choose>
			<xsl:when test="$content/rubros/rubro">
				
					<xsl:call-template name="rubro_item">
						<xsl:with-param name="rubros" select="$content/rubros"/>
						<xsl:with-param name="icon" select="'fa-folder'"/>
					</xsl:call-template>
				
			</xsl:when>
			<xsl:otherwise>
				<div class="alert alert-info">
					<center>
						<p>No hay ningún rubro creado</p>
						<a href="#addRubro" data-toggle="modal" class="btn btn-info">Agregar Rubro</a>
					</center>
				</div>
			</xsl:otherwise>
		</xsl:choose>
			
	</div>
</div>




</xsl:template>


<!-- RUBRO ITEM -->
<xsl:template name="rubro_item">
	<xsl:param name="rubros" />
	<xsl:param name="icon" />
	
	<xsl:for-each select="$rubros/rubro">
		<xsl:sort order="ascending" select="@order" data-type="number"/>
		<xsl:sort order="ascending" select="name" />

		<section  class="panel" id="rubro_{@id}">
			<header class="panel-heading clearfix">
					
					
					<div class="btn-group pull-right">
						<button class="btn btn-primary btn-sm btn-edit-rubro" data-id="{@id}"><i class="fa fa-edit">&#xa0;</i> Editar</button>
						<button class="btn btn-primary btn-sm btn-delete-rubro" data-id="{@id}"><i class="fa fa-edit">&#xa0;</i> Eliminar</button>
					</div>
                
                    <div class="tools">
						<a class="fa fa-chevron-up" href="javascript:;">&#xa0; <xsl:value-of select="title" /> </a>
					</div>
                  
			</header>



			<div class="panel-body" style="display:none;">
				<table class="table table-bordered table-striped table-condensed">
					<thead>
						<tr>
							<th>Nombre</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="rubros/rubro">
							<tr id="rubro_{@id}">
								<td><xsl:value-of select="title" /></td>
								<td>
									<div class="btn-group">
										<button data-id="{@id}" class="btn btn-primary btn-sm btn-edit-rubro" ><i class="fa fa-edit">&#xa0;</i> Editar</button>
										<button data-id="{@id}" class="btn btn-primary btn-sm btn-delete-rubro"><i class="fa fa-trash-o">&#xa0;</i> Eliminar</button>
									</div>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</div>


		</section>
	</xsl:for-each>



	<!-- MODAL ADD -->
	<div id="modalAddCategory" class="modal fade">
		 <div class="modal-dialog">
		 	<div class="modal-content">
				<div class="modal-header">
					 <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
					  <h4 class="modal-title">Editar</h4>
				</div>
				<div class="modal-body">

					<form role="form">
						<div class="form-group">
						    <label for="exampleInputEmail1">Nombre</label>
						    <input type="email" class="form-control" value="" placeholder="Ingresar Nombre" />
						</div>
						<div class="form-group">
						    <label for="exampleInputEmail1">Rubro Padre</label>
						    <select class="form-control">
						    	<option>seleccionar</option>
						    </select>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-info">Guardar</button>
						</div>
					</form>
				</div>
			</div>
		 </div>
	</div>
	<!-- // MODAL ADD -->

	<script>
		 $('.panel .tools .fa').click(function () {
            var el = $(this).parents(".panel").children(".panel-body");
            if ($(this).hasClass("fa-chevron-down")) {
                $(this).removeClass("fa-chevron-down").addClass("fa-chevron-up");
                el.slideUp(200);
            } else {
                $(this).removeClass("fa-chevron-up").addClass("fa-chevron-down");
                el.slideDown(200); }
        });
      </script>


      <div id="modal" class="modal fade" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>

</xsl:template>
</xsl:stylesheet>