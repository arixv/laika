var container, default_categories = [];

$(document).ready(function(){
	container = $('#thumbnails');
});

function UploadHandler(file, response){
	
	// Manejo visual del upload mientras se sube.
	var progress = new FileProgress(file);

	//console.log(response);
	//return;*/
	// Manejo de datos del archivo subido
	var obj = jQuery.parseJSON(response);

	//console.log(response);

	// Si el archivo se subio con exito
	if(obj.status == 'ok')
	{
		progress.setStatus("Done.");
		progress.setUploaded();
		EditFile(obj);
		//editPhotoData(id, file, title, categories);
	}
	else
	{
		// se produjo un error
		progress.setError(obj.message);
	}

	

	/*
	var params     = parseQuery(response);
	var type       = params['type'];
	var id         = params['id'];
	var status     = params['status'];
	var file       = params['file'];
	var title      = params['title'];
	var categories = (params['categories']=='false')?false:params['categories'];

	if(status == 'ok'){
		progress.setStatus("Done.");
		progress.setUploaded();
		editPhotoData(id, file, title, categories);
	}else{
		progress.setError(response);
		//alert("Error: "+response);
	}
	*/
}

function EditFile(obj)
{
	
	var photo        = $(document.createElement('div')).attr('class', 'photo-data floatFix').attr('id', 'item'+obj.data.multimedia_id);
	var img          = $(document.createElement('img')).attr('src', obj.generated);
	var inputId      = $(document.createElement('input')).attr(
						{
							"type": "hidden",
							"name": "ids[]",
							"class": "text",
							"value": obj.data.multimedia_id
						});
	var inputTitle   = $(document.createElement('input')).attr(
						{
							"type": "text",
							"name": "title_"+obj.data.multimedia_id,
							"class": "text",
							"value": obj.data.multimedia_title
						});
	var inputSummary = $(document.createElement('textarea')).attr(
						{
							"tyoe": "text",
							"name": "summary_"+obj.data.multimedia_id
						});
	var text1        = $(document.createElement('span')).html('Titulo');
	var text2        = $(document.createElement('span')).html('Epigrafe');

	var categories = $(document.createElement('div')).attr("class", "categories");

	if(obj.categories[0] != null){	
		for(x in obj.categories){
			var category        = obj.categories[x];
			var categoriesTitle = $(document.createElement('h4')).html(category.title);
			var list            = $(document.createElement('ul'));
			for(i in category.subcategories){
				var subcategory = category.subcategories[i];
				var item  = $(document.createElement('li'));
				var input = $(document.createElement('input'))
								.attr("type", "checkbox")
								.attr("name", "categories_"+obj.data.multimedia_id+"[]")
								.attr("value", subcategory.category_id)
								.attr("class", "check")
								.attr("id", "item_"+obj.data.multimedia_id+"_"+subcategory.category_id);
				var label = $(document.createElement('label'))
								.attr("for", "item_"+obj.data.multimedia_id+"_"+subcategory.category_id)
								.html(subcategory.name);
				//console.log(subcategory.category_id+' - '+default_categories);
				if(subcategory.selected == "1" || $.inArray(subcategory.category_id, default_categories) != '-1'){
					$(input).attr("checked", "checked");
				}
				if($.inArray(subcategory.category_id, default_categories) != '-1')
				{
					$(input).attr("disabled", "disabled");	
				}
				$(item).append(input, label);
				$(list).append(item);
			}
			$(categories).append(categoriesTitle, list);
		}
		/*
		alert('agrego categorias');*/
	}

	photo.append(img, inputId, text1, inputTitle, text2, inputSummary, categories);
	container.append(photo);

	if(!$('#saveForm').length > 0){
		$('#thumbnails').after('<div class="guardar"><button id="saveForm" class="boton">Guardar Fotos</button></div>');
	}
}

/*
function editPhotoData(photo_id, photo_file, title, categories)
{
	
	var container = $('#thumbnails');
	var html = '<div class="photo-data floatFix" id="item'+photo_id+'">';
	html += '<img src="'+photo_file+'" />';
	html += '<input type="hidden" name="ids[]" class="text" value="'+photo_id+'" />';
	html += '<span>Título</span>';
	html += '<input type="text" name="titulo_'+photo_id+'" class="text" value="'+title+'" />';
	html += '<span>Epigrafe</span>';
	html += '<textarea name="epigrafe_'+photo_id+'"></textarea>';
	
	// Categorias
	if(categories){
		//html += '<span>Categorias</span>';
		var myObject = eval('(' + categories + ')');
		for (x in myObject){
			var obj = myObject[x];
			for (y in obj){
				html += '<h4>'+obj[y].name+'</h4>';
				html += '<ul>';
				jQuery.each(obj[y].subcategories, function(pos, el){
					if(el.selected == 1){
						html += '<li><input type="checkbox" id="item-'+photo_id+'-'+el.id+'" name="categories_'+photo_id+'[]" value="'+el.id+'" checked="checked"/><label for="item-'+photo_id+'-'+el.id+'">'+el.name+'</label></li>';
					}else{
						html += '<li><input type="checkbox" id="item-'+photo_id+'-'+el.id+'" name="categories_'+photo_id+'[]" value="'+el.id+'" /><label for="item-'+photo_id+'-'+el.id+'">'+el.name+'</label></li>';
					}
					html += '<input type="hidden" name="parent_'+el.id+'_'+photo_id+'" value="'+obj[y].id+'" />';
				});
				html += '</ul>';
			}
		}
	}

	html += '</div>';
	
	container.prepend(html);
	
	var width = container.width();
	$('input.text, textarea', container).css('width', (width-290)+'px');

	if(!$('#saveForm').length > 0){
		container.append('<div class="guardar"><button id="saveForm" class="boton">Guardar Fotos</button></div>');
	}


}
*/

