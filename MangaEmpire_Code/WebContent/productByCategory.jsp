<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,Model.*"%>
<% 

	
Collection<?> products = (Collection<?>) request.getAttribute("prodottiCategory");

    
    
%>     
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Prodotti</title>

<style>

<%@ include file="./Css/productByCategory.css"  %>

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="./JScript/cartButton.js"></script>
</head>
<body>
<jsp:include page="header.jsp" flush="true" />


<%
	String category = (String)request.getAttribute("categoria");
	if(category==null || category.equals("none")){
	%>
		<h1>Tutti i prodotti</h1>
		
		
	<% }else{%>
		<h1><%=category%></h1>

<%}%>

 <div class= "container">


		
	<%
			
			
			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while(it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
					
		%>
				<figure><a href="product?action=read&id=<%=bean.getISBN()%>"><img class="copertina" src= "<%=bean.getCopertina()%>"></a>
				<figcaption class= "boxtitoli" ><a href="product?action=read&id=<%=bean.getISBN()%>" class= "titoli"><%=bean.getSerie() +" Vol."+bean.getVolume() %></a></figcaption><br>
				<div class= "prezzi"><%=bean.getPrezzo()%> &euro;   
					<button class="AddToCart" type="button" value='<%=ProductBean.stringify(bean) %>'><img src="https://cdn-icons-png.flaticon.com/512/49/49969.png" class = "cart" width=50px height=auto; ></button>

				</div></figure>
				
				
				
				
		<% } }%>

</div>
<jsp:include page="footer.jsp" flush="true" />
</body>
</html>