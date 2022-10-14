<%
// Check user credentials
	
UserBean user =(UserBean) request.getSession().getAttribute("User"); 

%>




<%@ page language="java" import="java.util.*,Model.UserBean" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MangaEmpire header</title>
<style>
	
	<%@ include file="./Css/HeaderFooterLayout.css"  %>	

</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript" src="./JScript/Searchbar.js"></script>
	<script type="text/javascript" src="./JScript/GetsSearched.js"></script>
	<script type="text/javascript" src ="./JScript/profiloInteractions.js"></script>
	
</head>

<body>


<div  class= "Header" >

			<div class= header2.0><a href ="MainPage.jsp">			
				<img class= "logo" src="https://i.imgur.com/NNwoGHW.png"></a>			
				<a class= "home" href ="MainPage.jsp">Home</a>
				<a class= "home" href ="product?action=listaCategory&categoria=none">Tutti i prodotti</a>
			 </div>
			
			<div>
				<input class= "searchbar" type="text" placeholder="Search.." id= "search">	
				<div class ="searchedElements" prodottoContainer>
					
					
					
				</div>		
				
				<img src="https://i.imgur.com/KfqIKkG.png" class="login" id="login" >
				
				<div class = "tendinautente"  tendinautente>
				
					<ul class = "tendina" tendina>
					<% if (user == null){ %>
					<li class = "children"><a href= "login-form.jsp"><button class="tasto">Log In</button></a>
					<li class = "children"><a href= "SignIn.jsp"><button class="tasto">Sign In</button></a>
					<%}if (user!= null){ %>
						<%if(user.getAdmin() == true) { %>
						<li class = "children"><a href= "ListaUtenti.jsp"><button class="tasto">Lista Utenti</button></a>
						<li class = "children"><a href= "catalogoAdmin.jsp"><button class="tasto">Catalogo</button></a>
						<%} %>
					<li class = "children"><a href= "protected.jsp"><button class="tasto">Area Utente</button></a>
					<li class = "children"><a href= "Logout"><button class="tasto">Log Out</button></a>
					<%} %>
					</ul>
			
				</div>

				<a href ="carrello.jsp"><img src=https://i.imgur.com/ITmnQjr.png class= "carrelloheader"></a>
			
			</div>
</div>
			<template prodottoTemplate>
				<div class ="element" element>
					<a class ="linkProd" linkProd>
						<div class = "immagine" dataimg> </div>
						<div class= "informazioni" datainf></div>
					</a>		
				</div>
			
			</template>

</body>

</body>
</html>