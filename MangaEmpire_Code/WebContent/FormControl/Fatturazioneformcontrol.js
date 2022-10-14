$( document ).ready(function() {

	$("#submitF").click(function(){
			
		var indirizzodifatturazione = document.fatturazione.indirizzo.value;
		var cap = document.fatturazione.cap.value;
		var paese = document.fatturazione.paese.value;
		

		
		let divPaeseF = $(this).parent().find("#PaeseF");
		let divIndirizzodifatturazione = $(this).parent().find("#IndirizzoF");
		
		divIndirizzodifatturazione.css("display","none");
		divPaeseF.css("display","none");
		
		let Err = true;
		
		if ((paese == "") || (paese == "Paese")) {
	
			divPaeseF.css("display","block");
			document.fatturazione.paese.focus();
	
			Err = false;
		}
		
		if ((indirizzodifatturazione == "") || (indirizzodifatturazione == "undefined")) {
	
			divIndirizzodifatturazione.css("display","block");
	
			
			Err = false;
	
		}
		if ((cap == "") || (cap.length != 5)){
		
			divIndirizzodifatturazione.css("display","block");
		
			
			
			Err = false;
		}
	
	

		return Err;
	
	});
	
	
	
	

	
	
	
});