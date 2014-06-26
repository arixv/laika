<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!-- Elementos de formularios -->

<xsl:template name="form">
    <xsl:param name="element"/>
	<xsl:param name="action" />

	  <!--Es requisito que el id del elemento venga como atributo @id en el nodo-->
	  <form name="form{$element/@id}" action="{$action}" method="post">
		<xsl:apply-templates select="$element/*[type='hidden']" mode="hidden"/>
		<ul class="formulario">
      	<xsl:apply-templates select="$element/*[not(type='hidden')]"/>
		<li class="botones">
			<button type="submit">Guardar</button>
			<button onclick="javascript:history.back()" >Cancelar</button>
		</li>
		</ul>
	  </form>
  </xsl:template>

  
  <xsl:template match="item[type='hidden']" mode="hidden">
	<input type="hidden" name="{name}" value="{value}" />
  </xsl:template>

  <xsl:template match="item">
	<li>
		<xsl:choose>
			<xsl:when test="type='text'">
				<xsl:call-template name="textbox" />
			</xsl:when>
			<xsl:when test="type='textarea'">
				<xsl:call-template name="textarea" />
			</xsl:when>
			<xsl:when test="type='select'">
				<xsl:call-template name="select" />
			</xsl:when>
			<xsl:when test="type='checkbox'">
				<xsl:call-template name="checkbox" />
			</xsl:when>
			<xsl:when test="type='radio'">
				<xsl:call-template name="radio" />
			</xsl:when>
		</xsl:choose>
		

	</li>
  </xsl:template>

  <!--<xsl:template match="*[name()='item' and type='text']">
  	<xsl:apply-templates select="label"/>
  	<input type="text" name="{name}" value="{value}" />
  	<xsl:apply-templates select="description" />
    </xsl:template>

    <xsl:template match="item[type='textarea']">
  	<xsl:apply-templates select="label"/>
  	<textarea name="{name}"><xsl:value-of select="value" /></textarea>
  	<xsl:apply-templates select="description" />
    </xsl:template>-->

  

  <xsl:template match="item[@type='radio']/value">
	<xsl:apply-templates select="../label"/>
	<input type="radio" name="{../name}" value="{.}" />
	<xsl:apply-templates select="../status"/>
	<xsl:apply-templates select="../description" />
  </xsl:template>

  


  <xsl:template name="textbox">
	<xsl:apply-templates select="label"/>
  	<input type="text" name="{name}" value="{value}" />
  	<xsl:apply-templates select="description" />
  </xsl:template>

  <xsl:template name="textarea">
	<xsl:apply-templates select="label"/>
  	<textarea name="{name}"><xsl:value-of select="value" /></textarea>
  	<xsl:apply-templates select="description" />
  </xsl:template>

  <xsl:template name="select">
	<xsl:apply-templates select="label"/>
	<select name="{name}">
		<xsl:if test="onChange">
			<xsl:attribute name="onChange"><xsl:value-of select="onChange" /></xsl:attribute>
		</xsl:if>
		<xsl:for-each select="value/option">
			<option value="{value}">
				<xsl:if test="value=../selected">
					<xsl:attribute name="selected">selected</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="label" /></option>
		</xsl:for-each>
	</select>
	<xsl:apply-templates select="description" />
  </xsl:template>

  <xsl:template name="checkbox">
	<xsl:apply-templates select="label"/>
	<div class="checks">
	<xsl:for-each select="checkbox">
		<input type="checkbox" name="{../name}" value="{value}" id="{../name}{value}">
			<xsl:if test="value = ../status">
				<xsl:attribute name="checked">checked</xsl:attribute>
			</xsl:if>
		</input>
		<label for="{../name}{value}"><xsl:value-of select="label" /></label>
	</xsl:for-each>
	</div>
	<xsl:apply-templates select="../description" />
  </xsl:template>

  <xsl:template name="radio">
	<xsl:apply-templates select="label"/>
	<div class="checks">
	<xsl:for-each select="radio">
		<input type="radio" name="{../name}" value="{value}" id="{../name}{value}">
			<xsl:if test="value = ../status">
				<xsl:attribute name="checked">checked</xsl:attribute>
			</xsl:if>
		</input>
		<label for="{../name}{value}"><xsl:value-of select="label" /></label>
	</xsl:for-each>
	</div>
	<xsl:apply-templates select="../description" />
  </xsl:template>


  <xsl:template match="label">
	<label for="{../name}"><xsl:value-of select="." /></label>
  </xsl:template>

  
  


  <xsl:template match="*[*]" mode="docs">
    <div class="codigo"> 
      <!-- remove the number element if you don't need it
      <xsl:number />: 
      -->
      <span style="color:blue">&lt;</span><span style="color:brown"><xsl:value-of select="name()" /></span><xsl:apply-templates select="@*" mode="docs"/><span style="color:blue">&gt;</span>
      <xsl:apply-templates mode="docs"/>
      <span style="color:blue">&lt;/</span><span style="color:brown"><xsl:value-of select="name()" /></span><span style="color:blue">&gt;</span>
    </div>
  </xsl:template>
    
    
  <xsl:template match="*[not(*)]" mode="docs">
    <div class="codigo"> 
      <!-- remove the number element if you don't need it
      <xsl:number />: 
      -->
      <span style="color:blue">&lt;<xsl:value-of select="name()" /></span>
      <xsl:apply-templates select="@*" mode="docs"/>
      <span style="color:blue">/&gt;</span>
    </div>
  </xsl:template>
  
  <xsl:template match="*[not(*)][node()]" mode="docs">
    <div class="codigo">
      <!-- remove the number element if you don't need it
      <xsl:number />:
      --> 
      <span style="color:blue">&lt;</span>
      <span style="color:brown"><xsl:value-of select="name()" /></span>
      <xsl:apply-templates select="@*" mode="docs"/>
      <span style="color:blue">&gt;</span>
      <xsl:value-of select="node()"/>
      <span style="color:blue">&lt;/</span><span style="color:brown"><xsl:value-of select="name()" /></span><span style="color:blue">&gt;</span>
    </div>
  </xsl:template>
  
  <xsl:template match="@*" mode="docs">
    <span style="color:red"><xsl:text> </xsl:text><xsl:value-of select="name()" /></span>
    <span style="color:blue">="</span><b><xsl:value-of select="." /></b>
    <span style="color:blue">"</span>
  </xsl:template>



</xsl:stylesheet>