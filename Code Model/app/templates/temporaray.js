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