$(document).ready(function(){
	
	$('body').animate({opacity:1}, 500, function(){
		
		// Alto de la ventana
		var wh = $(window).height() - 80;
		//alert(wh);
		$('#modalContent').attr('style', 'height:'+wh+'px');
	
	});
	
	
});