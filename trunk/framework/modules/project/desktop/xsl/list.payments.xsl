<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="sort" />

<xsl:variable name="htmlHeadExtra">
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/jquery-multi-select/css/multi-select.css" />
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/js/select2/select2.css" />

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
	<script type="text/javascript" src="{$adminPath}/desktop/js/module.list.js" >&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/js/module.edit.js" >&#xa0;</script>
	<script type="text/javascript" src="{$modPath}/desktop/js/project.edit.js"  >&#xa0;</script>
</xsl:variable>

<xsl:template name="content">

	<xsl:variable name="object" select="$content/object" />

	<xsl:call-template name="project.nav">
		<xsl:with-param name="active" >payments</xsl:with-param>
	</xsl:call-template>

	<form name="list" id="list_form" action="{$adminroot}{$modulename}/list_payments/{$object/@id}/" method="get">
		<input type="hidden" name="sort" value="{$sort}" />
	</form>


<!-- FACTURAS -->
<div class="row">
	<div class="col-sm-12">

		
			
	

		<section class="panel">

			<header class="panel-heading wht-bg">
               <h4 class="gen-case">Pagos</h4>
            </header>

			<div class="panel-body">

				<table class="table table-striped">
					<thead>
						<tr>
							<th>
								<a href="#" data-sort="date" >Fecha</a>
								<xsl:if test="$sort = 'date'"><i class="fa fa-caret-down"></i></xsl:if>
							</th>
							<th>
								<a href="#" data-sort="type" >Recurso</a>
								<xsl:if test="$sort = 'type'"><i class="fa fa-caret-down"></i></xsl:if>
							</th>
							
							<th>
								<a href="#" data-sort="state" >Proveedor</a>
								<xsl:if test="$sort = 'provider.title'"><i class="fa fa-caret-down"></i></xsl:if>
							</th>
							<th>
								<a href="#" data-sort="amount" >Monto</a>
								<xsl:if test="$sort = 'amount'"><i class="fa fa-caret-down"></i></xsl:if>
							</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="$content/payments/payment">
							<tr id="payment_{id}">
								<td><xsl:call-template name="fecha.formato.numerico"><xsl:with-param name="fecha" select="date" /></xsl:call-template></td>
								<td><xsl:value-of select="resource/title" /></td>
								<td><xsl:value-of select="resource/provider_title" /></td>
								<td>$ <xsl:call-template name="format.price"><xsl:with-param name="amount" select="value" /></xsl:call-template></td>
							</tr>
						</xsl:for-each>
						
					</tbody>
				</table>
			</div>


		</section>



	</div>
</div>
<!-- //FACTURAS -->


<div id="modal" class="modal" tabindex="1" role="dialog" aria-hidden="true">&#xa0;</div>
	
</xsl:template>
</xsl:stylesheet>