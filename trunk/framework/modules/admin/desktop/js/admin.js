/*
 * jQuery modion backend functions
 * @Author: Claudio Romano Cherñac
 * @requires jQuery v1.2.2 or later

 * Copyright (c) 2011 Frooit.com <http://www.frooit.com/>
 */


var adminpath, adminmod, isCtrl = false, isShift = false, cookieOptions = {};

/*jQuery(window).bind('load',function(){*/
jQuery(document).ready(function(){

	if($('#mdn_navigation').length > 0){
		$(this).layout();
		showTools();
		$(window).resize(function(){
			$(this).layout();
			showTools();
		});
	}

	modion.keyboard();
	modion.setScroll();
	cookieOptions = {path : String(adminpath), expires : 7}	

});


/*
Key combination reference
ctrl = 17;
shift = 16;
alt = 18
cmd = 224
esc = 27
*/
var config = {
	keys : [
		/*{name:'Arrow Left',  code: 37,  call: '', ctrl: 0, shift: 0},
		{name:'Arrow Up',    code: 38,  call: '', ctrl: 0, shift: 0},
		{name:'Arrow Right', code: 39,  call: '', ctrl: 0, shift: 0},
		{name:'Arrow Down',  code: 40,  call: '', ctrl: 0, shift: 0},
		{name:'Enter',       code: 13,  call: '', ctrl: 0, shift: 0},*/
		{name:'Num 1',       code: 49,  call: 'grid.showlist()',  ctrl: 1, shift: 0},
		{name:'Num 2',       code: 50,  call: 'grid.showbox()',   ctrl: 1, shift: 0},
		{name:'S',           code: 83,  call: 'modion.SaveEditForm()',  ctrl: 0, shift: 0},
		{name:'N',           code: 78,  call: 'modion.CreateNew()', ctrl: 0, shift: 0}
	]
}

var modion = {

	id : 0,
	group : [],
	fullscreen : false,

	keyboard : function(){

		$(document.documentElement).keydown(function(event){
			var element = $(event.target);
			if (!element.is('input,textarea')) {

				if(event.which == 17) isCtrl  = true;
		    	if(event.which == 16) isShift = true;

		    	//alert(event.keyCode);
				jQuery.each(config.keys, function(pos, el){
					if(event.keyCode == el.code){
						if(el.ctrl == 1 && el.shift == 1 && isCtrl  && isShift)   {modion.callFunc(el.call);}
						if(el.ctrl == 1 && el.shift == 0 && isCtrl  && !isShift)  {modion.callFunc(el.call);}
						if(el.ctrl == 0 && el.shift == 1 && !isCtrl && isShift)   {modion.callFunc(el.call);}
						if(el.ctrl == 0 && el.shift == 0 && !isCtrl && !isShift)  {modion.callFunc(el.call);}
					}
				});
			}
		});

		$(document).keyup(function(e){
			if(e.which == 17) isCtrl  = false;
			if(e.which == 16) isShift = false;
		});
	},

	callFunc: function(name){
		eval(name);
	},

	displayError : function(message)
	{
		var html = '<h3>Error <small>El sistema ha encontrado un error de Javascript</small></h3>';
		html += '<div class="alert alert-error">'+message+'</div>';

		var options = {width:400, height: 100, html: html};
		layer.load(options);
		
		//alert(message);
	},

	displayMessage : function(message)
	{
		var html = '<h3>Mensaje</h3>';
		html += '<div class="alert">'+message+'</div>';

		var options = {width:400, height: 200, html: html};
		layer.load(options);

	},

	ajaxCall : function(options, callOptions){

		var defaults = {
			m: 'object',
			action: null
		};
		options = jQuery.extend(defaults, options);
		
		if(options.action == null){return false;}

		var dataStr = '';
		for(x in options){
			dataStr += x+'='+options[x]+'&';
		}

		var ajaxOptions = {
			type: "POST",
			async: true,
			cache: false,
			context: this,
			beforeSend: false,
			complete: false,
			callback: false,
			success: callOptions.callback,
			error: null,
			url: adminpath,
			data: dataStr
		}

		callOptions = jQuery.extend(ajaxOptions, callOptions);

		try {
			jQuery.ajax(callOptions);
		}
		catch(e){
			alert(e);
		}

	},

	callback_default: function(response){
		this.displayError("Uncaught Ajax Response:\n"+response);
	},

	CreateNew : function()
	{
		window.location.href = adminpath+module+'/add/';
	},

	focusSearch : function()
	{
		$("input[name='q']").val('').focus();
	},

	SaveEditForm : function()
	{
		$("form[name='edit']").submit();
	},

	toggleFullScreen : function()
	{
		if(!this.fullscreen){
			var docElm = $('body')[0];
	        if      (docElm.requestFullscreen)       {docElm.requestFullscreen();}
	        else if (docElm.mozRequestFullScreen)    {docElm.mozRequestFullScreen();}
	        else if (docElm.webkitRequestFullScreen) {docElm.webkitRequestFullScreen();}
	        $('body').css({"width":"100%"});
	        this.fullscreen = true;
    	}else{

    		if      (document.exitFullscreen)         {document.exitFullscreen();}
            else if (document.mozCancelFullScreen)    {document.mozCancelFullScreen();}
            else if (document.webkitCancelFullScreen) {document.webkitCancelFullScreen();}
            $('body').css({"width":"auto"});
            this.fullscreen = false;
    	}
	},

	parseQueryString : function(query)
	{
		var Params = {};
		if ( ! query ) {return Params;}// return empty object
		var Pairs = query.split(/[;&]/);
		for ( var i = 0; i < Pairs.length; i++ ) {
			var KeyVal = Pairs[i].split('=');
			if ( ! KeyVal || KeyVal.length != 2 ) {continue;}
			var key = unescape( KeyVal[0] );
			var val = unescape( KeyVal[1] );
			val = val.replace(/\+/g, ' ');
			Params[key] = val;
		}
		return Params;
	},

	setScroll : function()
	{
		// setSlider($('.box-overflow'));
		// setSlider($('#mdn_navigation'));

		// $(".slider-wrap").hide();
		// $(".scroll-container").hover(function(){
		// 		$(".slider-wrap", this).fadeIn('fast');
		// 	},
		// 	function(){
		// 		$(".slider-wrap", this).fadeOut('fast');
		// });
	},

	publish : function(object_id)
	{
		if(confirm("Estas seguro que deseas publicar el elemento?")){
			//jElement.prepend(loader).find('.status').hide();
			$('.publish').hide();
			$('.republish').hide();
			$('#publishing span.right').append('<span class="boton btnproccess">Publicando...</span>');
		
			var module_name = "object";
			if(typeof(module)!= "undefined" ){
				module_name = module;
			}
			

			this.id = object_id;
			modion.ajaxCall(
			{
				m: module_name,
				action: 'BackPublish',
				item_id: object_id
			},
			{
				callback: this.publish_callback,
				context: modion
			});
		}

	},

	publish_callback : function(data, textStatus, jqXHR)
	{
		//alert("Cambio: "+this.id);

		if(data == 1)
		{
			
			var unpublish = $(document.createElement('a')).attr("class","boton unpublish").html('Despublicar');

			unpublish.click(function(e){
				e.preventDefault();
				modion.unpublish(modion.id);
			});
			$('#publishing span.right').prepend(unpublish);
			$('#publishing span.itemstatus').html('<span class="status published rounded left ">Published</span>&#xa0;Publicado');
			$('.btnproccess').hide(); 

		}else
		{
			modion.displayError(data);
		}
		
	},

	unpublish : function(object_id)
	{
		if(confirm("Estas seguro que deseas despublicar el elemento?")){
			//jElement.prepend(loader).find('.status').hide();

			$('.unpublish').before('<span class="btn btnproccess">Publicando...</span>');
			$('.unpublish').hide();

			var module_name = "object";
			if(typeof(module)!= "undefined" ){
				module_name = module;
			}

			this.id = object_id;
			modion.ajaxCall(
			{
				m: module_name,
				action: 'BackUnPublish',
				item_id: object_id
			},
			{
				callback: this.unpublish_callback,
				context: modion
			});
		}

	},

	unpublish_callback : function(data, textStatus, jqXHR)
	{
		//alert("Cambio: "+this.id);

		if(data == 1)
		{
			var unpublish = $(document.createElement('a')).attr("class","btn publish").html('Publicar');

			unpublish.click(function(e){
				e.preventDefault();
				modion.publish(modion.id);
			});
			$('#publishing span.right').prepend(unpublish);
			$('#publishing span.itemstatus').html('<span class="status unpublished rounded left ">Published</span>&#xa0;Despublicado');
			$('.btnproccess').hide();

		}else
		{
			modion.displayMessage(data);
			$('.btnproccess').hide();
			$('.unpublish').show();
		}
		
	},

}


var relation = {

	relation_id : 0,
	type_id : 0,

	AddItem : function(elem)
	{
		if(elem.is(':checked')){
			var label = jQuery('label[for=rel_'+elem.val()+']').html();
			jQuery('#relations-list')
				.append('<li id="item-'+elem.val()+'"><input type="hidden" name="objects[]" value="'+elem.val()+'"/>'+label+'</li>');
		}else{
			jQuery('#relations-list #item-'+elem.val()).remove();
		}
	},

	updateList : function(object_id, type_id)
	{
		this.type_id = type_id;

		modion.ajaxCall(
		{
			m:'object',
			action:'BackRefreshRelations',
			object_id: object_id,
			type_id: type_id
		},
		{
			callback: this.updateList_callback,
			context: relation
		});

	},

	updateList_callback : function(data, textStatus, jqXHR)
	{
		jQuery('#relation-'+this.type_id).html(data);
		var string = "<xml>"+data+"</xml>",
		xmlDoc = jQuery.parseXML(string),
		xml = jQuery(xmlDoc);
		jQuery("ul[name='relation-"+this.type_id+"'] .count").html(xml.find('li').size());
	},

	delete : function(object_id, relation_id)
	{
		this.relation_id = relation_id;

		modion.ajaxCall(
		{
			m:'object',
			action:'BackDeleteRelation',
			object_id: object_id,
			relation_id: relation_id
		},
		{
			callback: this.delete_callback,
			context: relation
		});

	},

	delete_callback : function(data, textStatus, jqXHR)
	{
		if(data==1){
			jQuery('#rel-'+this.relation_id).slideUp('fast');
			
			var container = jQuery('#rel-'+this.relation_id).parent().parent().parent(); 
			var count = jQuery(".count", container).html();
			jQuery(".count", container).html(count-1);

			jQuery('#rel-'+this.relation_id).remove();

		}else{
			alert('Se ha producido un error y no se pudo borrar la relación');
		}
	},

	add : function(){},
	add_callback : function(){}

}

var category = {
	id : 0,
	parent : 0,
	delete : function(category_id, object_id)
	{	
		this.id = category_id;
		//category.id = category_id;
		modion.ajaxCall(
		{
			m:'object',
			action:'BackDeleteCategoryRelation',
			object_id: object_id,
			category_id: category_id
		},
		{
			callback: this.delete_callback,
			context: category
		});
	},

	delete_callback : function(data, textStatus, jqXHR)
	{
		if(data=='1'){
			$("*[category_id="+this.id+"]").slideUp('fast', function(){$(this).remove()});
		}else{
			modion.displayError('Se ha producido un error y no se pudo borrar la categoría');
		}
	},

	AddItem : function(elem)
	{
		if(elem.is(':checked')){
			var label = jQuery('label[for=cat_'+elem.val()+']').html();
			jQuery("form[name='categorizar']")
				.append('<input type="hidden" name="categories[]" value="'+elem.val()+'"/>');
		}else{
			jQuery('#category-list #item-'+elem.val()).remove();
		}
	},

	objectUpdateList : function(object_id, parent_id)
	{
		this.parent = parent_id;
		//category.id = category_id;
		modion.ajaxCall(
		{
			m:'object',
			action:'BackRefreshCategories',
			object_id: object_id,
			parent_id: parent_id
		},
		{
			callback: this.objectUpdateList_callback,
			context: category
		});
	},

	objectUpdateList_callback : function(data)
	{
		jQuery('#categories-'+this.parent).html(data);
	},

	multimediaUpdateList : function(multimedia_id, parent_id)
	{
		this.parent = parent_id;
		//category.id = category_id;
		modion.ajaxCall(
		{
			m:'multimedia',
			action:'BackRefreshCategories',
			multimedia_id: multimedia_id,
			parent_id: parent_id
		},
		{
			callback: this.multimediaUpdateList_callback,
			context: category
		});

	},

	multimediaUpdateList_callback : function(data)
	{
		jQuery('#categories-'+this.parent).html(data);
	},

	multimediaDelete : function(category_id, multimedia_id)
	{
		this.id = category_id;

		modion.ajaxCall(
		{
			m:'multimedia',
			action:'BackDeleteCategoryRelation',
			multimedia_id: multimedia_id,
			category_id: category_id
		},
		{
			callback: this.multimediaDelete_callback,
			context: category
		});

	},

	multimediaDelete_callback : function(data, textStatus, jqXHR)
	{
		if(data==1){
			jQuery('#cat-'+this.id).slideUp('fast');
			jQuery('#cat-'+this.id).remove();
		}else{
			modion.displayError('Se ha producido un error y no se pudo borrar la categoría');
		}
	}


}



var grid = {

	showlist: function(){
		$('.gridbox').removeClass('pressed');
		$('.gridlist').addClass('pressed');

		$('#grid').removeClass('grid-box').addClass('grid-list');
		//$('.list-header').removeClass('rounded');

		$(this).layout()
		$.cookie('gridview', 'list', cookieOptions);
	},

	showbox: function(){
		$('.gridlist').removeClass('pressed');
		$('.gridbox').addClass('pressed');
		$('#grid').removeClass('grid-list').addClass('grid-box');
		
		var boxwidth = $('.grid-box ul.list li').width();
		$('li.longbox').css({width:(boxwidth-30)+'px'})
		$('li.sidebar').css({width:(boxwidth-120)+'px'})
		
		$(this).layout();
		$.cookie('gridview', 'box', cookieOptions);
	},

	swapView: function(){
		//modion.displayMessage('Cambio la grilla');

	}

}




var layer = {
	options : {
			overlay : 'mdn_overlay',
			modalwindow   : 'mdn_modal',
			iframe : 'mdn_iframe',
			background : 'mdn_background',
			topbar : 'mdn_topbar',
			close : 'mdn_close',
			closeBtn : 'mdn_closeButton'
	},
	modalWidth : 720,
	modalHeight : 530,

	load : function(options)
	{
		var defaults = {
			html: null,
			width: 600,
			height: 300,
		};
		options = jQuery.extend(defaults, options);

		try {

			var layerwindow = this;
			
			if(options.width == 'window'){
				var w = $(window).width();
				this.modalWidth = w - 50;
			}else{
				this.modalWidth = parseInt(options.width,10) + 30 || this.modalWidth;
			}

			if(options.height == 'window'){
				var h = jQuery(window).height();
				this.modalHeight = h - 50;
			}else{
				this.modalHeight = parseInt(options.height, 10) + 40 || this.modalHeight;
			}

			var content = $(document.createElement('div')).attr("style", "padding:15px;");
			content.append(options.html)
			this.showModal(content);

		}catch(e){
			alert("Error: "+e);
		}
	},

	loadExternal : function(reference)
	{
		try {

			
			url = (typeof reference == 'object') ? reference.href : reference;
			var options = this.options;

			//Remover previous iframe
			$('#'+options.iframe).remove();

			var queryString = url.replace(/^[^\?]+\??/,'');
			var params = modion.parseQueryString(queryString);

			if(params['width']=='window'){
				var w = $(window).width();
				this.modalWidth = w - 50;
			}else{
				this.modalWidth = (params['width']*1) + 30 || 620;
			}

			if(params['height']=='window'){
				var h = jQuery(window).height();
				this.modalHeight = h - 50;
			}else{
				this.modalHeight = (params['height']*1) + 40 || 400;
			}

			var debug = {
				"window width": $(window).width(),
				"window height": $(window).height(),
				"modal width": this.modalWidth,
				"modal height": this.modalHeight
			};
			//console.log(debug);

			iframeWidth  = this.modalWidth;
			iframeHeight = this.modalHeight;

			var iframe   = $(document.createElement('iframe'))
								.attr(
									{
										"frameborder" :"0", 
										"hspace" : "0", 
										"src" : url,
										"id" : options.iframe,
										"name" : options.iframe+Math.round(Math.random()*1000),
										"style" : "width:"+iframeWidth+"px;height:"+(iframeHeight - 40)+"px;"
									}
								);

			this.showModal(iframe);

		}
		catch(e){
			alert("Error: "+e);
		}
	},

	showModal : function(content)
	{
		try{

			var options = this.options;
			var layerwindow = this;

			if (typeof document.body.style.maxHeight === "undefined") {//if IE 6
				$("body","html").css({height: "100%", width: "100%"});
				$("html").css("overflow","hidden");
				if (document.getElementById("mdn_HideSelect") === null) {//iframe to hide select elements in ie6
					$("body").append("<iframe id='mdn_HideSelect'></iframe>");
				}
			}else{//all others
				if(document.getElementById("mdn_overlay") === null){
					//$("body").append("<div id='mdn_overlay'></div><div id='mdn_modal'></div>");
				}
			}

			// Create html Elements
			var overlay     = $(document.createElement('div')).attr({"id":options.overlay, "class": options.background});
			var modalwindow = $(document.createElement('div')).attr("id", options.modalwindow);
			var topbar      = $(document.createElement('div')).attr("id", options.topbar);
			var close       = $(document.createElement('div')).attr("id", options.close);
			var closeBtn    = $(document.createElement('a'))
								.attr(
									{
										"href":"#", 
										"id":options.closeBtn, 
										"Title": "Cerrar"
									}
								)
								.bind('click',function(){layerwindow.Remove()})
								.html('Cerrar');

			$(modalwindow).append($(topbar).append($(close).append(closeBtn))).append(content);
			$("body").append(overlay).append(modalwindow);

			this.setPosition();

			$("#mdn_modal").css({display:"block"});
			
			document.onkeyup = function(e){ 	
				if (e == null) { // ie
					keycode = event.keyCode;
				} else { // mozilla
					keycode = e.which;
				}
				if(keycode == 27){ // close
					layerwindow.Remove();
				}	
			}

		}
		catch(e){
			alert("Error: "+e);
		}
	},

	setPosition : function()
	{
		var modalWidth = this.modalWidth, modalHeight = this.modalHeight;

		$("#"+this.options.modalwindow).css(
			{
				marginLeft: '-' + parseInt((modalWidth / 2),10) + 'px',
				width: modalWidth + 'px',
				height: modalHeight - 10 //add height of the header
			}
		);
		// if ( !(jQuery.browser.msie && jQuery.browser.version < 7)) { // take away IE6
		// 	$("#mdn_modal").css(
		// 		{
		// 			marginTop: '-' + parseInt((modalHeight / 2),10) + 'px'
		// 		}
		// 	);
		// }
	},

	Remove : function()
	{
		var options = this.options;

		$("#"+options.closeBtn).unbind("click");
		$("#"+options.modalwindow).fadeOut("fast",function(){
			$('#'+options.modalwindow+',#'+options.overlay+',#mdn_HideSelect').trigger("unload").unbind().remove();
		});
		
		if (typeof document.body.style.maxHeight == "undefined") {//if IE 6
			$("body","html").css({height: "auto", width: "auto"});
			$("html").css("overflow","");
		}
		document.onkeydown = "";
		document.onkeyup = "";
		return false;
	},

	Ready : function()
	{
		if($('#modalContent').length > 0)
		{
			$('body').animate({opacity:1}, 500, 
				function(){
					var wh = $(window).height();
					if($('.showButtons').length > 0){
						wh = wh - 80;
					}else{
						wh = wh - 40;
					}
					$('#modalContent').attr('style', 'height:'+wh+'px');
					//setSlider($('#modalContent'));
				}
			);
		}
	}

}




































function showTools(){
	if($('#tools').length > 0){

		

		var cw = $('#container').width() - ($('#tools').width() + 35);

		$('.box').css({width: cw+'px'});
		
		$('#tools').animate({opacity:1}, 1500, function(){
			if($('.mceLayout').length > 0){
				$('.mceLayout').css({width:'100%'});
				$('.mceLayout iframe').css({width:'100%'});
			}
		});
	}
}


jQuery.fn.layout = function(){

	var wh = $(window).height();
	var ww = $(document).width();

	var navigationHeight = wh;
	$('#mdn_navigation, #mdn_limit').css({height:(navigationHeight - 60)+'px'});
	
	//Posicionamiento barra
	var navleft = $.cookie('navigation_left');

	if(!is_null(navleft)){
		$('#mdn_navigation').css({width:navleft+'px'});
		$('#mdn_limit').css({left:navleft+'px'});
		var dif = parseInt(navleft);
	}else{
		var nw = $('#mdn_navigation').width();
		$('#mdn_limit').css({left:nw+'px'});
		var dif = nw;
		//$('#container').css({'margin-left':dif+'px'});
	}
	
	
	var containerwidth  = (ww-dif) - 40 - 95;
	var containerheight = (ww-dif) - 30;
	

	//console.log(containerwidth);
	$('#container:not(.homeEditor)').css({width:containerwidth+'px'});
	$('.list-header:not(.homeEditor)').css({width:containerwidth+'px'});
	
	//$('.box-overflow').css({height:(wh-100)+'px'})

	

	//$('#container').css({'margin-left':dif+'px'});

	// Abrir y cerrar la navegacion
	/*$('#mdn_limit').draggable({
		axis: 'x',
		addClasses: false,
		start: function(){
			
		},
		drag: function(event, ui){
			if(ui.offset.left < 400 && ui.offset.left > 0){
				$('#mdn_navigation').css({width: ui.offset.left});
				var dif = ui.offset.left + 14; //Ancho de la barra separadora
				
				$('#container').css({width:(ww-dif)-30+'px'});
				AdjustList();
				
				$.cookie('navigation_left', ui.offset.left, cookieOptions);
				showTools();
			}else{
				ui.helper.draggable('cancel');
			}
		}
	});*/

	AdjustList();
	modion.setScroll();
	displayGroup('content');
}

function AdjustList(){
	if($('#grid.grid-list').length > 0 )
	{
		var width   = $('ul.list ul').width();
		var longbox = Math.floor(width*0.7) - 45;
		var sidebar = Math.floor(width*0.3) - 40;

		$('li.longbox').css({width:longbox+'px'});
		$('li.sidebar').css({width:sidebar+'px'});
	}
}

function is_null(input){
	return input==null;
}

function displayGroup(group_name){
	$('.mdn_navgroup').hide();
	$('#'+group_name).show();
}

window.onerror = modion.displayError;


