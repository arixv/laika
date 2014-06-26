var sourcePath, generatedPath;


function processPhoto(form)
{

	/*
		Opciones:
		0 : Cortada al ancho (toma la configuracion de article)
		1 : Alineada a la izquierda
		2 : Alineada a la derecha
		3 : Original centrada
	*/

	var id = $('input[name=photo_id]', form).val();
	var type = $('input[name=type]', form).val();
	var column = $('input[name=column]:checked', form).val();

	var folder = id.substr(id.length - 1, 1);
	
	var suffix; var html;
	
	switch(column){
		case "1":
			suffix = "_p";
			html = '<span style="float:left;margin:0 10px 0 0;"><img src="'+generatedPath+folder+'/'+id+suffix+'.'+type+'" alt="" class="column left"/></span>';
			break;
		case "2":
			suffix = "_p";
			html = '<span style="float:right;margin:0 0 0 10px;"><img src="'+generatedPath+folder+'/'+id+suffix+'.'+type+'" alt="" class="column right"/><span>';
			break;
		case "3":
			html = '<p class="original" style="text-align:center;"><img src="'+sourcePath+folder+'/'+id+suffix+'.'+type+'" alt="" /></p>';
			break;
		default:
			suffix = "_n";
			html = '<span style="display:block;margin:10px 0;" class="fullwidth"><img src="'+generatedPath+folder+'/'+id+suffix+'.'+type+'" alt="" class="fullwidth"/></span>';
			break;
	}


	/*if(column == 1){
		prefix = '_p';
		html = '<img src="'+pathGenerated+folder+'/'+id+prefix+'.'+type+'" style="float:left;margin:0 10px 0 0;" alt="" class="column"/>';
	}else if(column == 2){
		html = '<p style="text-align:center;"><img src="'+pathSource+folder+'/'+id+'.'+type+'" alt="" class="original"/></p>';
	}else{
		prefix = '_605-360';
		html = '<img src="'+pathGenerated+folder+'/'+id+prefix+'.'+type+'" alt="" class="fullwidth"/>';
	}*/
	
	
	parent.tinyMCE.activeEditor.selection.setContent(html, {format : 'raw'});

	//parent.layer.Remove();;
	parent.layer.Remove();
	return false;
	
}


function EmbedAsGallery(object_id)
{
	
	html = '<slideshow object_id="'+object_id+'">&nbsp;</slideshow>';
	//var node = parent.tinyMCE.activeEditor.selection.getNode();
	
	parent.tinyMCE.activeEditor.dom.addClass(parent.tinyMCE.activeEditor.selection.getNode(), 'embed');
	parent.tinyMCE.activeEditor.selection.setContent(html, {format : 'raw'});
	
	
	
	//alert(node);
	//var el = parent.tinyMCE.activeEditor.dom.create('slideshow', {object_id : 31});
	//parent.tinyMCE.activeEditor.selection.setNode(el);
	//parent.tinyMCE.activeEditor.dom.replace(node, html);
	

	parent.layer.Remove();;
	return false;
	
}


function EmbedSelectedAsGallery(object_id)
{
	var ids = '';
	var html = '';

	$('.embedGallery, .embedAll').hide();

	$('.embed-details *').remove();
	$('.list-header span').html('Seleccione las fotos que desea en la galería');
	
	$('.embed-details').each(function(i){
		
		var btn = $(document.createElement('a'))
					.attr('class', 'botoncito right')
					.html('Seleccionar')
					.click(function(){
						var id = $(this).parent().parent().attr('id').substring(6,15);
						ids += id+',';
						$(this).before('<span class="right" style="display:block;padding:6px;">Seleccionada</span>').hide();
						//console.log(ids);
					});

		$(this).append(btn);
		
	});
	
	
	var box    = $(document.createElement('div')).attr('class', 'right');
	var accept = $(document.createElement('a'))
					.attr('class', 'boton')
					.html('Aceptar')
					.click(function(){
						html = '<slideshow object_id="'+object_id+'" ids="'+trim(ids)+'">&nbsp;</slideshow>';
						//alert(html);
						parent.tinyMCE.activeEditor.dom.addClass(parent.tinyMCE.activeEditor.selection.getNode(), 'embed');
						parent.tinyMCE.activeEditor.selection.setContent(html, {format : 'raw'});
						parent.layer.Remove();;
						return false;
					});
	var cancel = $(document.createElement('a'))
					.attr('class', 'boton')
					.html('Cancelar')
					.click(function(){
						window.location.reload();
					});
	
	$('.list-header').append(box.append(accept).append(cancel));


}


function trim(str){
	return str.substring(0,str.length-1);
}


