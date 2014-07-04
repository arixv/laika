/************************ GLOBAL FUNCTIONS ************************/

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


/************************ PARTIDAS ************************/

/* addPartida */
function LoadModalAddPartida(project_id){
    $('#modal').load(
    	"/admin/project/add_partida/"+project_id,
    	function(){
		    $(this).modal({
		        keyboard:true,
		        backdrop:true
		    });
	}).modal('show'); 

    return false;
}

/* editPartida */
function LoadModalEditPartida(project_id,partida_id){
    $('#modal').load(
    	"/admin/project/edit_partida/"+project_id+'/partida/'+partida_id,
    	function(){
		    $(this).modal({
		        keyboard:true,
		        backdrop:true
		    });
	}).modal('show'); 
    return false;
}

/* deletePartida */
function DeletePartida(partida_id){
	$.ajax({
		url:"/admin/project/delete_partida/"+partida_id,
		success:function(data){
			if(data == 1){
				$("#partida_"+partida_id).remove();	
			}
			
		}
	});
    return false;
}


/************************ RUBROS ************************/

/* function: AddRubro */
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

/* function: DeleteRubro */
function DeleteRubro(project_id,rubro_id)
{
	if(confirm("¿Realmente quiere eliminar este rubro del proyecto?"))
	{
		alert("El Rubro será eliminado");
	}
	return false;
}


/************************ SUBRUBROS ************************/

/* function: AddSubRubro */
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

/* function: DeleteSubRubro */
function DeleteSubRubro(project_id,subrubro_id){
	if(confirm("¿Realmente quiere eliminar este SUBrubro del proyecto?")){
		$.ajax({
			url:"/admin/project/delete_subrubro/"+project_id+"/subrubro/"+subrubro_id,
			success:function(data){
				// if(data.result == false)
				// {
				// 	alert("Error al cargar los modelos");
				// }else{
				// 	fillcombo(data, "subrubros");
				// }
			}
		});
	}
	return false;
}

/* function: LoadSubrubros */
function LoadSubrubros(rubro_id)
{
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



/************************ FACTURAS ************************/

/* function: AddFactura */
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


/* editPartida */
function LoadModalEditFactura(project_id,factura_id){
    $('#modal').load(
    	"/admin/project/edit_factura/"+project_id+'/factura/'+factura_id,
    	function(){
		    $(this).modal({
		        keyboard:true,
		        backdrop:true
		    });
	}).modal('show'); 
    return false;
}


/* deletePartida */
function DeleteFactura(factura_id){
	$.ajax({
		url:"/admin/project/delete_factura/"+factura_id,
		success:function(data){
			if(data == 1){
				$("#factura_"+factura_id).remove();	
			}
			
		}
	});
    return false;
}



/****************** WHEN DOM IS READY ************************/

$(document).ready(function(){

	/* DeletePartida  */
	$('.btn-delete-partida').click(function(e){
		e.preventDefault();
		if(confirm("Esta seguro de borrar esta Partida?")){
			partida_id = $(this).attr("partida-id");
			DeletePartida(partida_id);
		}
	});

	/* EditPartida  */
	$('.btn-edit-partida').click(function(e){
		e.preventDefault();
		partida_id = $(this).attr("partida-id");
		project_id = $(this).attr("project-id");
		LoadModalEditPartida(project_id,partida_id);
	});

	/* AddFactura */
	$('.btn-add-factura').click(function(e){
		project_id = $(this).attr("project-id");
		LoadModalAddFactura(project_id);
	});
	
	/* DeleteFactura  */
	$('.btn-delete-factura').click(function(e){
		e.preventDefault();
		if(confirm("Esta seguro de borrar esta Factura?")){
			factura_id = $(this).attr("factura-id");
			DeleteFactura(factura_id);
		}
	});



	/* EditFactura  */
	$('.btn-edit-factura').click(function(e){
		e.preventDefault();
		factura_id = $(this).attr("factura-id");
		project_id = $(this).attr("project-id");
		LoadModalEditFactura(project_id,factura_id);
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