/**
 * 
 */
$(document).ready(function(){
	
	
		
		$.get('category',
				function(res) { // on success					
				
 				const category = JSON.parse(res);

 				PopolaSel(category);		
 				
 				
			})
		    .fail(function() { // on failure
		    	alert("fail")
		    });
		
		
		
			function PopolaSel(category){
				 
				 
				 let select1 = document.querySelector("[categoria1]");
				 let select2 = document.querySelector("[categoria2]");
				 let select3 = document.querySelector("[categoria3]");
				 let select4 = document.querySelector("[categoria4]");

				if(select1 != null){		
					let product = document.querySelector("[isbn]");
					$.get('ProductCategory', {"product" : product.value} ,
						function(res) { // on success					
									
					 		const Precategory = JSON.parse(res);
					 				
					 		
					 		 let Preoption = document.querySelector("[PreCategory1]");
							 let Preoption2 = document.querySelector("[PreCategory2]");
							 
							  Preoption.setAttribute('value',Precategory[0] );
							  let PreoptionText = document.createTextNode(Precategory[0] );
							  Preoption.appendChild(PreoptionText);

				          
			
				            if(Precategory[1] != null){			                
				                Preoption2.setAttribute('value',Precategory[1] );
				                let PreoptionText2 = document.createTextNode(Precategory[1]);
				                Preoption2.appendChild(PreoptionText2);
				            	}	                    	  
				                    	            				 				
								})
							    .fail(function() { // on failure
							    	alert("fail")
							    });
						 
						 
					 }
				 
				 for (let i = 0; i < category.length; i++) {
					 
					  if(select1 != null){			  

                      let option = document.createElement("option");
                      option.setAttribute('value',category[i] );

                      let optionText = document.createTextNode(category[i] );
                      option.appendChild(optionText);

                      select1.appendChild(option);

                      let option2 = document.createElement("option");
                      option2.setAttribute('value',category[i] );

                      let optionText2 = document.createTextNode(category[i]);
                      option2.appendChild(optionText2);

                      select2.appendChild(option2);

                     }
					  
					  let option3 = document.createElement("option");
					  option3.setAttribute('value',category[i] );

					  let optionText3 = document.createTextNode(category[i]);
					  option3.appendChild(optionText3);

					  select3.appendChild(option3);
					  
					  let option4 = document.createElement("option");
					  option4.setAttribute('value',category[i] );

					  let optionText4 = document.createTextNode(category[i]);
					  option4.appendChild(optionText4);

					  select4.appendChild(option4);
					 					  
				}


					
			}

	
	
});
		



