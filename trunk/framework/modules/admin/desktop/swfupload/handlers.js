function fileQueueError(file, errorCode, message)
{
	switch (errorCode){
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			modion.displayMessage('El archivo '+file.name + ' está corrupto');
			//alert('El archivo '+file.name + ' está corrupto')
			break;
		case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
			modion.displayMessage('No se pudo agregar el archivo '+ file.name + ' . El tamaño máximo permitido por archivo es de '+this.settings.file_size_limit);
			break;
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
		case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
		case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
			modion.displayMessage("Se superó la cantidad de archivos permitida, Se pueden incluir hasta "+this.settings.file_upload_limit+" archivos por vez");
			break
		default:
			modion.displayMessage(message);
			break;
	}

}


function fileDialogComplete(numFilesSelected, numFilesQueued)
{
	try {
		if (numFilesQueued > 0) {
			//this.startUpload();
		}
	} catch (ex) {
		this.debug(ex);
	}

	if (numFilesQueued > 0) {
		if(jQuery('#startupload').length!=1 || jQuery('#startupload').css('display')=='none'){
			if(jQuery('#startupload').length!=1){
				jQuery('.uploadTop').append('<span><button id="startupload" class="boton azul" style="margin-top:5px;">Iniciar Carga</button></span>');
			}else{
				jQuery('#startupload').css('display','block');
			}
			jQuery('#startupload').click(function(e){
				e.preventDefault();
				swfu.startUpload();
			});
		}
	}
}

function uploadStart (file){
	var uploadItem = new FileProgress(file);
	uploadItem.setUploadStart();
}

function uploadProgress(file, bytesLoaded, bytesTotal) {
	try {
		var percent = Math.ceil((bytesLoaded / file.size) * 100);
		var progress = new FileProgress(file);
		progress.setProgress(percent);
		if (percent === 100) {
			progress.setStatus("Waiting response...");
		} else {
			progress.setStatus("Uploading...");
		}
	} catch (ex) {
		this.debug(ex);
	}
}
	
function uploadSuccess(file, serverData) {
	try {
		var progress = new FileProgress(file);

		//alert(serverData)
		var params = modion.parseQueryString(serverData);
		var type     = params['type'];
		var id       = params['id'];
		var status   = params['status'];
		var file     = params['file'];
		var title    = params['title'];
		var mode     = this.customSettings.upload_mode;

		//handler(serverData);

		if(type == 'image'){
			if(status == 'ok'){
				if(mode == 'unique'){
					addImageRadioForm(file, id);
				}else if(mode == 'editeach'){
					addImageEditEachForm(file, id, title);
				}else if(mode == 'bulkedit'){
					addImageEditBulkForm(file, id, title);
				}else if(mode == 'photoset'){
					addImageEditPhotosetForm(file, id, title);
				}
				else{
					addImage(file, id);
				}
				progress.setStatus("Done.");
				progress.setUploaded();
			}else{
				progress.setStatus("Error.");
				alert(serverData);
			}
		}else if(type=='video'){
			if(status == 'ok'){
				//updateForm(id);
				/*
					Funcion definida en el js del modulo de videos
					no está en este handler.
					El modulo toma el control.
				*/
				uploadSuccessVideo(id);
				progress.setStatus("Done.");
				progress.setUploaded();
			}else{
				progress.setStatus("Error.");
				alert(serverData);
			}
		}
		
	} catch (ex) {
		this.debug(ex);
	}
}


function uploadComplete(file) {
	try {
		/*  I want the next upload to continue automatically so I'll call startUpload here */
		if (this.getStats().files_queued > 0) {
			this.startUpload();
		} else {
			var progress = new FileProgress(file);
			progress.setComplete();
			//progress.setStatus("Todas las fotos fueron recibidas con éxito.");
			progress.toggleCancel(false);
		}
	} catch (ex) {
		this.debug(ex);
	}
}

function uploadError(file, errorCode, message) {
	var imageName =  "error.gif";
	var progress;
	try {
		switch (errorCode) {
		case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
			try {
				progress = new FileProgress(file);
				progress.setCancelled();
				progress.setStatus("Cancelado");
				progress.toggleCancel(false);
			}
			catch (ex1) {
				this.debug(ex1);
			}
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
			try {
				progress = new FileProgress(file);
				progress.setCancelled();
				progress.setStatus("Stopped");
				progress.toggleCancel(true);
			}
			catch (ex2) {
				this.debug(ex2);
			}
		case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
			imageName = "uploadlimit.gif";
			break;
		case SWFUpload.errorCode_QUEUE_LIMIT_EXCEEDED:
			alert("You are crazy?");
			break;
		default:
			alert(message);
			break;
		}

		//addImage("images/" + imageName);

	} catch (ex3) {
		this.debug(ex3);
	}

}



function updateForm(id){
	$('#addVideo').prepend('<input type="hidden" name="video_id" value="'+id+'" />');
	$('#step-2').slideDown();
}



function addImageRadioForm(src, id) {
	jQuery('#thumbnails').append('<div class="preview" id="foto'+id+'"/>');
	jQuery('#thumbnails #foto'+id).append('<label for="s'+id+'"><img src="'+ src+'" /><br/></label>');
	jQuery('#thumbnails #foto'+id).append('<input type="radio" value="'+id+'" name="fotoId" id="s'+id+'" /> Seleccionar');
	jQuery('#thumbnails #foto'+id).fadeIn('fast');
	
	if(! jQuery('#guardar').length > 0){
		jQuery('#thumbnails').after('<button id="guardar" class="boton azul" onclick="selectUploaded();return false;">Guardar seleccion</button>');
	}
}

function addImageEditEachForm(src, id, title){
	jQuery('#thumbnails').append('<div class="preview" id="foto'+id+'"/>');
	jQuery('#thumbnails #foto'+id).append('<img src="'+ src+'" /><br/>');
	jQuery('#thumbnails #foto'+id).append('<input type="hidden" value="'+id+'" name="photos[]" />');
	jQuery('#thumbnails #foto'+id).append('<span>Titulo</span> <input type="text" value="'+title+'" name="title_'+id+'" id="s'+id+'" />');
	//jQuery('#thumbnails #foto'+id).append('<span>Tags</span> <input type="text" value="" name="tags_'+id+'" id="s'+id+'" />');
	jQuery('#thumbnails #foto'+id).fadeIn('fast');

	if(! jQuery('#guardar').length > 0){
		jQuery('#thumbnails').after('<button id="guardar" class="boton azul" type="submit">Guardar Cambios</button>');
		jQuery('#thumbnails').after('<p>Las fotos fueron subidas con exito.');
	}
}

function addImageEditBulkForm(src, id, title){
	jQuery('#thumbnails').append('<div class="preview" id="foto'+id+'"/>');


	if(! jQuery('#editfields').length > 0){
		jQuery('#thumbnails').after('<div id="editfields"></div>');
		jQuery('#editfields').append('<h2>Editar en lote</h2>');
		jQuery('#editfields').append('<span>Titulo</span> <input type="text" value="'+title+'" name="title" id="s'+id+'" />');
		//jQuery('#editfields').append('<span>Tags</span> <input type="text" value="" name="tags" id="s'+id+'" />');
	}
	if(! jQuery('#guardar').length > 0){
		jQuery('#editfields').after('<button id="guardar" class="boton azul" type="submit">Guardar Cambios</button>');
		jQuery('#thumbnails').before('<p>Las fotos fueron subidas con exito.');
	}
	
	jQuery('#thumbnails #foto'+id).append('<img src="'+ src+'" /><br/>');
	jQuery('#thumbnails #foto'+id).append('<input type="hidden" value="'+id+'" name="photos[]" />');
	jQuery('#thumbnails #foto'+id).fadeIn('fast');
}

function addImageEditPhotosetForm(src, id, title){
	jQuery('#thumbnails').append('<div class="preview" id="foto'+id+'"/>');

	jQuery('#thumbnails #foto'+id).append('<div><label for="radio_'+id+'"><img src="'+ src+'" /></label></div>');
	jQuery('#thumbnails #foto'+id).append('<input type="hidden" value="'+id+'" name="photos[]" />');
	jQuery('#thumbnails #foto'+id).append('<span>Titulo</span> <input type="text" value="'+title+'" name="title_'+id+'" id="s'+id+'" /><br/>');
	//jQuery('#thumbnails #foto'+id).append('<span>Tags</span> <input type="text" value="" name="tags_'+id+'" id="s'+id+'" /><br/>');
	jQuery('#thumbnails #foto'+id).append('<input type="radio" value="'+id+'" name="photo_id" id="radio_'+id+'"/> <label for="radio_'+id+'">Foto principal</label>');
	jQuery('#thumbnails #foto'+id).fadeIn('fast');

	if(! jQuery('#guardar').length > 0){
		jQuery('#thumbnails').after('<button id="guardar" class="boton azul" type="submit">Guardar Cambios</button>');
		jQuery('#thumbnails').after('<p>Las fotos fueron subidas con exito.');
	}
}



function addImage(src, id) {
	jQuery('#thumbnails').append('<div class="preview" id="foto'+id+'"/>');
	jQuery('#thumbnails').find("#foto"+id).append('<img src="'+ src+'" /><br/>');
	jQuery('#thumbnails').find('img').fadeIn('fast');
}


function fadeIn(element, opacity) {
	var reduceOpacityBy = 5;
	var rate = 30;	// 15 fps


	if (opacity < 100) {
		opacity += reduceOpacityBy;
		if (opacity > 100) {
			opacity = 100;
		}

		if (element.filters) {
			try {
				element.filters.item("DXImageTransform.Microsoft.Alpha").opacity = opacity;
			} catch (e) {
				// If it is not set initially, the browser will throw an error.  This will set it if it is not set yet.
				element.style.filter = 'progid:DXImageTransform.Microsoft.Alpha(opacity=' + opacity + ')';
			}
		} else {
			element.style.opacity = opacity / 100;
		}
	}

	if (opacity < 100) {
		setTimeout(function () {
			fadeIn(element, opacity);
		}, rate);
	}
}






/* ******************************************
 *	FileProgress Object
 *	Control object for displaying file info
 * ****************************************** */


function FileProgress(file) {
	this.fileProgressElement = jQuery('#'+file.id);

}
FileProgress.prototype.setUploadStart = function () {
	this.fileProgressElement.find('.delete a').fadeOut('1', function(){
		//jQuery(this).parent().append('<div class="uploading">&nbsp;</div>');
		//jQuery(this).parent().find('div').fadeIn('fast', function(){
			//jQuery(this).parent().parent().slideUp();
		//});
	});
	this.fileProgressElement.find('.delete').append('<div class="uploading">&nbsp;</div>');
	this.fileProgressElement.find('.delete .uploading').fadeIn('fast');
}
FileProgress.prototype.setProgress = function (percentage) {
	this.fileProgressElement.find('.progressbar').css('width', percentage + "%");
};
FileProgress.prototype.setComplete = function () {
	jQuery('#startupload').fadeOut('slow');
	jQuery('.title').slideUp('slow');
	jQuery('#uploadComplete').html('Todas los archivos se subieron correctamente.');
};
FileProgress.prototype.setUploaded = function () {
	this.fileProgressElement.find('.progressbar').css('width', "100%");

	this.fileProgressElement.find('.delete .uploading').fadeOut('fast', function(){
		jQuery(this).parent().parent().find('.delete').append('<div class="done">&nbsp</div>');
		jQuery(this).parent().parent().find('.delete .done').fadeIn('fast', function(){
			//jQuery(this).parent().parent().slideUp();
			jQuery(this).parent().parent().find('.percent').fadeOut('slow');
		});
		//jQuery(this).parent().parent().find('.percent').fadeOut('slow');
	});
}
FileProgress.prototype.setError = function (message) {
	this.fileProgressElement.find('div').hide();
	this.fileProgressElement.html(message);
};
FileProgress.prototype.setCancelled = function () {
	this.fileProgressElement.className = "progressContainer";
	this.fileProgressElement.childNodes[3].className = "progressBarError";
	this.fileProgressElement.childNodes[3].style.width = "";
};
FileProgress.prototype.setStatus = function (status) {
	this.fileProgressElement.find('.percent b').html(status);
};
FileProgress.prototype.toggleCancel = function (status) {

};

function toggleCancel (id) {
	var items = jQuery("#uploadlist li").size()-1;
	swfu.cancelUpload(id);
	jQuery('#'+id).slideUp('fast', function(){
		jQuery(this).remove();
		if(items == 0){
			jQuery("#startupload").fadeOut('fast');
		}
	});
	return false;
}



/* Rulo jquery */

function createitem(file) {

	/*
	// Debug object properties (not knowing them)
	for (var prop in file) {
	alert ("Property: " + prop  + " valor: " + file[prop]);
	}
	*/

	var size = Math.round(file.size / 1000);
	var sizeStr;
	if (size > 1000){
		var sub = String(size / 1000);
		sizeStr = sub.substring(0,4) + " mb";
	}else{
		sizeStr = size + " kb";
	}
	var item = '<li id="'+file.id+'"><div class="file">'+file.name+'</div><div class="size">'+sizeStr+'</div><div class="delete"><a href="#" title="No subir">&nbsp;</a></div><div class="percent"><div class="progressbar">&nbsp;</div><b>En Espera</b></div></li>';
	var container = jQuery("#"+this.customSettings.upload_target);
	container.append(item);

	jQuery('#'+file.id+' .delete a').click(function(e){
		e.preventDefault();
		toggleCancel(file.id)
	});

}


