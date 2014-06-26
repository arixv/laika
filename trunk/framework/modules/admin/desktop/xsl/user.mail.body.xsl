<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />


<xsl:variable name="cellsPerRow">3</xsl:variable>

<xsl:param name="pass" />
<xsl:param name="call" />

<xsl:variable name="config" select="/xml/configuration" />

<xsl:template match="/xml">

	
<html>
	<head>
		<title><xsl:value-of select="$config/ApplicationID"/> | User Details</title>
	</head>
	<body class="mdn_modal">
		<xsl:choose>
			<xsl:when test="$call = 'recover'">
			</xsl:when>
			<xsl:otherwise>
				<p style="font:normal 13px/17px arial,sans-serif;color:#444;">
					Hola <xsl:value-of select="content/user/name"/>,<br/>
					Estos son los datos de acceso al sistema de <a href="{$config/system/domain}/admin"><xsl:value-of select="$config/system/applicationID" /></a>
				</p>
				<p style="font:normal 13px/17px arial,sans-serif;color:#444;">
					Usuario: <xsl:value-of select="content/user/username"/><br/>
					Password: <xsl:value-of select="$pass"/><br/>
				</p>
				<p style="font:normal 13px/17px arial,sans-serif;color:#444;">
					Para acceder ingresá en: <a href="{$config/system/domain}{$config/system/adminpath}"><xsl:value-of select="$config/system/domain" /><xsl:value-of select="$config/system/adminpath" /></a>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</body>
</html>

</xsl:template>


</xsl:stylesheet>