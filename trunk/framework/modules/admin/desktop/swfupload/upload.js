$(document).ready(function(){
	
	/* Switch upload */
	$('#multiple-upload .switch-upload').click(function(e){
		e.preventDefault();
		$('#multiple-upload').slideUp();
		$('#basic-upload').slideDown();
	});
	$('#basic-upload .switch-upload').click(function(e){
		e.preventDefault();
		$('#basic-upload').slideUp();
		$('#multiple-upload').slideDown();
	});
	jQuery('#simple-upload button').click(function(){
		jQuery(this).hide();
		jQuery(this).after('<span class="boton">Subiendo..</span>');
	});
	
});