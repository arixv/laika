<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:variable name="htmlHeadExtra">
	<script type="text/javascript" src="{$modPath}/desktop/js/users.js">&#xa0;</script>
</xsl:variable>
<xsl:param name="page" />
<xsl:param name="query" />

<xsl:template name="content">


<div class="row">
	<div class="col-sm-12">
		<ul class="breadcrumb">
	        <li ><i class="fa fa-home">&#xa0;</i> <xsl:value-of select="$config/module/@title" /></li>
	    </ul>
	</div>
</div>

<div class="row">
	<div class="col-sm-12">
		<section class="panel">

			<header class="panel-heading wht-bg">
				<div class="btn-group pull-right">
					<a href="{$adminroot}{$modulename}/add" class="btn btn-info">Agregar&#xa0;<i class="fa fa-plus">&#xa0;</i></a>
				</div>
				<h4><xsl:value-of select="$config/module/@title" />&#xa0;</h4>
			</header>

			<table class="table  table-hover general-table" id="grid">
				<thead>
					<tr>
						
						<th>Nombre Usuario</th>
						<th>Nombre </th>
						<th>Apellido</th>
						<th>Email</th>
						<th>Rol</th>
						<th>Acciones</th>
					</tr>
				</thead>
				
				<tbody>
					<xsl:for-each select="content/users/user">
						<tr id="user_{@user_id}">
							<td>
								<a href="{$config/system/adminpath}{$config/module/@name}/edit/{@user_id}/">
									<xsl:value-of select="username" />
								</a>
							</td>
							<td>
								<xsl:value-of select="name" />
							</td>
							<td>
								<xsl:value-of select="lastname" />
							</td>
							<td>
								<xsl:value-of select="email" />
							</td>
							<td>
								<xsl:value-of select="role/user_level_description" />
							</td>
							<td>
								<a class="btn btn-sm btn-info" href="{$config/system/adminpath}{$config/module/@name}/edit/{@user_id}/" title="Editar">
									<i class="fa fa-pencil" >&#xa0;</i> 
									Editar
								</a>
								<xsl:if test="username!='admin'">
									<a class="btn btn-sm btn-default" href="#" onclick="deleteUser({@user_id});return false;" title="Borrar usuario">
										<i class="fa fa-trash-o" >&#xa0;</i> 
										Borrar
									</a>
								</xsl:if>
							</td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>

		</section>
	</div>
</div>

</xsl:template>
</xsl:stylesheet>