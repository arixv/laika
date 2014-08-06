<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />

<!--The system pass the current url to the transformation-->
<xsl:param name="modName" />
<xsl:param name="action" />

<xsl:variable name="action2">action=<xsl:value-of select="$action" /></xsl:variable>
<xsl:variable name="group"><!--
	--><xsl:choose><!--
		--><xsl:when test="$action = ''"><!--
			--><xsl:value-of select="//item[@name = $modName][.//subitem/@url = '']/@group" /><!--
		--></xsl:when><!--
		--><xsl:otherwise><!--
			--><xsl:value-of select="//item[@name = $modName][.//subitem/@url = $action2]/@group" /><!--
		--></xsl:otherwise><!--
	--></xsl:choose><!--
--></xsl:variable>

<xsl:template name="header">
	<header class="header fixed-top clearfix" >
		<div class="brand">
			<a href="/admin/" class="logo">
        		<img src="{$adminPath}/desktop/imgs/logos/logo.png" alt="" />
    		</a>
    		<div class="sidebar-toggle-box">
        		<div class="fa fa-bars">&#xa0;</div>
    		</div>
		</div>

		<div class="top-nav clearfix">
				<ul class="nav pull-right top-menu">
					<li>
						<form name="search" method="get" action="/admin/{$modName}/search/">
							<input type="text" name="q" class="form-control search" />
						</form>
					</li>
					<li class="dropdown">
						<a data-toggle="dropdown" class="dropdown-toggle" href="#">
							<img src="{$adminPath}/desktop/imgs/avatar.jpg" alt="" />
							<span class="username">
								<xsl:value-of select="$config/user/name" />&#xa0;<xsl:value-of select="$config/user/lastname" /> 
							</span>
							<b class="caret">&#xa0;</b>
						</a>

						<ul class="dropdown-menu extended logout">
							<li><a href="{$adminroot}admin/user/edit/"><i class=" fa fa-suitcase">&#xa0;</i>Mi cuenta</a></li>
							<li class="divider">&#xa0;</li>
							<li>
								<a href="{$adminroot}logout/">
									<i class="fa fa-key">&#xa0;</i>
								Salir</a>
							</li>
						</ul>
					</li>
				</ul>
		</div>
			
	</header>
</xsl:template>


<xsl:template name="navigation">

	<!-- <div id="mdn_config">
		&#xa0;
		<div class="icons">
			<a href="#" onclick="displayGroup('home');" class="icon_home">Home</a>
			<a href="#" onclick="displayGroup('content')" class="icon_content">Contenido</a>
			<a href="#" onclick="displayGroup('multimedia')" class="icon_multimedia">Multimedias</a>
			<a href="#" onclick="displayGroup('configuration')" class="icon_config">Administración</a>
		</div>
	</div> -->

	<aside>
	<div id="sidebar" class="nav-collapse" >
		<div class="leftside-navigation">
		<xsl:variable name="user_access" select="/xml/configuration/user/@access" />

		<ul class="sidebar-menu" >
			<!-- <li>
                <a href="index.html">
                	<xsl:choose>
					<xsl:when test="@name = 'dashboard'">
						<xsl:attribute name="class">active</xsl:attribute>
					</xsl:when>
					</xsl:choose>
                    <i class="fa fa-dashboard">&#xa0;</i>
                    <span>Dashboard</span>
                </a>
            </li> -->
				<xsl:for-each select="$config/navigation/item">
					<xsl:sort order="ascending" select="@order" data-type="number"/>
					<xsl:if test="not(@access_level) or @access_level='all' or contains(@access_level, $user_access)">
						<xsl:call-template name="navigation.item" />
					</xsl:if>
				</xsl:for-each>
		</ul>
			
			

			<!--MULTIMEDIAS
			<div id="mdn_navgroup" class="rounded">
				<xsl:for-each select="$config/navigation/item[@group = 2 or @group ='multimedia']">
					<xsl:sort order="ascending" select="@order" data-type="number"/>
					<xsl:if test="not(@access_level) or @access_level='all' or contains(@access_level, $user_access)">
						<xsl:call-template name="navigation.item" />
					</xsl:if>
				</xsl:for-each>
			</div>
			MULTIMEDIAS-->
			
			
			
			<!--ADMINISTRACION
			<div id="mdn_navgroup" class="rounded">
				<xsl:for-each select="$config/navigation/item[@group = 3 or @group ='administration']">
					<xsl:sort order="ascending" select="@order" data-type="number"/>
					<xsl:if test="not(@access_level) or @access_level='all' or contains(@access_level, $user_access)">
						<xsl:call-template name="navigation.item" />
					</xsl:if>
				</xsl:for-each>
			</div>
			ADMINISTRACION-->
		</div>
	</div>
	</aside>
</xsl:template>



<xsl:template name="navigation.item">
	<xsl:variable name="module_name" select="@name" />

	<li>
		<xsl:if test="subitem"><xsl:attribute name="class">sub-menu dcjq-parent-li</xsl:attribute></xsl:if>

			<a  href="{$adminroot}{$module_name}/{subitem/@url}">

				<xsl:attribute name="class">
					<xsl:choose>
						<xsl:when test="@name = $modName">
							active <xsl:if test="subitem">dcjq-parent</xsl:if>				
						</xsl:when>
						<xsl:otherwise><xsl:if test="subitem">dcjq-parent</xsl:if></xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<i class="fa fa-rocket">&#xa0;</i> 
				<xsl:value-of select="@display"/>
				<span class="dcjq-icon">&#xa0;</span>
			</a>

			
			<xsl:if test="subitem">
			
				<ul class="sub" >
					<xsl:for-each select="subitem">
						<li>
							<xsl:if test="position() = last()"><xsl:attribute name="class">last</xsl:attribute></xsl:if>

							<xsl:variable name="thisUrl"><xsl:value-of select="$adminroot" /><xsl:value-of select="$modName"/>/<xsl:value-of select="@url" /></xsl:variable>
							<a href="{$adminroot}{$module_name}/{@url}">

								<xsl:if test="contains($page_url, $thisUrl)">
									<xsl:attribute name="class">selected</xsl:attribute>
								</xsl:if>
								<!-- <xsl:choose>
									<xsl:when test="(@url = '' and $action='') and parent::item/@name = $modName">
										<xsl:attribute name="class">selected</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:if test="($action = substring-after(@url, '=')) and parent::item/@name = $modName">
											<xsl:attribute name="class">selected</xsl:attribute>
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose> -->

								<xsl:value-of select="@name"/>
							</a>
						</li>
					</xsl:for-each>
				</ul>
			</xsl:if>
		</li>
</xsl:template>


</xsl:stylesheet>