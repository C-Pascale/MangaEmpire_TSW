/**
 * 
 */
 $( document ).ready(function() {
	
	$(".login").click(function(){

		
	    let divParent = $(this).parent().find(".tendinautente");
	    			

	   if(divParent.css("display")== "block"){
		   divParent.css("display","none");
		   let lista = divParent.find(".tendina");
		   lista.css("display","none");
	    
	    }
	    else{
	    		

	    divParent.css("display","block");
	  
	    let lista = divParent.find(".tendina");
	    lista.css("display","block");
	    
	   
	    
	};

});
});