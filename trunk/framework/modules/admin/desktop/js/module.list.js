
var actions = {
	"categories"  : {"module": module, "method" : "BackDisplayGroupCategoryModal"},
	"delete"      : {"module": module, "method" : "BackDelete"},
	"duplicate"   : {"module": module, "method" : "BackDuplicate"},
	"publish"     : {"module": module, "method" : "BackPublish"},
	"unpublish"   : {"module": module, "method" : "BackUnPublish"},
	"changeState" : {"module": module, "method" : "BackChangeState"},
	"deleteGroup" : {"module": module, "method" : "BackDeleteGroup"}
}

var loader = '<img src="'+adminmod+'/desktop/imgs/backgrounds/loader.gif" alt="" class="loader"/>';

$(document).ready(function(){

	// Inicializa los botones de cada item
	$('ul.list > li').not('.head').each(function(i,v){
		//console.log($(this).attr('id'));
		list.initRow($(this));
	});

	list.SetActions();

	if($('ul.multimedia').length == 0){	

		// Grilla en lista
		$('.gridlist').click(function(e){
			e.preventDefault();
			grid.showlist();
		});

		// Grilla en cajas
		$('.gridbox').click(function(e){
			e.preventDefault();
			grid.showbox();
		});

		// Restaurar grilla por cookie

		var gridview = $.cookie('gridview');
		if(!is_null(gridview)){
			if(gridview == 'box'){grid.showbox();}
		}

	}

	
	$("a[rel='tooltip']").tooltip('hide');
	jQuery("abbr.timeago").timeago();

});


var list = {
	id : 0,
	group : [],

	initRow : function(row)
	{
		var id = row.attr('item_id');
		$('.deleteObject', row)
				.click(
					function(e){
						e.preventDefault(); 
						list.delete(id); 
					}
				);

		$('.quickedit', row)
				.click(
					function(e){
						e.preventDefault(); 
						list.quickEdit(id);
					}
				);

		$('.publish, .republish', row)
				.click(
					function(e){
						e.preventDefault();
						list.publish(id, $(this));
					}
				);

		$('.unpublish', row)
				.click(
					function(e){
						e.preventDefault();
						list.unpublish(id, $(this));
					}
				);
		$('.check', row)
				.change(function(){
					if($(this).is(':checked')){
						list.ActionsShow();
						list.GroupItemAdd(row);
					}else{
						list.ActionsHide();
						list.GroupItemRemove(row);
					}
				});

		if($('ul.multimedia').length > 0){
			$('.longbox', row).hover(
				function(){
					$('.data', $(this)).show();
				},
				function(){
					
					$('.data', $(this)).hide();
				}
			);
			$('.more-data', row).click(function(){
				list.ToggleExtradata(row);
			});
		}
	},

	ToggleExtradata : function(row){
		if($('.extra-data', row).is(':visible'))
		{
			$('.extra-data', row).hide();
			$('.more-data', row)
				.removeClass('icon-minus-sign')
				.addClass('icon-plus-sign');
		}
		else
		{
			//$('.data', row).hide();
			$('.extra-data', row).show();
			$('.more-data', row)
				.removeClass('icon-plus-sign')
				.addClass('icon-minus-sign');
		}
		
	},

	ActionsShow : function()
	{
		if(!$('.list-actions').is(':visible')){
			$('.list-tools').fadeOut('fast', function(){
				$('.list-actions').fadeIn('fast');	
			});
		}
	},

	ActionsHide : function()
	{
		if($('.check:checked').length == 0){
			$('.list-actions').fadeOut('fast', function(){
				$('.list-tools').fadeIn('fast');	
			});
		}
		if($('.checkAll').is(':checked')){
			$('.checkAll').attr('checked', false)
		}
	},

	SetActions : function()
	{
		// Acciones en grupo
		var actions = $('.list-actions');
		$('.checkAll', actions)
				.change(function(){
					if($(this).is(':checked')){
						$('.check').each(function(){
							$(this).attr('checked', true);
							list.GroupItemAdd($(this).parent().parent().parent());
						});
						
					}else{
						$('.check').each(function(){
							$(this).attr('checked', false);
							list.GroupItemRemove($(this).parent().parent().parent());
						});
					}
				});

		$('.delete', actions)
				.click(function(e){
					e.preventDefault();
					if(list.group.length > 0)
					{
						list.GroupDelete();
					}else
					{
						alert('No hay elementos seleccionados');
					}
					
				});

		$('.categories', actions)
				.click(function(e){
					e.preventDefault();
					if(list.group.length > 0)
					{
						list.SetCategories();
					}else
					{
						alert('No hay elementos seleccionados');
					}
				});

		$('.duplicate', actions)
				.click(function(e){
					e.preventDefault();
					if(list.group.length > 0)
					{
						list.duplicate();
					}else
					{
						alert('No hay elementos seleccionados');
					}
				});
	},

	duplicate : function()
	{
		if(confirm("Estas seguro que deseas duplicar los elementos seleccionados?"))
		{
			modion.ajaxCall(
			{
				m:actions.duplicate.module,
				action:actions.duplicate.method,
				list: this.group
			},
			{
				callback: this.duplicate_callback,
				context: list
			});
		}
	},

	duplicate_callback : function(data, textStatus, jqXHR)
	{
		console.log(data);
		if(data == '1')
		{
			list.updateView();
		}
		else
		{
			modion.displayError(data);
		}
	},

	SetCategories : function()
	{
		var url = adminpath+'?m='+actions.categories.module+'&action='+actions.categories.method+'&module='+module+'&list='+this.group+'&height=window';
		layer.loadExternal(url);
		//layer(null,url,null);
	},

	GroupItemAdd : function(elem)
	{
		var id = elem.attr('item_id');
		var index = $.inArray(id, this.group);
		if(index == -1){
			this.group.push(elem.attr('item_id'));
		}
		console.log(this.group);
	},

	GroupItemRemove : function(elem)
	{
		var id = elem.attr('item_id');
		var index = $.inArray(id, this.group);
		this.group.splice(index,1);
		console.log(this.group);
	},

	/*
	GroupChangeState : function(state)
	{
		$.each(this.group, function(i, v){list.changeState(v, state);});
	},
	*/

	GroupDelete : function()
	{
		//console.log(this.group);
		if(confirm("Estas seguro que deseas eliminar los elementos seleccionados?\nEsta acción no se puede deshacer."))
		{
			modion.ajaxCall(
			{
				m:actions.deleteGroup.module,
				action:actions.deleteGroup.method,
				list: this.group
			},
			{
				callback: this.GroupDelete_callback,
				context: list
			});
		}

		$.each(this.group, function(i, v){
			console.log("borro el item: "+ v);
		});
	},

	GroupDelete_callback : function(data, textStatus, jqXHR)
	{
		if(data == '1')
		{
			$.each(this.group, function(i, v){
				//console.log("borro el item: "+ v);
				$("li[item_id='"+v+"']").fadeOut('fast').remove();
			});
			this.group = [];
		}
		else
		{
			alert(data);
		}
		//console.log(data);
	},

	delete : function(object_id)
	{
		//alert('Borro: '+ object_id)
		
		if(confirm("Estas seguro que quieres eliminar el elemento?")){
			
			this.id = object_id;
			modion.ajaxCall(
			{
				m: actions.delete.module,
				action: actions.delete.method,
				item_id: object_id
			},
			{
				callback: this.delete_callback,
				context: list
			});
			var id = name.substring(7,15);

		}
	},

	delete_callback : function(data, textStatus, jqXHR)
	{
		console.log(data);
		if(data == 1){
			$("li[item_id="+this.id+"]").slideUp();	
		}else{
			modion.displayMessage(data);
			//alert('Se ha producido un error');
		}
		
	},

	publish : function(object_id, jElement)
	{
		if(confirm("Estas seguro que deseas publicar el elemento?")){
			jElement.prepend(loader).find('.status').hide();

			this.id = object_id;
			modion.ajaxCall(
			{
				m: actions.publish.module,
				action: actions.publish.method,
				item_id: object_id
			},
			{
				callback: this.publish_callback,
				context: list
			});
		}

	},

	publish_callback : function(data, textStatus, jqXHR)
	{
		//alert("Cambio: "+this.id);

		if(data == 1)
		{
			var row = $("li[item_id="+this.id+"]");	
			$('.loader', row).hide().remove();
			$('.status', row).show();

			$('.publish, .republish', row).attr('data-original-title', 'Publicado');
			$('.publish span, .republish span', row)
				.removeClass('unpublished')
				.removeClass('saved')
				.addClass('published');

			$('.publish, .republish', row)
				.removeClass('publish')
				.removeClass('republish')
				.addClass('unpublish')
				.unbind('click')
				.click(
					function(e){
						e.preventDefault(); 
						list.unpublish(list.id, $(this));
					}
				)
		}else
		{
			modion.displayError(data);
		}
		
	},

	unpublish : function(object_id, jElement)
	{
		if(confirm("Estas seguro que deseas despublicar el elemento?")){
			jElement.prepend(loader).find('.status').hide();

			this.id = object_id;
			modion.ajaxCall(
			{
				m: actions.unpublish.module,
				action: actions.unpublish.method,
				item_id: object_id
			},
			{
				callback: this.unpublish_callback,
				context: list
			});
		}

	},

	unpublish_callback : function(data, textStatus, jqXHR)
	{
		//alert("Cambio: "+this.id);

		var row = $("li[item_id="+this.id+"]");	

		$('.loader', row).hide().remove();
		$('.status', row).show();

		if(data == 1)
		{
			
			
			$('.unpublish', row).attr('data-original-title', 'Sin Publicar');
			$('.unpublish span', row)
				.removeClass('published')
				.addClass('unpublished');

			$('.unpublish', row)
				.removeClass('unpublish')
				.addClass('publish')
				.unbind('click')
				.click(
					function(e){
						e.preventDefault();
						list.publish(list.id, $(this));
					}
				)
		}else
		{
			modion.displayMessage(data);

		}
		
	},

	changeState : function(object_id, object_state, jElement)
	{
		//alert('Borro: '+ object_id)
		jElement.prepend(loader).find('.status').hide();

		this.id = object_id;
		modion.ajaxCall(
		{
			m: actions.changeState.module,
			action: actions.changeState.method,
			item_id: object_id,
			item_state: object_state
		},
		{
			callback: this.changeState_callback,
			context: list
		});

	},

	changeState_callback : function(data, textStatus, jqXHR)
	{
		//console.log("Cambio: "+this.id);
		if(data == 1)
		{
			var row = $("li[item_id="+this.id+"]");	
			$('.loader', row).hide().remove();
			$('.status', row).show();
			if($('.publish', row).length > 0)
			{
				$('.publish', row).attr('data-original-title', 'Publicado');
				$('.publish span', row)
					.removeClass('unpublished')
					.addClass('published');

				$('.publish', row)
					.removeClass('publish')
					.addClass('unpublish')
					.unbind('click')
					.click(
						function(e){
							e.preventDefault(); 
							list.changeState(list.id, 0, $(this));
						}
					)
					
			}else{
				$('.unpublish', row).attr('data-original-title', 'Sin Publicar');
				$('.unpublish span', row)
					.removeClass('published')
					.addClass('unpublished');

				$('.unpublish', row)
					.removeClass('unpublish')
					.addClass('publish')
					.unbind('click')
					.click(
						function(e){
							e.preventDefault();
							list.changeState(list.id, 1, $(this));
						}
					)
			}

		}else
		{
			alert('Se ha producido un error');
		}
		
	},

	updateView : function()
	{
		window.location.reload();
	},


	quickEdit : function(object_id)
	{
		alert('quick edit object: '+ object_id);
	}

}


