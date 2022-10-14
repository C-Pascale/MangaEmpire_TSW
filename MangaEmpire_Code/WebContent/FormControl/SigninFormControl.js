$( document ).ready(function() {

	
	var isstring = /^[\sA-Za-z]+$/
	var email_reg_exp = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	
	
	$("#reset").click(function(){
		
		let divEmail = $(this).parent().find("#Email");
		let divPsw = $(this).parent().find("#Psw");
		let divConferma = $(this).parent().find("#Conferma");
		let divNome = $(this).parent().find("#Nome");
		let divCognome = $(this).parent().find("#Cognome");
		let divPaese = $(this).parent().find("#Paese");
		let divTelefono = $(this).parent().find("#Telefono");
		let divIndirizzodispedizione = $(this).parent().find("#Indirizzo");
		let divIndirizzodifatturazione = $(this).parent().find("#Fatturazione");

		divEmail.css("display","none");
		divPsw.css("display","none");
		divConferma.css("display","none");
		divNome.css("display","none");
		divCognome.css("display","none");
		divPaese.css("display","none");
		divTelefono.css("display","none");
		divIndirizzodispedizione.css("display","none");
		divIndirizzodifatturazione.css("display","none");
		
	});
	
	$("#submit").click(function(){
	
	var email = document.SignIn.email.value;
	var psw = document.SignIn.psw.value;
	var conferma = document.SignIn.conferma.value;
	var nome = document.SignIn.nome.value;
	var cognome = document.SignIn.cognome.value;
	var paese = document.SignIn.paese.options[document.SignIn.paese.selectedIndex].value;
	var telefono = document.SignIn.telefono.value;
	var indirizzodispedizione = document.SignIn.indirizzodispedizione.value;
	var cap = document.SignIn.cap.value;
	var indirizzodifatturazione = document.SignIn.indirizzodifatturazione.value;
	var capF = document.SignIn.capF.value;
	
	let divEmail = $(this).parent().find("#Email");
	let divPsw = $(this).parent().find("#Psw");
	let divConferma = $(this).parent().find("#Conferma");
	let divNome = $(this).parent().find("#Nome");
	let divCognome = $(this).parent().find("#Cognome");
	let divPaese = $(this).parent().find("#Paese");
	let divTelefono = $(this).parent().find("#Telefono");
	let divIndirizzodispedizione = $(this).parent().find("#Indirizzo");
	let divIndirizzodifatturazione = $(this).parent().find("#Fatturazione");
	
	divEmail.css("display","none");
	divPsw.css("display","none");
	divConferma.css("display","none");
	divNome.css("display","none");
	divCognome.css("display","none");
	divPaese.css("display","none");
	divTelefono.css("display","none");
	divIndirizzodispedizione.css("display","none");
	divIndirizzodifatturazione.css("display","none");
	
	let Err = true;
	
	if ((!email_reg_exp.test(email)) || (email == "") || (email == "undefined")) {
	
	divEmail.css("display","block");
	
	document.SignIn.email.focus();
	document.SignIn.email.select();
	
	Err = false;
	}else{
		$.get('CheckEmailSignIn', {"email" : email},
				function(res) { // on success	
				
				if(res=="false"){
					Err = false;
					divEmail.css("display","block");
					document.SignIn.email.focus();
					document.SignIn.email.select();
				}
				
			})
	        .fail(function() { // on failure
	        
	        	Err = false;
	        	divEmail.css("display","block");
	        	document.SignIn.email.focus();
	        	document.SignIn.email.select();
	        });

		
	}
	
	
	if (psw == "") {
	
	divPsw.css("display","block");
	document.SignIn.psw.focus();
	
	Err = false;
	}
	
	if (psw != conferma) {
	
	divConferma.css("display","block");
	
	document.SignIn.conferma.value = "";
	document.SignIn.conferma.focus();
	
	Err = false;
	}
	
	
	
	
	
	if ( (nome.charAt(0)== " ") || (!isstring.test(nome)) || (nome == "") || (nome == "undefined")) {

	divNome.css("display","block");
	document.SignIn.nome.focus();
	
	Err = false;
	}
	
	if ((!isstring.test(cognome)) || (cognome == "") || (cognome == "undefined")) {
	
	divCognome.css("display","block");
	document.SignIn.cognome.focus();
	
	Err = false;
	}
	
	if ((paese == "") || (paese == "undefined")|| (paese == "paese")) {
	
	divPaese.css("display","block");
	document.SignIn.paese.focus();
	
	Err = false;
	}
	
	if ((isNaN(telefono)) || (telefono == "") || (telefono == "undefined") || (telefono.length != 10)) {
	
	divTelefono.css("display","block");
	
	document.SignIn.telefono.value = "";
	document.SignIn.telefono.focus();
	
	Err = false;
	}
	
	
	if ((indirizzodispedizione == "") || (indirizzodispedizione == "undefined") || (cap == "") || (cap.length != 5)) {
	
	divIndirizzodispedizione.css("display","block");
	document.SignIn.indirizzodispedizione.focus();
	
	Err = false;
	}
	if ((indirizzodifatturazione == "") || (indirizzodifatturazione == "undefined") || (capF == "") || (capF.length != 5)) {
	
	divIndirizzodifatturazione.css("display","block");
	document.SignIn.indirizzodifatturazione.focus();
	
	Err = false;
	}
	
	
	return Err;

	
	
	
	});	
	
});