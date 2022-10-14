<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,Model.ProductBean,Model.UserBean"%>

<%
request.getSession().removeAttribute("page");
request.getSession().setAttribute("page","/catalogoAdmin.jsp");

// Check user credentials
Boolean adminRoles = (Boolean) session.getAttribute("adminRoles");
if ((adminRoles == null) || (!adminRoles.booleanValue()))
{	
    response.sendRedirect("./loginerror.jsp");
    return;
}

UserBean user = (UserBean)session.getAttribute("User");
if ((user == null) || (!user.getAdmin()))
{	
    response.sendRedirect("./loginerror.jsp");
    return;
}

Collection<?> products = (Collection<?>) request.getAttribute("products");
if(products == null) {
	response.sendRedirect("./product");	
	return;
}


ProductBean product = (ProductBean) request.getAttribute("product");

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CatalogoAdmin</title>
<style>

<%@ include file="./Css/Layout.css"  %>

</style>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="./JScript/catalogo.js"></script>
<script src = "./FormControl/CatalogoformControl.js"></script>
<script src = "./FormControl/modificaFormControl.js"></script>

</head>
<body>

<jsp:include page="header.jsp" flush="true" />

<h2>Catalogo</h2>
	<table border="1">
		<tr>
			<th><a href="product?sort=ISBN">ISBN &#8645;</a></th>
			<th>Prezzo</th>
			<th> <a href="product?sort=autore">Autore &#8645;</a></th>
			<th>Quantit&agrave</th>
			<th><a href="product?sort=serie">Volume &#8645;</a></th>
			<th>Volume</a></th>
			<th>Descrizione</th>
			<th>Copertina</th>
			<th>Action</th>
		</tr>
		
		<%
			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while (it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
		%>
		
		<tr>
				<td><a href="product?action=read&id=<%=bean.getISBN()%>"> <%= bean.getISBN() %></a></td>
				<td><%= bean.getPrezzo() %></td>
				<td><%= bean.getAutore() %></td>
				<td><%= bean.getQuantity() %></td>
				<td><%= bean.getSerie() %></td>
				<td><%= bean.getVolume() %></td>
				<td> <textarea rows="4" cols="50" readonly><%= bean.getDescrizione() %></textarea></td>
				<td><a href="product?action=read&id=<%=bean.getISBN()%>"><img src="<%= bean.getCopertina() %>" width=20px height=40px ></a></td>
				<td><a href="product?action=delete&id=<%=bean.getISBN()%>" class = "azioni">Delete</a><br>
				<td><a href="product?action=modify&id=<%=bean.getISBN()%>" class = "azioni">Modifica</a><br></td>
		</tr>
		<%
				}
			} else {
		%>
		<tr>
			<td colspan="6">No products available</td>
		</tr>
		<%
			}
		%>
	</table>
	
	<%
		if (product != null) {
	%>
	
	<h2>Modifica i dati del prodotto</h2>
	
	<form action="product" method="post" name = "modifica" id="modifica">
		<input type="hidden" name="action" value="update"> 
		
		<label for="ISBN" class= "testocatalogo">ISBN:</label><br> 
		<input name="isbn" type="text" maxlength="13" value=<%= product.getISBN() %> readonly class="form-input" isbn><br> 
		
		
		<label for="prezzo" class= "testocatalogo">Prezzo:</label><br>
		<input name="prezzoM" type="text" min="0" value="<%=product.getPrezzo() %>"   value="<%=product.getPrezzo() %>" class="form-input"><br>
		<input  id="PrezzoM" class="form-input" type="text"  readonly value="Format del prezzo non valido Es: 4.99" ><br>
	
		
		<label for="Autore" class= "testocatalogo">Autore:</label><br> 
		<input name="autoreM" type="text" maxlength="45"   value="<%=product.getAutore() %>" class="form-input"><br>
		<input  id="AutoreM" class="form-input" type="text"  readonly value="Inserire un autore valido" ><br>

		<label for="Quantità " class= "testocatalogo">Quantit&agrave:</label><br> 
		<input name="quantityM" type="number" min="0"   value="<%=product.getQuantity() %>" class="form-input"><br>
		<input  id="QuantityM" class="form-input" type="text"  readonly value="Quantit&agrave non valida" ><br>
		
		<label for="Serie" class= "testocatalogo">Serie:</label><br> 
		<input name="serieM" type="text" maxlength="60"  value="<%=product.getSerie() %>" class="form-input"><br>
		<input id="SerieM"  class="form-input" type="text"  readonly value="Serie non valida" ><br>
		
		<label for="Volume" class= "testocatalogo">Volume:</label><br> 
		<input name="volumeM" type="number" min="0"   value="<%=product.getVolume() %>" class="form-input"><br>
		<input id="VolumeM"  class="form-input" type="text"  readonly value="Volume non valido" ><br>
		
		<label for="Descrizione" class= "testocatalogo">Descrizione:</label><br>
		<textarea name="descrizioneM" maxlength="100" rows="3" class="form-input" ><%=product.getDescrizione() %></textarea><br>
		<input id="DescrizioneM"  class="form-input" type="text" readonly value="Descrizione non valida" ><br>
		
		<label for="Copertina" class= "testocatalogo">Copertina:</label><br> 
		<input name="copertinaM" type="text" maxlength="100"  value="<%=product.getCopertina() %>" class="form-input"><br>
		<input id="CopertinaM"  class="form-input" type="text"  readonly value="Link non valido" ><br>
		
		<label  class= "testocatalogo" for="Categoria">Categoria:</label><br> 
		<select name="categoria1M" form="modifica" categoria1 class="form-input">
		<option PreCategory1></option></select><br> 
		<input id="Categoria1M"  class="form-input" type="text" readonly value="Scegliere una categoria" ><br>
		
		<label  class= "testocatalogo" for="Categoria">Categoria*:</label><br> 
			<select name="categoria2M" form="modifica"  categoria2 class="form-input">
			<option PreCategory2></option>
			</select><br> 

		<input class= "category" type="submit" id = "submitM" value="Modifica"><input id = "resetM" class= "category" type="reset" value="Riprova">

	</form>
	
	<%
		}
	%>
	
	<h2>Inserisci i dati del prodotto</h2>
	<form action="product" method="post" id="insertForm" name="insertForm">
		<input type="hidden" name="action" value="insert"> 
		
		<label class= "testocatalogo" for="ISBN">ISBN:</label><br> 
		<input name="isbn" class="form-input" maxlength = "13" type="text"  placeholder="Inserire qui l'ISBN" ><br> 
		<input id="ISBN" name="ISBN" class="form-input" type="text" maxlength="13" readonly value="ISBN non valido.Riprova." >
		
		<label class= "testocatalogo" for="prezzo">Prezzo:</label><br>
		<input name="prezzo" class="form-input" type="text" min="0"  placeholder="Inserire qui il Prezzo Es. 4.99" ><br>
		<input  id="Prezzo" class="form-input" type="text"  readonly value="Format del prezzo non valido Es: 4.99" ><br>
		
		<label  class= "testocatalogo" for="Autore">Autore:</label><br> 
		<input name="autore" class="form-input" type="text" maxlength="45"  placeholder="Inserire qui l'Autore"><br>
		<input  id="Autore" class="form-input" type="text"  readonly value="Inserire un autore valido" ><br>
		
		<label  class= "testocatalogo" for="Quantit&agrave">Quantit&agrave:</label><br> 
		<input name="quantity" class="form-input" type="text" min="0"  placeholder="Inserire qui la Quantit&agrave"><br>
		<input  id="Quantity" class="form-input" type="text"  readonly value="Quantit&agrave non valida" ><br>
		
		<label class= "testocatalogo" for="Serie">Serie:</label><br> 
		<input name="serie" class="form-input" type="text" maxlength="60"  placeholder="Inserire qui il Nome della Serie"><br>
		<input id="Serie"  class="form-input" type="text"  readonly value="Serie non valida" ><br>
		
		<label class= "testocatalogo" for="Volume">Volume:</label><br> 
		<input name="volume" class="form-input" type="text" min="0"  placeholder="Inserire qui il Volume"><br>
		<input id="Volume"  class="form-input" type="text"  readonly value="Volume non valido" ><br>
		
		<label  class= "testocatalogo" for="Descrizione">Descrizione:</label><br>
		<textarea name="descrizione" class="form-input" maxlength="100" rows="3"  placeholder="Inserire qui la Descrizione"></textarea><br>
		<input id="Descrizione"  class="form-input" type="text" readonly value="Descrizione non valida" ><br>
		
		<label  class= "testocatalogo" for="Copertina">Copertina:</label><br> 
		<input name="copertina" class="form-input" type="text" maxlength="100"  placeholder="Inserire qui il link della Copertina"><br>
		<input id="Copertina"  class="form-input" type="text"  readonly value="Link non valido" ><br>
		
		<label  class= "testocatalogo" for="Categoria">Categoria:</label><br> 
		<select name="categoria1" class="form-input" form="insertForm" class = "selCategory" categoria3>
		<option>Seleziona almeno una Categoria</option>
		</select><br> 
		<input id="Categoria1"  class="form-input" type="text" readonly value="Scegliere una categoria" ><br>
		
		<label  class= "testocatalogo" for="Categoria">Categoria*:</label><br> 
		<select name="categoria2" class="form-input" form="insertForm" class = "selCategory" categoria4 >
		
		
			<option></option>
			</select>
			
			<br> 

		<input id="submit" class= "category" type="submit" value="Aggiungi"><input id = "reset" class= "category" type="reset" value="Riprova">

		


	</form>
	
	<jsp:include page="footer.jsp" flush="true" />
</body>
</html>