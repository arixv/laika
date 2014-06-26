
jQuery.fn.slideTree = function()
{
	return this.each(function(){
		var container = $(this);

		$('.openclose', container).toggle(
			function(){
				var box = $(this).parent().parent().find('.leaf-childs:first');
				var name = box.attr('class');
				var cat = name.substring(9, 25);
				
				$.cookie(cat, 'close');

				box.hide();
				$(this).removeClass('opened').addClass('closed');
			},
			function(){
				
				var box = $(this).parent().parent().find('.leaf-childs:first');
				var name = box.attr('class');
				var cat = name.substring(9, 25);
				
				$.cookie(cat, 'open');
				
				box.show();
				$(this).removeClass('closed').addClass('opened');
			}
		);
		
		$('.leaf-childs', container).each(function(e){
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


function editItem(id){

	var caja = $('#id_' + id + ' .leaf:first');
	
	if(!($('.subedit', caja).length > 0)){
		caja.append('<div class="subedit"><div class="loading">Loading...</div></div>');
		var edit = $('.subedit', caja);
		edit.slideDown('fast');
		
		var url_string = adminpath+"location/edit/"+id;


		jQuery.ajax({
			type: "POST",
			url: url_string,
			//data: "id="+id,
			success: function(msg){
				edit.html(msg);
				edit.find(".cancel").click(function(){
					edit.slideUp('fast', function(){
						setSlider($('.box-overflow'));
					});
				});
				$('body').animate({opacity:1}, 300, function(){setSlider($('.box-overflow'));});
			}
		});
	}else{
		var edit = $('.subedit', caja);
		edit.slideDown('fast', function(){
			setSlider($('.box-overflow'));	
		});
	}
	
}

function addSubItem(id){
	
	var caja = $('#id_'+id+' .leaf:first');

	if(!($('.subadd', caja).length > 0)){
		caja.append('<div class="subadd"><img src="/framework/modules/admin/desktop/imgs/loader.gif" alt="" /></div>');
		var edit = $('.subadd', caja);
		edit.slideDown('fast');
		
		jQuery.ajax({
			type: "POST",
			url: adminpath+"?m="+module+"&action=BackDisplayAddChild",
			data: "id="+id,
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

function deleteItem(id)
{
	if(confirm('Estas seguro que deseas eliminar el item y sus sub-items?'))
	{
		jQuery.ajax({
			type: "POST",
			url: adminpath+module+"/delete/"+id,
			data: "",
			success: function(msg)
			{
				if(msg == '1')
				{
					$("#id_"+id).fadeOut('slow').remove();
				}
				else
				{
					alert(data);
				}
			}
		});
	}
}

