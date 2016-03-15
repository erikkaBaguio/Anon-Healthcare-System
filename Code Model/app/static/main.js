function register(){

	var valueName = $('input[name="fname"]').val()
	var valueMName = $('input[name="mname"]').val()
	var valueLName = $('input[name="lname"]').val()
	var valueEmail = $('input[name="email"]').val()
	var valuePass = $('input[name="password"]').val()

	$.ajax({
		type: "POST",
		url: "/user/",
		data: {fname:valueName, mname:valueMName, lname:valueLName, email:valueEmail, pass:valuePass},
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
