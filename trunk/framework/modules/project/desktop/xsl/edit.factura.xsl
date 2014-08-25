<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="type" />

<!-- PROJECT OBJECT -->
<xsl:variable name="object" select="$content/object" />

<!-- HEAD EXTRA -->
<xsl:variable name="htmlHeadExtra">
	<script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script>
	<script src="{$modPath}/desktop/js/project.edit.js" type="text/javascript">&#xa0;</script>
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/jquery-multi-select/css/multi-select.css" />
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/select2/select2.css" />
	<script type="text/javascript" src="{$adminPath}/desktop/js/select2/select2.js">&#xa0;</script>
</xsl:variable>

<!-- FOOTER EXTRA -->
<xsl:variable name="htmlFooterExtra">

</xsl:variable>


<xsl:template name="content">

<xsl:call-template name="project.nav">
		<xsl:with-param name="active" >factura</xsl:with-param>
</xsl:call-template>


<div class="row">
		<div class="col-sm-12">		
			<ul class="breadcrumb">
		        <li ><a href="{$adminroot}{$modName}/list_factura/{$project_id}"><i class="fa fa-home">&#xa0;</i> Listar Facturas</a></li>
		    </ul>
		</div>
</div>

<form name="editFactura" role="form" action="/admin/?m=project&amp;action=BackEditFactura" method="post">
	<input type="hidden" name="project_id" value="{$project_id}" />
	<input type="hidden" name="factura_id" value="{$content/factura/id}" />

	<div class="row" >
		<div class="col-sm-12">
				<section class="panel">
					<header class="panel-heading wht-bg">
						<div class="form-group">
							<button type="submit" class="btn btn-info pull-right">Guardar</button>
						</div>
						<h4 class="gen-case">Editar Factura</h4>
					</header>
					<div class="panel-body">
						<xsl:call-template name="form.edit.factura" />
					</div>
				</section>
		</div>
	</div>
</form>






<div id="modal" class="modal fade" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>

</xsl:template>
</xsl:stylesheet>