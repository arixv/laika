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

	<div class="content100 showTools">

		<xsl:variable name="user" select="content/user" />
		<form name="user" action="/admin/?m={$config/module/@name}&amp;action=BackEdit" method="post">
			<input type="hidden" name="user_id" value="{$user/@user_id}" />
			
			<div class="list-header rounded floatFix">
				<span class="right"><!-- 
				 --><a href="{$adminroot}{$modName}/return/" class="btn">Volver sin guardar</a>&#xa0;<!-- 
				 --><button type="submit" class="btn btn-inverse save"><span>Guardar</span></button>&#xa0;<!-- 
			 --></span>

				<h2 class="techo">Editar datos de Usuario</h2>
			</div>

			
			<div class="edit-body">
				<div class="box-overflow">
				
					<div id="tools" style="margin:0;">
						<div class="padding">
							<span class="stop"></span>
							<ul id="sorteable-0">
								<li class="header">
									<h3>Nivel de acceso</h3>
								</li>
								<li class="collapsable avatar">
									<select name="access_level">
										<xsl:for-each select="content/levels/level">
											<option value="{@level_id}">
												<xsl:if test="/xml/content/user/@access_level = @level_id">
													<xsl:attribute name="selected">selected</xsl:attribute>
												</xsl:if>
												<xsl:value-of select="name" />
											</option>
										</xsl:for-each>
									</select>
								</li>
							</ul>
							<ul id="sorteable-1">
								<li class="header">
									<h3>Enviar</h3>
								</li>
								<li class="collapsable user">
									<p>Enviar los datos de acceso al usuario por e-mail</p>
									<a id="sendEmail" class="botoncito" href="#" style="display:block;width:80px;margin:auto;" onclick="sendMail({$user/@user_id});return false;">Enviar E-mail</a>
								</li>
							</ul>
							<span class="stop"></span>
						</div>
					</div>

					<div class="box">

						<xsl:if test="$message!=''">
							<div class="alert alert-error">
								<xsl:value-of select="$message" />
							</div>
						</xsl:if>

						<ul class="form">
							<li>
								<label>Username (requerido)</label>
								<input type="text" name="username" value="{$user/username}"/>
							</li>
							<li>
								<label>Nombre</label>
								<input type="text" name="user_name" value="{$user/name | $user/user_name}"/>
							</li>
							<li>
								<label>Apellido</label>
								<input type="text" name="user_lastname" value='{$user/lastname | $user/user_lastname}'/>
							</li>
							<li>
								<label>E-mail (requerido)</label>
								<input type="text" name="user_email" value="{$user/email | $user/user_email}"/>
							</li>
							<li>
								<label>Contraseña Actual (para no modificar la contraseña dejar este campo en blanco)</label>
								<input type="password" name="user_pass" value=""/>
								<p></p>
							</li>
							<li>
								<label>Nueva Contaseña (para no modificar la contraseña dejar este campo en blanco)<!--(actual: <xsl:value-of select="$pass" />)--></label>
								<input type="password" name="user_pass0" value=""/>
							</li>
							<li>
								<label>Repetir Nueva Contaseña (para no modificar la contraseña dejar este campo en blanco)</label>
								<input type="password" name="user_pass1" value=""/>
								<p></p>
							</li>
						</ul>
					</div>
				</div>
			</div>

		</form>
	</div>


</xsl:template>
</xsl:stylesheet>