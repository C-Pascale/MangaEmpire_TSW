/**

 * 
 */
$(document).ready(function(){
	
	$(".AddToCart").click(function(){
		
		
		
	
			let img = $(this);
			if(img.css("background-color") != "#00BB2D"){
				img.css("background-color","#00BB2D");
			}
	
			let product = $(this).val();
			
			$.get('Additem', {"product" : product},
				function(res) { // on sucess	
				
			})
		    .fail(function() { // on failure

		    });
		
	});
	
	
});
		




	