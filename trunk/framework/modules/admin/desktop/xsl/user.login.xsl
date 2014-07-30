<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />

<xsl:param name="referer" />
<xsl:param name="email" />
<xsl:param name="message" />
<xsl:param name="call" />

<xsl:variable name="config" select="/xml/configuration" />
<xsl:variable name="content" select="/xml/content" />

<xsl:template match="/xml">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Login <xsl:value-of select="$config/system/applicationID" /></title>
	<link rel="stylesheet" type="text/css" href="{$modPath}/desktop/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="{$modPath}/desktop/css/debug.css" />
	<link rel="stylesheet" type="text/css" href="{$modPath}/desktop/css/style.css" />
	<link rel="stylesheet" type="text/css" href="{$modPath}/desktop/css/style-responsive.css" />
	<link rel="stylesheet" type="text/css" href="{$modPath}/desktop/font-awesome/css/font-awesome.css" />
	<script src="{$modPath}/desktop/js/jquery-1.7.1.min.js" />
</head>

<body class="login-body">

	<div class="container" >
		<xsl:choose>
			<xsl:when test="$call = 'password'">
					      

					<form class="form-signin" name="user" action="/admin/login/pass-send" method="post">
						<label>Email</label>
						<input type="text" name="email" />
						<button type="submit">Enviar Password</button>
					</form>
				
			</xsl:when>
			<xsl:when test="$call = 'pass-sended'">
				
					Los detalles de tu cuenta han sido enviados a tu casilla de email.<br/>
					<a href="/admin/login">Volver al login</a>
				
			</xsl:when>
			<xsl:when test="$call = 'notexist'">
				
					<div class="mensaje">
						El e-mail que ingresaste no pertenece a un usuario existente.
					</div>
					<form class="form-signin" name="user" action="/admin/login/pass-send" method="post">
						<h2 class="form-signin-heading">Ingresar email</h2>
						<div class="login-wrap" >
							<div class="user-login-info">
								<input type="text" name="email" class="form-control" placeholder="Email" />
							</div>
							<button type="submit">Enviar Password</button>
						</div>
					</form>
				
			</xsl:when>
			<xsl:otherwise>
				
					<xsl:if test="$message!=''">
						<div class="mensaje">
							<xsl:value-of select="$message"/>
						</div>
					</xsl:if>
					<form name="user" class="form-signin" action="{$config/system/adminpath}login/run" method="post" id="user" autocomplete="off">
						<h2 class="form-signin-heading">Login</h2>
						<div class="login-wrap" >
							<div class="user-login-info">
								<input type="hidden" name="referer" value="{$referer}" />
								<input type="text" name="username" class="form-control" placeholder="Nombre de Usuario" />
								<input type="password" name="password" class="form-control" placeholder="contraseña" />
							</div>
							<button class="btn btn-lg btn-login btn-block" type="submit">Ingresar</button>
						</div>
					</form>
					<!-- <a href="/admin/login/recover-pass">Olvidé mi contraseña</a> -->
				
			</xsl:otherwise>
		</xsl:choose>
	</div>
	
	<xsl:if test="$debug=1">
		<xsl:call-template name="debug" />
	</xsl:if>
</body>
</html>

</xsl:template>


</xsl:stylesheet>