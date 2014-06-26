var adminpath

function sendMail(user_id)
{
	
	jQuery('#sendEmail').after('<span id="sendingEmail" class="botoncito" style="display:block;width:80px;margin:auto;">Enviando...</span>');
	jQuery('#sendEmail').hide();
	
	
	jQuery.ajax({
		type: "POST",
		url: adminpath+"?m=admin&action=BackEmailSend",
		data: "user_id="+user_id,
		success: function(response){
			if(response == 1){
				jQuery('li.user').html('<p>Los datos han sido enviados</p>');
			}else{
				alert(response);
			}
		}
	});
}

function deleteUser(user_id){
	if(confirm('Estas seguro que deseas eliminar el usuario?')){
		
		jQuery.ajax({
			type: "POST",
			url: adminpath+"?m=admin&action=BackDeleteUser",
			data: "user_id="+user_id,
			success: function(response){
				if(response==1){
					jQuery('#user_'+user_id).slideUp('fast');
					jQuery('#user_'+user_id).remove();
				}else{
					//alert('Se ha producido un error y no se pudo borrar al usuario');
					alert(response);
				}
			}
		});
	}
}
