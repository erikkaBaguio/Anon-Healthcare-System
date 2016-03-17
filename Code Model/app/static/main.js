function register(){

	var valueName = $("#fname").val()
	var valueMName = $("#mname"").val()
	var valueLName = $("#lname").val()
	var valueEmail = $("#email").val()

	var user_info = {"fname": valuenName, "mname": valueMName, "lname": valueLName, "email": valueEmail}

	$.ajax({
		type: "POST",
		url: "/user/",
		dataType: json,
		data: JSON.strigify(user_info),
		success: function(resp){
			console.log(resp.status);

				$("#results").html('<p>OK!</p>');
		},
		error: function(error){
			console.log(error);
		},
	});
}