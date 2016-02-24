$(document).ready(function(){
	console.log("ready");

	$("form").on("submit", function(){
		console.log("the form has been submitted!")

		var valueOne = $('input[name="username"]').val()
		var valuetwo= $('input[name="password"]').val()
		console.log(valueOne, valuetwo)

		$.ajax({
			type: "POST",
			url: "/",
			data: {first: valueOne, second: valuetwo}
		})
	})

});