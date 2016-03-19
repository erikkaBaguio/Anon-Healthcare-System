$(document).ready(function(){

	$("#role-registration-form").hide()

	$.ajax({
		type: "GET",
		url: "/admin/<int:par_doctor_id>",
		dataType: "json",
		success: function(resp){
			if(resp.status == 'ok'){
				$("#active-appointments").html('<p>' + resp.count +'</p>')
			}
		},
		error: function(resp){
			alert("error loading appointment count");
		},
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

//Login a new user
function login(){

    var valueUserName = $("#username").val();
    var valuePassword = $("#password").val();

	var user_info = {username: valueUsername, password: valuePassword}
    console.log(valuePassword);
	console.log(valueUserName);
    $.ajax({
        type: "POST",
        url: "/login",
        data: JSON.stringify(user_info),
        dataType: "json",
        success: function(resp){
            console.log(resp.status);

                $("#results").html('<p>OK!</p>');
        },
        error: function(error){
            console.log(error);
        },
    });
}