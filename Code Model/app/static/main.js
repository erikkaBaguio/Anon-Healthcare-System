function register(){

	var valueName = $('input[name="fname"]').val()
	var valueMName = $('input[name="mname"]').val()
	var valueLName = $('input[name="lname"]').val()
	var valueEmail = $('input[name="email"]').val()

	$.ajax({
		type: "POST",
		url: "/user/",
		data: {fname:valueName, mname:valueMName, lname:valueLName, email:valueEmail},
		success: function(resp){
			console.log(resp.status);

				$("#results").html('<p>successfully register ' + valueName + '</p>');

				// $("input").val("")
		},
		error: function(error){
			console.log(error);
		},
	});
}

function