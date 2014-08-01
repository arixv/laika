<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />



<xsl:variable name="htmlHeadExtra">
	 	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/fuelux/css/tree-style.css" />
		<script type="text/javascript" >

			$(document).ready(function(){
				
				$(".btn-edit-rubro").click(function(e){
					e.preventDefault();
					var id = $(this).attr("data-id");

					$('#modal').load(
				    	"/admin/rubro/edit/"+id,
				    	function(){
						    $(this).modal({
						        keyboard:true,
						        backdrop:true
						    });
					}).modal('show'); 

				    return false;
				});


				$(".btn-delete-rubro").click(function(e)
				{
					e.preventDefault();
					var id = $(this).attr("data-id");
					if(confirm('Estas seguro que deseas eliminar la categoría y sus categorías?')){
						modion.ajaxCall(
						{
							m:'rubro',
							action:'BackRemove',
							id: id,
						}
						,
						{
							callback: function(response){
								if(response == 1) {
									$("#rubro_"+id).remove();
								}
							}
						});
					}

				});

			});

			
		</script>

</xsl:variable>


<xsl:variable name="htmlFooterExtra">
	<script type="text/javascript" src="{$adminPath}/desktop/js/tree.js">&#xa0;</script>
</xsl:variable>

<xsl:template name="content">
<div class="row">
	<div class="col-sm-12">

		<a href="#addRubro" data-toggle="modal" class="btn btn-info pull-right">Agregar Rubro</a>
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


<!-- modal agregar rubros -->
<div id="addRubro" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
        	<form name="addRubro" role="form" action="/admin/?m=rubro&amp;action=BackAdd" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                    <h4 class="modal-title">Agregar Rubro</h4>
                </div>
           		<div class="modal-body">
            		
                	<div class="form-group">
                		<label>Rubro Padre</label>
                		<select name="parent_id" class="form-control" >
                			<option value="0">Seleccionar</option>
                			<xsl:for-each select="$content/rubros/rubro">
                				<option value="{@id}"><xsl:value-of select="title" /></option>
                			</xsl:for-each>
                		</select>
                	</div>

                	<div class="form-group">
                		<label>Nombre</label>
                		<input type="text" name="title" class="form-control" />
                	</div>
                </div>
                <div class="modal-footer">
                	<button type="submit" class="btn btn-info">Guardar</button>
                    <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- // modal agregar rubros -->

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
						<button class="btn btn-default btn-sm btn-edit-rubro" data-id="{@id}"><i class="fa fa-edit">&#xa0;</i> Editar</button>
						<button class="btn btn-default btn-sm btn-delete-rubro" data-id="{@id}"><i class="fa fa-edit">&#xa0;</i> Eliminar</button>
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
									<button data-id="{@id}" class="btn btn-success btn-sm btn-edit-rubro" ><i class="fa fa-edit">&#xa0;</i> Editar</button>
									<button data-id="{@id}" class="btn btn-default btn-sm btn-delete-rubro"><i class="fa fa-trash-o">&#xa0;</i> Eliminar</button>
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