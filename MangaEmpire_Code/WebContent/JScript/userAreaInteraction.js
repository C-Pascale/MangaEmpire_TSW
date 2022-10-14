$( document ).ready(function() {	
	
	let tables = document.getElementsByClassName("hidden");
	for(let i=0;i<tables.length;i++){
		let rows = tables[i].getElementsByTagName("tr");
		
		for(let i=0;i<rows.length;i++){
			let nome = rows[i].getElementsByClassName("nome")[0];
			if(nome!=null){
		
			$.get('getProdfromNome',{"product" : nome.textContent},
				function(res) { // on success						
		 			const prod = JSON.parse(res);
		 			if(prod.copertina!=null){
		 				let copertina=rows[i].getElementsByClassName("copertina")[0];
		 				let a = document.createElement("a");
		 				a.setAttribute("href", "product?action=read&id=" + prod.ISBN);
		 				let Img = document.createElement("img");
		 				Img.setAttribute("src", prod.copertina);
		 				Img.className = "immagine";	 
		 				a.appendChild(Img)						
		 				copertina.appendChild(a);
		 			}
		 
				})
				.fail(function() { // on failure
				    	alert("fail")
				 });
				
			}		
		}
		
	}
	
	
		$(".paese").on("blur",function(){
	
				let paese = $(this).val();
				
				let text =$(this).next();
				text.val(paese);			
		});

	
	
		$(".paese").click(function(){
			let paese = $(this).val();
			
			let text =$(this).next();
			text.val(paese);			
		 });

		 $("#spedizione").click(function(){
				document.querySelector("[spedizione]").style.display = "none";
				document.querySelector("[fatturazione]").style.display = "none";
				document.querySelector("[inserimentoS]").style.display = "";
			 });
			 
		 $("#fatturazione").click(function(){
				document.querySelector("[fatturazione]").style.display = "none";
				document.querySelector("[spedizione]").style.display = "none";
				document.querySelector("[inserimentoF]").style.display = "";	 
		 });
		 
	
	 
	 $(".dettagli").click(function(){
		 let table = $(this).parent().parent().parent().parent().next();
		 if(table.css("display") == "none"){
			 table.css("display","block");
		}else{
			table.css("display","none")
		}		 
	 });
	 
	let OldpwShown = 0;
	let pwShown = 0;
	let ConpwShown = 0;
	
	 $("#eyeOld").click(function(){
	
		if(OldpwShown == 0) {
			OldpwShown = 1;
			$("#pswOld").prop('type', 'text');
			$("#mostraOld").attr("src","https://i.imgur.com/zkiMx4y.png");
		 }else {
			 OldpwShown = 0;
			$("#pswOld").prop('type', 'password');
			
			$("#mostraOld").attr("src","https://i.imgur.com/t85zx0r.png");
		 }
		
	 });
	 
	 $("#eyePsw").click(function(){

			if(pwShown == 0) {
				pwShown = 1;
				$("#password").prop('type', 'text');
				$("#mostraPsw").attr("src","https://i.imgur.com/zkiMx4y.png");
			 }else {
				 pwShown = 0;
				$("#password").prop('type', 'password');
				$("#mostraPsw").attr("src","https://i.imgur.com/t85zx0r.png");
			 }
	 });
	 
	 $("#eyeConferma").click(function(){

			if(ConpwShown == 0) {
				ConpwShown = 1;
				$("#conferma").prop('type', 'text');
				$("#mostraConferma").attr("src","https://i.imgur.com/zkiMx4y.png");
			 }else {
				 ConpwShown = 0;
				$("#conferma").prop('type', 'password');
				$("#mostraConferma").attr("src","https://i.imgur.com/t85zx0r.png");
			 }	 
	 });
	 
	 
	 
	 
});
