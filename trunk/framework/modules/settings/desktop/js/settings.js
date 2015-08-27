
function LoadModalAddCosto(){
    $('#modal').load(
    	"/admin/settings/add_costo/",
    	function(){
		    $(this).modal({
		        keyboard:true,
		        backdrop:true
		    });
	}).modal('show'); 

    return false;
}


function LoadModalEditCosto(costo_id){
    $('#modal').load(
    	"/admin/settings/edit_costo/"+costo_id,
    	function(){
		    $(this).modal({
		        keyboard:true,
		        backdrop:true
		    });
	}).modal('show'); 
    return false;
}


function DeleteCosto(costo_id)
{
	
	$.ajax({
		url:"/admin/settings/delete_costo/"+costo_id,
		success:function(data){
			console.log(data);
			if(data == 1)
			{
				$("#costo_"+costo_id).remove();	
			}
		}
	});

	return false;
}


/****************** WHEN DOM IS READY ************************/

$(document).ready(function(){


	/* btn-add-costo */
	$('.btn-add-costo').click(function(e){
		e.preventDefault();
		LoadModalAddCosto();
	});

	/* btn-delete-costo  */
	$('.btn-delete-costo').click(function(e){
		e.preventDefault();
		if(confirm("Esta seguro de borrar este Costo?")){
			costo_id = $(this).attr("costo-id");
			DeleteCosto(costo_id);
		}
	});

	/* btn-edit-costo  */
	$('.btn-edit-costo').click(function(e){
		e.preventDefault();
		costo_id = $(this).attr("costo-id");
		LoadModalEditCosto(costo_id);
	});


});