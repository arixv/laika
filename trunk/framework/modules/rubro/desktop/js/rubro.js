	$(document).ready(function(){
				
		$(".btn-edit-rubro").click(function(e){
			e.preventDefault();
			var id = $(this).attr("data-id");

			$('#modal').load(
		    	"/admin/rubro/edit/"+id,
		    	function(){
				    $(this).modal({
				        keyboard:true,
				        backdrop:true
				    });
			}).modal('show'); 

		    return false;
		});

		$('.btn-add-rubro').click(function(e){
			e.preventDefault();
			$('#modal').load(
		    	"/admin/rubro/add/",
		    	function(){
				    $(this).modal({
				        keyboard:true,
				        backdrop:true
				    });
			}).modal('show'); 

		    return false;

		});


		$(".btn-delete-rubro").click(function(e)
		{
			e.preventDefault();
			var id = $(this).attr("data-id");
			if(confirm('Estas seguro que deseas eliminar la categoría y sus categorías?')){
				modion.ajaxCall(
				{
					m:'rubro',
					action:'BackRemove',
					id: id,
				}
				,
				{
					callback: function(response){
						if(response == 1) {
							$("#rubro_"+id).remove();
						}
					}
				});
			}

		});

	});
