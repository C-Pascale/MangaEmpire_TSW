$( document ).ready(function() {

	
	var cardno = /^(?:3[47][0-9]{19})$/;
	
	var input = document.getElementById("numc");

	input.onkeyup = function () {
    	if (input.value.length == 4) {
		
        if (input.value.length % 4 == 0) {
            input.value += "-";

        }
    }else if (input.value.length > 5 && input.value.length < 16) {
	            if (input.value.length % 5 == 4) {
          			  input.value += "-";
        }
	}

	}	
	
	
	$("#reset").click(function(){

  		let divNome = $(this).parent().parent().parent().find("#Nome");
  		let divNumC = $(this).parent().parent().parent().find("#NumC");
  		let divMese = $(this).parent().parent().parent().find("#Mese");
  		let divCvv = $(this).parent().parent().parent().find("#Cvv");
  		let divSpedizione = $(this).parent().parent().parent().find("#Spedizione");
  		
  		divNome.css("display","none");
  		divNumC.css("display","none");
  		divMese.css("display","none");
  		divCvv.css("display","none");
  		divSpedizione.css("display","none");
		
	});
	
	$("#submit").click(function(){

		var nome = document.pagamento.nome.value;
		var numc = document.pagamento.numc.value;
		var data = document.pagamento.mese.value;
		var cvv = document.pagamento.cvv.value;
		var spedizione = document.pagamento.spedizione.value;
		
		let Err = true;
		
		var dateForm  = new Date(data);

		

  		
  		let divNome = $(this).parent().parent().parent().find("#Nome");
  		let divNumC = $(this).parent().parent().parent().find("#NumC");
  		let divMese = $(this).parent().parent().parent().find("#Mese");
  		let divCvv = $(this).parent().parent().parent().find("#Cvv");
  		let divSpedizione = $(this).parent().parent().parent().find("#Spedizione");
  		
  		divNome.css("display","none");
  		divNumC.css("display","none");
  		divMese.css("display","none");
  		divCvv.css("display","none");
        
      
	if (nome == "") {
		
		divNome.css("display","block");
		document.pagamento.nome.focus();
	
		Err = false;
	}
	
	if ((numc == "") || (numc.length != 19) || (!numc.value.test(cardno))  ) {
	
		divNumC.css("display","block");
		document.pagamento.numc.focus();
	
		Err = false;
	}
	
	if ((data == 0) || (data == "undefined") || (dateForm < Date.now())) {
		
				
			divMese.css("display","block");
			document.pagamento.mese.focus();
	
			Err = false;
		
	}
	
	if ((cvv == "") || (cvv < 3) || (isNaN(cvv))){
	
		divCvv.css("display","block");
		document.pagamento.cvv.focus();
	
		Err = false;
	}
	
	if (spedizione == "") {
		
		divSpedizione.css("display","block");
		document.pagamento.nome.focus();
	
		Err = false;
	}
	
	return Err


});
});