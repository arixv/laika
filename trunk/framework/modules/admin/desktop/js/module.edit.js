cookieOptions = {}

var multimediaActions = [
	{
		"type_id" : 1,
		"setRelations"    : {"module":"photo", "method":"BackSetRelation"},
		"updateRelations" : {"module":"photo", "method":"BackRefreshRelation"},
	},
	{
		"type_id" : 2,
		"setRelations"    : {"module":"video", "method":"BackSetRelation"},
		"updateRelations" : {"module":"video", "method":"BackRefreshRelation"},
	},
	{
		"type_id" : 3,
		"setRelations"    : {"module":"document", "method":"BackSetRelation"},
		"updateRelations" : {"module":"document", "method":"BackRefreshRelation"},
	},
	{
		"type_id" : 4,
		"setRelations"    : {"module":"audio", "method":"BackSetRelation"},
		"updateRelations" : {"module":"audio", "method":"BackRefreshRelation"},
	}
]


$(document).ready(function()
{
	
	// Borrar categorias
	$('.categories-list li a.delete').click(function(e){
		e.preventDefault();
		var category_id = $(this).attr('category_id');
		var object_id   = $(this).attr('object_id');
		category.delete(category_id,object_id)
	});


	// Cajas movibles
	$('li.header').each(function(){
		$(this).prepend('<a href="#" class="button open">&#xa0;</a>');

		$(this).parent().collapseTools({
			trigger     : "button",
			collapse    : "collapsable",
			closeClass  : "open",
			openClass   : "close"
		});
	});
	
	$("#tools .padding").sortable({
		//axis: "y",
		cursor: "move",
		handle: ".header",
		update: function() { saveOrder(); }
	});
	restoreOrder();
	
	// $('.header:first').find('.subir').addClass('stop');
	// $('.header:last').find('.bajar').addClass('stop');

	cookieOptions = {path : String(adminpath), expires : 7}

});


var multimedia = {
	id: 0,
	typeid: 0,
	object_id: 0,

	// Para las imagenes necesitamos crear tamaños
	setRelation : function(object_id, multimedia_id, type_id)
	{
		this.id        = multimedia_id;
		this.typeid    = type_id;
		this.object_id = object_id;

		var iframe = $('#mdn_iframe').contents();
		var row = jQuery("*[item_id='"+this.id+"'] li.sidebar", iframe);
		jQuery("a.boton", row).hide();
		$(row).append('<span class="right"><img src="'+adminmod+'/desktop/imgs/backgrounds/loader.gif" class="loader" /></span>');

		var local;
		for(x in multimediaActions)
		{
			temp = multimediaActions[x];
			if(temp.type_id == type_id){
				local = multimediaActions[x];
				//console.log(multimedia);
			}
		}


		modion.ajaxCall(
		{
			m: local.setRelations.module,
			action:local.setRelations.method,
			object_id: object_id,
			multimedia_id: multimedia_id
		},
		{
			callback: this.setRelation_callback,
			context: multimedia
		});
	},

	setRelation_callback: function(data, textStatus, jqXHR)
	{
		if(data=='1'){
			var iframe = $('#mdn_iframe').contents();
			var row = jQuery("*[item_id='"+this.id+"'] li.sidebar", iframe);
			$('.loader', row).hide();
			$(row).append('<span class="right">Ok!</span>');
			
			this.updateRelations(this.object_id, this.typeid);
		}else{
			modion.displayError(data);
			//return data;
			//document.write(msg);
		}
	},

	updateRelations: function(object_id, type_id)
	{
		var local;
		this.typeid = type_id;
		for(x in multimediaActions)
		{
			temp = multimediaActions[x];
			if(temp.type_id == type_id){
				local = multimediaActions[x];
				//console.log(multimedia);
			}
		}

		modion.ajaxCall(
		{
			m:local.updateRelations.module,
			action:local.updateRelations.method,
			object_id: object_id
		},
		{
			callback: this.updateRelations_callback,
			context: multimedia
		});
	},

	updateRelations_callback: function(data)
	{
		jQuery('#multimedia-'+this.typeid).html(data);
		var string = "<xml>"+data+"</xml>",
		xmlDoc = jQuery.parseXML(string),
		xml = jQuery(xmlDoc);
		jQuery("ul[type_id='"+this.typeid+"'] .count").html(xml.find('li').size());
	},


	removeRelation: function(object_id, multimedia_id, type_id)
	{
		this.id     = multimedia_id;
		this.typeid = type_id;
		modion.ajaxCall(
		{
			m: 'multimedia',
			action: 'BackDeleteRelation',
			object_id: object_id,
			mid: multimedia_id
		},
		{
			callback: this.removeRelation_callback,
			context: multimedia
		});

	},

	removeRelation_callback: function(data, textStatus, jqXHR)
	{
		if(data==1){
			jQuery('#mid-'+this.id).slideUp('fast', function(){
				jQuery('#mid-'+this.id).remove();
			});
			var count = jQuery("ul[type_id='"+this.typeid+"'] .count").html();
			jQuery("ul[type_id='"+this.typeid+"'] .count").html(count-1);
		}else{
			alert(data);
		}
	},

}




$.fn.move = function(options){
	
	options = jQuery.extend({
		triggerUp   : ".subir",
		triggerDown : ".bajar",
		disable     : "stop",
		limit       : "stop"
	}, options);
	
	var thisElement = jQuery(this);

	return this.each(function(i){

		thisElement.find(options.triggerDown).click(function(e){
			e.preventDefault();
			__slideDown(thisElement);
			return false;
		});
		
		thisElement.find(options.triggerUp).click(function(e){
			e.preventDefault();
			__slideUp(thisElement);
			return false;
		});
		
		
		thisElement.find('.mover').click(function(e){
			e.preventDefault();
			__ordenar($(this));
			return false;
		});

		__slideDown = function(element){
			var next  = element.next();
			
			if(next.attr('class')!=options.limit){
				var start = element.position().top;
				var end = next.position().top;

				var offset = start - end;
				element.animate({'top': (next.height()+22)+'px'}, 'fast');
				next.animate({ 'top': offset+'px'}, 'slow', function(){
					jQuery(element).swap(next);

					if(element.next().attr('class')==options.limit){
						element.find(options.triggerDown).addClass(options.disable);
						next.find(options.triggerDown).removeClass(options.disable);
					}

					if(next.prev().attr('class')==options.limit){
						element.find(options.triggerUp).removeClass(options.disable);
						next.find(options.triggerUp).addClass(options.disable);
					}

					element.css('top', '0');
					next.css('top', '0');

					saveOrder();
				}); 
			}
		}

		__slideUp = function(element){
			var next  = element.prev();

			if(next.attr('class')!=options.limit){
				var start = element.position().top;
				var end = next.position().top;

				var offset = start - end;
				element.animate({'top': -offset+'px'}, 'fast');
				next.animate({ 'top': (element.height()+22)+'px'}, 'slow', function(){
					jQuery(element).swap(next);
					
					if(element.prev().attr('class')==options.limit){
						element.find(options.triggerUp).addClass(options.disable);
						next.find(options.triggerUp).removeClass(options.disable);
					}
					
					if(next.next().attr('class')==options.limit){
						element.find(options.triggerDown).removeClass(options.disable);
						next.find(options.triggerDown).addClass(options.disable);
					}
					
					element.css('top', '0');
					next.css('top', '0');

					saveOrder();
				});
			}
		}

		__ordenar = function(el){
			var a = el[0];
			a.parentNode.insertBefore($('#ordenar')[0], a);
			$('#ordenar').show();
		}
	});
}


// Modificado de: http://brandonaaron.net/blog/2007/06/10/jquery-snippets-swap
jQuery.fn.swap = function(b) {
	b = jQuery(b)[0];
	var a = this[0];
	var t = a.parentNode.insertBefore(document.createTextNode(''), a);
	b.parentNode.insertBefore(a, b);
	t.parentNode.insertBefore(b, t);
	t.parentNode.removeChild(t);
	return this;
};


$.fn.collapseTools = function(options)
{
	options = jQuery.extend({
		name        : "boxclassname",
		trigger     : "button",
		collapse    : "box",
		closeClass  : "cerrarCanal",
		openClass   : "abrirCanal"
	}, options);


	/* Administra las cajas de canales para abrir y cerrar desde el techo y los subcanales con solapas */
	return this.each(function(i){
		var container = jQuery(this);

		$('.'+options.trigger, container).click(function(e){
			e.preventDefault();
			_collapse($(this), $('.'+options.collapse, container));
		});

		_collapse = function(button, box){
			button.removeClass(options.closeClass).addClass(options.openClass);
			box.slideUp('fast');
			var name = box.parent().attr('id');
			$.cookie(name, 'collapsed', cookieOptions);
			button.unbind('click');
			button.click(function(e){
				e.preventDefault();
				_expand($(this), box)
			});
		}

		_expand = function(button, box){
			button.removeClass(options.openClass).addClass(options.closeClass);
			box.slideDown('fast');
			var name = box.parent().attr('id');
			$.cookie(name, 'expanded', cookieOptions);
			button.unbind('click');
			button.click(function(e){
				e.preventDefault();
				_collapse($(this), box)
			});
		}

		
		//var nameContainer = container.attr('id');
		//if($.cookie(nameContainer)=='collapsed'){
		//_collapse($('.'+options.trigger, container), $('.'+options.collapse, container));
		//}
		
		
	});
}



jQuery.fn.collapsableTabs = function(options){
	return this.each(function(){

		options = jQuery.extend({
			closed        : false,
			trigger       : ".subclose",
			collapse      : ".notas3 .padding",
			closeClass    : "cerrarSubcanal",
			openClass     : "abrirSubcanal",
			tabsContainer : "tabCollapse"
		}, options);
		

		var tabs = {
			selected  : 'activo',
			visible   : 'on',
			invisible : 'off',
			ignore    : 'collapse'
		};

		var container = jQuery(this);

		// Manejo de los tabs
		container.find("ul:first li").click(function()
		{
			var tab = $(this).attr('class');

			var tempstr = tab.split(' ');
			if(tempstr[1] != tabs.selected){
				//alert(tab);
				if(tab != tabs.ignore){
					//alert('')
					container.find('.'+tabs.selected).removeClass(tabs.selected);
					$(this).addClass(tabs.selected);
					var active = container.find('.'+tabs.visible);
					active.removeClass(tabs.visible);
					active.addClass(tabs.invisible);
					$("#"+tab).removeClass(tabs.invisible);
					$("#"+tab).addClass(tabs.visible);

					// Check si la caja esta abierta, si está cerrada la abrimos
					if(container.find(options.collapse).css('display')=='none'){
						__expand($(options.trigger, container), $(options.collapse, container));
					}
				}
			}
		});


		//Colapsar
		$(options.trigger, container).click(function(e){
			e.preventDefault();
			__collapse($(this), $(options.collapse, container));
		});

		__collapse = function(button, box){
			button.removeClass(options.closeClass).addClass(options.openClass);
			button.parent().parent().find('li').removeClass(tabs.selected);
			box.slideUp();
			button.unbind('click');
			button.click(function(e){
				e.preventDefault();
				__expand($(this), box)
			});
		}

		__expand = function(button, box){
			button.removeClass(options.openClass).addClass(options.closeClass);
			var solapa = box.find('.'+tabs.visible).attr('id');
			button.parent().parent().find('li.'+solapa).addClass(tabs.selected);
			box.slideDown();
			button.unbind('click');
			button.click(function(e){
				e.preventDefault();
				__collapse($(this), box)
			});
		}
		
		if(options.closed){
			__collapse($(options.trigger, container), $(options.collapse, container));
		}
	});
}


function HideContent(id) {
	document.getElementById(id).style.display = "none";
	//window.location.href = window.location.href;
	location.reload(true);
}



function saveOrder() {
	$.cookie('cajasTools', $('#tools .padding').sortable("toArray"), cookieOptions);
}


function saveListOrder(){
	var itemsList = $('#ordenar ul').sortable("toArray");

	var rebuild = new Array();
	for (var i = 0, n=itemsList.length; i < n; i++) {
		rebuild[i] = 'cajaItem-' + itemsList[i].substring(9,itemsList[i].length);
	}
	$.cookie('cajasLNorder', rebuild, cookieOptions);
}

function restoreOrder()
{
	var list = $('#cajasTools');
	if (list == null) return

	var cookie = $.cookie('cajasTools');
	if (!cookie) return;

	var IDs = cookie.split(",");
	var items = list.sortable("toArray");

	for (var i = 0, n = IDs.length; i < n; i++) {
		if(IDs[i]!=''){
			var id = IDs[i].substring(9,11);
			var itemID = IDs[i];
			//alert(itemID);
			var savedOrd = $("div.ui-sortable").children("#" + itemID);
			var cajaOrdenar = $("ul.ui-sortable").children("#sorteable-" + id);
			$("div.ui-sortable").filter(":first").append(savedOrd);
			$("ul.ui-sortable").filter(":first").append(cajaOrdenar);
		}
	}
	$("div.ui-sortable").append('<span class="stop"> </span>');
}


