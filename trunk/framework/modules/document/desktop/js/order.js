var object_id, type_id = 3;

$(document).ready(function(){

	var options = { 
		success: updateOrder
	};
	$("form[name='ordenar']").ajaxForm(options);

	$("#elementos").sortable({
		axis: "y",
		cursor: "move",
		//handle: ".header",
		update: function() { saveOrder(); }
	});
	
});


function saveOrder(){

	var IDs = $('#elementos').sortable('toArray');

	var form = $("form[name='ordenar']");
	$('input.order', form).remove();

	for (var i = 0, n = IDs.length; i < n; i++) {
		if(IDs[i]!=''){
			var id = IDs[i].substring(3,11);
			form.append('<input type="hidden" name="order['+i+']" value="'+id+'" class="order"/>')
		}
	}

}


function updateOrder(responseText, statusText, xhr, $form)
{
	parent.multimedia.updateRelations(object_id, type_id);
	parent.layer.Remove();
}
