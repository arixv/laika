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

	<div class="col-md-12">
		<section class="panel">
		<header class="panel-heading">Agregar Usuario de sistema</header>




		<div class="panel-body">
			<xsl:if test="$message!=''">
				<div class="user-msj">
					<xsl:value-of select="$message" />
				</div>
			</xsl:if>

		
			<form name="user" id="form_add" action="/admin/?m={$config/module/@name}&amp;action=BackAdd" method="post">

				<div class="position-center">

						<div class="form-group">
							<label>Username (requerido)</label>
							<input type="text" name="username" value="" class="form-control" />
						</div>
						<div class="form-group">
							<label>Nombre</label>
							<input type="text" name="user_name" value="{$user/name | $user/user_name}" class="form-control" />
						</div>
						<div class="form-group">
							<label>Apellido</label>
							<input type="text" name="user_lastname" value='{$user/lastname | $user/user_lastname}' class="form-control"  />
						</div>
						<div class="form-group">
							<label>E-mail (requerido)</label>
							<input type="text" name="user_email" value="{$user/email | $user/user_email}" class="form-control"  />
						</div>
						<div class="form-group">
							<label>Password</label>
							<input type="password" name="user_pass0" value="" class="form-control" />
						</div>
						<div class="form-group">
							<label>Repetir Password</label>
							<input type="password" name="user_pass1" value="" class="form-control" />
						</div>
						<div class="form-group">
							<label>Nivel de acceso</label>
							<select name="access_level" class="form-control">
								<xsl:for-each select="content/levels/level">
									<option value="{@level_id}"><xsl:value-of select="name" /></option>
								</xsl:for-each>
							</select>
						</div>
				</div>

				<div class="buttons floatFix">
<!-- 						<a href="#" class="btn" onclick="javascript:history.back();">Cancelar</a>&#xa0; -->
						<button type="button" onclick="$('#form_add').submit();" class="btn btn-info">Guardar</button>
				</div>
			</form>
		</div>
		</section>
	</div>


</xsl:template>
</xsl:stylesheet>