
/*
function: AddRubro
*/
function LoadModalAddRubro(project_id)
{
    $('#modal').load(
    	"/admin/project/add_rubro/"+project_id,
    	function(){
		    $(this).modal({
		        keyboard:true,
		        backdrop:true
		    });
	}).modal('show'); 

    return false;
}

/*
function: AddSubRubro
*/
function LoadModalAddSubRubro(project_id,rubro_id)
{
	$('#modal').html("");
    $('#modal').load(
    	"/admin/project/add_sub_rubro/"+project_id + "/rubro/" + rubro_id,
    	function(){
		    $(this).modal({
		        keyboard:true,
		        backdrop:true
		    });
	}).modal('show'); 

    return false;
}

/*
function: AddFactura
*/
function LoadModalAddFactura(project_id)
{
	$('#modal').html("");
    $('#modal').load(
    	"/admin/project/add_factura/"+project_id ,
    	function(){
		    $(this).modal({
		        keyboard:true,
		        backdrop:true
		    });
	}).modal('show'); 

    return false;
}

/*
function: DeleteRubro
*/
function DeleteRubro(project_id,rubro_id){
	if(confirm("¿Realmente quiere eliminar este rubro del proyecto?")){
		alert("El Rubro será eliminado");
	}
	return false;
}

/*
function: DeleteSubRubro
*/
function DeleteSubRubro(project_id,subrubro_id){
	if(confirm("¿Realmente quiere eliminar este SUBrubro del proyecto?")){
		alert("El SUBrubro será eliminado");
	}
	return false;
}

/*
function: LoadSubrubros
*/
function LoadSubrubros(rubro_id)
{
	console.log("load subrubros...");	
	$.ajax({
		url:"/admin/project/subrubros_json/"+rubro_id,
		dataType:"json",
		success:function(data){
			if(data.result == false)
			{
				alert("Error al cargar los modelos");
			}else{
				fillcombo(data, "subrubros");
			}
		}
	});
}

function fillcombo(dataObjects,targetObjectId)
{
	var listItems = [];
	var targetObject = $("#"+targetObjectId);
	var optionSelectedId = targetObject.attr("data-selector");
	$.each(dataObjects.result,function(index,val)
	{
		var option = '<option value="' + val.id + '"' ;
		if(optionSelectedId == val.id){option+= ' selected="selected" >'}else{option+='>';}
		option += val.title + "</option>";
		listItems.push( option );
	});

	var options = '<option value="">- Seleccionar -</option>' + listItems.join("");
	targetObject.html(options);
}


$(document).ready(function(){

	/* DELETE PARTIDA ACTION */
	$('.btn-delete-partida').click(function(e){
		e.preventDefault();
		if(confirm("Esta seguro de borrar esta Partida?")){
			console.log($(this).attr("data-id"));	
		}
		
	});

	/* UPDATE COMBO SUBRUBROS */
	$(".rubro").change(function()
	{
		console.log("rubro changed");
		rubro_id = $(this).val();
		if(rubro_id != '')
		{
			LoadSubrubros(rubro_id);
		}
		
	});

	

});