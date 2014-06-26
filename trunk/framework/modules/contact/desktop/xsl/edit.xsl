<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
<xsl:param name="calendar" />
<xsl:param name="type" />

<xsl:variable name="htmlHeadExtra">

	<xsl:call-template name="js.cal" />
	<script src="{$adminPath}/desktop/js/module.edit.js" type="text/javascript">&#xa0;</script>

</xsl:variable>

<xsl:template name="content">

	<xsl:variable name="object" select="$content/object" />

	<div class="content100 showTools">
		
		<form name="edit" action="{$adminroot}{$config/module/@name}/edit/" method="post">
		<input type="hidden" name="modToken" value="{$modToken}" />
		<input type="hidden" name="contact_id" value="{$object/@id}" />

		<div class="list-header floatFix">
			<div class="buttons">
				 <a href="{$adminroot}{$modName}/return/" class="btn"><i class="icon-chevron-left">&#160;</i>Volver</a>
				 <!-- <button type="button"  name="back" value="1" class="btn save-back"><span>Guardar y volver</span></button> -->
				 <!-- <button type="submit" class="btn btn-inverse save"><span>Guardar</span></button> -->
			</div>

			<h2 class="techo">Datos Contacto</h2>
		</div>

		<!-- LANG: <xsl:value-of select="$lang/publish" /> -->
		<!-- <xsl:copy-of select="$lang" /> -->

		<div class="edit-body">
			<div class="box-overflow">
			
				<div id="tools">
					<div class="padding">

						<ul id="sorteable-0" class="rounded">
							<xsl:call-template name="tool.publishing">
								<xsl:with-param name="object_id" select="$object/@id" />
								<xsl:with-param name="state" select="$object/@state" />
								<xsl:with-param name="date_field" select="'creation_date'" />
								<xsl:with-param name="date_value" select="$object/date" />
								<xsl:with-param name="modified_value" select="$object/@modification_date" />
								<xsl:with-param name="createdby" select="$object/createdby" />
								<xsl:with-param name="modifiedby" select="$object/modifiedby" />
							</xsl:call-template>
						</ul>
						
					</div>
				</div>

				<div class="box">
					<ul class="form addNota">
						<li>
							<label>Nombre</label>
							<input type="text" maxlength="200" name="name" value="{$object/name}"/>
						</li>
						<li>
							<label>Apellido</label>
							<input type="text" name="lastname" value="{$object/lastname}"/>
						</li>
						<li>
							<label>E-mail</label>
							<input type="text" name="email" value="{$object/email}"/>
						</li>
						
						<li>
							<label>Teléfono</label>
							<input type="text" name="phone" value="{$object/phone}"/>
						</li>

						<li>
							<label>Ubicación</label>
							<input type="text" name="phone" value="{$object/location/name}"/>
						</li>
						<li>
							<label>Localidad</label>
							<input type="text" name="phone" value="{$object/sublocation/name}"/>
						</li>


						<li>
							<label>Carrera</label>
							<input type="text" name="carrera_title" value="{$object/carrera_title}"/>
						</li>


						<li>
							<label>Universidad</label>
							<input type="text" name="universidad_title" value="{$object/universidad_title}"/>
						</li>

						<li>
							<label>Comentario</label>
							<textarea name="comment"><xsl:value-of select="$object/comment" /></textarea>
						</li>
						
						
					</ul>
				</div>
			</div>
		</div>

		</form>
	</div>


</xsl:template>
</xsl:stylesheet>