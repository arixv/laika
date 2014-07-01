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
	<script src="{$modPath}/desktop/js/dashboard.js" >&#xa0;</script>

</xsl:variable>

<xsl:template name="content">
   
    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon orange"><i class="fa fa-gavel">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span>320</span>
                Presupuestos
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="mini-stat clearfix">
            <span class="mini-stat-icon tar"><i class="fa fa-tag">&#xa0;</i></span>
            <div class="mini-stat-info">
                <span>50</span>
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
            <div class="panel-body">
                <div class="monthly-stats pink">
                    <div class="clearfix">
                        <h4 class="pull-left">January 2013</h4>
                        <!-- Nav tabs -->
                        <div class="btn-group pull-right stat-tab">
                            <a href="#line-chart" class="btn stat-btn active" data-toggle="tab"><i class="ico-stats">&#xa0;</i></a>
                            <a href="#bar-chart" class="btn stat-btn" data-toggle="tab"><i class="ico-bars">&#xa0;</i></a>
                        </div>
                    </div>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" id="line-chart">
                            <div class="sparkline" data-type="line" data-resize="true" data-height="75" data-width="90%" data-line-width="1" data-min-spot-color="false" data-max-spot-color="false" data-line-color="#ffffff" data-spot-color="#ffffff" data-fill-color="" data-highlight-line-color="#ffffff" data-highlight-spot-color="#e1b8ff" data-spot-radius="3" data-data="[100,200,459,234,600,800,345,987,675,457,765]">&#xa0;</div>
                        </div>
                        <div class="tab-pane" id="bar-chart">
                            <div class="sparkline" data-type="bar" data-resize="true" data-height="75" data-width="90%" data-bar-color="#d4a7f5" data-bar-width="10" data-data="[300,200,500,700,654,987,457,300,876,454,788,300,200,500,700,654,987,457,300,876,454,788]">&#xa0;</div>
                        </div>
                    </div>
                </div>
                <div class="circle-sat">
                    <ul>
                        <li class="left-stat-label"><span class="sell-percent">60%</span><span>Direct Sell</span></li>
                        <li>
                        	<span class="epie-chart" data-percent="45">
                        		<span class="percent">&#xa0;</span>
                        	</span>
                        </li>
                        <li class="right-stat-label"><span class="sell-percent">40%</span><span>Channel Sell</span></li>
                    </ul>
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


    <div class="col-md-12">
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
                        <!-- <div class="daily-sales-info">
                            <span class="sales-count">1200 </span> <span class="sales-label">Products Sold</span>
                        </div> -->
                    </div>
                </div>
            </div>
        </section>
    </div>


   <div class="col-md-12">
        <section class="panel">
            <div class="panel-body">
                <div class="top-stats-panel">
                    <h4 class="widget-h">Top Advertise</h4>
                    <div class="sm-pie">&#xa0;</div>
                </div>
            </div>
        </section>
    </div>

	<div class="col-md-12">
    	<section class="panel">
    		<header class="panel-heading">Proveedores con Facturas Impagas</header>
    		<div class="panel-body">
    			<table class="table">
    				<thead>
    					<tr>
    						<th>#</th>
    						<th>Proveedor</th>
    						<th>Facturas</th>
    						<th>Monto</th>
    					</tr>
    				</thead>
    				<tbody>
    					<tr>
    						<td>1</td>
    						<td>Mark</td>
    						<td>Otto</td>
    						<td>$ 120</td>
    					</tr>
    					<tr>
    						<td>2</td>
    						<td>Mark</td>
    						<td>Otto</td>
    						<td>$ 120</td>
    					</tr>
    					<tr>
    						<td>3</td>
    						<td>Mark</td>
    						<td>Otto</td>
    						<td>$ 120</td>
    					</tr>
    					<tr>
    						<td>4</td>
    						<td>Mark</td>
    						<td>Otto</td>
    						<td>$ 120</td>
    					</tr>
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
    						<th>Rubro</th>
    						<th>Subrubro</th>
    						<th>Monto</th>
    					</tr>
    				</thead>
    				<tbody>
    					<tr>
    						<td>Mark</td>
    						<td>Otto</td>
    						<td>$ 120</td>
    					</tr>
    					<tr>
    						<td>Mark</td>
    						<td>Otto</td>
    						<td>$ 120</td>
    					</tr>
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
    						<th>Rubro</th>
    						<th>Subrubro</th>
    						<th>Monto</th>
    					</tr>
    				</thead>
    				<tbody>
    					<tr>
    						<td>Mark</td>
    						<td>Otto</td>
    						<td>$ 120</td>
    					</tr>
    					<tr>
    						<td>Mark</td>
    						<td>Otto</td>
    						<td>$ 120</td>
    					</tr>
    				</tbody>
    			</table>
    		</div>
    	</section>
    </div>

</xsl:template>
</xsl:stylesheet>