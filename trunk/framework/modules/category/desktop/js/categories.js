
jQuery.fn.slideCategories = function(){
	return this.each(function(){
		var container = $(this);
		$('.openclose', container).toggle(
			function(){
				var box = $(this).parent().parent().find('.category-childs:first');
				var name = box.attr('class');
				var cat = name.substring(9, 25);
				
				$.cookie(cat, 'close');
				
				box.hide();
				$(this).removeClass('opened').addClass('closed');
				modion.setScroll();
			},
			function(){
				
				var box = $(this).parent().parent().find('.category-childs:first');
				var name = box.attr('class');
				var cat = name.substring(9, 25);
				
				$.cookie(cat, 'open');
				
				box.show();
				$(this).removeClass('closed').addClass('opened');
				modion.setScroll();
			}
		);
		
		$('.category-childs', container).each(function(e){
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


function editCategory(id){

	var caja = $('#category_'+id+' .leaf:first');
	
	if(!($('.subedit', caja).length > 0)){
		caja.append('<div class="subedit"><div class="loading">Loading...</div></div>');
		var edit = $('.subedit', caja);
		edit.slideDown('fast');
		
		jQuery.ajax({
			type: "POST",
			url: adminpath+"?m=category&action=BackDisplayEdit",
			data: "categoria_id="+id,
			success: function(msg){
				edit.html(msg);
				edit.find(".cancel").click(function(){
					edit.slideUp('fast', function(){
						//setSlider($('.box-overflow'));
					});
				});
				$('body').animate({opacity:1}, 300, function(){
					//setSlider($('.box-overflow'));
				});
			}
		});
	}else{
		var edit = $('.subedit', caja);
		edit.slideDown('fast', function(){
			//setSlider($('.box-overflow'));	
		});
	}
	
}

function updateCategory(id){
	var caja = $('#category_'+id+' .leaf:first');
	var edit = $('.subedit', caja);
	edit.slideUp('fast');
}

function AddSubCategory(id){
	
	var caja = $('#category_'+id+' .leaf:first');

	if(!($('.subadd', caja).length > 0)){
		caja.append('<div class="subadd"><img src="/framework/modules/admin/desktop/imgs/loader.gif" alt="" /></div>');
		var edit = $('.subadd', caja);
		edit.slideDown('fast');
		
		jQuery.ajax({
			type: "POST",
			url: adminpath+"?m=category&action=BackDisplayAddChild",
			data: "category_id="+id,
			success: function(msg){
				edit.html(msg);
				edit.find(".cancel").click(function(){
					edit.slideUp('fast', function(){
						//setSlider($('.box-overflow'));
					});
				});
				$('body').animate({opacity:1}, 500, function(){setSlider($('.box-overflow'));});
			}
		});
	}else{
		var edit = $('.subadd', caja);
		edit.slideDown('fast');
	}
	
}



