/**
 * 
 */
$(document).ready(function(){
	
	
		let divCategory = document.querySelector("[categorie]");
		let product = divCategory.getAttribute('value');;
		
		$.get('ProductCategory',{"product" : product},
				function(res) { // on success					
				
 				const category = JSON.parse(res);
 			
 				StampaCat(category);		
 				
			})
		    .fail(function() { // on failure
		    	alert("fail")
		    });
		
		
		
			function StampaCat(category){
				 let divstampa = document.querySelector("[categorie]");
				 
				 for (let i = 0; i < category.length; i++) {
					 
					  let C1 = document.createElement("h2");
					  C1.textContent = category[i];	
					  divstampa.appendChild(C1);
					  

					}
					
			}

	
	
});
		



