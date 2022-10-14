$( document ).ready(function() {

			 $("#input").on("keyup", function() {
				 let table = document.querySelector("[table]");
				 const tr = table.getElementsByClassName("tbody");
				 let searchInput = document.querySelector("[search]");
				 let value = $(this).val().toLowerCase();
				 let trovati=0;
				 
				 for (let i = 0; i < tr.length; i++) {
					 
						let tds = tr[i].getElementsByTagName("td");
			
						if (tds) {
							
							let txtValue = " ";
							
							 for (let i = 0; i < tds.length; i++) {
								 	
								 	let Tcont = " " + tds[i].textContent;
								 	txtValue += Tcont;
							
							
							 }
							
							if (txtValue.toLowerCase().includes(value) && value.length != 0) {
								 trovati= trovati+1;
								 tr[i].style.display = "";
							} else {
			    		        tr[i].style.display = "none";
			    		      }
				  
						}
					}
					
				 if(trovati == 0){
					 for (let i = 0; i < tr.length; i++) {
						 tr[i].style.display = "";
					 }
					 
				 }
				 
			
			 });
			 
		


	
		
	 
	 $(".info").click(function(){
		 
		 let user = $(this).val();
		 
		 const tables = document.getElementsByClassName("prodotti");
		 
		 for (let i = 0; i < tables.length; i++) {
			 
			 let CurrentTable =  tables[i];
			 
			 if(CurrentTable.value == user){
				let TabP =  CurrentTable.nextElementSibling;
				if( TabP.style.display == "flex" ){
					TabP.style.display = "none";
				}else{
					TabP.style.display = "flex";
				}
				
		
				
			 }
			 
			 	
			 
		 } 
	 });
	 
	 
	 $(".checkDate").click(function(){
		 
		 let Inputdates = $(this).parent().find("input");
		 
		let start = new Date(Inputdates[0].value);	
		let finish = new Date(Inputdates[1].value);
		let orders = document.querySelector("[ordine]");
		let trO = orders.getElementsByTagName("tr");
		
		if(start<finish && start != null && finish != null){
			


		
		 for (let i = 0; i < trO.length; i++) {
			 let dateTab = trO[i].getElementsByClassName("data")[0];
			 if(dateTab!=null){
				 let data= new Date(dateTab.textContent);	
				 
				 if(data<start || data >finish){
				        trO[i].style.display = "none";
				 }
				 
			 }

		 }
		
		
		}else{
			for (let i = 0; i < trO.length; i++) {
				
				 trO[i].style.display = "";
				
			}
				
			
		}

	 });
	 
	 
});
	


	
		
		 


	    
	    		    
	    		    
	    		     
	    		      
	    		

	  




  	
