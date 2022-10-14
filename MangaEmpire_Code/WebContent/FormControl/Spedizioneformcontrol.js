$( document ).ready(function() {

	$("#submitS").click(function(){
			
		var indirizzodispedizione = document.spedizione.indirizzo.value;
		var cap = document.spedizione.cap.value;
		var paese = document.spedizione.paese.value;
		

		
		let divPaeseS = $(this).parent().find("#PaeseS");
		let divIndirizzodispedizione = $(this).parent().find("#IndirizzoS");
		
		divIndirizzodispedizione.css("display","none");
		divPaeseS.css("display","none");
		
		let Err = true;
		
		if ((paese == "") || (paese == "Paese")) {
	
			divPaeseS.css("display","block");
			document.spedizione.paese.focus();
	
			Err = false;
		}
		
		if ((indirizzodispedizione == "") || (indirizzodispedizione == "undefined")) {
	
			divIndirizzodispedizione.css("display","block");
	
			
			Err = false;
	
		}
		if ((cap == "") || (cap.length != 5)){
		
			divIndirizzodispedizione.css("display","block");
		
			
			
			Err = false;
		}

		return Err;
	
	});
	
	
	
	

	
	
	
});