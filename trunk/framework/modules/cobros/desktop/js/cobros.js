/* function: AddCobro */
function LoadModalAddCobro()
{
    $('#modal').load("/admin/cobros/add/",
    	function(){
		    $(this).modal({
		        keyboard:true,
		        backdrop:true
		    });
	}).modal('show'); 

    return false;
}

function DeleteCobro(id){
	$.ajax({
		url:"/admin/cobros/delete/"+id,
		success:function(data){
			if(data == 1){
				$("#cobro_"+id).remove();	
			}
			
		}
	});
    return false;
}


$(document).ready(function(){
	$('.btn-add-cobro').click(function(e){
		e.preventDefault();
		LoadModalAddCobro();
	});
	
	/* DeleteCobro  */
	$('.btn-delete-cobro').click(function(e){
		e.preventDefault();
		if(confirm("Esta seguro de borrar este Cobro?")){
			id = $(this).attr("data-id");
			DeleteCobro(id);
		}
	});
	
});