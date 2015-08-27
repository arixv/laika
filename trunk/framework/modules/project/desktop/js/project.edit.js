/************************ GLOBAL FUNCTIONS ************************/

function sortItems(){
	var ids = $('#sortable-rubros').sortable('toArray');
	var form = $('form[name="ordenar"]');
	var project_id = $('#project_id').val(); 
	var i = 0;
	var n=ids.length;
	
	console.log(project_id);

	var json = '{"project_id":"'+project_id+'","objects":[';

	for(i; i<n; i++){
		if(ids[i]!=''){
			var id = ids[i];//.substring(3,11);
			json += '{"id":"'+id+'","order":"'+i+'"}';

			if(i<n-1){
				json+=',';
			}
		}
	}
	json += ']}';

	console.debug(json);

	$.ajax({
		url:'/admin/project/sort_resources/' + project_id + '/',
		data:'data='+json,
		method:'POST',
		type:'POST',
		//dataType:'json',
		success:function(e){
			console.log(e);
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

function PaymentCalendar(){
	var total_payments = $('#payments').val();
	var quantity = $('#quantity');
	var cost = $('#cost');

	if(quantity.val() == ''){
		alert("Por favor ingrese la cantidad");
		quantity.focus();
		return false;
	}

	if(cost.val() == ''){
		alert("Por favor ingrese el costo por unidad");
		cost.focus();
		return false;
	}

	var total_cost = cost.val() * quantity.val();
	var each_payment = total_cost / total_payments;

	var html = '<table class="table table-stripped" style="margin-bottom:250px;">';
	html+= '<thead>';
	html+= '<tr>';
	html+= '	<th>Nro Pago</th>';
	html+= '	<th>Fecha</th>';
	html+= '	<th>Valor</th>';
	html+= '</tr>';
	html+= '</thead>';
	html+= '<tbody>';

	for(var i = 1; i <= total_payments; i++){
		html+= '<tr>';
		html+= '	<td>Pago #'+i+'</td>';
		html+= '	<td>';
		html+= '		<div data-date-viewmode="years" data-date-format="dd-mm-yyyy" data-date=""  class="input-append date dpYears">';
		html+= '			<input type="text"  name="payments_days[]" value="" size="16" class="form-control default-date-picker" />';
		html+= '		</div>';
		html+= '	</td>';
		html+= '	<td><input type="text" name="payments_values[]" value="'+each_payment+'" class="form-control"  /></td>';
		html+= '</tr>';
	}

	html+= '</tbody>';
	html+= '</table>';

	$('#payment_calendar').html(html);
	$('.default-date-picker').datepicker({format: 'dd-mm-yyyy'});
	$('.dpYears').datepicker();
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
	if(confirm("¿Realmente quiere eliminar este rubro del proyecto?")){
		$.ajax({
			url:"/admin/project/delete_rubro/"+project_id+"/rubro/"+rubro_id,
			success:function(data){
				if(data == 1)
				{
					$("#rubro_"+rubro_id).remove();	
				}
			}
		});
	}
	return false;
}


/************************ SUBRUBROS ************************/

/* function: AddSubRubro */
function LoadModalAddResource(project_id){
	$('#modal').html("");
    $('#modal').load(
    	"/admin/project/add_resource/"+project_id,
    	function(){
		    $(this).modal({
		        keyboard:true,
		        backdrop:true
		    });
	}); 

}

/* function: Edit Resource */
function LoadModalEditResource(project_id,resource_id)
{
    $('#modal').load(
    	"/admin/project/edit_resource/"+project_id + "/resource/" + resource_id,
    	function(){
		    $(this).modal({
		        keyboard:true,
		        backdrop:true
		    });
	}).modal('show'); 

    return false;
}

/* function: DeleteSubRubro */
function DeleteProjectResource(project_id,resource_id){
	if(confirm("¿Realmente quiere eliminar este Recurso del proyecto?")){
		$.ajax({
			url:"/admin/project/delete_resource/"+project_id+"/resource/"+resource_id,
			success:function(data){
				if(data == 1)
				{
					$("#resource_"+resource_id).remove();	
				}
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
function LoadModalAddFactura(project_id,partida_id,redirect)
{
	var call_url = "/admin/?m=project&action=BackDisplayAddFactura&project_id="+project_id ;

	if(typeof(partida_id) !== 'undefined'){
		call_url+= '&partida_id='+partida_id;
	}
	if(typeof(redirect) !== 'undefined'){
		call_url+='&redirect='+redirect;
	}

	$('#modal').html("");
    $('#modal').load(
    	call_url,
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

	

	/* AddPartida */
	$('.btn-add-partida').click(function(e){
		e.preventDefault();
		project_id = $(this).attr("project-id");
		LoadModalAddPartida(project_id);
	});

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
		e.preventDefault();
		project_id = $(this).attr("project-id");
		partida_id = $(this).attr("partida-id");
		redirect = $(this).attr("data-redirect");
		LoadModalAddFactura(project_id,partida_id,redirect);
	});
	
	/* DeleteFactura  */
	$('.btn-delete-factura').click(function(e){
		e.preventDefault();
		if(confirm("Esta seguro de borrar esta Factura?")){
			factura_id = $(this).attr("factura-id");
			DeleteFactura(factura_id);
		}
	});

	

	/* Add Resource */
	$('.btn-add-resource').click(function(e){
		e.preventDefault();
		project_id = $(this).attr("project-id");
		LoadModalAddResource(project_id);
	});
	/* Delete Resource */
	$('.btn-delete-resource').click(function(e){
		e.preventDefault();
		var resource_id = $(this).attr("resource-id");
		var subrubro_id = $(this).attr("subrubro-id");
		var project_id = $(this).attr("project-id");
		DeleteProjectResource(project_id,resource_id);
	});
	/* Edit Resource  */
	$('.btn-edit-resource').click(function(e){
		e.preventDefault();
		var resource_id = $(this).attr("resource-id");
		var subrubro_id = $(this).attr("subrubro-id");
		var project_id = $(this).attr("project-id");
		LoadModalEditResource(project_id,resource_id);
	});
		

	/* EditFactura  */
	// $('.btn-edit-factura').click(function(e){
	// 	e.preventDefault();
	// 	factura_id = $(this).attr("factura-id");
	// 	project_id = $(this).attr("project-id");
	// 	LoadModalEditFactura(project_id,factura_id);
	// });


	/* UPDATE COMBO SUBRUBROS */
	$(".rubro").change(function()
	{
		rubro_id = $(this).val();
		if(rubro_id != '')
		{
			LoadSubrubros(rubro_id);
		}
		
	});

	

});