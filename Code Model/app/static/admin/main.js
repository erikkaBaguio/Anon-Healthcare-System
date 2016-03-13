$(document).ready(function(){

	$("#role-registration-form").hide()

	$.ajax({
		type: "GET",
	});

});

function showRoleForm(){ $("#role-registration-form").show() }
function addRole(){

	var valueName = $('input[name="name"]').val()
	console.log(valueName)

	$.ajax({
		type: "POST",
		url: "/admin/role",
		data: $('form').serialize(),
		success: function(resp){
			$("#role-result").html('<div class="alert alert-success"> <strong>Success!</strong> Indicates a successful or positive action.</div>');
		},
		error: function(error){
			console.log(error);
		},
	});

}