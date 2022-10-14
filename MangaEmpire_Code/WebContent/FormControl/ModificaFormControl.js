$( document ).ready(function() {


	var isLink = /^(?:(?:https?|ftp):\/\/)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/\S*)?$/;
	var isFloat = /(^-?\d\d*\.\d\d*$)|(^-?\,\d\d*$)/;
	
	$("#resetM").click(function(){
		
		let divPrezzoM = $(this).parent().find("#PrezzoM");
	let divAutoreM = $(this).parent().find("#AutoreM");
	let divQuantityM = $(this).parent().find("#QuantityM");
	let divSerieM = $(this).parent().find("#SerieM");
	let divVolumeM = $(this).parent().find("#VolumeM");
	let divDescrizioneM = $(this).parent().find("#DescrizioneM");
	let divCopertinaM = $(this).parent().find("#CopertinaM");
	let divCategoria1M = $(this).parent().find("#Categoria1M");
	

	
	divPrezzoM.css("display","none");
	divAutoreM.css("display","none");
	divQuantityM.css("display","none");
	divSerieM.css("display","none");
	divVolumeM.css("display","none");
	divDescrizioneM.css("display","none");
	divCopertinaM.css("display","none");
	divCategoria1M.css("display","none");
		
	});
				
	$("#submitM").click(function(){

	var prezzoM = document.modifica.prezzoM.value;
	var autoreM = document.modifica.autoreM.value;
	var quantityM = document.modifica.quantityM.value;
	var serieM = document.modifica.serieM.value;
	var volumeM = document.modifica.volumeM.value;
	var descrizioneM = document.modifica.descrizioneM.value;
	var copertinaM = document.modifica.copertinaM.value;
	var categoria1M = document.modifica.categoria1M.options[document.modifica.categoria1M.selectedIndex].value;
	

	
	let divPrezzoM = $(this).parent().find("#PrezzoM");
	let divAutoreM = $(this).parent().find("#AutoreM");
	let divQuantityM = $(this).parent().find("#QuantityM");
	let divSerieM = $(this).parent().find("#SerieM");
	let divVolumeM = $(this).parent().find("#VolumeM");
	let divDescrizioneM = $(this).parent().find("#DescrizioneM");
	let divCopertinaM = $(this).parent().find("#CopertinaM");
	let divCategoria1M = $(this).parent().find("#Categoria1M");
	

	
	divPrezzoM.css("display","none");
	divAutoreM.css("display","none");
	divQuantityM.css("display","none");
	divSerieM.css("display","none");
	divVolumeM.css("display","none");
	divDescrizioneM.css("display","none");
	divCopertinaM.css("display","none");
	divCategoria1M.css("display","none");
	
	
	let Err = true;
		


	if ((prezzoM == "") || (prezzoM == "0") || (!isFloat.test(prezzoM))) {
	
	divPrezzoM.css("display","block");
	
	document.modifica.prezzoM.focus();
	
	Err = false;


	}
	
	if ((descrizioneM == "") || (descrizioneM == "undefined")) {
	
	
	divDescrizioneM.css("display","block");
	
	document.modifica.descrizioneM.focus();
	
	Err = false;
	

	}
	
	if ((copertinaM == "") || (copertinaM == "undefined") || (!isLink.test(copertinaM))) {
	
	divCopertinaM.css("display","block");
	document.modifica.copertinaM.focus();
	
	Err = false;


	}
	
	
	if ((categoria1M == "") || (categoria1M == "undefined") || (categoria1M == "Seleziona almeno una Categoria")) {
	
	divCategoria1M.css("display","block");
	document.modifica.categoria1M.focus();
	
	Err = false;


	}
	if (autoreM == "") {
	
	
	divAutoreM.css("display","block");
	
	document.modifica.autoreM.focus();
	
	Err = false;


	}
	
	
	if ((isNaN(quantityM)) || (quantityM == "0") || (quantityM == "") || (quantityM == "undefined")) {

	divQuantityM.css("display","block");
	document.modifica.quantityM.focus();
	
	Err = false;


	}
	
	if ((serieM == "") || (serieM == "undefined")) {
	
	divSerieM.css("display","block");
	document.modifica.serieM.focus();
	
	Err = false;


	}
	
	if ((isNaN(volumeM)) || (volumeM == "")|| (volumeM == "0") || (volumeM == "undefined")) {
	
	divVolumeM.css("display","block");
	document.modifica.volumeM.focus();
	
	Err = false;


	}
	
	
	
	
	return Err;

	
	
	
	});	
	
});