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
	<div class="col-sm-12">
		<ul class="breadcrumb">
	        <li ><a href="/admin/admin"><i class="fa fa-home">&#xa0;</i> Usuarios</a></li>
	        <li >Editar Usuario</li>
	    </ul>
	</div>
</div>

<div class="row">
<!-- col-sm-12 -->
<div class="col-sm-12">


	<section class="panel">

		<!-- header -->
		<header class="panel-heading">Editar datos de Usuario</header>
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
					
					
					<div class="form-group">
						<label>Username (requerido)</label>
						<input type="text" name="username" class="form-control" value="{$user/username}"/>
					</div>
					<div class="form-group">
						<label>Nombre</label>
						<input type="text" name="user_name"  class="form-control" value="{$user/name | $user/user_name}"/>
					</div>
					<div class="form-group">
						<label>Apellido</label>
						<input type="text" name="user_lastname" class="form-control" value='{$user/lastname | $user/user_lastname}'/>
					</div>
					<div class="form-group">
						<label>E-mail (requerido)</label>
						<input type="text" name="user_email" class="form-control" value="{$user/email | $user/user_email}"/>
					</div>
					<div class="form-group">
						<label>Contraseña Actual (para no modificar la contraseña dejar este campo en blanco)</label>
						<input type="password" name="user_pass" class="form-control" value=""/>
						<p></p>
					</div>
					<div class="form-group">
						<label>Nueva Contaseña (para no modificar la contraseña dejar este campo en blanco)<!--(actual: <xsl:value-of select="$pass" />)--></label>
						<input type="password" name="user_pass0" class="form-control" value=""/>
					</div>
					<div class="form-group">
						<label>Repetir Nueva Contaseña (para no modificar la contraseña dejar este campo en blanco)</label>
						<input type="password" name="user_pass1" class="form-control" value=""/>
						<p></p>
					</div>

					<div class="form-group">
						<label>Nivel de acceso</label>
						<select name="access_level" class="form-control">
							<xsl:for-each select="content/levels/level">
								<option value="{@level_id}">
									<xsl:if test="/xml/content/user/@access_level = @level_id">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="description" />
								</option>
							</xsl:for-each>
						</select>
					</div>

						
					 <button type="submit" class="btn btn-info save"><span>Guardar</span></button>
					 <a href="{$adminroot}{$modName}/return/" class="btn btn-default">Volver</a>


	
								

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