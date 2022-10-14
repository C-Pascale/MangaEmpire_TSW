/**

 * 
 */
$(document).ready(function(){
	
		
	$(".CartProductsQuantity").on('change', function() {

		let productQuantity = $(this).val();


		let product = document.querySelector("[product]");

		
		
		$.get('ChangeQuantity', {"product" : product.value , "productQuantity" : productQuantity},
				function(res) { // on success	

			})
	        .fail(function() { // on failure
	        	});
	     });


		
		
	
});
