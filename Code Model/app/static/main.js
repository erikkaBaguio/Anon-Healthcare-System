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

    valueName = valueName.mystring.replace(/"/g,"'");
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


jQuery(document).ready(function ($) {
    $('#loginform').submit(function (event) {
        event.preventDefault();
		var valueUsername = $('input[name="username"]').val()
		var valuePassword = $('input[name="password"]').val()

        $.ajax({
			type: 'POST',
            url: '/login/',
            data: {username:valueUsername, password:valuePassword},
            timeout: 1000,

        }).success(function(data, textStatus, jqXHR) {
            var preLoginInfo = JSON.parse($.cookie('dashboard.pre.login.request'));
            window.location = preLoginInfo.url;

        }).fail(function(jqXHR, textStatus, errorThrown) {
            alert('Booh! Wrong credentials, try again!');
        });
    });
});

//Login a new user
function login(name, password) {
    var userData = {
        name: name,
        password: password
    };

    $.ajax({
        url: "http://localhost:4730/login",
        type: "POST",
        dataType: "json",
        data: userData,
        error: function (xhr, status) {
            console.log("Sorry, there was a problem!");
        },
        complete: function (xhr, status) {
            console.log(xhr);
        }
    });
}