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
<<<<<<< HEAD
=======


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