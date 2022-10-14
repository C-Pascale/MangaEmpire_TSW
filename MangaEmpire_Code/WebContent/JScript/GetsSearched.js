/**
 * 
 */

 $( document ).ready(function() {
	 
	 
	 $("#search").on("keyup", function() {
		
		 	let divParent = $(this).parent().find(".searchedElements");
		 	 $(this).parent().find(".tendinautente").css("display","none");

		 	
		    let value = $(this).val().toLowerCase(); 
		    if (value.length > 0){
			divParent.css("border","solid");
			
		    
		    }
		  else{
			
			divParent.css("border","none");
		   
		}
		    
		    let elements = divParent.find(".element");
		    elements.css("display","none");
		    
		 
		    for(let i = 0 ; i < elements.length ; i++ ){
		    	
		    	let element = divParent.children(0).eq(i);
		    			    	
		    	let nome = element.find(".informazioni").text();
		    	
		    	if(nome.toLowerCase().includes(value) && value.length != 0 ){
		 				element.css("display","flex");
	 			}
		    	    	
		    }
		    
		    

	 })
	 
	 
	 
})