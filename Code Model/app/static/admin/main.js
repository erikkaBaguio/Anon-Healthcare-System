$(document).ready(function(){

	$("#role-registration-form").hide()

});

function showRoleForm(){ $("#role-registration-form").show() }
function addRole(){

	var valueName = $('input[name="name"]').val()

	$.ajax({
		type: "POST",
		url: "role/",
		data: {name:valueName},
		success: function(resp){
			$("#role-result").html('<div class="alert alert-success"> <strong>Success!</strong> Indicates a successful or positive action.</div>');
		},
		error: function(error){
			console.log(error);
		},
	});

}