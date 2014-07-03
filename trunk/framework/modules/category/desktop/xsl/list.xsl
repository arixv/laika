<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />



<xsl:variable name="htmlHeadExtra">
	 	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/fuelux/css/tree-style.css" />
		<script type="text/javascript" src="{$modPath}/desktop/js/categories.js">&#xa0;</script>
		<link rel="stylesheet" type="text/css" href="{$modPath}/desktop/css/categories.css" />
		<script type="text/javascript" >

			jQuery(document).ready(function(){
				jQuery('#grid').slideCategories();
				
				$(".highlighted").click(function(e)
				{
					e.preventDefault();
					var id_attr = $(this).parent().parent().attr("id");
					var category_id = id_attr.substring(9,id_attr.length);

					modion.ajaxCall(
					{
						m:'category',
						action:'BackUnsetHighlight',
						category_id: category_id,
					}
					,
					{
						callback: function(response){
							if(response == 1) {
								var a_link = $("#"+id_attr).find("a.highlighted:first");
								a_link.removeClass("highlighted").addClass("not_highlighted");
							}
						},
						context: category
					});

				});

				$(".not_highlighted").click(function(e)
				{
					e.preventDefault();
					var id_attr = $(this).parent().parent().attr("id");

					var category_id = id_attr.substring(9,id_attr.length);

					modion.ajaxCall(
					{
						m:'category',
						action:'BackSetHighlight',
						category_id: category_id,
					}
					,
					{
						callback: function(response){
							if(response == 1) 
							{
								var a_link = $("#"+id_attr).find("a.not_highlighted:first");
								a_link.removeClass("not_highlighted").addClass("highlighted");
							}
						},
						context: category
					});

				});

			});

			function validate(elem){
				if(confirm('Estas seguro que deseas eliminar la categoría y sus categorías?')){
					window.location.href = $(elem).attr('href');
				}
			}
		</script>

</xsl:variable>


<xsl:variable name="htmlFooterExtra">
	<script type="text/javascript" src="{$adminPath}/desktop/js/tree.js">&#xa0;</script>
</xsl:variable>

<xsl:template name="content">
<div class="row">
	<div class="col-sm-6">
		<section class="panel">
			<header class="panel-heading">
				<xsl:value-of select="$config/module/@title" />
			</header>

			<div class="panel-body">
				<div id="FlatTree" class="tree tree-solid-line">
					<xsl:call-template name="category_item">
						<xsl:with-param name="categories" select="$content/categories"/>
					</xsl:call-template>
				</div>
			</div>
		</section>
	</div>
</div>
</xsl:template>

<xsl:template name="category_item">
	<xsl:param name="categories" />
	
	<xsl:for-each select="$categories/category">
		<xsl:sort order="ascending" select="@order" data-type="number"/>
		<xsl:sort order="ascending" select="name" />
		
		<div class="tree-folder" id="category_{@category_id}">
			<div class="tree-folder-header">

				<i class="fa fa-folder">&#xa0;</i>
				
				<!-- <xsl:if test="categories/category">
					<a href="#" class="openclose opened">&#xa0;</a>
				</xsl:if> -->

				<!-- <xsl:choose>
					<xsl:when test="@highlight=1"><a href="" class="highlighted"><i class="icon-star">&#xa0;</i></a></xsl:when>
					<xsl:otherwise>
						<a class="not_highlighted" href="" ><i class="icon-star" >&#xa0;</i></a></xsl:otherwise>
				</xsl:choose> -->
				
				<div class="tree-folder-name" >
					<!-- <a onclick="editCategory({@category_id});return false;" href="?m={/xml/configuration/module/@name}&amp;action=edit&amp;category_id={@category_id}">
						<xsl:value-of select="name" />
					</a> -->

					<xsl:value-of select="name" />

					<div class="tree-actions" >
						<a href="#modalEditCategory" data-toggle="modal" ><i class="fa fa-pencil" >&#xa0;</i></a>
						<a href="#modalAddCategory" data-toggle="modal" ><i class="fa fa-plus" >&#xa0;</i></a>
						<i class="fa fa-trash-o" >&#xa0;</i>
						<!-- <a class="btn btn-small" onclick="editCategory({@category_id});return false;" href="?m={/xml/configuration/module/@name}&amp;action=edit&amp;category_id={@category_id}"><i class="fa fa-pencil" >&#xa0;</i>&#xa0;Edit</a>
						<a class="btn btn-small" onclick="AddSubCategory({@category_id});return false;" href="?m={/xml/configuration/module/@name}&amp;action=BackDisplayAddChild&amp;category_id={@category_id}"><i class="icon-plus" >&#xa0;</i>&#xa0;Add Subcategory</a>
						<a class="btn btn-small" onclick="validate(this);return false;" href="{$adminroot}?m={$config/module/@name}&amp;action=BackRemove&amp;category_id={@category_id}" id="{@category_id}" ><i class="icon-remove" >&#xa0;</i>&#xa0;Delete</a> -->
					</div>
				</div>
				
			</div>
			<xsl:if test="categories/category">
				<div class="category-childs cat_{@category_id}">
				<xsl:call-template name="category_item">
					<xsl:with-param name="categories" select="categories"/>
				</xsl:call-template>
				</div>
			</xsl:if>
		</div>
	</xsl:for-each>


	<!-- MODAL EDIT -->
	<div id="modalEditCategory" class="modal fade">
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
						    <input type="email" class="form-control" value="" />
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
	<!-- // MODAL EDIT -->


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



</xsl:template>
</xsl:stylesheet>