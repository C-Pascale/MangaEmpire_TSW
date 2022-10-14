/**
 * 
 */
 $( document ).ready(function() {

	
		
	 	
	 	let email = document.querySelector("[emailLogin]");
	 	let psw = document.querySelector("[pswLogin]");
	 	if(email!=null){
	 		email.style.display = "block";
	 		psw.style.display = "block";
	 	}
	 	
	 	
		let pwShown = 0;
		let CpwShown = 0;

$("#eye").click(function(){
		

	if (pwShown == 0) {
        pwShown = 1;
        
        $("#password").prop('type', 'text');
        $("#mostra").attr("src","https://i.imgur.com/VXWadFc.png");
        if ( document.URL.includes("login-form.jsp") ) {
    

        	document.login.password.focus();
        }else if( document.URL.includes("SignIn.jsp") ){
			document.SignIn.psw.focus();
	}
    } else {
        pwShown = 0;
        $("#password").prop('type', 'password');
        $("#mostra").attr("src","https://i.imgur.com/t85zx0r.png");
       	
        if ( document.URL.includes("login-form.jsp") ) {
    

        	document.login.password.focus();
        }else if( document.URL.includes("SignIn.jsp") ){
			document.SignIn.psw.focus();
	}
        
    }
});

$("#eyeConferma").click(function(){
	

	if (CpwShown == 0) {
		CpwShown = 1;
        $("#conferma").prop('type', 'text');
        $("#mostraConferma").attr("src","https://i.imgur.com/VXWadFc.png");
        
        document.SignIn.conferma.focus();
    } else {
    	CpwShown = 0;
        $("#conferma").prop('type', 'password');
        $("#mostraConferma").attr("src","https://i.imgur.com/t85zx0r.png");
        
        document.SignIn.conferma.focus();
    }
});



});