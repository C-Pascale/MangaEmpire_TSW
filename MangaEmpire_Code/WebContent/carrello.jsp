<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,Model.CarrelloBean,Model.ProductBean"%>
    
 <% 
 
 	request.getSession().removeAttribute("page");
	request.getSession().setAttribute("page","/carrello.jsp");
	
	AbstractMap<?,Collection<?>> ProductList = (AbstractMap<?,Collection<?>> ) request.getAttribute("ProductLists");
	if(ProductList == null) {
		response.sendRedirect("./lista_prodotti");	
		return;
	}	
	
	
%>  
      
    
    
    
<!DOCTYPE html>
<html>
<head>
<% 
CarrelloBean carrello = (CarrelloBean) request.getSession().getAttribute("carrello");
if(carrello == null){
	carrello = new CarrelloBean();
}

%>
<style type="text/css">
		<%@ include file="./Css/Carrello.css"  %>
</style>



<meta charset="ISO-8859-1">
<title>Carrello</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="./JScript/changeCart.js"></script>
<script type="text/javascript" src="./JScript/CarrelloDragScroll.js"></script>
<script type="text/javascript" src="./JScript/DragScrollConsigliati.js"></script>

</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
		 		
	<div class= "page">
	 	<div class="carrello">
	 		<a href="carrello?page=/carrello.jsp&action=empty" id="cestino" ><img src="https://i.imgur.com/7O3Mq1x.png" width=50px height=auto> </a> 	
	 	
	 	
	 	
	 	<%
	 			
			if (carrello != null && carrello.size() != 0) {
				Iterator<?> it = carrello.iterator();
				while(it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
			
	 		
	 	%>	
	 	
	 	<div class="prodottoCart" >
	 	
	 			<a href="product?action=read&id=<%=bean.getISBN()%>"><img src=<%=bean.getCopertina() %> class="copertina"> </a>
	 		<div class = "infoprodotto" >
	 		<button style="display:none" value="<%=bean.getISBN()%>" product></button>
	 			<h2 class="articolo"><%=bean.getSerie() +" Vol."+bean.getVolume() %>   </h2>
	 			<h2><%= bean.getPrezzo()%> &euro;    </h2>
	 			<h2>Quantità:    <input type="number" class="CartProductsQuantity" max="<%=bean.getQuantity()%>" value="<%= carrello.getQuantity(bean)%>">
	 			</h2>
	 		</div>
	 	</div> 	
	 		<a href="carrello?page=/carrello.jsp&action=remove&id=<%=bean.getISBN()%>" id="cestino" ><img src="https://i.imgur.com/7O3Mq1x.png" width=50px height=auto> </a>
	 	
	 	<%}}else{%>
	 		<div class="prodotto">
	 				 <h2>Ancora nessun prodotto inserito</h2>			
	 		</div> 	
	
	 	<%}%>
	 	</div>

		<div  class="totale">
			<%if (carrello.getTotale() > 0){ %>
			<h1>	TOTALE:<%=  carrello.getTotale() %></h1>
			<a href = "pagamento.jsp"><input type="button" class = "pulsanti" value = "Procedi col Pagamento ->"></a>	
			
			<%}else{%>
			<h1>TOTALE:0.00</h1>
			
			 	
		<%}%>
			
	</div>	
	</div>
<br>
		
<div class="consigliati">
	
	
	<h3 > CONSIGLIATI</h3>

	<div class= "container" id="consigliati"> 
			<%
			
			Collection<?> Suggestedproducts = ProductList.get("consigliati");

			if (Suggestedproducts != null && Suggestedproducts.size() != 0) {
				Iterator<?> it = Suggestedproducts.iterator();
				while(it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
					
					
		%>
				<figure><a href="product?action=read&id=<%=bean.getISBN()%>"><img class="copertina" src= "<%=bean.getCopertina()%>"></a>
				<figcaption class= "boxtitoli" ><a href="product?action=read&id=<%=bean.getISBN()%>" class= "titoli"><%=bean.getSerie() +" Vol."+bean.getVolume() %></a></figcaption><br>
				<div class= "prezzi"><%=bean.getPrezzo()%> &euro;
				<a  href="carrello?page=/carrello.jsp&action=add&id=<%=bean.getISBN()%>" onclick='addToCart()'><img class = "linkcarrello" src="https://cdn-icons-png.flaticon.com/512/49/49969.png"> </a>
				</div></figure>
		<% }}%>	
		
	</div>
	
	
	</div>
	
	

		

	<jsp:include page="footer.jsp" flush="true" />
</body>
</html>