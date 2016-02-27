function rowtask(fname)
{
   return '<div class="col-lg-12">' +
          '<h4>' + fname '</h4>' +
}

function loadtasks()
{

$.ajax({
    		url: 'http://127.0.0.1:5000/users',
    		type:"POST",
    		dataType: "json",
    		success: function(resp) {
				$("#tasks").html("");
				if (resp.status  == 'ok') {
				   for (i = 0; i < resp.count; i++)
				   {
					   description = resp.entries[i].fname;                      
                       $("#tasks").append(rowtask(description, done, id, title));
				   }
				} else
				{
					$("#tasks").html("");
					alert(resp.message);
				}
    		},
    		error: function (e) {
        		alert("danger");
   			},
                beforeSend: function (xhrObj){
          		xhrObj.setRequestHeader("Authorization",
                        "Basic " + btoa("ako:akolagini"));
   			}
		}); 
}

function deletetask(id)
{
	$.ajax({
		url: 'http://127.0.0.1:5000/tasks/delete/'+id,
    		type:"GET",
    		dataType: "json",
    		success: function(resp) {
				alert(resp.status);
				window.location = 'http://127.0.0.1:5000/tasks';
				loadtasks() ;
    		},
    		error: function (e) {
        		alert("danger");
   			},
                beforeSend: function (xhrObj){
          		xhrObj.setRequestHeader("Authorization",
                        "Basic " + btoa("ako:akolagini"));
   			}
	})
}