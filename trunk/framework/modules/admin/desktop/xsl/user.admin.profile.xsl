<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="message" />
<xsl:param name="pass" />
<xsl:variable name="htmlHeadExtra">
	<script src="{$modPath}/desktop/js/users.js" type="text/javascript">&#xa0;</script>
	<!-- <script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script> -->
</xsl:variable>



<xsl:template name="content">


<div class="row">
	<div class="col-sm-12">
		<ul class="breadcrumb">
	        <li ><a href="/admin/admin"><i class="fa fa-home">&#xa0;</i> Usuarios</a></li>
	        <li >Mi Perfil</li>
	    </ul>
	</div>
</div>

<xsl:variable name="user" select="content/user" />

<div class="row">
	<div class="col-sm-12">
		<section class="panel">
			<header class="panel-heading">Editar Mi Perfil</header>

			<!-- panel-body -->
			<div class="panel-body">


				<!-- position-center -->		
				<div class="position-center">

						<form name="user" action="/admin/?m={$config/module/@name}&amp;action=BackEditMyData" method="post">
							<input type="hidden" name="user_id" value="{$user/@user_id}" />

									<xsl:if test="$message!=''">
										<div class="alert alert-error">
											<xsl:value-of select="$message" />
										</div>
									</xsl:if>

									<div class="form-group">
											<label>Username (requerido)</label>
											<input type="text" class="form-control" name="username" value="{$user/username}"/>
									</div>
									<div class="form-group">
											<label>Nombre</label>
											<input type="text" class="form-control" name="user_name" value="{$user/name | $user/user_name}"/>
									</div>
									<div class="form-group">
											<label>Apellido</label>
											<input type="text" class="form-control" name="user_lastname" value='{$user/lastname | $user/user_lastname}'/>
									</div>
									<div class="form-group">
											<label>E-mail (requerido)</label>
											<input type="text" class="form-control" name="user_email" value="{$user/email | $user/user_email}"/>
									</div>
									<div class="form-group">
											<label>Contraseña Actual (para no modificar la contraseña dejar este campo en blanco)</label>
											<input type="password" class="form-control" name="user_pass" value=""/>
											<p></p>
									</div>
									<div class="form-group">
											<label>Nueva Contaseña (para no modificar la contraseña dejar este campo en blanco)<!--(actual: <xsl:value-of select="$pass" />)--></label>
											<input type="password" class="form-control" name="user_pass0" value=""/>
									</div>
									<div class="form-group">
											<label>Repetir Nueva Contaseña (para no modificar la contraseña dejar este campo en blanco)</label>
											<input type="password" class="form-control" name="user_pass1" value=""/>
											<p></p>
									</div>
									<div class="form-group">
										<a href="{$adminroot}{$modName}/return/" class="btn">Volver sin guardar</a>
										<button type="submit" name="back" value="1" class="btn save-back"><span>Guardar y volver</span></button>
										<button type="submit" class="btn btn-primary save"><span>Guardar</span></button>
									</div>
					</form>
				</div>
			</div>
		</section>
	</div>
</div>

</xsl:template>
</xsl:stylesheet>