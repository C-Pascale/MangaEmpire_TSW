<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,Model.ProductBean"%>
 
 
 <%  	
 	request.getSession().removeAttribute("page");
	request.getSession().setAttribute("page","/MainPage.jsp");
	
	AbstractMap<?,Collection<?>> ProductList = (AbstractMap<?,Collection<?>> ) request.getAttribute("ProductLists");
	if(ProductList == null) {
		response.sendRedirect("./lista_prodotti");	
		return;
	}				
%>  
   
 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>MainPage</title>

<style type="text/css">
	<%@ include file="./Css/Layout.css"  %>
</style>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="./JScript/cartButton.js"></script>
<script type="text/javascript" src="./JScript/DragScrollNovita.js"></script>
<script type="text/javascript" src="./JScript/DragScrollPopolari.js"></script>
<script type="text/javascript" src="./JScript/DragScrollConsigliati.js"></script>


</head>
<body class= "allbody">
	<jsp:include page="header.jsp" flush="true" />
	<img class="banner" src="https://t4.ftcdn.net/jpg/04/04/73/39/360_F_404733910_2mIXr6RbC5G3WZJFjopVsBaR3EOM6Bqy.jpg">
	
	<div class="menu">
		<a href ="product?categoria=action&action=listaCategory"> <input type="submit" class ="category" value="ACTION"></a>
		<a href ="product?categoria=comedy&action=listaCategory"> <input type="submit" class ="category" value="COMEDY"></a>	
		<a href ="product?categoria=fantasy&action=listaCategory"> <input type="submit" class ="category" value="FANTASY"></a>	
		<a href ="product?categoria=horror&action=listaCategory"> <input type="submit" class ="category" value="HORROR"></a>	
		<a href ="product?categoria=isekai&action=listaCategory"> <input type="submit" class ="category" value="ISEKAI"></a>
		<a href ="product?categoria=RomCom&action=listaCategory"> <input type="submit" class ="category" value="ROMCOM"></a>
	</div>
	
	
	 <h2 >	NOVITA' </h2>
	 <div class= "container" id="novita">
		
		
					<%
			Collection<?> Newproducts = ProductList.get("novita");
			
			if (Newproducts != null && Newproducts.size() != 0) {
				Iterator<?> it = Newproducts.iterator();
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
			<br>
			

	<h2 > PIU' VENDUTI</h2>
		 <div class= "container" id="popolari">  
			<%
			Collection<?> Popularproducts = ProductList.get("popolari");
			
			if (Popularproducts != null && Popularproducts.size() != 0) {
				Iterator<?> it = Popularproducts.iterator();
				while(it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
				
		%>
				<figure><a href="product?action=read&id=<%=bean.getISBN()%>"><img class="copertina" src= "<%=bean.getCopertina()%>"></a>
				<figcaption class= "boxtitoli"><a href="product?action=read&id=<%=bean.getISBN()%>" class= "titoli"><%=bean.getSerie() +" Vol."+bean.getVolume() %></a></figcaption><br>
				<div class= "prezzi"><%=bean.getPrezzo()%> &euro;   
				<button class="AddToCart" type="button" value='<%=ProductBean.stringify(bean) %>'><img src="https://cdn-icons-png.flaticon.com/512/49/49969.png" class= "cart" width=50px height=auto;> </button>
				</div></figure>
		<% } }%>	
		
	</div>
	<br>
	
	<h2 > CONSIGLIATI</h2>
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
				<button class="AddToCart" type="button" value='<%=ProductBean.stringify(bean) %>'><img src="https://cdn-icons-png.flaticon.com/512/49/49969.png" class= "cart" width=50px height=auto;> </button>
				</div></figure>
		<% } }%>	
		
	</div>


<jsp:include page="footer.jsp" flush="true" />
</body>
</html>
