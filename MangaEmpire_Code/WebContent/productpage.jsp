<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,Model.ProductBean"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<% ProductBean product = (ProductBean) request.getAttribute("product");%>
<title><%= product.getSerie() %> <%= product.getVolume() %></title>

<style>

<%@ include file="./Css/ProductPageLayout.css"  %>

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="./JScript/cartButton.js"></script>
<script type="text/javascript" src="./JScript/ProductCategory.js"></script>

</head>

<body>
	<jsp:include page="header.jsp" flush="true" />
	
	<div class= "page">
		<div>
		
			<img class= "copertina" src="<%= product.getCopertina() %>"> 
		
	 	</div>
		
		<div class= "titolo">
			<div id="categorie" value='<%= product.getISBN()%>' categorie>
				
			</div>
		
			<h1><%= product.getSerie() %> Vol.  <%= product.getVolume() %></h1>
		
			<h2>
	
			<%= product.getPrezzo()%> &euro;</h2> <button class="AddToCart" type="button" value='<%=ProductBean.stringify(product) %>'><img src="https://cdn-icons-png.flaticon.com/512/49/49969.png" class = "cart" width=50px height=auto; ></button>
			
			<% if(product.getQuantity() >0){ %>
			<h2 class="disponibili"><%= product.getQuantity()%> disponibili</h2>
	
	 		<%}else{%>
	 			
	 		<h2 style="color:red;"class="disponibili">Non disponibile</h2>
	 			
	 		<%	}	%>
	 	
	 	</div>
	 	
		

	</div>
	
	<div class= "descrizione">
		<h1>Descrizione</h1>
		
		<h3><%= product.getDescrizione() %></h3>
	</div>
	
	
	
	<jsp:include page="footer.jsp" flush="true" />
</body>
</html>