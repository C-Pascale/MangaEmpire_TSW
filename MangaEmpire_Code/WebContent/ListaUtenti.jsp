<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,Model.*"%>


<%
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

request.getSession().removeAttribute("page");
request.getSession().setAttribute("page","/ListaUtenti.jsp");

Collection<?> users = (Collection<?>) request.getAttribute("users");
if(users == null) {
	response.sendRedirect("./UserControl");	
	return;
}

UserBean ShowedUser = (UserBean) request.getAttribute("ShowedUser");


%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Lista Utenti</title>
<style>

<%@ include file="./Css/ListaUtenti.css"  %>

</style>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="./JScript/ListaUtenti.js"></script>
<script type="text/javascript" src="./JScript/DragScrollListaUtenti.js"></script>

</head>
<body>


<jsp:include page="header.jsp" flush="true" />

<h2>Utenti</h2>

	<input class= "searchbarUtenti" type="text" placeholder="Search.." id= "input" search>	
	
	<div id = "divUtenti">
	<table border="1" id="Mytable" table>
		<tr>
			<th><a href="UserControl?sort=email" class = "ordina">Email &#8645;</a></th>
			<th><a href="UserControl?sort=nome" class = "ordina">Nome &#8645;</a></th>
			<th><a href="UserControl?sort=cognome" class = "ordina">Cognome &#8645;</a></th>
			<th>paese</th>
			<th>indirizzo <br>spedizione</th>
			<th>indirizzo <br>fatturazione</th>
			<th>telefono</th>
			<th><a href="UserControl?sort=admin" class = "ordina">Admin &#8645;</a></th>
			<th>Action</th>
		</tr>

		<%
			if (users != null && users.size() != 0) {
				Iterator<?> it = users.iterator();
				while (it.hasNext()) {
					UserBean bean = (UserBean) it.next();
		%>
		
		<tr class="tbody" utente>
				<td><%= bean.getEmail() %></a></td>
				<td><%= bean.getNome() %></td>
				<td><%= bean.getCognome() %></td>
				<td><%= bean.getPaese() %></td>
				<td><%= bean.getIndirizzo() %></td>
				<td><%= bean.getIndirizzoF() %></td>
				<td><%= bean.getTelefono() %></td>
				<td><%= bean.getAdmin() %>
					<%
					if (bean.getAdmin() == false) {
					%>
					<a href="UserControl?action=setAdmin&id=<%=bean.getEmail()%>"><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSI00o4_7EPWnfdNgXgFn-fSST99l9H7-RKLpTp32BLmw&s" 
							class ="checkbox"></a>
					<%
					}else{
					%>		
					<%
					if (!user.getEmail().equals(bean.getEmail())) {
						
					%><a href="UserControl?action=removeAdmin&id=<%=bean.getEmail()%>">	<%}%>	
					<img src="https://user-images.githubusercontent.com/11351528/51387695-f564d000-1b4c-11e9-817d-5e6280f997d0.png" 
							class ="checkbox"></a>
				<%}%>					
				</td>
				<td><a href="UserControl?action=showOrder&id=<%=bean.getEmail()%>"><button>Ordini</button></a><br></td>
				
		</tr>
		<%
				}
			} else {
		%>
		<tr>
			<td colspan="6">No users available</td>
		</tr>
		<%
			}
		%>
	</table>
	</div>
	<%
	if (ShowedUser != null) {
	%>
	<div ordini>
			<h2 >Ordini</h2>
		<div style="display:flex">	
			<input type="date" id="start">
			<input type="date" id="end">
			<button class="checkDate"><img class="checkDate" src="https://thumbs.dreamstime.com/z/icona-della-lente-d-ingrandimento-di-vettore-o-segno-128227165.jpg"></button>
		</div>	
			<%
			Collection<OrderBean> orders = (Collection<OrderBean>)request.getAttribute("Userorders");
			HashMap<String,Collection<OrderedProductBean>> productsMap = (HashMap<String,Collection<OrderedProductBean>>)request.getAttribute("ProdAcquistati"); 
		if (orders != null && orders.size() != 0) {
		
		
		%>
	
		<table ordine>
			<tr>
				<th>Codice</th>
				<th>Totale</th>
				<th>Indirizzo</th>
				<th>Data</th>
				<th>Arrivo previsto</th>	
				<th>Costo Spedizione</th>
				<th>Status</th>
				<th></th>
			</tr>			
		<%	
			Iterator<?> it = orders.iterator();
			while (it.hasNext()) {
				OrderBean order = (OrderBean) it.next();
		%>	
		
			<tr>
				<td><%= order.getCodice() %>	</td>
				<td><%= order.getTotale() %></td>
				<td><%= order.getIndirizzo() %>	</td>
				<td class="data"><%= order.getData() %></td>
				<td><%= order.getArrivoprevisto() %></td>	
				<td><%= order.getCostoSpedizione() %></td>
				<td><%= order.getStatus() %>	</td>
				<td><button value='<%= order.getCodice() %>' class="info" info>info</button></td>
			</tr>
			<%} %>					
		</table>	
		<%	
			Iterator<?> itO = orders.iterator();
			while (itO.hasNext()) {
				OrderBean order = (OrderBean) itO.next();
				Collection<OrderedProductBean> products = productsMap.get(order.getCodice());%>
		<div>
			<button class = "prodotti" value="<%= order.getCodice()%>"> </button><table class ="hidden"> 
			
				<tr>						
					<th>nome</th>
					<th>quantity</th>
					<th>costo</th>	
					<th>iva</th>
				</tr>
				
			<%	
			Iterator<?> itP = products.iterator();
			while (itP.hasNext()) {
				OrderedProductBean product = (OrderedProductBean) itP.next();
			%>			

			<tr>
				<td><%=product.getNome()%></td>
				<td><%=product.getQuantity()%></td>
				<td><%=product.getCosto()%></td>	
				<td><%=product.getIva()%></td>
			</tr>
		<%}%>
				</table>
		</div>	
		<%}} %>	
	</div>
	<%}%>


</body>

	<jsp:include page="footer.jsp" flush="true" />
</html>