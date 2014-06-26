function fileQueueError(file, errorCode, message) {
	try {
		var imageName = "error.gif";
		var errorName = "";
		if (errorCode === SWFUpload.errorCode_QUEUE_LIMIT_EXCEEDED) {
			errorName = "You have attempted to queue too many files.";
		}

		if (errorName !== "") {
			alert(errorName);
			return;
		}

		switch (errorCode) {
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			imageName = "zerobyte.gif";
			break;
		case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
			imageName = "toobig.gif";
			break;
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
		case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
		case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
			alert("You have exceeded the queue limit, upload just "+this.settings.file_upload_limit+" files per time");
			break
		default:
			alert(message);
			break;
		}

		addImage("images/" + imageName);

	} catch (ex) {
		this.debug(ex);
	}

}


function fileDialogComplete(numFilesSelected, numFilesQueued) {

	//alert(this.customSettings.album_id);
	
	if(this.customSettings.album_id==undefined){
		alert("No elegiste ningun album para tus fotos!");
		return false;
	}

	try {
		if (numFilesQueued > 0) {
			//this.startUpload();
		}
	} catch (ex) {
		this.debug(ex);
	}


	if(jQuery('#startupload').length!=1){
		jQuery('#uploadlist').after('<button id="startupload">Start Upload</button>');
		
		jQuery('#startupload').click(function(){
			swfu.startUpload();
		});
	}
	
	
}

function uploadProgress(file, bytesLoaded, bytesTotal) {

	try {
		//alert(file.id);
		var percent = Math.ceil((bytesLoaded / file.size) * 100);

		var progress = new FileProgress(file,  this.customSettings.upload_target);
		progress.setProgress(percent);
		if (percent === 100) {
			progress.setStatus("Generando todos los tamaños para la foto...");
			progress.toggleCancel(false, this);
		} else {
			progress.setStatus("Uploading...");
			progress.toggleCancel(true, this);
		}
	} catch (ex) {
		this.debug(ex);
	}
}

function uploadSuccess(file, serverData) {
	try {
		var progress = new FileProgress(file,  this.customSettings.upload_target);

		if (serverData.substring(0, 7) === "FILEID:") {
			var photo_id = serverData.substring(7, 25);
			alert(photo_id);
			//addImage("/content/cache/" + this.customSettings.user_id + "/" + serverData.substring(7) + "_thumb_80x60.jpg", file.id);
			//editImage(photo_id, file.id);

			progress.setStatus("Done.");
			progress.toggleCancel(false);
		} else {
			addImage("/app_ui/common/imgs/errorThumb.jpg");
			progress.setStatus("Error.");
			progress.toggleCancel(false);
			alert(serverData);
		}


	} catch (ex) {
		this.debug(ex);
	}
}


/* Rulo functions */
function editImage(photo_id, elem_id) {
	
	jQuery('#'+elem_id).parent().parent().slideDown('fast');
	jQuery('#'+id).parent().parent().find('.preview img').attr('src', src);
	jQuery('#'+id).parent().parent().find('.preview img').fadeIn('fast');
	
	
}




function uploadComplete(file) {
	try {
		/*  I want the next upload to continue automatically so I'll call startUpload here */
		if (this.getStats().files_queued > 0) {
			this.startUpload();
		} else {
			var progress = new FileProgress(file,  this.customSettings.upload_target);
			progress.setComplete();
			progress.setStatus("Todas las fotos fueron recibidas con éxito.");
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
				progress = new FileProgress(file,  this.customSettings.upload_target);
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
				progress = new FileProgress(file,  this.customSettings.upload_target);
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

		addImage("images/" + imageName);

	} catch (ex3) {
		this.debug(ex3);
	}

}









function addImage(src, id) {
	
	jQuery('#'+id).parent().parent().find('.preview').append('<img src=""/>');
	jQuery('#'+id).parent().parent().find('.preview img').attr('src', src);
	jQuery('#'+id).parent().parent().find('.preview img').fadeIn('fast');
	
	
}

/*
function addImage(src) {
	var newImg = document.createElement("img");
	newImg.style.margin = "0 10px 10px 0";

	document.getElementById("thumbnails").appendChild(newImg);
	if (newImg.filters) {
		try {
			newImg.filters.item("DXImageTransform.Microsoft.Alpha").opacity = 0;
		} catch (e) {
			// If it is not set initially, the browser will throw an error.  This will set it if it is not set yet.
			newImg.style.filter = 'progid:DXImageTransform.Microsoft.Alpha(opacity=' + 0 + ')';
		}
	} else {
		newImg.style.opacity = 0;
	}

	newImg.onload = function () {
		fadeIn(newImg, 0);
	};
	newImg.src = src;
}
*/



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






/*
function createitem(file) {


	var list = document.getElementById('uploadlist');
	var item = document.createElement("li");

	var itemName = document.createElement("div");
	itemName.className = "file";
	itemName.innerHTML = file.name;
	
	var size = Math.round(file.size / 1000);
	var sizeStr;
	if (size > 1000){
		var sub = String(size / 1000);
		sizeStr = sub.substring(0,4) + " mb";
	}else{
		sizeStr = size + " kb";
	}
	var filesize = document.createElement("div");
	filesize.className = "size";
	filesize.innerHTML = sizeStr;
	
	var itemBar = document.createElement("div");
	itemBar.className = "percent";
	var bar = document.createElement("div");
	bar.className = "progressbar";
	bar.id = file.id;
	bar.innerHTML = "&nbsp;";
	itemBar.appendChild(bar);

	var preview = document.createElement("div");
	preview.className = "preview";
	
	var itemDelete = document.createElement("div");
	itemDelete.className = "delete";
	var Cancel = document.createElement("a");
	Cancel.href = "#";
	Cancel.innerHTML = "Delete";
	itemDelete.appendChild(Cancel);

	item.appendChild(itemName);
	item.appendChild(filesize);
	//item.appendChild(preview);
	item.appendChild(itemDelete);
	item.appendChild(itemBar);
	
	list.appendChild(item);
	fadeIn(list, 0);
}
*/



/* ******************************************
 *	FileProgress Object
 *	Control object for displaying file info
 * ****************************************** */


function FileProgress(file, targetID) {
	

	this.fileProgressElement = jQuery('#'+file.id);
	
	//this.fileProgressElement = document.getElementById(file.id);
	

	/*this.fileProgressID = "divFileProgress";

		this.fileProgressWrapper = document.getElementById(this.fileProgressID);
		if (!this.fileProgressWrapper) {
			this.fileProgressWrapper = document.createElement("div");
			this.fileProgressWrapper.className = "progressWrapper";
			this.fileProgressWrapper.id = this.fileProgressID;

			this.fileProgressElement = document.createElement("div");
			this.fileProgressElement.className = "progressContainer";

			var progressCancel = document.createElement("a");
			progressCancel.className = "progressCancel";
			progressCancel.href = "#";
			progressCancel.style.visibility = "hidden";
			progressCancel.appendChild(document.createTextNode(" "));

			var progressText = document.createElement("div");
			progressText.className = "progressName";
			progressText.appendChild(document.createTextNode(file.name));

			var progressBar = document.createElement("div");
			progressBar.className = "progressBarInProgress";

			var progressStatus = document.createElement("div");
			progressStatus.className = "progressBarStatus";
			progressStatus.innerHTML = "&nbsp;";

			this.fileProgressElement.appendChild(progressCancel);
			this.fileProgressElement.appendChild(progressText);
			this.fileProgressElement.appendChild(progressStatus);
			this.fileProgressElement.appendChild(progressBar);

			this.fileProgressWrapper.appendChild(this.fileProgressElement);

			document.getElementById(targetID).appendChild(this.fileProgressWrapper);
			fadeIn(this.fileProgressWrapper, 0);

		} else {
			this.fileProgressElement = this.fileProgressWrapper.firstChild;
			this.fileProgressElement.childNodes[1].firstChild.nodeValue = file.name;
		}

		this.height = this.fileProgressWrapper.offsetHeight;*/

}
FileProgress.prototype.setProgress = function (percentage) {
	//this.fileProgressElement.className = "progressContainer green";
	//this.fileProgressElement.childNodes[3].className = "progressBarInProgress";
	//this.fileProgressElement.style.width = percentage + "%";
	this.fileProgressElement.find('.progressbar').css('width', percentage + "%");
	
	//alert(percentage);
	//alert(percentage);
};
FileProgress.prototype.setComplete = function () {
	//this.fileProgressElement.className = "progressContainer blue";
	//this.fileProgressElement.childNodes[3].className = "progressBarComplete";
	//this.fileProgressElement.childNodes[3].style.width = "";
	this.fileProgressElement.find('.progressbar').css('width', "100%");
	this.fileProgressElement.find('.delete a').fadeOut('fast', function(){
		jQuery(this).parent().parent().find('.delete').append('<div>&nbsp</div>');
		jQuery(this).parent().parent().find('.delete div').fadeIn('fast');
	});


};
FileProgress.prototype.setError = function () {
	this.fileProgressElement.className = "progressContainer red";
	this.fileProgressElement.childNodes[3].className = "progressBarError";
	this.fileProgressElement.childNodes[3].style.width = "";

};
FileProgress.prototype.setCancelled = function () {
	this.fileProgressElement.className = "progressContainer";
	this.fileProgressElement.childNodes[3].className = "progressBarError";
	this.fileProgressElement.childNodes[3].style.width = "";

};
FileProgress.prototype.setStatus = function (status) {
	//this.fileProgressElement.childNodes[2].innerHTML = status;
	//this.fileProgressElement.style.width = "100%";
	this.fileProgressElement.find('.percent b').html(status);
	//this.fileProgressElement.style.background = "#ccc";
	//alert(this.fileProgressElement.id);
};

FileProgress.prototype.toggleCancel = function (show, swfuploadInstance) {
	//this.fileProgressElement.childNodes[0].style.visibility = show ? "visible" : "hidden";
	if (swfuploadInstance) {
		var fileID = this.fileProgressID;
		this.fileProgressElement.childNodes[0].onclick = function () {
			swfuploadInstance.cancelUpload(fileID);
			return false;
		};
	}
};



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
	var item = '<li id="'+file.id+'"><div class="file">'+file.name+'</div><div class="size">'+sizeStr+'</div><div class="delete"><a href="#" title="Delete from queue">&nbsp;</a></div><div class="percent"><div class="progressbar">&nbsp;</div><b>Queued</b></div></li>';
	var container = jQuery("#uploadlist");
	container.append(item);

}

