<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:template name="content">

	<div class="content100">

		<div class="list-header">
			<h1>Dashboard</h1>
		</div>
	<div class="edit-body box dashboard">
			
			<xsl:for-each select="$config/navigation/item">
				<a href="{$config/system/adminpath}{@name}">

					<span>
						<i class="icon_box">&#160;</i>
						<xsl:value-of select="@display" />
					</span></a>
			</xsl:for-each>
		</div>
	</div>
</xsl:template>
</xsl:stylesheet>