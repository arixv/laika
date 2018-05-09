<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="message" />
<xsl:param name="pass" />
<xsl:variable name="htmlHeadExtra">
	<!-- <script src="{$modPath}/desktop/js/users.js" type="text/javascript">&#xa0;</script> -->
	<!-- <script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script> -->
</xsl:variable>




<xsl:template name="content">

<xsl:variable name="user" select="content/user" />

<div class="row">
<!-- col-sm-12 -->
<div class="col-sm-8 col-sm-offset-2">

	<section class="panel">

		<!-- header -->
		<header class="panel-heading">Editar Perfil</header>
		<!-- /header -->


		<!-- panel-body -->
		<div class="panel-body">


			<!-- position-center -->		
			<div class="position-center">


				<xsl:if test="$message!=''">
					<div class="alert alert-block alert-danger fade in">
						<xsl:value-of select="$message" />
					</div>
				</xsl:if>

				<form role="form" name="user" action="/admin/?m={$config/module/@name}&amp;action=BackEdit" method="post">
					<input type="hidden" name="user_id" value="{$user/@user_id}" />
					
					
					<div class="form-group row">
						<label class="col-lg-4">Usuario</label>
						<div class="col-lg-8">
							<input type="text" name="username" class="form-control" value="{$user/username}" disabled="disabled" />
						</div>
					</div>
					<div class="form-group row">
						<label class="col-lg-4">Nombre</label>
						<div class="col-lg-8">
							<input type="text" name="user_name"  class="form-control" value="{$user/name | $user/user_name}"/>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-lg-4">Apellido</label>
						<div class="col-lg-8" >
							<input type="text" name="user_lastname" class="form-control" value='{$user/lastname | $user/user_lastname}'/>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-lg-4">E-mail</label>
						<div class="col-lg-8" >
							<input type="text" name="user_email" class="form-control" value="{$user/email | $user/user_email}"/>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-lg-4">Nivel de acceso</label>
						<div class="col-lg-8" >
							<xsl:for-each select="content/levels/level">
									<xsl:if test="/xml/content/user/@access_level = @level_id">
										<p class="badge" ><xsl:value-of select="description" /></p>
									</xsl:if>
							</xsl:for-each>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-lg-4">
							Contraseña Actual<br/>							
						</label>
						<div class="col-lg-8">
							<input type="password" name="user_pass" class="form-control" value=""/>
							<small>(para no modificar la contraseña dejar este campo en blanco)</small>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-lg-4">Nueva Contaseña</label>
						<div class="col-lg-8">
							<input type="password" name="user_pass0" class="form-control" value=""/>
							<small> (para no modificar la contraseña dejar este campo en blanco)</small>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-lg-4" >Repetir Nueva Contaseña</label>
						<div class="col-lg-8">
							<input type="password" name="user_pass1" class="form-control" value=""/>
							 <small>(para no modificar la contraseña dejar este campo en blanco)</small>
						</div>
					</div>

					<div class="form-group row">
						<div class="col-lg-8 col-lg-offset-4">
					 		<button type="submit" class="btn btn-info btn-lg save"><span>Guardar</span></button>
					 	</div>
					</div>
								

				</form>
			</div>
			<!-- /position-center -->
		</div>
		<!-- panel-body -->

	</section>

</div>
<!-- /col-sm-12 -->
</div>
</xsl:template>
</xsl:stylesheet>