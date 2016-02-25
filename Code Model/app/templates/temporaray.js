/**
 * Created by josiah on 2/25/16.
 */
function newuser(fname, mname, lname, email, password, role, is_active) {
     return '<div class="col-lg-12">' +
            '<div class="form-group">' +
            '<label class="col-md-2 control-label">' + fname + '</label>' +
            '<div class="col-md-10">' +
            '<input name="fname" type="text" class="form-control" </div></div>';
             //'<h4>' + id + "&nbsp;&nbsp;" + title + '</h4>' +
             //'<p>'+description+' </br> Status: '+done+'</p> </div>';
}

function rowusers(id, fname, mname, lname, email, role, is_active) {
    return '<div class="col-lg-12">' +
          '<h4>' + id + "&nbsp;&nbsp;" + lname + '</h4>' +
          '<p></p>' + fname + "&nbsp;&nbsp;" + mname + '</p>' +
          '<p>'+email+' </br> Role: '+role+'</br> is_active: '+is_active+'</p> </div>';
}

function adduser() {

    $.ajax({
        url: 'http://127.0.0.1:5000/adduser',
        type: "POST",
        dataType: "json",
        success: function(resp) {

        }
        error:
    });
}

function loadusers() {
    $.ajax({
        url: 'http://127.0.0.1:5000/users',
        type: "GET",
        dataType: "json",
        success: function(resp) {
            $("users").html("");
            if(resp.status == 'OK') {
                for(i = 0; i < resp.count; i++) {
                    id = resp.entries[i].id
                    fname = resp.entries[i].fname
                    mname = resp.entries[i].mname
                    lname = resp.entries[i].lname
                    email= resp.entries[i].email
                    role = resp.entries[i].role
                    is_active = resp.entries[i].is_active

                    $("#users").append(rowusers(id, fname, mname, lname, email, role, is_active))
                }
            } else {
                $("#users").html("");
                alert(resp.message);
            }
        },
        error: function (e) {
            alert("danger");
        }
    });
}