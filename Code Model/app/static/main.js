function register(){

	var valueName = $("#fname").val()
	var valueMName = $("#mname").val()
	var valueLName = $("#lname").val()
	var valueEmail = $("#email").val()

	var user_info = {fname: valueName, mname: valueMName, lname: valueLName, email: valueEmail}

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

function login(){

    var valueUserName = $("#email").val();
    var valuePassword = $("#password").val();
    console.log(valueUserName)
    var user_info = {username: valueUserName, password: valuePassword}

    $.ajax({
        type: "POST",
        url: "/login",
        data: user_info,
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

jQuery(document).ready(function () {
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