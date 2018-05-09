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

<script>
 $('.panel .tools .fa').click( function() {
 	rubro_id = $(this).attr('data-id');
    var el = $("#rubro_body_" + rubro_id );
    console.log( el );
    if ($(this).hasClass("fa-chevron-down")) {
        $(this).removeClass("fa-chevron-down").addClass("fa-chevron-up");
        el.show();
    } else {
        $(this).removeClass("fa-chevron-up").addClass("fa-chevron-down");
        el.hide();
    }
});
</script>

<div id="modal" class="modal fade" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>



</xsl:template>


<!-- RUBRO ITEM -->
<xsl:template name="rubro_item">
	<xsl:param name="rubros" />
	<xsl:param name="icon" />
	
	<xsl:for-each select="$rubros/rubro">
		<xsl:sort order="ascending" select="@order" data-type="number"/>
		<xsl:sort order="ascending" select="name" />

		<section  class="panel" id="rubro_{@id}" style="border:1px solid #ccc;">
			<header class="panel-heading clearfix">
					<div class="btn-group pull-right">
						<button class="btn btn-primary btn-sm btn-edit-rubro" data-id="{@id}"><i class="fa fa-edit">&#xa0;</i> Editar</button>
						<button class="btn btn-primary btn-sm btn-delete-rubro" data-id="{@id}"><i class="fa fa-edit">&#xa0;</i> Eliminar</button>
					</div>
                
                    
					<div class="tools">
						<xsl:if test="rubros/rubro">
							<a class="fa fa-chevron-down" data-id="{@id}" href="javascript:;">&#xa0;</a>
						</xsl:if>
						<xsl:value-of select="title" />

						<xsl:if test="sindicato_name != ''">
							&#xa0;&#xa0;&#xa0;<span class="label label-warning">sindicato: <xsl:value-of select="sindicato_name" /></span>
						</xsl:if>

					</div>
			</header>

			<div class="panel-body" id="rubro_body_{@id}" style="display:none;" >
				<xsl:for-each select="rubros/rubro">
					<div class="panel" id="rubro_{@id}" style="border:1px solid #ccc;" >
						<header class="panel-heading clearfix">

							<div class="btn-group pull-right">
								<button data-id="{@id}" class="btn btn-primary btn-sm btn-edit-rubro" ><i class="fa fa-edit">&#xa0;</i> Editar</button>
								<button data-id="{@id}" class="btn btn-primary btn-sm btn-delete-rubro"><i class="fa fa-trash-o">&#xa0;</i> Eliminar</button>
							</div>
							
							<div class="tools">
								<xsl:if test="rubros/rubro">
									<a class="fa fa-chevron-down" data-id="{@id}" href="javascript:;">&#xa0;</a>
								</xsl:if>
								<xsl:value-of select="title" />

								<xsl:if test="sindicato_name != ''">
									&#xa0;&#xa0;&#xa0;<span class="label label-warning">sindicato: <xsl:value-of select="sindicato_name" /></span>
								</xsl:if>
								
							</div>

						</header>

						<xsl:variable name="rubro" select="." />
						<xsl:if test="$rubro/rubros/rubro">
							<div class="panel-body" id="rubro_body_{@id}" style="display:none;" >
								<xsl:call-template name="rubro_item">
									<xsl:with-param name="rubros" select="$rubro/rubros"/>
									<xsl:with-param name="icon" select="'fa-folder'"/>
								</xsl:call-template>
							</div>
						</xsl:if>
					</div>
				</xsl:for-each>
			</div>
		</section>
	</xsl:for-each>


	


      

</xsl:template>
</xsl:stylesheet>