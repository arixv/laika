var container, modpath, default_categories = [];

$(document).ready(function(){
	container = $('#thumbnails');
});

function UploadHandler(file, response){
	
	// Manejo visual del upload mientras se sube.
	var progress = new FileProgress(file);

	console.log(response);
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

}

function EditFile(obj)
{
	
	var video        = $(document.createElement('div')).attr('class', 'document-data rounded floatFix').attr('id', 'item'+obj.data.multimedia_id);
	var img          = $(document.createElement('img')).attr('src', modpath+'/desktop/imgs/'+obj.data.multimedia_source+'.png');
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
	/*
	var inputSummary = $(document.createElement('textarea')).attr(
						{
							"tyoe": "text",
							"name": "summary_"+obj.data.multimedia_id
						});
	*/
	var text1        = $(document.createElement('h2')).html('Titulo');
	//var text2        = $(document.createElement('span')).html('Epigrafe');

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
				console.log(subcategory.category_id+' - '+default_categories);
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
	}

	video.append(img, inputId, text1, inputTitle, categories);
	container.append(video);

	if(!$('#saveForm').length > 0){
		$('#thumbnails').after('<div class="guardar"><button id="saveForm" class="boton">Guardar Documentos</button></div>');
	}
}


