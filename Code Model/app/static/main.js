function login(){

    valueUserName = $("#username").val()
    var valuePassword = $("#password").val()

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

//function register(){
//
//	var valueName = $("#fname").val()
//	var valueMName = $("#mname").val()
//	var valueLName = $("#lname").val()
//	var valueEmail = $("#email").val()
//
//	var user_info = {fname: valueName, mname: valueMName, lname: valueLName, email: valueEmail}
//
//	$.ajax({
//		type: "POST",
//		url: "/user/",
//		data: JSON.stringify(user_info),
//		dataType: "json",
//		success: function(resp){
//			console.log(resp.status);
//
//				$("#results").html('<p>OK!</p>');
//		},
//		error: function(error){
//			console.log(error);
//		},
//	});
//}

function create_username(fname, lname) {
    var username = fname + '.' + lname;
    username = username.replace(/\s/g, '').toLocaleLowerCase();


    return username;
}


function get_random_int() {
    var random_int = Math.floor((Math.random() * 75) + 1);

    return random_int;
}


function generate_password() {
    var characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~!@#$%^&*()_+';
    var char_length = characters.length;
    var random_password = '';
    var pass_length = random_password.length;

    for(var i = 0; i < 16; i++) {
        var random_int = get_random_int();

        random_password = random_password + characters[random_int];
    }



    //return char_length;
    return random_password;
}

function register(){

	var valueName = $('input[name="fname"]').val();
	var valueMName = $('input[name="mname"]').val();
	var valueLName = $('input[name="lname"]').val();
	var valueEmail = $('input[name="email"]').val();
    var valueUsername = create_username(valueName, valueLName);
    var valuePass = generate_password();

    valueName = valueName.mystring.replace(/"/g,x"'");
    valueMName = valueMName.mystring.replace(/"/g,"'");
    valueLName = valueLName.mystring.replace(/"/g,"'");
    valueEmail = valueEmail.mystring.replace(/"/g,"'");
    valueUsername = valueUsername.mystring.replace(/"/g,"'");
    valuePass = valuePass.mystring.replace(/"/g,"'");


    var user_data = {fname: valueName, mname: valueMName, lname: valueLName,
                        email: valueEmail, username: valueUsername, password: valuePass};



    var json_data = JSON.stringify(user_data);


    console.log(json_data);

	$.ajax({
		type: "POST",
		url: "/user/",
        dataType: "json",
		data: json_data,
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