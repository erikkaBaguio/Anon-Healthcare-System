
function get_all_users() {
    $.ajax({
        url: 'http://127.0.0.1:5000/users/',
        type: "GET",
        datatype: 'json',
        success: function(resp) {
            $("#users").html("");
            if(resp == 'ok') {
                for(i = 0; i < resp.count; i++) {
                    id = resp.entries[i].id;
                    fname = resp.entries[i].fname;
                    mname = resp.entries[i].mname;
                    lname = resp.entries[i].lname;
                    email = resp.entries[i].email;
                    password = resp.entries[i].password;
                    role = resp.entries[i].role;
                    is_active = resp.entries[i].is_active;
                }
            }
            else {
                $("users").html("");
                alert(resp.message);
            }
        },
        error: function(e) {
            alert("danger" + e.status);
        }

    });
}

function get_disease_data() {
    $.ajax({
        url: 'http://127.0.0.1:5000/disease/',
        type: "GET",
        datatype: "json",
        success: function (resp) {
            $("#diseases").html("");
            if (resp == 'ok') {
                for (i = 0; i < resp.count; i++) {
                    description = resp.entries[i].description;
                    done = resp.entries[i].done;
                    id = resp.entries[i].id;
                    title = resp.entries[i].title;
                }
            } else {
                $("diseases").html("");
                alert(resp.message);
            }
        },
        error: function (e) {
            alert("danger" + e.status);
        }

    })
}


function get_questions(){
    $.ajax({
        url: 'http://127.0.0.1:5000/question',
        type: "GET",
        datatype: "json",
        success: function(resp) {
            $("#questions").html("");
            if (resp == "OK") {
                for (i = 0; i < resp.count; i++) {
                    id = resp.entries[i].id;
                    question = resp.entries[i].question;
                    user_id = resp.entries[i].user_id;
                    category_id = resp.entries[i].category_id;
                    done = resp.entries[i].done;
                }
            } else {
                $("questions").html("");
                alert(resp.message);
            }
        },
        error: function (e) {
            alert("danger" + e.status);
        }

    })
}