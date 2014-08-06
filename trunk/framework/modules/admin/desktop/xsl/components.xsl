<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />

<xsl:param name="htmlHeadExtra" />
<xsl:param name="page" />
<xsl:param name="state" />
<xsl:param name="category_id" />

<!-- 
	Template: htmlHead
	Use: Is the <head> tag for all Admin pages
	Called: In every page of admin
-->
<xsl:template name="htmlHead">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title><xsl:value-of select="$config/system/applicationID" /></title>
	<xsl:apply-templates select="$config/admin/desktop/*[@header='1']" />
	<script type="text/javascript"><!-- 
		 -->adminmod = '<xsl:value-of select="$adminPath"/>';<!-- 
		 -->adminpath = '<xsl:value-of select="$config/system/adminpath"/>';<!-- 
		 -->module = '<xsl:value-of select="$modName"/>';<!-- 
	 --></script>
	<xsl:copy-of select="$htmlHeadExtra" />

	<!-- IE 6-8 support for html5 -->
	<xsl:comment><!-- 
	-->[if lt IE 9]&gt;
      	 &lt;script src="http://html5shim.googlecode.com/svn/trunk/html5.js"&gt;&lt;/script&gt;
    &lt;![endif]<!-- 
	 --></xsl:comment>
</xsl:template>

<xsl:template name="htmlFooter">
	<xsl:apply-templates select="$config/admin/desktop/*[@header='0']" />
	<xsl:copy-of select="$htmlFooterExtra" />
</xsl:template>

<xsl:template match="css">
	<xsl:variable name="cssfile"><xsl:apply-templates mode="replaceTags"/></xsl:variable>
	<link rel="stylesheet" type="text/css" href="{$cssfile}" />
</xsl:template>
<xsl:template match="script">
	<xsl:variable name="scriptfile"><xsl:apply-templates mode="replaceTags"/></xsl:variable>
	<script type="text/javascript" src="{$scriptfile}">&#xa0;</script>
</xsl:template>

<xsl:template name="jquery">
	<xsl:variable name="scriptfile"><xsl:apply-templates select="/xml/configuration/admin/desktop/script[@name='jquery']" mode="replaceTags"/></xsl:variable>
	<script type="text/javascript" src="{$scriptfile}">&#xa0;</script>
</xsl:template>

<xsl:template match="adminpath" mode="replaceTags">
	<xsl:value-of select="$adminPath" />
</xsl:template>
<xsl:template match="modpath" mode="replaceTags">
	<xsl:value-of select="$modPath" />
</xsl:template>

<xsl:template name="modal.scripts">
	<script type="text/javascript" src="{$adminPath}/desktop/js/forms.js" />
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery-ui.js" />
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery.mousewheel.min.3.0.6.js" />
	<!-- <script type="text/javascript" src="{$adminPath}/desktop/js/setSlider.js" /> -->
	<script type="text/javascript" src="{$adminPath}/desktop/js/admin.js" />
	<script type="text/javascript" src="{$adminPath}/desktop/js/jquery.cookie.js" />
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/bootstrap/css/bootstrap.css" />
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/css/admin.css" />
	
</xsl:template>



<!-- 
	Template: tiny_mce
	Use: WYSIWYG Editor 
	Called: In Creation and Edition Actions
-->
<xsl:template name="tiny_mce">
	<xsl:param name="elements">content</xsl:param>
	<xsl:param name="width">560</xsl:param>
	<xsl:param name="height">200</xsl:param>
	<xsl:param name="object_id">0</xsl:param>
	<xsl:param name="object_typeid">0</xsl:param>
	<xsl:param name="css"><xsl:value-of select="$adminPath"/>/desktop/css/editor.css</xsl:param>

	<xsl:param name="editingHome">0</xsl:param>
	
	<script type="text/javascript" src="{$adminPath}/desktop/tiny_mce/tiny_mce_src.js">&#xa0;</script>
	<script type="text/javascript">

	tinyMCE.init({
		// General options
		mode : "exact",
		elements: "<xsl:value-of select="$elements" />",
		width: '<xsl:value-of select="$width" />',
		height: '<xsl:value-of select="$height" />',
		theme : "advanced",
		skin : "modion",
		language : 'es',
		convert_urls : false,
		
		<xsl:choose>
		<xsl:when test="$editingHome = 0">
			plugins : "autolink,lists,pagebreak,style,layer,table,save,advhr,mdnimage,advimage,advlink,iespell,inlinepopups,preview,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave",

			extended_valid_elements : "slideshow[object_id|type|ids],embed[*],img[*]",
			//valid_children : "+p[style]",

			// Theme options
			theme_advanced_buttons1 : "bold,italic,underline,justifyleft,justifycenter,justifyright,justifyfull,formatselect,bullist,|,mdnimage,image,link,unlink,code",
			theme_advanced_buttons2 : "",
			<!-- theme_advanced_buttons2 : "copy,paste,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,|,mdnimage,image,link,unlink,anchor,cleanup,code", -->
			theme_advanced_buttons3 : "",
			theme_advanced_buttons4 : "",
		</xsl:when>
		<xsl:otherwise>
			plugins : "autolink,lists,pagebreak,style,advlink,iespell,paste,nonbreaking,xhtmlxtras,wordcount,advlist",

			// Theme options
			theme_advanced_buttons1 : "save,|,bold,italic,underline,|,link,unlink,anchor,cleanup,code,|copy,paste,pasteword,|,search,replace,|,bullist,numlist",
			theme_advanced_buttons2 : "",
			theme_advanced_buttons3 : "",
			theme_advanced_buttons4 : "",
		</xsl:otherwise>
		</xsl:choose>
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		//theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,
		entity_encoding : "raw",
		
		// Example content CSS (should be your site CSS)
		content_css : "<xsl:value-of select="$css"/>?v=<xsl:value-of select="$horaActual"/>",
		object_id : <xsl:value-of select="$object_id"/>,
		object_typeid : <xsl:value-of select="$object_typeid"/>,

		<!--
		// Drop lists for link/image/media/template dialogs
		template_external_list_url : "lists/template_list.js",
		external_link_list_url : "lists/link_list.js",
		external_image_list_url : "lists/image_list.js",
		media_external_list_url : "lists/media_list.js",

		// Style formats
		style_formats : [
			{title : 'Bold text', inline : 'b'},
			{title : 'Red text', inline : 'span', styles : {color : '#ff0000'}},
			{title : 'Red header', block : 'h1', styles : {color : '#ff0000'}},
			{title : 'Example 1', inline : 'span', classes : 'example1'},
			{title : 'Example 2', inline : 'span', classes : 'example2'},
			{title : 'Table styles'},
			{title : 'Table row 1', selector : 'tr', classes : 'tablerow1'}
		],

		// Replace values for the template plugin
		template_replace_values : {
			username : "Some User",
			staffid : "991234"
		}
		-->
	});

	</script>
</xsl:template>


<xsl:template name="swf.upload">
	<xsl:param name="module" />
	<xsl:param name="action" />
	<xsl:param name="callback" />
	<xsl:param name="callback_method">post</xsl:param>
	<xsl:param name="post_params"/>
	<xsl:param name="redirect" />
	<!--
		El mode indica que hacer con las fotos subidas:
		editeach:  se puede editar titulo y tags de cada foto por separado
		unique: seleccionar una foto subida con radio,
		bulkedit: Se agrega un titulo y tags a todas las fotos
		standalone: solo muestra los previews
	-->
	<xsl:param name="mode" />
	<!--
		handler es la funcion de javascrip que deberá ser llamada por el flash
		al terminar de subir un archivo, para que maneje que hacer con lo retornado.
	-->
	<xsl:param name="handler" />
	<xsl:param name="uploadLimit" />
	<xsl:param name="filesLimit" />
	<xsl:param name="filesTypes" />
	<xsl:param name="filesTypesDescription" />
	
	<script type="text/javascript" src="{$adminPath}/desktop/swfupload/upload.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/swfupload/swfupload.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/swfupload/handlers.js">&#xa0;</script>
	<script type="text/javascript">
		var swfu;
			window.onload = function () {
				swfu = new SWFUpload({
					// Backend Settings
					upload_url: "/admin/upload.php",
					post_params: {
						"m": '<xsl:value-of select="$module" />',
						"action": '<xsl:value-of select="$action" />',
						"user_id": '<xsl:value-of select="$config/user/@user_id" />',
						"user_type": 'backend'<!-- 
						--><xsl:if test="$post_params!=''">,<!--
							--><xsl:call-template name="post.parse.flash"><!--
								--><xsl:with-param name="params" select="$post_params"/><!--
							--></xsl:call-template><!--
						--></xsl:if>
					},
					// File Upload Settings
					file_size_limit : "<xsl:value-of select="$uploadLimit"/>",
					file_types : "<xsl:value-of select="$filesTypes" />", // *.jpg
					file_types_description : "<xsl:value-of select="$filesTypesDescription" />", 
					file_upload_limit : "<xsl:value-of select="$filesLimit"/>",
					
					// Event Handler Settings - these functions as defined in Handlers.js
					//  The handlers are not part of SWFUpload but are part of my website and control how
					//  my website reacts to the SWFUpload events.
					
					file_dialog_complete_handler : fileDialogComplete,
					file_queued_handler : createitem,
					file_queue_error_handler : fileQueueError,
					upload_start_handler: uploadStart,
					upload_progress_handler : uploadProgress,
					upload_error_handler : uploadError,
					<xsl:choose>
						<xsl:when test="$handler!=''">
							upload_success_handler : <xsl:value-of select="$handler" />,
						</xsl:when>
						<xsl:otherwise>
							upload_success_handler : uploadSuccess,
						</xsl:otherwise>
					</xsl:choose>
					upload_complete_handler : uploadComplete,

					// Button Settings
					button_image_url : adminmod+"/desktop/imgs/uploadbutton.png",	// Relative to the SWF file
					button_placeholder_id : "spanButtonPlaceholder",
					button_width: 130,
					button_height: 31,
					button_text : '<span class="button"> </span>',
					button_text_style : '.button { color:#67707d;font-family: Arial, sans-serif; font-size: 13pt;font-weight:bold;} .buttonSmall { font-size: 10pt; }',
					button_text_top_padding: 6,
					button_text_left_padding: 20,
					button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
					button_cursor: SWFUpload.CURSOR.HAND,

					// Flash Settings
					flash_url : "<xsl:value-of select="$adminPath"/>/desktop/swfupload/swfupload.swf",

					custom_settings : {
						upload_target : "uploadlist",
						upload_mode   : "<xsl:value-of select="$mode"/>"
						
					},

					// Debug Settings
					debug: false
				});
			};
	</script>
	<div id="multiple-upload">
		<form class="uploader">
		<!--<button id="btnBrowse" type="button" onclick="swfu.selectFiles(); this.blur();"><img src="images/page_white_add.png" style="padding-right: 3px; vertical-align: bottom;"/>Select Images <span style="font-size: 7pt;">(2 MB Max)</span></button>-->
		<p>Con la carga optimizada podrás subir en lote.</p>
		<div class="uploadTop floatFix">
			<p>
				<span>
					<span id="spanButtonPlaceholder"></span>
				</span>
			</p>
		</div>
		</form>

		<div id="upload">
			<ul id="uploadlist"></ul>
		</div>
		<p>Estas usando el upload en flash, si no te funciona bien usá el <a href="#" class="switch-upload">Upload del navegador</a></p>

		<xsl:if test="$callback != ''">
			<form name="fileUpload" action="{$callback}" method="{$callback_method}">
				<xsl:if test="$post_params!=''">
					<xsl:call-template name="post.parse.html">
						<xsl:with-param name="params" select="$post_params"/>
					</xsl:call-template>
				</xsl:if>
				<div id="thumbnails" class="floatFix">&#xa0;</div>
			</form>
		</xsl:if>

	</div>


	<div id="basic-upload">

		<p style="margin:10px 0;border-top:1px solid #e2e2e2;">
			<b style="display:block;padding:10px 0 5px;">Carga Simple</b>
			Seleccioná el archivo a subir.
		</p>
		<form id="simple-upload" method="post" enctype="multipart/form-data" action="/admin/upload.php">
			<input type="hidden" name="simple_upload" value="1" />
			<xsl:if test="$redirect!=''">
				<input type="hidden" name="redirect" value="{$redirect}" />
			</xsl:if>
			<input type="hidden" name="m" value="{$module}" />
			<input type="hidden" name="action" value="{$action}" />
			<xsl:if test="$post_params!=''">
				<xsl:call-template name="post.parse.html">
					<xsl:with-param name="params" select="$post_params"/>
				</xsl:call-template>
			</xsl:if>
			<input type="file" name="Filedata" value="" class="file"/>
			<button type="submit" class="boton">Subir</button>
		</form>
		<p>Estas usando el upload del navegador, cambiar a el <a href="#" class="switch-upload">Upload en Flash</a></p>
	</div>
</xsl:template>


<xsl:template name="post.parse.flash"><!--
--><xsl:param name="params" /><!--
	--><xsl:choose><!--
		--><xsl:when test="contains($params, '|')"><!--
			--><xsl:call-template name="post.split"><!--
				--><xsl:with-param name="param" select="substring-before($params, '|')" /><!--
			--></xsl:call-template>,<!--
			--><xsl:call-template name="post.parse.flash"><!--
				--><xsl:with-param name="params" select="substring-after($params, '|')" /><!--
			--></xsl:call-template><!--
		--></xsl:when><!--
		--><xsl:otherwise><!--
			--><xsl:call-template name="post.split"><!--
				--><xsl:with-param name="param" select="$params" /><!--
			--></xsl:call-template><!--
		--></xsl:otherwise><!--
	--></xsl:choose><!--
--></xsl:template>

<xsl:template name="post.split"><!--
--><xsl:param name="param" /><!--
	-->"<xsl:value-of select="substring-before($param, '=')"/>" : '<xsl:value-of select="substring-after($param, '=')" />'<!--
--></xsl:template>


<xsl:template name="post.parse.html">
<xsl:param name="params" />
	<xsl:choose>
		<xsl:when test="contains($params, '|')">
			<xsl:call-template name="post.split.html">
				<xsl:with-param name="param" select="substring-before($params, '|')" />
			</xsl:call-template>
			<xsl:call-template name="post.parse.html">
				<xsl:with-param name="params" select="substring-after($params, '|')" />
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="post.split.html">
				<xsl:with-param name="param" select="$params" />
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="post.split.html">
<xsl:param name="param" />
	<input type="hidden" name="{substring-before($param, '=')}" value="{substring-after($param, '=')}" />
</xsl:template>


<!--- TOOLS  **************************************************************************************** -->

<xsl:template name="tool.publishing">
	<xsl:param name="object_id" />
	<xsl:param name="state" />
	<xsl:param name="date_field" />
	<xsl:param name="date_value" />
	<xsl:param name="modified_value" />
	<xsl:param name="createdby" />
	<xsl:param name="modifiedby" />

	<section class="panel">
		<header class="panel-heading">Publicación</header>

		<div class="panel-body">
			
			 <div class="form-group">		
				<label>Fecha</label>
				<input class="form-control" type="text" name="{$date_field}" value="{$date_value}" />
				<a href="#" class="btn"  onclick="return false;">
					<i class="fa fa-calendar">&#xa0;</i>
				</a>
			</div>
 			<!-- 
 			<div class="form-group">
 				<label>Creación</label>
 				<xsl:value-of select="$createdby" />
 			</div>

			<xsl:if test="$modifiedby != ''">
				<div class="form-group">
					<label>Edición</label>
					<xsl:value-of select="$modifiedby" />&#xa0;
					<xsl:call-template name="fecha.formato.mensaje">
						<xsl:with-param name="fecha" select="$modified_value" />
					 </xsl:call-template>
				</div>				
			</xsl:if> -->
			
		<!-- 		
			<xsl:choose>
				<xsl:when test="$state = 1">
					<a href="#" onclick="modion.unpublish({$object_id});return false;" class="btn btn-primary unpublish">Despublicar</a>
				</xsl:when>
				<xsl:when test="$state = 3">
					<a href="#" onclick="modion.publish({$object_id});return false;" class="btn btn-primary republish">Republicar</a>&#xa0;
				</xsl:when>
				<xsl:otherwise>
					<a href="#" onclick="modion.publish({$object_id});return false;" class="publish btn btn-primary">Publicar</a>
				</xsl:otherwise>
			</xsl:choose>
			
					
			<xsl:choose>
				<xsl:when test="$state = 1">
					<span class="status published rounded left ">Published</span>&#xa0;Publicado
					</xsl:when>
				<xsl:otherwise>
					<span class="status unpublished rounded left ">Published</span>&#xa0;Despublicado
				</xsl:otherwise>
			</xsl:choose>
				 -->
		

			<button type="submit" class="btn btn-info save">Guardar</button>
		</div>
	</section>
</xsl:template>



<xsl:template name="tool.metainformation">
	<xsl:param name="metatitle_field" />
	<xsl:param name="metadescription_field" />
	<xsl:param name="metatitle" />
	<xsl:param name="title" />
	<xsl:param name="metadescription" />
	<xsl:param name="summary" />

	<section class="panel">
		<header class="panel-heading">Meta Información</header>
		<div class="panel-body">

			<div class="form-group">
				<label>Meta Titulo</label>
				<xsl:choose>
					<xsl:when test="metatitle != ''">
						<input type="text" name="{$metatitle_field}" value="{$metatitle}" class="form-control" />
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="{$metatitle_field}" value="{$title}"  class="form-control"  />
					</xsl:otherwise>
				</xsl:choose>
			</div>
		
			<div class="form-group">
				<label>Meta Description</label>
				<xsl:choose>
					<xsl:when test="$metadescription != ''">
						<xsl:variable name="metaresumen"><!-- 
							 --><xsl:call-template name="cortar.cadena"><!-- 
								 --><xsl:with-param name="cadena" select="$metadescription" /><!-- 
								 --><xsl:with-param name="cantidad">235</xsl:with-param><!-- 
							 --></xsl:call-template><!-- 
						 --></xsl:variable>
						<input type="text" maxlength="250" name="{$metadescription_field}" value="{$metaresumen}" class="form-control"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="metaresumen"><!-- 
							 --><xsl:call-template name="cortar.cadena"><!-- 
								 --><xsl:with-param name="cadena" select="$summary" /><!-- 
								 --><xsl:with-param name="cantidad">200</xsl:with-param><!-- 
							 --></xsl:call-template><!-- 
						 --></xsl:variable>
						<input type="text" maxlength="250" name="{$metadescription_field}" value="{$metaresumen}" class="form-control"/>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</div>
	</section>
</xsl:template>


<xsl:template name="tool.order">
	<xsl:param name="order_field" />
	<xsl:param name="order_value" />
	<li class="header">
		<h3>Order</h3>
	</li>
	<li class="collapsable">
		<select name="{$order_field}" id="order">
			<xsl:call-template name="combo.item.incremental">
				<xsl:with-param name="start">0</xsl:with-param>
				<xsl:with-param name="end">100</xsl:with-param>
				<xsl:with-param name="selected" select="$order_value" />
			</xsl:call-template>
		</select>
	</li>
</xsl:template>

<!-- /TOOLS **************************************************************************************** -->

<xsl:template name="js.cal">
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/jscal/css/jscal2.css" />
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/jscal/css/border-radius.css" />
	<link rel="stylesheet" type="text/css" href="{$adminPath}/desktop/jscal/css/steel/steel.css" />
	<script type="text/javascript" src="{$adminPath}/desktop/jscal/js/jscal2.js">&#xa0;</script>
	<script type="text/javascript" src="{$adminPath}/desktop/jscal/js/lang/es.js">&#xa0;</script>
</xsl:template>


<xsl:template name="fecha.formato.numerico">
	<xsl:param name="fecha" />
	<xsl:variable name="dia" select="substring($fecha, 9, 2)" />
	<xsl:variable name="mes" select="substring($fecha, 6, 2)" />
	<xsl:variable name="anio" select="substring($fecha, 1, 4)" />
	<xsl:value-of select="$dia" />.<xsl:value-of select="$mes" />.<xsl:value-of select="$anio" />
</xsl:template>


<xsl:template name="fecha.formato.mensaje">
	<xsl:param name="fecha" />
	<xsl:variable name="dia" select="substring($fecha, 9, 2)" />
	<xsl:variable name="mes" select="substring($fecha, 6, 2)" />
	<xsl:variable name="anio" select="substring($fecha, 1, 4)" />
	<xsl:variable name="min" select="substring($fecha, 12, 2)" />
	<xsl:variable name="seg" select="substring($fecha, 15, 2)" />
	<xsl:value-of select="$dia" />.<xsl:value-of select="$mes" />.<xsl:value-of select="$anio" />&#xa0;<xsl:value-of select="$min" />:<xsl:value-of select="$seg" /> hs
</xsl:template>

<xsl:template name="combo.item.incremental">
	<xsl:param name="start"/>
	<xsl:param name="end"/>
	<xsl:param name="selected"/>
	<xsl:choose>
		<xsl:when test="number($start) &lt;= number($end)">
			<option value="{$start}">
				<xsl:if test="$selected = $start">
					<xsl:attribute name="selected">selected</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="$start" />
			</option>
			<xsl:call-template name="combo.item.incremental">
				<xsl:with-param name="end" select="$end" />
				<xsl:with-param name="selected" select="$selected" />
				<xsl:with-param name="start"><xsl:value-of select="number($start) + 1" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
</xsl:template>


<!--Categories-->
<xsl:template name="combo.categories">
	<xsl:param name="categories" />
	<xsl:param name="id" />

	<select name="category_id" id="category_id">
		<xsl:call-template name="combo.categories.item">
			<xsl:with-param name="categories" select="$categories" />
			<xsl:with-param name="id" select="$id" />
		</xsl:call-template>
	</select>

</xsl:template>

<xsl:template name="combo.categories.item">
	<xsl:param name="categories" />
	<xsl:param name="id" />
	<xsl:param name="profundidad" select='0' />

	<xsl:for-each select="$categories/category">
		<xsl:sort order="ascending" select="name" />
		<option value="{@category_id}">
			<xsl:if test="@parent!=0">
				<xsl:attribute name="style">padding-left:<xsl:value-of select="$profundidad"/>px</xsl:attribute>
			</xsl:if>
			<xsl:if test="@category_id = $id">
				<xsl:attribute name="selected">selected</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="name" />
		</option>
		<xsl:if test="count(categories/category)>0">
			<xsl:call-template name="combo.categories.item">
				<xsl:with-param name="categories" select="categories"/>
				<xsl:with-param name="id" select="$id"/>
				<xsl:with-param name="profundidad" select="$profundidad + 15"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:for-each>

</xsl:template>



<!--Categorias-->
<xsl:template name="combo.categories.event">
	<xsl:param name="categories" />
	<xsl:param name="id" />
	<xsl:param name="showLugar">0</xsl:param>

	<select name="location_id" id="location_id">
		<xsl:if test="$showLugar!=0">
			<xsl:attribute name="onchange">actulizarLugar(this)</xsl:attribute>
		</xsl:if>
		<xsl:call-template name="combo.categorias.evento.item">
			<xsl:with-param name="categories" select="$categorias" />
			<xsl:with-param name="id" select="$id" />
		</xsl:call-template>
	</select>
</xsl:template>


<xsl:template name="combo.categorias.evento.item">
	<xsl:param name="categorias" />
	<xsl:param name="id" />
	<xsl:param name="profundidad" select='0' />

	<xsl:for-each select="$categorias/categoria">
		<xsl:sort order="ascending" select="name" />
		<option value="{@category_id}">
			<xsl:if test="@parent!=0">
				<xsl:attribute name="style">padding-left:<xsl:value-of select="$profundidad"/>px</xsl:attribute>
			</xsl:if>
			<xsl:if test="@category_id = $id">
				<xsl:attribute name="selected">selected</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="name" />
		</option>
		<xsl:if test="count(categorias/categoria)>0">
			<xsl:call-template name="combo.categorias.evento.item">
				<xsl:with-param name="categories" select="categorias"/>
				<xsl:with-param name="id" select="$id"/>
				<xsl:with-param name="profundidad" select="$profundidad + 15"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:for-each>

</xsl:template>



<!--Categorias-->



<xsl:template name="combo.tags">
	<xsl:param name="tags" />
	<xsl:param name="id" />

	<select name="tag_id" id="tag_id">
		<xsl:call-template name="combo.tags.item">
			<xsl:with-param name="tags" select="$tags" />
			<xsl:with-param name="id" select="$id" />
		</xsl:call-template>
	</select>
</xsl:template>


<xsl:template name="combo.tags.item">
	<xsl:param name="tags" />
	<xsl:param name="id" />
	<xsl:param name="profundidad" select='8' />

	<xsl:for-each select="$tags/tag">
		<option value="{@tag_id}">
			<xsl:if test="@parent!=0">
				<xsl:attribute name="style">padding-left:<xsl:value-of select="$profundidad"/>px</xsl:attribute>
			</xsl:if>
			<xsl:if test="@tag_id = $id">
				<xsl:attribute name="selected">selected</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="name" />
		</option>
		<xsl:if test="count(tags/tag)>0">
			<xsl:call-template name="combo.tags.item">
				<xsl:with-param name="tags" select="tags"/>
				<xsl:with-param name="id" select="$id"/>
				<xsl:with-param name="profundidad" select="$profundidad + 8"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:for-each>

</xsl:template>




<xsl:template name="pagination.box">

	<xsl:call-template name="pagination">
		<xsl:with-param name="total" select="content/collection/@total" />
		<xsl:with-param name="display" select="content/collection/@display | content/collection/@pagesize" />
		<xsl:with-param name="currentPage" select="content/collection/@currentPage | content/collection/@page" />
		<xsl:with-param name="url" select="$page_url" />
		<xsl:with-param name="params" select="$page_params" />
	</xsl:call-template>


</xsl:template>


<xsl:template name="search.box" >
	<div class="search">
		<form name="search" action="{$adminroot}{$config/module/@name}/search" method="post">
			<xsl:if test="$category_id != ''">
				<input type="hidden" name="categories" value="{$category_id}" />	
			</xsl:if>
			<input type="text" name="q" value="" />
			<button type="submit">Search</button>
		</form>
	</div>
</xsl:template>

<xsl:template name="pagination">
	<xsl:param name="url" />
	<xsl:param name="params" />
	<xsl:param name="currentPage" />
	<xsl:param name="display" />
	<xsl:param name="total" />
	<xsl:param name="category_id" />

	<xsl:variable name="pageurl"><!-- 
		 --><xsl:choose><!-- 
			 --><xsl:when test="$url=''"><!-- 
				 --><xsl:choose><!-- 
					 --><xsl:when test="$query != ''"><!-- 
				 		 --><xsl:value-of select="$adminroot"/><xsl:value-of select="$modName"/>/search/?page=<!-- 
				 	 --></xsl:when><!-- 
				 	 --><xsl:otherwise><!-- 
				 		 --><xsl:value-of select="$adminroot"/><xsl:value-of select="$modName"/>/list/?page=<!-- 
				 	 --></xsl:otherwise><!-- 
				  --></xsl:choose><!-- 
			  --></xsl:when><!-- 
			  --><xsl:otherwise>
			  		<xsl:choose>
			  			<xsl:when test="$params!=''"><!--
			  				--><xsl:value-of select="$url" />?<xsl:value-of select="$params"/>&amp;page=<!--
			  			--></xsl:when>
			  			<xsl:otherwise><!-- 
			  				--><xsl:value-of select="$url" />?page=<!--
			  			--></xsl:otherwise>
			  		</xsl:choose>
			  	</xsl:otherwise><!-- 
		 --></xsl:choose><!--  
	 --></xsl:variable>
	<xsl:variable name="queryStr"><!-- 
		--><xsl:if test="$query != ''">&amp;q=<xsl:value-of select="$query" /></xsl:if><!-- 
		--><xsl:if test="$category_id != ''">&amp;categories=<xsl:value-of select="$category_id" /></xsl:if><!-- 
	 --></xsl:variable>
	<xsl:variable name="totalPages">
		<xsl:choose>
			<xsl:when test="ceiling($total div $display) != '' and number(ceiling($total div $display))">
				<xsl:value-of select="ceiling($total div $display)" />
			</xsl:when>
			<xsl:otherwise>1</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>


<xsl:choose>
	<xsl:when test="$currentPage &gt; $totalPages">
	</xsl:when>
	<xsl:otherwise>

		<xsl:choose>
			<xsl:when test="$totalPages != 1">
				<div class="text-center">
					<ul class="pagination">
							<li><a class="btn" href="{$pageurl}1{$queryStr}">«</a></li>

								<xsl:call-template name="link.paginas">
									<xsl:with-param name="pagina" select="$currentPage" />
									<xsl:with-param name="pageurl" select="$pageurl" />
									<xsl:with-param name="queryStr" select="$queryStr" />
									<xsl:with-param name="cantidad" select="$totalPages" />
									<xsl:with-param name="display" select="1" />
									<xsl:with-param name="limit1" select="$currentPage - 4" />
									<xsl:with-param name="limit2" select="$currentPage + 4" />
								</xsl:call-template>

	
							<li><a class="btn arrow" href="{$pageurl}{$totalPages}{$queryStr}">»</a></li>
								
						</ul>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="pagination">
					<div class="right">
						&#xa0;
					</div>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:otherwise>
</xsl:choose>

</xsl:template>



<xsl:template name="link.paginas"><!-- 
	--><xsl:param name="pageurl" /><!-- 
	--><xsl:param name="queryStr" /><!-- 
	--><xsl:param name="pagina" /><!-- 
	--><xsl:param name="cantidad" /><!-- 
	--><xsl:param name="display" /><!-- 
	--><xsl:param name="limit1" /><!-- 
	--><xsl:param name="limit2" /><!-- 
	--><xsl:if test="$limit1 != ''"><!-- 
		 --><xsl:if test="($pagina - 1) &gt; 0 and ($pagina - 1) &gt;= $limit1"><!-- 
			 --><xsl:if test="$limit1 &gt; 0"><!-- 
				 --><li><!-- 
					 --><a class="btn" href="{$pageurl}{$limit1}{$queryStr}"><xsl:value-of select="$limit1" /></a><!-- 
				 --></li><!-- 
			 --></xsl:if><!-- 
			 --><xsl:call-template name="link.paginas">
					<xsl:with-param name="pagina" select="$pagina" />
					<xsl:with-param name="pageurl" select="$pageurl" />
					<xsl:with-param name="queryStr" select="$queryStr" />
					<xsl:with-param name="cantidad" select="$cantidad" />
					<xsl:with-param name="limit1" select="$limit1 + 1" />
				</xsl:call-template><!-- 
		 --></xsl:if><!-- 
	 --></xsl:if><!-- 
	 --><xsl:if test="$display!=''"><!-- 
		 --><li class="active"><!-- 
			 --><span class="btn selected"><xsl:value-of select="$pagina" /></span><!-- 
		 --></li><!-- 
	 --></xsl:if><!-- 
	 --><xsl:if test="$limit2 != ''"><!-- 
		 --><xsl:if test="($pagina + 1) &lt;= $limit2"><!-- 
			 --><xsl:if test="($pagina + 1) &lt;= $cantidad"><!-- 
				 --><li><!-- 
					 --><a class="btn" href="{$pageurl}{$pagina + 1}{$queryStr}"><xsl:value-of select="$pagina + 1" /></a><!-- 
				 --></li><!-- 
			 --></xsl:if><!-- 
			 --><xsl:call-template name="link.paginas">
					<xsl:with-param name="pagina" select="$pagina + 1" />
					<xsl:with-param name="pageurl" select="$pageurl" />
					<xsl:with-param name="queryStr" select="$queryStr" />
					<xsl:with-param name="cantidad" select="$cantidad" />
					<xsl:with-param name="limit2" select="$limit2" />
				</xsl:call-template><!-- 
		 --></xsl:if><!-- 
	 --></xsl:if>
</xsl:template>

<xsl:template name="cortar.cadena"><!-- 
 --><xsl:param name="cadena" /><!-- 
 --><xsl:param name="cantidad" /><!-- 
 --><xsl:if test="$cadena!=''"><!-- 
	 --><xsl:choose><!-- 
		 --><xsl:when test="string-length($cadena)&gt;$cantidad"><!-- 
			 --><xsl:call-template name="limpiar.tags"><!-- 
				 --><xsl:with-param name="cadena" select="substring($cadena,0,$cantidad)" /><!-- 
			 --></xsl:call-template> [...]<!--
			<xsl:value-of select="substring($cadena,0,$cantidad)" />...
	 --></xsl:when><!-- 
		 --><xsl:otherwise><!-- 
			 --><xsl:call-template name="limpiar.tags"><!-- 
				 --><xsl:with-param name="cadena" select="$cadena" /><!-- 
			 --></xsl:call-template><!-- 
		 --></xsl:otherwise><!-- 
	 --></xsl:choose><!-- 
 --></xsl:if><!-- 
 --></xsl:template>


<xsl:template name="limpiar.tags"><!-- 
	 --><xsl:param name="cadena" /><!-- 
	 --><xsl:variable name="string0"><!-- 
		 --><xsl:value-of select="translate($cadena, '&#13;', ' ')" /><!-- 
	 --></xsl:variable><!-- 
	 --><xsl:variable name="string"><!-- 
		 --><xsl:value-of select="translate($string0, '&#xa;', '')" /><!-- 
	 --></xsl:variable><!-- 
	 --><xsl:choose><!-- 
		 --><xsl:when test="contains($string, '&lt;')"><!-- 
			 --><xsl:value-of select="substring-before($string, '&lt;')" /><!-- 
			 --><xsl:call-template name="limpiar.tags"><!-- 
				 --><xsl:with-param name="cadena" select="substring-after($string, '&gt;')" /><!-- 
			 --></xsl:call-template><!-- 
		 --></xsl:when><!-- 
		 --><xsl:when test="contains($string, '&gt;')"><!-- 
			 --><xsl:value-of select="substring-before($string, '&gt;')" /><!-- 
			 --><xsl:call-template name="limpiar.tags"><!-- 
				 --><xsl:with-param name="cadena" select="substring-after($string, '&gt;')" /><!-- 
			 --></xsl:call-template><!-- 
		 --></xsl:when><!-- 
		 --><xsl:otherwise><!-- 
			 --><xsl:value-of select="$string" disable-output-escaping="yes" /><!-- 
		 --></xsl:otherwise><!-- 
	 --></xsl:choose><!-- 
 --></xsl:template>

<xsl:template name="clear.break">
	<xsl:param name="string" />

	<xsl:variable name="string0">
		<xsl:value-of select="translate($string, '&#13;', ' ')" />
	</xsl:variable>
	<xsl:variable name="string1">
		<xsl:value-of select="translate($string0, '&#xa;', '')" />
	</xsl:variable>
	<xsl:value-of select="$string1" disable-output-escaping="yes"/>
</xsl:template>

<!--################### TEMPLATES DE OBJETOS ####################-->

<xsl:template name="tool.categories">
	<xsl:param name="categories" />
	<xsl:param name="object_id" />

	<xsl:if test="$config/module/options/group[@name='categories']/option">
		<xsl:for-each select="$config/module/options/group[@name='categories']/option[@type='parent']">
		<section class="panel" id="sorteable-{position() + 2}">
			<header class="panel-heading">
				<xsl:value-of select="@display" />
			</header>
			<div class="panel-body">
				<xsl:call-template name="object.categories">
					<xsl:with-param name="categories" select="$categories" />
					<xsl:with-param name="object_id" select="$object_id" />
					<xsl:with-param name="parent" select="@value" />
				</xsl:call-template>
			</div>
		</section>
		</xsl:for-each>
	</xsl:if>
</xsl:template>


<xsl:template name="object.categories">
	<xsl:param name="categories" />
	<xsl:param name="object_id" />
	<xsl:param name="parent">1</xsl:param>


	<ul id="categories-{$parent}" class="categories-list">
		<xsl:for-each select="$categories/category[.//parent/@category_id = $parent]">
			<xsl:sort order="ascending" select="@order" data-type="number"/>
			<li id="cat-{@category_id}" category_id="{@category_id}">
				<!-- <a href="#" onclick="deleteCategory({@category_id}, {$object_id});return false;" class="right" title="Remove Category">Remove Category</a> -->
				<!-- onclick="category.delete({@category_id}, {$object_id});" -->
				<a href="#" category_id="{@category_id}" object_id="{$object_id}" class="btn btn-sm pull-right delete" title="Remove Category">Remove Category</a>
				<xsl:value-of select="name"/>
			</li>
		</xsl:for-each>
		<!-- Este tag hace falta para que si no hay childs no se cierre inline y rompa en html5 -->
		<xsl:comment />
	</ul>
	<div class="form-group">
		<a href="/admin/?m=object&amp;action=BackDisplayCategoryOrder&amp;object_id={$object_id}&amp;parent_id={$parent}&amp;height=window" onclick="layer.loadExternal(this);return false;" class="btn btn-sm btn-default pull-right">Order</a>
		<a href="/admin/?m=object&amp;action=BackDisplayCategoryModal&amp;object_id={$object_id}&amp;parent_id={$parent}&amp;height=window" onclick="layer.loadExternal(this);return false;" class="btn btn-sm btn-primary add pull-right"><span>Add Category</span></a>
	</div>
</xsl:template>


<xsl:template name="object.relations">
	<xsl:param name="objects" />
	<xsl:param name="relations" />
	<xsl:param name="object_id" />
	<xsl:param name="position" />

	<xsl:for-each select="$objects/option">
		<xsl:variable name="node" select="@name" />
			<ul id="sorteable-{$position + position()}" name="relation-{@type_id}">
				<li class="header">
					<h3><xsl:value-of select="@display" /> <span class="count"><xsl:value-of select="count($relations//*[name()=$node])"/></span></h3>
				</li>
				<li class="collapsable">
					<ul id="relation-{@type_id}" class="relaciones">
						<xsl:for-each select="$relations/*/*[name()=$node]">
							<xsl:sort order="ascending" select="@order" data-type="number"/>
							<li id="rel-{@*[position()=2]}">
								<a class="right" href="#" onclick="relation.delete({$object_id}, {@*[position()=2]});return false;" title="Borrar relación">Delete</a>
								<span class="status state-{@state} rounded">&#xa0;</span>
								<a href="{$adminroot}{$node}/edit/{@*[position()=2]}">
									<xsl:value-of select="title | name"/>
								</a>
							</li>
						</xsl:for-each>
						
						<!-- Este tag hace falta para que si no hay childs no se cierre inline y rompa en html5 -->
						<xsl:comment />
					</ul>
					<xsl:if test="count($relations//*[name()=$node]) &gt;= 1">
						<a href="/admin/?m=object&amp;action=BackDisplayRelationOrderModal&amp;object_id={$object_id}&amp;type_id={@type_id}&amp;height=window" onclick="layer.loadExternal(this);return false;" class="btn-small right">Ordenar</a>
					</xsl:if>
					<a href="/admin/?m=object&amp;action=BackDisplayRelationModal&amp;object_id={$object_id}&amp;type_id={@type_id}&amp;categories={@categories}&amp;category_parentid={@category_parentid}&amp;height=window" onclick="layer.loadExternal(this);return false;" class="btn-small right add"><span>Add</span></a>
				</li>
			</ul>
		</xsl:for-each>
	<!--<a href="/admin/?m=object&amp;action=BackDisplayCategoryModal&amp;object_id={$object_id}&amp;parent={$parent}" onclick="layer.loadExternal(this);return false;" class="botoncito right">Categorizar</a>-->
</xsl:template>

<!--################### FIN TEMPLATES DE OBJETOS ####################-->



<!--################### TEMPLATES DE MULTIMEDIA ####################-->
<xsl:template name="multimedia.categories">
	<xsl:param name="categories" />
	<xsl:param name="mid" />
	<xsl:param name="parent">1</xsl:param>


	<ul id="categories-{$parent}" class="categories-list">
		<xsl:for-each select="$categories/category">
			<li id="cat-{@category_id}">
				<a href="#" onclick="category.multimediaDelete({@category_id}, {$mid});return false;" class="right" title="Remove Category">Remove Category</a>
				<xsl:value-of select="name"/>
			</li>
		</xsl:for-each>
		<!-- Este tag hace falta para que si no hay childs no se cierre inline y rompa en html5 -->
		<xsl:comment />
	</ul>
	<a href="{$adminroot}{$modName}/?m=multimedia&amp;action=BackDisplayCategoryModal&amp;mid={$mid}&amp;parent_id={$parent}&amp;height=window" onclick="layer.loadExternal(this);return false;" class="btn-small right add">
		<span>Add Category</span></a>
</xsl:template>


<xsl:template name="multimedia.relations">
	<xsl:param name="configuration" />
	<xsl:param name="multimedias" />
	<xsl:param name="object_id" />
	<xsl:param name="position" />

	
	<xsl:for-each select="$configuration/option">
		<xsl:variable name="node" select="@name" />
		<section class="panel" id="sorteable-{$position}" name="{@name}" type="multimedia" type_id="{@type_id}">
		
			<header class="panel-heading">
					<xsl:choose>
						<xsl:when test="@display"><xsl:value-of select="@display" /></xsl:when>
						<xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
					</xsl:choose>
					<span class="badge bg-inverse pull-right"><xsl:value-of select="count($multimedias//*[name()=$node])" /></span>
			</header>
			

			<div class="panel-body">

				<ul id="multimedia-{@type_id}" class="multimedia">
					<xsl:for-each select="$multimedias//*[name()=$node][*]">
						<xsl:sort order="ascending" select="@order" />
						<li id="mid-{@photo_id | @video_id | @document_id | @audio_id}">
							<xsl:choose>
								<xsl:when test="name()='photo'">
									<a class="right" href="#" onclick="multimedia.removeRelation({$object_id}, {@photo_id}, {@type_id});return false;" title="Borrar Foto">Delete</a>
									<!-- <img src="{$config/system/images_domain}/content/photos/generated/{substring(@photo_id, string-length(@photo_id),1)}/{@photo_id}_t.{@type}" alt="{titulo}" /> -->
									<h3>
										<a href="{$adminroot}photo/edit/{@photo_id}/" title="Editar imágen">
											<xsl:value-of select="title"/>
										</a>
									</h3>

									<xsl:call-template name="photo">
										<xsl:with-param name="id" select="@photo_id" />
										<xsl:with-param name="type" select="@type" />
										<xsl:with-param name="suffix">_t</xsl:with-param>
										<xsl:with-param name="alt" select="title" />
									</xsl:call-template>
									<p>
										<xsl:choose>
											<xsl:when test="summary = ''">Sin epigrafe</xsl:when>
											<xsl:otherwise><xsl:value-of select="summary" /></xsl:otherwise>
										</xsl:choose>
									</p>
									<!-- <xsl:value-of select="@width" /> x <xsl:value-of select="@height" />
									<br/>
									<xsl:value-of select="@type" /> -->
									
								</xsl:when>
								<xsl:when test="name()='video'">
									<a class="right" href="#" onclick="multimedia.removeRelation({$object_id}, {@video_id}, {@type_id});return false;" title="Borrar Foto">Delete</a>
									<a href="{$adminroot}video/edit/{@video_id}/" title="Editar video">
										<xsl:value-of select="title"/>
									</a>
									<br/>
									<a href="{$adminroot}?m=video&amp;action=BackDisplayPreview&amp;video_id={@video_id}&amp;width=627&amp;height=380" onclick="layer.loadExternal(this);return false;">Preview</a>
								</xsl:when>
								<xsl:when test="name()='audio'">
									<a class="right" href="#" onclick="multimedia.removeRelation({$object_id}, {@audio_id}, {@type_id});return false;" title="Borrar Foto">Delete</a>
									<a href="{$adminroot}audio/edit/{@audio_id}/" title="Editar audio">
										<img src="{substring($adminPath, 1, string-length($adminPath) - 5)}audio/desktop/imgs/audio.png" style="margin:0 10px 0 0;vertical-align:middle;" class="icon" />
										<xsl:value-of select="title"/>
									</a>
									<span class="data">
										Peso:
										<xsl:choose>
											<xsl:when test="@weight='' or not(@weight)">
												--
											</xsl:when>
											<xsl:when test="@weight &gt; 1000000">
												<xsl:value-of select='format-number(@weight div 1000000, "#.##")' /> Mb
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select='format-number(@weight div 1000, "#.##")' /> Kb
											</xsl:otherwise>
										</xsl:choose> |  
										Tipo: <xsl:value-of select="@type" />
									</span>

								</xsl:when>
								<xsl:when test="name()='document'">
									<a class="right" href="#" onclick="multimedia.removeRelation({$object_id}, {@document_id}, {@type_id});return false;" title="Borrar Foto">Delete</a>
									<a href="{$adminroot}document/edit/{@document_id}/" title="Editar documento">
										<img src="{substring($adminPath, 1, string-length($adminPath) - 5)}document/desktop/imgs/{@type}.png" style="margin:0 10px 0 0;vertical-align:middle;" class="icon" />
										<xsl:value-of select="title"/>
									</a>
									<span class="data">
										Peso:
										<xsl:choose>
											<xsl:when test="@weight='' or not(@weight)">
												--
											</xsl:when>
											<xsl:when test="@weight &gt; 1000000">
												<xsl:value-of select='format-number(@weight div 1000000, "#.##")' /> Mb
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select='format-number(@weight div 1000, "#.##")' /> Kb
											</xsl:otherwise>
										</xsl:choose> |  
										Tipo: <xsl:value-of select="@type" />
									</span>
								</xsl:when>
							</xsl:choose>
						</li>
					</xsl:for-each>

					<!-- Este tag hace falta para que si no hay childs no se cierre inline y rompa en html5 -->
					<xsl:comment />
				</ul>

				<xsl:choose>
					<xsl:when test="@name ='photo'">
						<a href="/admin/?m=photo&amp;action=BackDisplayRelationOrderModal&amp;object_id={$object_id}&amp;category_id={@category}&amp;height=window" onclick="layer.loadExternal(this);return false;" class="btn btn-default btn-sm right">Ordenar</a>
						<a href="{$adminroot}photo/modal/?object_id={$object_id}&amp;type_id={@type_id}&amp;category_id={@category_id}&amp;parent={@category_parentid}&amp;width=700&amp;height=window" onclick="layer.loadExternal(this);return false;" class="btn btn-info pull-right add"><i class="fa fa-plus">&#xa0;</i> Agregar</a>
					</xsl:when>
					<xsl:when test="@name ='video'">
						<a href="{$adminroot}video/modal/?object_id={$object_id}&amp;type_id={@type_id}&amp;category_id={@category}&amp;parent={@parent}&amp;height=window" onclick="layer.loadExternal(this);return false;" class="btn btn-primary btn-sm right add"><i class="icon icon-add">&#xa0;</i> <span>Agregar</span></a>
					</xsl:when>
					<xsl:when test="@name ='audio'">
						<a href="/admin/?m=audio&amp;action=BackDisplayRelationOrderModal&amp;object_id={$object_id}&amp;category_id={@category}&amp;height=window" onclick="layer.loadExternal(this);return false;" class="btn btn-default btn-sm right">Ordenar</a>
						<a href="{$adminroot}audio/modal/?object_id={$object_id}&amp;type_id={@type_id}&amp;category_id={@category}&amp;parent={@parent}&amp;height=window" onclick="layer.loadExternal(this);return false;" class="btn btn-primary btn-sm right add"><i class="icon icon-add">&#xa0;</i> Agregar</a>
					</xsl:when>
					<xsl:when test="@name ='document'">
						<a href="/admin/?m=document&amp;action=BackDisplayRelationOrderModal&amp;object_id={$object_id}&amp;category_id={@category}&amp;height=window" onclick="layer.loadExternal(this);return false;" class="btn btn-small right">Ordenar</a>
						<a href="{$adminroot}document/modal/?object_id={$object_id}&amp;type_id={@type_id}&amp;category_id={@category}&amp;parent={@parent}&amp;height=window" onclick="layer.loadExternal(this);return false;" class="btn btn-small right add"><i class="icon icon-add">&#xa0;</i> Agregar</a>
					</xsl:when>
				</xsl:choose>

			</div>
		</section>
		
	</xsl:for-each>
	
</xsl:template>


<!-- 	Template: Photo -->
<xsl:template name="photo">
	<xsl:param name="id" />
	<xsl:param name="suffix" />
	<xsl:param name="type" />
	<xsl:param name="class" />
	<xsl:param name="style" />
	<xsl:param name="alt" />

	<img src="{$config/system/images_domain}/content/{$config/site/preffix}/photos/generated/{substring($id, string-length($id), 1)}/{$id}{$suffix}.{$type}" alt="{$alt}">
		<xsl:if test="$class!=''"><xsl:attribute name="class"><xsl:value-of select="$class" /></xsl:attribute></xsl:if>
		<xsl:if test="$style!=''"><xsl:attribute name="style"><xsl:value-of select="$style" /></xsl:attribute></xsl:if>
	</img>
</xsl:template>


<xsl:template name="photo.src">
	<xsl:param name="id" />
	<xsl:param name="suffix" />
	<xsl:param name="type" />
	<xsl:value-of select="$config/system/images_domain" />/content/<xsl:value-of select="$config/site/preffix" />/photos/generated/<xsl:value-of select="substring($id, string-length($id), 1)"/>/<xsl:value-of select="$id"/><xsl:value-of select="$suffix"/>.<xsl:value-of select="$type" />
</xsl:template>

<xsl:template name="photo.original.src">
	<xsl:param name="id" />
	<xsl:param name="type" />
	<xsl:value-of select="$config/system/images_domain" />/content/<xsl:value-of select="$config/site/preffix" />/photos/source/<xsl:value-of select="substring($id, string-length($id), 1)"/>/<xsl:value-of select="$id"/>.<xsl:value-of select="$type" />
</xsl:template>

<!--################### FIN TEMPLATES DE MULTIMEDIA ####################-->


<!--################### TEMPLATES DE FILTROS ####################-->

<xsl:template name="filter.list">
	<xsl:param name="filter" />
	<xsl:param name="isMultimedia">0</xsl:param>
	
	<div class="filters btn-toolbar">
		<xsl:if test="$isMultimedia = 0">
			<div class="btn-group">
				<xsl:variable name="statestring">
					<xsl:choose>
						<xsl:when test="$state = 1">Publicado</xsl:when>
						<xsl:when test="$state = 0">No Publicado</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<button class="btn dropdown-toggle" data-toggle="dropdown">Estado 
					<xsl:if test="$state != ''"> &#x02192; <xsl:value-of select="$statestring" />&#xa0;</xsl:if>
					<span class="caret">&#xa0;</span></button>
				<ul class="dropdown-menu">
					<li><a href="{$adminroot}{$modName}/list/">Todos</a></li>
					<li class="divider">&#xa0;</li>
					<li>
						<xsl:if test="$state = 1">
							<xsl:attribute name="class">active</xsl:attribute>
						</xsl:if>
						<a href="{$adminroot}{$modName}/list/?state=1">Publicado</a>
					</li>
					<li>
						<xsl:if test="$state = 0">
							<xsl:attribute name="class">active</xsl:attribute>
						</xsl:if>
						<a href="{$adminroot}{$modName}/list/?state=0">No Publicado</a>
					</li>
					
					
					<!-- dropdown menu links -->
				</ul>
			</div>
		</xsl:if>
		<xsl:if test="$filter/group">
			<xsl:for-each select="$filter/group">
				<div class="btn-group">
					<button class="btn dropdown-toggle" data-toggle="dropdown"><xsl:value-of select="@name" />&#xa0;
						<xsl:if test="$category_id != ''"> &#x02192; <xsl:value-of select=".//category[@category_id=$category_id]/name" />&#xa0;</xsl:if>
					<span class="caret">&#xa0;</span>
					</button>
					<ul class="dropdown-menu">
				    	<li>
							<a>
								<xsl:choose>
									<xsl:when test="$state != ''">
										<xsl:attribute name="href"><xsl:value-of select="$adminroot"/><xsl:value-of select="$modName"/>/list/?state=<xsl:value-of select="$state" /></xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="href"><xsl:value-of select="$adminroot"/><xsl:value-of select="$modName"/>/list/</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
								Todas
							</a>
						</li>
						<li class="divider">&#xa0;</li>

						<xsl:for-each select="category">
				    		<xsl:sort order="ascending" select="@order" data-type="number" />
							<xsl:call-template name="filter.item" />
						</xsl:for-each>
						

					</ul>
				</div>
			</xsl:for-each>
		</xsl:if>
	</div>
</xsl:template>

<xsl:template name="filter.item">
	<xsl:param name="prefix" />
		<li>
			<xsl:if test="@category_id = $category_id">
				<xsl:attribute name="class">active</xsl:attribute>
			</xsl:if>
			<a>
				<xsl:choose>
					<xsl:when test="$state != ''">
						<xsl:attribute name="href"><xsl:value-of select="$adminroot"/><xsl:value-of select="$modName"/>/list/?categories=<xsl:value-of select="@category_id"/>&amp;state=<xsl:value-of select="$state" /></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="href"><xsl:value-of select="$adminroot"/><xsl:value-of select="$modName"/>/list/?categories=<xsl:value-of select="@category_id"/></xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="$prefix != ''"><xsl:value-of select="$prefix" /></xsl:if>
				<xsl:value-of select="name" />
			</a>
		</li>
		<xsl:if test="categories/category">
			<xsl:for-each select="categories/category">
				<xsl:call-template name="filter.item">
					<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/>- </xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>
</xsl:template>


<!--################### FIN TEMPLATES DE FILTROS ####################-->





<xsl:template name="display.collection" >
	<xsl:param name="collection" />
	<xsl:param name="display_photo" >1</xsl:param>

<div class="row">
	<div class="col-sm-12">
		<ul class="breadcrumb">
	        <li ><i class="fa fa-home">&#xa0;</i> <xsl:value-of select="$config/module/@title" /></li>
	    </ul>
	</div>
</div>

<div class="row">
	<div class="col-sm-12">
		<section class="panel">
			<header class="panel-heading wht-bg">
				<div class="btn-group pull-right">
					<a href="{$adminroot}{$modulename}/add" class="btn btn-info">Agregar&#xa0;<i class="fa fa-plus">&#xa0;</i></a>
				</div>
				<h4><xsl:value-of select="$config/module/@title" />&#xa0;</h4>
			</header>

			<div class="panel-body">
				<div class="clearfix">

					

					<!-- <xsl:call-template name="filter.list">
						<xsl:with-param name="filter" select="content/filter" />
					</xsl:call-template> -->

					
				</div>
				<!-- <div class="list-tools floatFix">
							
							

							

					
							<xsl:call-template name="search.box" />
							<xsl:call-template name="pagination.box" />

					
				</div> -->
				<!-- 
				<div class="list-actions">
					<span class="left">
						<label for="all">Seleccionar todos</label>
						<input type="checkbox" name="all" id="all" class="checkAll" />
					</span>
					
					<div class="btn-group">
						<a href="#" class="btn delete">Eliminar</a>
						<xsl:if test="$config/module/options/group[@name='categories']/option">
							<a href="#" class="btn categories">Categorizar</a>
						</xsl:if>
						<a href="#" class="boton publish">Publicar</a>
						<a href="#" class="boton unpublish">Despublicar</a>
						<a href="#" class="btn duplicate">Duplicar</a>
					</div>
				</div> -->
		

		
	<!-- 
			<xsl:if test="$query != ''">
					<div class="alert">
						<button class="close" data-dismiss="alert">×</button>
						Mostrando resultados  
						para la búsqueda <strong><em>"<xsl:value-of select="$query"/>"</em></strong>
						<xsl:if test="$category_id != ''"> de la categoría <xsl:value-of select="//category[@category_id=$category_id]/name" /></xsl:if>
						<xsl:variable name="found">
							<xsl:choose>
								<xsl:when test="/xml/content/collection/@total !=''">
									<xsl:value-of select="/xml/content/collection/@total" />
								</xsl:when>
								<xsl:otherwise>0</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						(<xsl:value-of select="$found" /> elementos encontrados)
					</div>
			    </xsl:if>
	 -->
			

				

			    <xsl:choose>
			    	<xsl:when test="not($collection/object) and $query = ''">
			    		<div class="panel-body">
			    			<div class="alert alert-warning fade in">
			    				<button data-dismiss="alert" class="close close-sm" type="button" >
                                	<i class="fa fa-times">&#xa0;</i>
                             	</button>
				    			<strong>No se encontró ningun elemento.</strong>
				    			
				    		</div>
				    	</div>
			    	</xsl:when>
			    	<xsl:otherwise>
						
						<div class="panel-body">
							<table class="table table-hover general-table" >
								<thead>
									<tr>
										<th>&#xa0;</th>
										<th>Titulo</th>
										<th>Fecha</th>
										<th>Estado</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>
								<xsl:for-each select="$collection/object">
									<tr class="item_row" id="object_{@id}" item_id="{@id}">
										<td>								
												<input type="checkbox" name="item_{@id}" class="check"/>
										</td>
										<td>
												<!-- PHOTO 
												<xsl:if test="$display_photo = 1">
													<xsl:choose>
														<xsl:when test="multimedias/photos/photo">
															<xsl:variable name="suffix">
																<xsl:choose>
																	<xsl:when test="multimedias/photos/photo/@preview = 1">_custom</xsl:when>
																	<xsl:otherwise>_t</xsl:otherwise>
																</xsl:choose>
															</xsl:variable>

															
															<a href="{$adminroot}{$modulename}/edit/{@id}">
															<xsl:call-template name="photo">
																<xsl:with-param name="id" select="multimedias/photos/photo[@order=1 or @order=0]/@photo_id" />
																<xsl:with-param name="suffix" select="$suffix" />
																<xsl:with-param name="type" select="multimedias/photos/photo[@order=1 or @order=0]/@type" />
																<xsl:with-param name="class">pic</xsl:with-param>
															</xsl:call-template>
															</a>
														</xsl:when>
														<xsl:otherwise>
															<span class="pic">&#xa0;</span>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:if>
												 // PHOTO -->
											
												<a href="{$adminroot}{$modulename}/edit/{@id}">
													<xsl:value-of select="title" />
												</a>
											</td>
											

											<td>

												<xsl:if test="publishedby">
													<span class="right" style="margin:0 10px 0 0;">
														Publicado por<br/> <xsl:value-of select="publishedby" />&#xa0;<!-- 
													 --><abbr class="timeago" title="{publication_date}"><xsl:value-of select="publication_date"/></abbr>
													</span>
												</xsl:if>
												
											</td>
											
											<td>

												<xsl:choose>
													<xsl:when test="@state = 0">
														<a href="#" class="publish" rel="tooltip" title="Sin publicar"><span class="status unpublished rounded">Un Published</span></a>
													</xsl:when>
													<xsl:when test="@state = 1">
														<a href="#" class="unpublish" rel="tooltip" title="Publicado"><span class="status published rounded">Published</span></a>
													</xsl:when>
													<xsl:when test="@state = 3">
														<a href="#" class="republish" rel="tooltip" title="Volver a publicar"><span class="status saved rounded">saved</span></a>
													</xsl:when>
												</xsl:choose>

												

												

												<xsl:for-each select="categories/category[not(@parent=1)]">
													<xsl:sort order="ascending" select="@order" data-type="number"/>
													<span class="cat">
														<a href="{$adminroot}{$modName}/list/?categories={@category_id}"><xsl:value-of select="name" /></a>
													</span>
													<!-- <xsl:if test="position()!=last()">, </xsl:if> -->
												</xsl:for-each>
												
											</td>


											
											<td>
												
													<a href="{$adminroot}{$modulename}/edit/{@id}" class="btn btn-sm btn-info" >
														<i class="fa fa-pencil">&#xa0;</i>
														Editar
													</a> 
													<a class="btn btn-sm btn-default deleteObject" href="#" title="Borrar">
														<i class="fa fa-trash-o">&#xa0;</i>
														Borrar
													</a>
												
											</td>
									</tr>
								</xsl:for-each>
								</tbody>
							</table>
						</div>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</section>
	</div>
</div>
</xsl:template>


<xsl:template name="resource.concept.combo">
	<select name="concept" class="form-control">
		<option value="Unidad">Unidad</option>
		<option value="Mensual">Mensual</option>
		<option value="Diario">Diario</option>
		<option value="Global">Global</option>
		<option value="Programas">Programas</option>
	</select>
</xsl:template>



<xsl:template name="factura.type.combo">
	<select name="type" class="form-control">
		<option value="">Seleccionar</option>
		<option value="A">A</option>
		<option value="B">B</option>
		<option value="C">C</option>
		<option value="Ticket">Ticket</option>
		<option value="Sin Comprobante">Sin Comprobante</option>
	</select>
</xsl:template>


<xsl:template name="providers.combo">
	<xsl:param name="providers" />
	<select name="provider_id" class="form-control">
		<option value="">Seleccionar</option>
		<xsl:for-each select="$providers/object">
			<xsl:sort select="title" />
			<option value="{@id}"><xsl:value-of select="title" /></option>
		</xsl:for-each>
	</select>
</xsl:template>





</xsl:stylesheet>