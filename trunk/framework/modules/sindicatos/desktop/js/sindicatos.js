
function DeleteSindicato(id){
	$.ajax({
		url:"/admin/sindicatos/delete/"+id,
		success:function(data){
			if(data == 1){
				$("#item_"+id).remove();	
			}
			
		}
	});
    return false;
}

function LoadModalAddSindicato(){
    $('#modal').load(
    	"/admin/sindicatos/add",
    	function(){
		    $(this).modal({
		        keyboard:true,
		        backdrop:true
		    });
	}).modal('show'); 

    return false;
}

function LoadModalEditSindicato(id){
	$('#modal').load(
    	"/admin/sindicatos/edit/"+id,
    	function(){
		    $(this).modal({
		        keyboard:true,
		        backdrop:true
		    });
	}).modal('show'); 

    return false;
}



$(document).ready(function(){
	$('.btn-add').click(function(e){
		e.preventDefault();
		LoadModalAddSindicato();
	});

	$('.btn-edit').click(function(e){
		e.preventDefault();
		var id = $(this).attr('data-id');
		LoadModalEditSindicato(id);
	});
	
	/* DeleteSindicato  */
	$('.btn-delete').click(function(e){
		e.preventDefault();
		if(confirm("Esta seguro de borrar?")){
			id = $(this).attr("data-id");
			DeleteSindicato(id);
		}
	});
	
});