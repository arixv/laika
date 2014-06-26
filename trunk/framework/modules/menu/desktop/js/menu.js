
jQuery.fn.slideMenus = function(){
	return this.each(function(){
		var container = $(this);
		$('.openclose', container).toggle(
			function(){
				var box = $(this).parent().parent().find('.menu-childs:first');
				var name = box.attr('class');
				var cat = name.substring(9, 25);
				
				$.cookie(cat, 'close');
				
				box.hide();
				$(this).removeClass('opened').addClass('closed');
			},
			function(){
				
				var box = $(this).parent().parent().find('.menu-childs:first');
				var name = box.attr('class');
				var cat = name.substring(9, 25);
				
				$.cookie(cat, 'open');
				
				box.show();
				$(this).removeClass('closed').addClass('opened');
			}
		);
		
		$('.menu-childs', container).each(function(e){
			var box = $(this);
			var name = box.attr('class');
			var cat = name.substring(9, 25);
			
			var status = $.cookie(cat);
			if(status=='open'){
				box.show();
			}
			if(status=='close'){
				box.hide();
			}
		});
		
	});
}


function editMenu(id){

	var caja = $('#menu_'+id+' .thisMenu:first');
	
	if(!($('.subedit', caja).length > 0)){
		caja.append('<div class="subedit"><img src="/framework/modules/admin/desktop/imgs/loader.gif" alt="" /></div>');
		var edit = $('.subedit', caja);
		edit.slideDown('fast');
		
		jQuery.ajax({
			type: "POST",
			url: adminpath+"?m=menu&action=BackDisplayEdit",
			data: "menu_id="+id,
			success: function(msg){
				edit.html(msg);
				edit.find(".cancel").click(function(){
					edit.slideUp('fast', function(){
						setSlider($('.box-overflow'));
					});

				});
				$('body').animate({opacity:1}, 500, function(){setSlider($('.box-overflow'));});
			}
		});
	}else{
		var edit = $('.subedit', caja);
		edit.slideDown('fast', function(){
			setSlider($('.box-overflow'));	
		});
		
	}
}

function addSubMenu(id){
	
	var caja = $('#menu_'+id+' .thisMenu:first');

	if(!($('.subadd', caja).length > 0)){
		caja.append('<div class="subadd"><img src="/framework/modules/admin/desktop/imgs/loader.gif" alt="" /></div>');
		var edit = $('.subadd', caja);
		edit.slideDown('fast');
		
		jQuery.ajax({
			type: "POST",
			url: adminpath+"?m=menu&action=BackDisplayAddChild",
			data: "menu_id="+id,
			success: function(msg){
				edit.html(msg);
				edit.find(".cancel").click(function(){
					edit.slideUp('fast', function(){
						setSlider($('.box-overflow'));
					});
				});
				$('body').animate({opacity:1}, 500, function(){setSlider($('.box-overflow'));});
			}
		});
	}else{
		var edit = $('.subadd', caja);
		edit.slideDown('fast', function(){
			setSlider($('.box-overflow'));	
		});
	}
}



