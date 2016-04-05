function register(){
	var valueName = $("#fname").val()
	var valueMName = $("#mname").val()
	var valueLName = $("#lname").val()
	var valueEmail = $("#email").val()

	var user_info = {"fname": valuenName, "mname": valueMName, "lname": valueLName, "email": valueEmail}
	var valueName = $('input[name="fname"]').val()
	var valueMName = $('input[name="mname"]').val()
	var valueLName = $('input[name="lname"]').val()
	var valueEmail = $('input[name="email"]').val()
	var valuePass = $('input[name="password"]').val()

	$.ajax({
		type: "POST",
		url: "/user/",
		dataType: json,
		data: JSON.stringify(user_info),
		data: {fname:valueName, mname:valueMName, lname:valueLName, email:valueEmail, pass:valuePass},

		success: function(resp){
			console.log(resp.status);

				$("#results").html('<p>OK!</p>');
		},
		error: function(error){
			console.log(error);
		},
	});
}

function login() {
    //$('#loginform').submit(function (event) {
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
    //            window.location = "/dashboard/";
    //    },
    //    error: function(e) {
    //         $("#result").html('<p> Invalid ' + e.status + '</p>');
    //    };
    //
    //    })
    //});
    var valueUsername = $('input[name="username"]').val()
    var valuePassword = $('input[name="password"]').val()

    $.ajax({
        type: 'POST',
        url: '/login/',
        data: {username:valueUsername, password:valuePassword},
        timeout: 1000,
    success: function(resp) {
        if(resp == 'ok'){
        window.location = "/dashboard/";
		alert("OK");
        }
	},
    error: function(e) {
        $("#result").html('<p> Invalid ' + e.status + '</p>');
    }
    })
}

//function get_user_with_id() {
//    $.ajax({
//        url: 'http://127.0.0.1:5000/users/',
//        type: "GET",
//        datatype: 'json',
//        success: function(resp) {
//            $("#users").html("");
//            if(resp == 'ok') {
//                for(i = 0; i < resp.count; i++) {
//                    id = resp.entries[i].id;
//                    fname = resp.entries[i].fname;
//                    mname = resp.entries[i].mname;
//                    lname = resp.entries[i].lname;
//                    email = resp.entries[i].email;
//                    password = resp.entries[i].password;
//                    role = resp.entries[i].role;
//                    is_active = resp.entries[i].is_active;
//                }
//            }
//            else {
//                $("users").html("");
//                alert(resp.message);
//            }
//        },
//        error: function(e) {
//            alert("danger" + e.status);
//        }
//
//    });
//}



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



function get_userinfo(){
    $.ajax({
        url: 'http://127.0.0.1:5000/question',
        type: "GET",
        datatype: "json",
        success: function(resp) {
            $("#user-informations").html("");
            if (resp == "OK") {
                for (i = 0; i < resp.count; i++) {
                    id = resp.entries[i].id;
                    fname = resp.entries[i].fname;
                    mname = resp.entries[i].mname;
                    lname = resp.entries[i].lname;
                    email = resp.entries[i].email;
                    password = resp.entries[i].password;
                    role = resp.entries[i].role;
                    is_active = resp.entries[i].is_active;
                }
            } else {
                $("user-informations").html("");
                alert(resp.message);
            }
        },
        error: function (e) {
            alert("danger" + e.status);
        }

    })
}

function get_patientfile(){
    $.ajax({
        url: 'http://127.0.0.1:5000/anoncare.api/patient',
        type: "GET",
        datatype: "json",
        success: function(resp) {
            $("#patientfile").html("");
            if (resp == "OK") {
                for (i = 0; i < resp.count; i++) {
                    id = resp.entries[i].id;
                    fname = resp.entries[i].fname;
                    mname = resp.entries[i].mname;
                    lname = resp.entries[i].lname;
                    age = resp.entries[i].age;
                    sex = resp.entries[i].sex;
                    height = resp.entries[i].height;
                    weight = resp.entries[i].weight;
                    date_of_birth = resp.entries[i].date_of_birth;
                    civil_status = resp.entries[i].civil_status;
                    name_of_guardian = resp.entries[i].name_of_guardian;
                    home_address = resp.entries[i].home_address;
                    cough = resp.entries[i].cough;
                    dyspnea = resp.entries[i].dyspnea;
                    hemoptysis = resp.entries[i].hemoptysis;
                    tb_exposure = resp.entries[i].tb_exposure;
                    frequency = resp.entries[i].frequency;
                    flank_plan = resp.entries[i].flank_plan;
                    discharge = resp.entries[i].discharge;
                    dysuria = resp.entries[i].dysuria;
                    nocturia = resp.entries[i].nocturia;
                    dec_urine_amount = resp.entries[i].dec_urine_amount;
                    asthma = resp.entries[i].asthma;
                    ptb = resp.entries[i].ptb;
                    heart_problem = resp.entries[i].heart_problem;
                    hepatitis_a_b = resp.entries[i].hepatitis_a_b;
                    chicken_pox = resp.entries[i].chicken_pox;
                    mumps = resp.entries[i].mumps;
                    typhoid_fever = resp.entries[i].typhoid_fever;
                    chest_pain = resp.entries[i].chest_pain;
                    palpitations = resp.entries[i].palpitations;
                    pedal_edema = resp.entries[i].pedal_edema;
                    orthopnea = resp.entries[i].orthopnea;
                    nocturnal_dyspnea = resp.entries[i].nocturnal_dyspnea;
                    headache = resp.entries[i].headache;
                    seizure = resp.entries[i].seizure;
                    dizziness = resp.entries[i].dizziness;
                    loss_of_consciousness = resp.entries[i].loss_of_consciousness;
                }
            } else {
                $("patientfile").html("");
                alert(resp.message);
            }
        },
        error: function (e) {
            alert("danger" + e.status);
        }

    })
}


