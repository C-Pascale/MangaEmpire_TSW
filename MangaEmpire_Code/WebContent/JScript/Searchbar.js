

 $( document ).ready(function() {


		 		 
	 		$.get('getProductJson',
					function(res) { // on success					
	 			
	 				const products = JSON.parse(res);
	 				search(products);			
	 				
				})
			    .fail(function() { // on failure
			    	alert("fail")
			    });
	 		

	
	 	
	 	
			function search(products){
				
				const template = document.querySelector("[prodottoTemplate]");
			 	const prodottoContainer = document.querySelector("[prodottoContainer]");
				
				 for (let i = 0; i < products.length; i++) {
		 				let copertina = (products[i].copertina) ;
		 				let nome = (products[i].serie) + " " + JSON.stringify(products[i].volume);
		 				let prezzo = "\u20AC" + " " + + JSON.stringify(products[i].prezzo) ;
		 				let ISBN = (products[i].ISBN);
		 				
		 		
		 				
		 				const element = template.content.cloneNode(true).children[0];
		 				
		 				const a = element.querySelector("[linkProd]");
		 				
		 				const img = element.querySelector("[dataimg]");
		 				var image = document.createElement("img");
		 				image.src = copertina ;
		 				image.className = "immagine";	 				
		 				img.append(image);
		 		
		 				const info = element.querySelector("[datainf]");
		 				info.textContent = nome;
		 				info.append("  " + prezzo );
		 				
		 				
		 				a.href = "product?action=read&id=" + ISBN ;

		 				
		 				prodottoContainer.append(element);
		 				
		 			 }
 			}			

});
	 	
