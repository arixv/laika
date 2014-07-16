<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:variable name="htmlHeadExtra">
	<link href="{$adminPath}/desktop/js/jvector-map/jquery-jvectormap-1.2.2.css" rel="stylesheet" />
	<link href="{$adminPath}/desktop/css/clndr.css" rel="stylesheet" />
	<link href="{$adminPath}/desktop/js/morris-chart/morris.css" rel="stylesheet"  />

</xsl:variable>

<xsl:variable name="htmlFooterExtra">
	<!--Morris Chart-->
	<script src="{$adminPath}/desktop/js/morris-chart/morris.js">&#xa0;</script>
	<script src="{$adminPath}/desktop/js/gauge/gauge.js">&#xa0;</script>
	<script src="{$adminPath}/desktop/js/morris-chart/raphael-min.js">&#xa0;</script>
	<script src="{$adminPath}/desktop/js/easypiechart/jquery.easypiechart.js">&#xa0;</script>

    <!-- jQuery Flot Chart-->
    <script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.js">&#xa0;</script>
    <script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.tooltip.min.js">&#xa0;</script>
    <script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.resize.js">&#xa0;</script>
    <script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.pie.resize.js">&#xa0;</script>
    <script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.selection.js">&#xa0;</script>
    <script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.stack.js">&#xa0;</script>
    <script src="{$adminPath}/desktop/js/flot-chart/jquery.flot.time.js">&#xa0;</script>

	<script src="{$modPath}/desktop/js/dashboard.js" >&#xa0;</script>

</xsl:variable>

<xsl:template name="content">
   
    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon orange"><i class="fa fa-gavel">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span><xsl:value-of select="$content/total_presupuestos/total" /></span>
                Presupuestos
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon tar"><i class="fa fa-tag">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span><xsl:value-of select="$content/total_proyectos/total" /></span>
                Proyectos Activos
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon pink"><i class="fa fa-money">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span>20</span>
                Proyectos Excedidos
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon green"><i class="fa fa-eye">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span>20</span>
                Clientes con Proyectos
            </div>
        </div>
    </div>



	<div class="col-md-8">
		<!--widget graph start-->
        <section class="panel">
            <header class="panel-heading">Estado de Proyectos</header>
            <div class="panel-body">
                 <div id="pie-chart-donut" class="pie-chart">
                    <div id="pie-donutContainer" style="width: 100%;height:400px; text-align: left;">&#xa0;
                    </div>
                </div>
            </div>
        </section>

        <!--widget graph end-->
     </div>

 

     <div class="col-md-4">
	    <section class="panel">
	        <div class="panel-body">
	            <div class="top-stats-panel">
	                <div class="gauge-canvas">
	                    <h4 class="widget-h">Total Presupuestado<br/>$500,000</h4>
	                    <canvas width="160" height="100" id="gauge"></canvas>
	                </div>
	                <ul class="gauge-meta clearfix">
	                    <li id="gauge-textfield" class="pull-left gauge-value">250,000</li>
	                    <li class="pull-right gauge-title">Safe</li>
	                </ul>
	            </div>
	        </div>
	    </section>
    </div>


<!--     <div class="col-md-12">
        <section class="panel">
            <div class="panel-body">
                <div class="top-stats-panel">
                    <h4 class="widget-h">Proyectos Activos</h4>
                    <div class="bar-stats">
                        <ul class="progress-stat-bar clearfix">
                            <li data-percent="50%"><span class="progress-stat-percent pink" style="height: 50%;">&#xa0;</span></li>
                            <li data-percent="90%"><span class="progress-stat-percent" style="height: 90%;">&#xa0;</span></li>
                            <li data-percent="70%"><span class="progress-stat-percent yellow-b" style="height: 70%;">&#xa0;</span></li>
                        </ul>

                        <ul class="bar-legend">
                            <li><span class="bar-legend-pointer pink">&#xa0;</span> Proyecto X</li>
                            <li><span class="bar-legend-pointer green">&#xa0;</span> Proyecto Xx</li>
                            <li><span class="bar-legend-pointer yellow-b">&#xa0;</span> Proyecto Xxx</li>
                        </ul>
                     
                    </div>
                </div>
            </div>
        </section>
    </div> -->



	<div class="col-md-12">
    	<section class="panel">
    		<header class="panel-heading">Proveedores con Facturas Impagas</header>
    		<div class="panel-body">
    			<table class="table">
    				<thead>
    					<tr>
    						<th>#Factura</th>
    						<th>Proveedor</th>
    						<th>Fecha</th>
    						<th>Monto</th>
                            <th>Acciones</th>
    					</tr>
    				</thead>
    				<tbody>
                        <xsl:for-each select="$content/proveedores_impagos/object">
    					<tr>
    						<td><xsl:value-of select="number" /></td>
    						<td><xsl:value-of select="title" /></td>
    						<td><xsl:value-of select="date" /></td>
    						<td>$ <xsl:value-of select="amount" /></td>
                            <td><a href="/admin/project/list_factura/{project_id}" class="btn btn-sm btn-info">Editar</a></td>
    					</tr>
                        </xsl:for-each>
    					
    				</tbody>
    			</table>
    		</div>
    	</section>
    </div>


    <div class="col-md-6">
    	<section class="panel">
    		<header class="panel-heading">Top 5 Rubros más costos</header>
    		<div class="panel-body">
    			<table class="table">
    				<thead>
    					<tr>
    						<th>Subrubro</th>
    						<th>Monto</th>
    					</tr>
    				</thead>
    				<tbody>
                        <xsl:for-each select="$content/rubros_mas_costosos/object">
        					<tr>
        						<td><xsl:value-of select="title" /></td>
        						<td>$ <xsl:value-of select="cost" /></td>
        					</tr>
                        </xsl:for-each>
    				</tbody>
    			</table>
    		</div>
    	</section>
    </div>

    <div class="col-md-6">
    	<section class="panel">
    		<header class="panel-heading">Top 5 Rubros más utilizados</header>
    		<div class="panel-body">
    			<table class="table">
    				<thead>
    					<tr>
    						<th>Subrubro</th>
    					</tr>
    				</thead>
    				<tbody>
    					<xsl:for-each select="$content/rubros_mas_utilizados/object">
                            <tr>
                                <td><xsl:value-of select="title" /></td>
                            </tr>
                        </xsl:for-each>
    				</tbody>
    			</table>
    		</div>
    	</section>
    </div>

</xsl:template>
</xsl:stylesheet>