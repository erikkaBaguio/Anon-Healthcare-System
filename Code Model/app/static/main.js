function login(){

    var valueUserName = $("#username").val();
    var valuePassword = $("#password").val();

	var user_info = {username: valueUserName, password: valuePassword}
    console.log(valuePassword);
	console.log(valueUserName);
    $.ajax({
        type: "POST",
        url: "http://localhost:5000/anoncare.api/login",
        data: JSON.stringify(user_info),
        dataType: "json",
        success: function(resp){
            if (resp.status  == 'ok') {
				    $("#results").html('<p>SUCCESSFULL!</p>');
			}
        },
        error: function(error){
            console.log('EROOOOOOOOOOOOOOOR!');
        },
    });
}

function register(){

	var valueName = $("#fname").val()
	var valueMName = $("#mname").val()
	var valueLName = $("#lname").val()
	var valueEmail = $("#email").val()

	var user_info = {"fname": valueName, "mname": valueMName, "lname": valueLName, "email": valueEmail}

	$.ajax({
		type: "POST",
		url: "/user/",
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

//Login a new user
