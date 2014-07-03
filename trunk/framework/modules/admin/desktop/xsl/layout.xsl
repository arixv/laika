<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
<!-- <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" /> -->

<!--Configuration path-->
<xsl:variable name="config" select="/xml/configuration" />
<xsl:variable name="content" select="/xml/content" />
<xsl:variable name="context" select="/xml/context" />
<xsl:variable name="adminroot" select="$config/system/adminpath" />
<xsl:variable name="modulename" select="$config/module/@name" />

<xsl:variable name="lang" select="document('../framework/modules/admin/desktop/lang/es.xml')/xml" />

<xsl:template match="/xml">
<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html>
</xsl:text>
<html lang="en">
<head>
	<xsl:call-template name="htmlHead" />
</head>
<body>
	<section id="container">
		<xsl:call-template name="header" />	
		<xsl:call-template name="navigation" />
		<section id="main-content">
			<section class="wrapper">
				<xsl:call-template name="content" />
			</section>
		</section>

		<xsl:call-template name="debug" />
		
		<xsl:call-template name="htmlFooter" />
		
	</section>
</body>
</html>

</xsl:template>


</xsl:stylesheet>