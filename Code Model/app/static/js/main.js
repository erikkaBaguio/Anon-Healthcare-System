/**
 * Created by erikka on 3/9/16.
 */
$(document).ready(function(){
	console.log("hgdhsjjka");
	$("#content").load("/static/pages/home.html");
});

function login(username,password){
	$("#content").load("/static/pages/login.html");
    //$('#login-form').submit(function (event) {
    //    event.preventDefault();
		//var valueUsername = $('input[name="username"]').val()
		//var valuePassword = $('input[name="password"]').val()
    //
    //    $.ajax({
		//	type: 'POST',
    //        url: '/login/',
    //        data: {username:valueUsername, password:valuePassword},
    //        timeout: 1000,
    //    success: function(resp) {
    //        if(resp == 'ok'){
    //            //window.location = "/dashboard/";
		//		alert("OK");
    //    	}
		//},
    //    error: function(e) {
    //         $("#result").html('<p> Invalid ' + e.status + '</p>');
    //    }
    //
    //    })
    //});
}