$(document).ready(function() {
	showDebug();
	var isCtrl = false;
	$(document).keyup(function (e){
		if(e.which == 18) isCtrl=false;
	}).keydown(function (e) {
	    if(e.which == 18) isCtrl=true;
	    if(e.which == 68 && isCtrl == true) {
			//alert('guardando... Con jQuery');
			openDebug();
	 	return false;
	 }
	});
});

function showDebug(){
	$(".techoDebug a").toggle(
		function(){openDebug()}, function(){closeDebug()}
	);

	jQuery(document).scroll(function(){
		var offset = jQuery(window).scrollTop();
		jQuery(".xmlContentBack").css("top", offset + 35);
		jQuery(".xmlContent").css("top", offset + 35);
		jQuery(".debug").css("top", offset);
	})
	
	
	/*
	document.onkeydown = function(e){ 	
		if (e == null) { // ie
			keycode = event.keyCode;
		} else { // mozilla
			keycode = e.which;
		}
		//alert(keycode);
		if(keycode == 27){ // close
			closeDebug();
		} 
	};
	*/
	
	jQuery('.codigo a').click(function(){
		jQuery(this).next().next().toggle(checkTree(jQuery(this)));
		return false;
	});

}

function checkTree(elem){
	elem.children('img').toggle();
}


function openDebug(){
	
	$('body').css({overflow:'hidden'});
	
	var offset = jQuery(window).scrollTop();
	var h = jQuery(window).height();
	var w = jQuery(window).width();
	
	jQuery(".debug").css("height", h);
	jQuery(".debug").css("top", offset);
	
	jQuery(".debug").show();
	jQuery(".xmlContentBack").css("height", h - 45);
	jQuery(".xmlContentBack").css("width", w - 20);
	
	jQuery(".techoDebug").css({top:0,bottom:'auto'});
	jQuery(".xmlContentBack").css("top", offset + 35);
	jQuery(".xmlContentBack").show()
	jQuery(".xmlContent").css("height", h - 45);
	jQuery(".xmlContent").css("width", w - 20);
	jQuery(".xmlContent").css("top", offset + 35);
	jQuery(".xmlContent").fadeIn('fast');

	document.onkeydown = function(e){ 	
		if (e == null) { // ie
			keycode = event.keyCode;
		} else { // mozilla
			keycode = e.which;
		}
		//alert(keycode);
		if(keycode == 27){ // close
			closeDebug();
		} 
	};
	/*
	var offset = jQuery(window).scrollTop();
	var h = jQuery(window).height();
	var w = jQuery(window).width();
	jQuery(".techoDebug").css('bottom','auto');
	jQuery(".techoDebug").animate({top:0}, 400);
	jQuery(".debug").css("height", h);
	jQuery(".debug").css("top", offset);
	jQuery(".debug").fadeIn('slow', function(){
		jQuery(".xmlContentBack").css("height", h - 45);
		jQuery(".xmlContentBack").css("width", w - 20);
		
		jQuery(".xmlContentBack").css("top", offset + 35);
		jQuery(".xmlContentBack").fadeIn('fast', function(){
			jQuery(".xmlContent").css("height", h - 45);
			jQuery(".xmlContent").css("width", w - 20);
			jQuery(".xmlContent").css("top", offset + 35);
			jQuery(".xmlContent").fadeIn('fast');
		});
	});
	document.onkeydown = function(e){ 	
		if (e == null) { // ie
			keycode = event.keyCode;
		} else { // mozilla
			keycode = e.which;
		}
		//alert(keycode);
		if(keycode == 27){ // close
			closeDebug();
		} 
	};
	*/
}

function closeDebug(){
	
	$('body').css({overflow:'auto'});
	jQuery(".techoDebug").css({top:'auto',bottom:0});
	jQuery(".xmlContent, .debug, .xmlContentBack").hide();
	
	/*
	jQuery(".xmlContent").fadeOut('fast', function(){
		jQuery(".xmlContentBack").fadeOut('fast', function(){
			jQuery(".debug").fadeOut("fast");
			jQuery(".techoDebug").animate({bottom:0}, 400);
			jQuery(".techoDebug").css('top','auto');
			
		});
	});
	*/
}










