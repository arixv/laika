$(document).ready(function(){
	
	layer.Ready();
	$('.upload').click(function(){
		actions.showUpload();
	});
	$('.back').click(function(){
		actions.showlist();
	});
});


var actions = {

	showUpload : function()
	{
		$('.list-tools, #grid').fadeOut('fast',function(){
			$('.uplaod-tools, #upload-container').fadeIn('fast');
			//setSlider($('#upload-container'));
		});
		$('.list-header').addClass('rounded');

	},

	showlist : function()
	{
		$('.uplaod-tools, #upload').fadeOut('fast',function(){
			$('.list-tools, #grid').fadeIn('fast');

		});
		$('.list-header').removeClass('rounded');
	}

} 




