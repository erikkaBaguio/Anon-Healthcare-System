function register(){

	function generatePassword() {
    var chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~!@#$%^&*()';

    console.log(random);

    var generated = '';

    for(var i = 0; i < 13; i++) {

        var random = Math.floor((Math.random() * 73) + 1)
        generated = generated + chars[random];
        console.log(generated);
    }

	password = generated.toString();

    return password;

	}

	password = generatePassword().toString();

	var valueName = $('input[name="name"]').val()
	var valueUsername = $('input[name="username"]').val()
	//var valuePass = $('input[name="password"]').val()
	var valuePass = $('input[name="password"]').val()
	//$('input[name="password"]') = password;
	//var valuePass = generatePassword().toString();
	console.log(valueName, valueUsername, valuePass);

	$.ajax({
		type: "POST",
		url: "/",
		data: {name:valueName, username:valueUsername, pass:valuePass},
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