function add_new_disease_data(){
    $.ajax({
        url : 'http://127.0.0.1:5000/disease/',
        type: "GET",
        datatype: "json",
        success: function(resp){
            $("#diseases").html("");
            if (resp == 'ok'){
                for (i = 0; i < resp.count; i++)
				{
					 description = resp.entries[i].description;
					 done = resp.entries[i].done;
					 id = resp.entries[i].id;
					 title = resp.entries[i].title;
                }
            }else {
                $("diseases").html("");
                alert(resp.message);
            }
        },
        error: function(e){
            alert("danger" + e.status);
        }

    });
}