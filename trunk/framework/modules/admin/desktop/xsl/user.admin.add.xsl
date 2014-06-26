<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="message" />
<xsl:param name="pass" />
<xsl:variable name="htmlHeadExtra">
	<!-- <script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script> -->
</xsl:variable>


<xsl:variable name="user" select="content/user" />


<xsl:template name="content">

	<div class="content100 showTools">

		<div class="list-header">
			<div class="buttons floatFix">
					<a href="#" class="btn" onclick="javascript:history.back();">Cancelar</a>&#xa0;
					<button type="button" onclick="$('#form_add').submit();" class="btn btn-inverse">Guardar</button>
			</div>

			<h2 class="techo">Agregar Usuario de sistema</h2>
		</div>


		<div class="edit-body">
			<xsl:if test="$message!=''">
				<div class="user-msj">
					<xsl:value-of select="$message" />
				</div>
			</xsl:if>

		
			<form name="user" id="form_add" action="/admin/?m={$config/module/@name}&amp;action=BackAdd" method="post">

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
										<option value="{@level_id}"><xsl:value-of select="name" /></option>
									</xsl:for-each>
								</select>
							</li>
						</ul>
						
						<span class="stop"></span>
					</div>
				</div>

				<div class="box">
					<ul class="form">
						<li>
							<label>Username (requerido)</label>
							<input type="text" name="username" value=""/>
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
							<label>Password</label>
							<input type="password" name="user_pass0" value=""/>
						</li>
						<li>
							<label>Repetir Password</label>
							<input type="password" name="user_pass1" value=""/>
						</li>
					</ul>
				</div>

				
			</form>
		</div>
	</div>


</xsl:template>
</xsl:stylesheet>