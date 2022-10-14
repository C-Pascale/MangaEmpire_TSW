$( document ).ready(function() {
	
	var isstring = /^[\sA-Za-z]+$/
	let Err = true;
	
	$("#pswOld").click(function(){
		$(this).parent().find("#PswOld").css("display","none");
		Err = true;			
	});
	
	
	$("#pswOld").on('blur',function(){
		let pswOld = document.SignIn.pswOld.value;
		let email = document.SignIn.email.value;
	
		let divPswOld = $(this).parent().find("#PswOld");
		Err = true;
		if (pswOld == "") {
			
			divPswOld.css("display","block");

			
			Err = false;
			}else{
				$.get('CheckPassword', {"email" : email},
						function(res) { // on success	
						if(JSON.parse(res) != pswOld){
							Err = false;
							divPswOld.css("display","block");
				
					
						}
						
					})
			        .fail(function() { // on failure
						alert("fail");
			        	Err = false;
			        	divPswOld.css("display","block");
	

			        });

				
			}
		

	});
	
	
	$("#reset").click(function(){
		
	let divPswOld = $(this).parent().find("#PswOld");
	let divPsw = $(this).parent().find("#Psw");
	let divConferma = $(this).parent().find("#Conferma");
	let divNome = $(this).parent().find("#Nome");
	let divCognome = $(this).parent().find("#Cognome");
	let divTelefono = $(this).parent().find("#Telefono");
	


	divPswOld.css("display","none");
	divPsw.css("display","none");
	divConferma.css("display","none");
	divNome.css("display","none");
	divCognome.css("display","none");
	divTelefono.css("display","none");
		
	});
	
	$("#submit").click(function(){
	

	var pswOld = document.SignIn.pswOld.value;
	var psw = document.SignIn.psw.value;
	var conferma = document.SignIn.conferma.value;
	var nome = document.SignIn.nome.value;
	var cognome = document.SignIn.cognome.value;
	var telefono = document.SignIn.telefono.value;
	
	

	let divPswOld = $(this).parent().find("#PswOld");
	let divPsw = $(this).parent().find("#Psw");
	let divConferma = $(this).parent().find("#Conferma");
	let divNome = $(this).parent().find("#Nome");
	let divCognome = $(this).parent().find("#Cognome");
	let divTelefono = $(this).parent().find("#Telefono");
	


	divPswOld.css("display","none");
	divPsw.css("display","none");
	divConferma.css("display","none");
	divNome.css("display","none");
	divCognome.css("display","none");
	divTelefono.css("display","none");

			
	
	if (psw != "" && psw != conferma ) {
	
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

	if ((isNaN(telefono)) || (telefono == "") || (telefono == "undefined") || (telefono.length != 10)) {
	
	divTelefono.css("display","block");
	
	document.SignIn.telefono.value = "";
	document.SignIn.telefono.focus();
	
	Err = false;
	}
	
	return Err;

	
	
	
	});	
	
});