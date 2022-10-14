$( document ).ready(function() {
	
	var isLink = /^(?:(?:https?|ftp):\/\/)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/\S*)?$/;
	var isFloat = /(^-?\d\d*\.\d\d*$)|(^-?\.\d\d*$)/;
	
	
	$("#reset").click(function(){
		
		let divISBN = $(this).parent().find("#ISBN");
	let divPrezzo = $(this).parent().find("#Prezzo");
	let divAutore = $(this).parent().find("#Autore");
	let divQuantity = $(this).parent().find("#Quantity");
	let divSerie = $(this).parent().find("#Serie");
	let divVolume = $(this).parent().find("#Volume");
	let divDescrizione = $(this).parent().find("#Descrizione");
	let divCopertina = $(this).parent().find("#Copertina");
	let divCategoria1 = $(this).parent().find("#Categoria1");
	

	divISBN.css("display","none");
	divPrezzo.css("display","none");
	divAutore.css("display","none");
	divQuantity.css("display","none");
	divSerie.css("display","none");
	divVolume.css("display","none");
	divDescrizione.css("display","none");
	divCopertina.css("display","none");
	divCategoria1.css("display","none");
		
	});
				
	$("#submit").click(function(){
	var isbn = document.insertForm.isbn.value;
	var prezzo = document.insertForm.prezzo.value;
	var autore = document.insertForm.autore.value;
	var quantity = document.insertForm.quantity.value;
	var serie = document.insertForm.serie.value;
	var volume = document.insertForm.volume.value;
	var descrizione = document.insertForm.descrizione.value;
	var copertina = document.insertForm.copertina.value;
	var categoria1 = document.insertForm.categoria1.options[document.insertForm.categoria1.selectedIndex].value;
	var ISBN = document.insertForm.ISBN.value;

	
	let divISBN = $(this).parent().find("#ISBN");
	let divPrezzo = $(this).parent().find("#Prezzo");
	let divAutore = $(this).parent().find("#Autore");
	let divQuantity = $(this).parent().find("#Quantity");
	let divSerie = $(this).parent().find("#Serie");
	let divVolume = $(this).parent().find("#Volume");
	let divDescrizione = $(this).parent().find("#Descrizione");
	let divCopertina = $(this).parent().find("#Copertina");
	let divCategoria1 = $(this).parent().find("#Categoria1");
	

	divISBN.css("display","none");
	divPrezzo.css("display","none");
	divAutore.css("display","none");
	divQuantity.css("display","none");
	divSerie.css("display","none");
	divVolume.css("display","none");
	divDescrizione.css("display","none");
	divCopertina.css("display","none");
	divCategoria1.css("display","none");
	
	
	let Err = true;
	
	if ((isbn == "") || (isbn == "undefined")) {
	
	document.insertForm.ISBN.value = "Inserire un Isbn valido*";
	
	divISBN.css("display","block");
	
	document.insertForm.isbn.focus();
	document.insertForm.isbn.select();
	
	Err = false;
	
	}else if(isNaN(isbn)){
		
		document.insertForm.ISBN.value = "Solo valori numerici*";
		
		divISBN.css("display","block");
		
		
		document.insertForm.isbn.focus();
	}else if(isbn.length < 13){
		
		document.insertForm.ISBN.value = "Isbn troppo corto*";
		
		divISBN.css("display","block");
		
		
		document.insertForm.isbn.focus();
	}else{


        $.get('CheckISBN', {"isbn" : isbn},
                function(res) { // on success

                if(res=="false"){
                    Err = false;
                    divISBN.css("display","block");
                    document.insertForm.isbn.focus();
                    document.insertForm.isbn.select();
                }

            })
            .fail(function() { // on failure

                Err = false;
                divISBN.css("display","block");
                document.SignIn.isbn.focus();
                document.SignIn.isbn.select();
            });

    }
		
	
	
	
	if ((prezzo == "") || (prezzo == "0") || (!isFloat.test(prezzo))) {
	
	divPrezzo.css("display","block");
	
	document.insertForm.prezzo.focus();
	
	Err = false;

	}
	
	if ((descrizione == "") || (descrizione == "undefined")) {
	
	
	divDescrizione.css("display","block");
	
	document.insertForm.descrizione.focus();
	
	Err = false;
	}
	
	if ((copertina == "") || (copertina == "undefined") || (!isLink.test(copertina))) {
	
	divCopertina.css("display","block");
	document.insertForm.copertina.focus();
	
	Err = false;
	}
	
	
	if ((categoria1 == "") || (categoria1 == "undefined") || (categoria1 == "Seleziona almeno una Categoria")) {
	
	divCategoria1.css("display","block");
	document.insertForm.categoria1.focus();
	
	Err = false;
	}
	if (autore == "") {
	
	
	divAutore.css("display","block");
	
	document.insertForm.autore.focus();
	
	Err = false;
	}
	
	
	if ((isNaN(quantity)) || (quantity == "0") || (quantity == "") || (quantity == "undefined")) {

	divQuantity.css("display","block");
	document.insertForm.quantity.focus();
	
	Err = false;
	}
	
	if ((serie == "") || (serie == "undefined")) {
	
	divSerie.css("display","block");
	document.insertForm.serie.focus();
	
	Err = false;
	}
	
	if ((isNaN(volume)) || (volume == "")|| (volume == "0") || (volume == "undefined")) {
	
	divVolume.css("display","block");
	document.insertForm.volume.focus();
	
	Err = false;
	}
	
	
	
	
	
	return Err;

	
	
	
	});	
	
});