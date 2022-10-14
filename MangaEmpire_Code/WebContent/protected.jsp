<%

//save current page

request.getSession().removeAttribute("page");
request.getSession().setAttribute("page","/protected.jsp");


// Check user credentials

UserBean user =(UserBean) request.getSession().getAttribute("User"); 
if ((user == null) )
{	
    response.sendRedirect("./login-form.jsp");
    return;
}
Boolean adminRoles = (Boolean) session.getAttribute("adminRoles");
if ((adminRoles == null) || (!adminRoles.booleanValue()))
{	
    response.sendRedirect("./login-form.jsp");
    return;
}
//
DecimalFormat df = new DecimalFormat("###.##");
%>

<%@ page language="java" import="java.util.*,Model.*,java.text.DecimalFormat" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Protected Page</title>
<style type="text/css">	
	<%@ include file="./Css/UserArea.css"  %>	
</style>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="./JScript/userAreaInteraction.js"></script>
<script type="text/javascript" src="./FormControl/dettagliFormControl.js"></script>
<script type="text/javascript" src="./FormControl/Spedizioneformcontrol.js"></script>
<script type="text/javascript" src="./FormControl/Fatturazioneformcontrol.js"></script>
<script type="text/javascript" src="./JScript/DragScrollOrdini.js"></script>
</head>
<body>

<jsp:include page="header.jsp" flush="true" />

<div>
	<h2>Area utente </h2>
</div>


<div class="UserData">
<img id="userimg" src="https://i.imgur.com/KfqIKkG.png">
	<div>
		<h1>Benvenuto  <%= user.getNome() %>  <%= user.getCognome() %></h1>
		<a href="Logout"><button class="logout">Logout</button></a>
	</div>
</div>
<div class = "action">
	<a  href="UserControl?action=showOrder&id=<%=user.getEmail()%>">    <button class="userA" >Ordini</button></a>
	<a  href="UserControl?action=modificaIndirizzo&id=<%=user.getEmail()%>"><button class="userA" >Indirizzo</button></a>
	<a  href="UserControl?action=modificaDettagli&id=none"><button class="userA" >Dettagli</button></a>
</div>

<div class="bacheca">	
	<% String action = (String) request.getAttribute("UserAction");
		if(action!=null){%>
	<div>	
	<%//	si clicca su ordini
	
		if (action.equals("ordini")) {
			
			Collection<OrderBean> orders = (Collection<OrderBean>)request.getAttribute("Userorders");
			HashMap<String,Collection<OrderedProductBean>> productsMap = (HashMap<String,Collection<OrderedProductBean>>)request.getAttribute("ProdAcquistati"); 
	
			if (orders != null && orders.size() != 0) {
				Iterator<?> it = orders.iterator();
				while (it.hasNext()) {
					OrderBean order = (OrderBean) it.next();
					Collection<OrderedProductBean> products = productsMap.get(order.getCodice());%>
	<div>
			<table>	
				<tr>
					<th>Codice</th>
					<th>Totale</th>
					<th>Indirizzo</th>
					<th>Data</th>
					<th>Arrivo previsto</th>	
					<th>Costo Spedizione</th>
					<th>Status</th>
					<th>Action</th>
				</tr>	
				<tr>
					<td><%= order.getCodice() %>	</td>
					<td><%= df.format(order.getTotale())  %> €</td>
					<td><%= order.getIndirizzo() %>	</td>
					<td><%= order.getData() %></td>
					<td><%= order.getArrivoprevisto() %></td>	
					<td><%= order.getCostoSpedizione() %> €</td>
					<td><%= order.getStatus() %>	</td>
					<td><a href="UserControl?action=fattura&order=<%=order.getCodice()%>" download><button class="dettagli" >StampaFattura</button></a>
					<br> <button class="dettagli">Dettagli</button>	</td>
				</tr>
			</table>
			
			<table class="hidden">
				<tr>
					<th>Copertina</th>
					<th>Nome</th>
					<th>Quantità</th>
					<th>Costo</th>	
					<th>Iva</th>
				
				</tr>
				<%	
				Iterator<?> itP = products.iterator();
				while (itP.hasNext()) {
					OrderedProductBean product = (OrderedProductBean) itP.next();
				%>	
					<tr>
						<td class="copertina"></td>
						<td class="nome"><%=product.getNome()%></td>
						<td><%=product.getQuantity()%></td>
						<td><%=product.getCosto()%>€</td>	
						<td><%=product.getIva()%></td>
					</tr>
				
			
			<%}%>
		</table>

	</div>
			
	<%}}%>
	
	<%	/*si clicca su indirizzo*/
	
		}else if (action.equals("indirizzo"))  {			
%>	
	<div class="divIndirizzi" spedizione>
		<div style="display:flex">	
			<h3>indirizzo di spedizione</h3>	
			<button id="spedizione" class="category modifica">modifica</button>
		</div>	
		<p><%=user.getIndirizzo() %>  <br> <%=user.getPaese() %></p>
	</div>
	
	<div class="divIndirizzi" fatturazione>
		<div style="display:flex">	
			<h3>indirizzo di fatturazione</h3>	
			<button id="fatturazione" class="category modifica">
				<%if (user.getIndirizzoF()!=null && user.getIndirizzoF().length()>0 ){ %> 
					modifica
				<%}else{ %> 
					inserisci
			<%}%>
			
			</button>
			
		</div>	
		<p>
			<%if (user.getIndirizzoF()!=null && user.getIndirizzoF().length()>0){ %> 
				<%=user.getIndirizzoF()%>
			<%}else{ %> 
					<a  href="UserControl?action=modificaIndirizzo&id=<%=user.getEmail()%>&tipo=modifica"><button class="category modifica" >Imposta l'inidirizzo di fatturaizone uguale a quello di spedizione</button></a>
								
			<%}%>
		
		</p>
	</div>
	
	<div style="display:none" inserimentoS>
		<form name = "spedizione" id="spedizione" action="UserControl?action=modificaIndirizzo&id=<%=user.getEmail()%>&tipo=spedizione" method="post" class="insertForm">
				<label  class= "testocatalogo" for="Indirizzo">Indirizzo di Spedizione:</label><br> 
				<input name="indirizzo" type="text" maxlength="50" placeholder="Inserire Indirizzo e numero civico" class="form-input"><br>
				<input name="cap" type="text" maxlength="50"  placeholder="Inserire cap" class="form-input"><br>		
				<input id = "IndirizzoS" name = "IndirizzoS" type="text" readonly value="Indirizzo non valido" class="form-input"><br>
				
				<select class="paese form-input" name="paeseSelect" form="spedizione"  class="form-input" required >
			
    					<option>Paese</option>
    				    <option value="Austria">Austria</option>
    				    <option value="Belgio">Belgio</option>
    				    <option value="Belgio">Belgio</option>
    				    <option value="Cipro">Cipro</option>
    				    <option value="Danimarca">Danimarca</option>
    				    <option value="Estonia">Estonia</option>
    				    <option value="Finlandia">Finlandia</option>
    				    <option value="Francia">Francia</option>
    				    <option value="Germania">Germania</option>
    				    <option value="Grecia">Grecia</option>
    				    <option value="Irlanda">Irlanda</option>
    				    <option value="Italia">Italia</option>
    				    <option value="Lettonia">Lettonia</option>
    				    <option value="Lituania">Lituania</option>
    				    <option value="Lussemburgo">Lussemburgo</option>
    				    <option value="Malta">Malta</option>
    				    <option value="Paesi Bassi">Paesi Bassi</option>
    				    <option value="Polonia">Polonia</option>
    				    <option value="Portogallo">Portogallo</option>
    				    <option value="Regno Unito">Regno Unito</option>
    				    <option value="Repubblica ceca">Repubblica ceca</option>
    				    <option value="Romania">Romania</option>
    				    <option value="Slovacchia">Slovacchia</option>
    				    <option value="Slovenia">Slovenia</option>
    				    <option value="Spagna">Spagna</option>
    				    <option value="Svezia">Svezia</option>
    				    <option value="Ungheria">Ungheria</option>
				</select>
				
							
								
				<input name="paese" id = "paese" type="text" maxlength="50" class="paeseText"><br>
				<input id = "PaeseS" type="text" maxlength="50" readonly value="Selezionare un paese" class="form-input"><br>		
				<input id = "submitS" class="pulsanti" type="submit" value="Conferma"><input class="pulsanti" type="reset" value="Riprova">
		
		</form>		
	</div>
	
		<div style="display:none" inserimentoF>
		<form name = "fatturazione" id="fatturazione" action="UserControl?action=modificaIndirizzo&id=<%=user.getEmail()%>&tipo=fatturazione" method="post" class="insertForm">
				<label  class= "testocatalogo" for="Indirizzo">Indirizzo di Fatturazione:</label><br> 
				<input name="indirizzo" type="text" maxlength="50"  placeholder="Inserire Indirizzo" class="form-input"><br>
				<input name="cap" type="text" maxlength="50" placeholder="Inserire cap" class="form-input"><br>
				<input id = "IndirizzoF" name = "IndirizzoF" type="text" maxlength="50" readonly value="Indirizzo non valido" class="form-input"><br>
				
				
			<select class="paese form-input" name="paeseSelect" form="fatturazione"  class="form-input" >		
			    <option>Paese</option>
    				    <option value="Austria">Austria</option>
    				    <option value="Belgio">Belgio</option>
    				    <option value="Belgio">Belgio</option>
    				    <option value="Cipro">Cipro</option>
    				    <option value="Danimarca">Danimarca</option>
    				    <option value="Estonia">Estonia</option>
    				    <option value="Finlandia">Finlandia</option>
    				    <option value="Francia">Francia</option>
    				    <option value="Germania">Germania</option>
    				    <option value="Grecia">Grecia</option>
    				    <option value="Irlanda">Irlanda</option>
    				    <option value="Italia">Italia</option>
    				    <option value="Lettonia">Lettonia</option>
    				    <option value="Lituania">Lituania</option>
    				    <option value="Lussemburgo">Lussemburgo</option>
    				    <option value="Malta">Malta</option>
    				    <option value="Paesi Bassi">Paesi Bassi</option>
    				    <option value="Polonia">Polonia</option>
    				    <option value="Portogallo">Portogallo</option>
    				    <option value="Regno Unito">Regno Unito</option>
    				    <option value="Repubblica ceca">Repubblica ceca</option>
    				    <option value="Romania">Romania</option>
    				    <option value="Slovacchia">Slovacchia</option>
    				    <option value="Slovenia">Slovenia</option>
    				    <option value="Spagna">Spagna</option>
    				    <option value="Svezia">Svezia</option>
    				    <option value="Ungheria">Ungheria</option>
			</select>
				
				<input name="paese" id = "paese" type="text" maxlength="50" class="paeseText"><br>	
				<input id = "PaeseF" type="text" maxlength="50" readonly value="Selezionare un paese" class="form-input"><br>
				<input id = "submitF" class="pulsanti" type="submit" value="Conferma"><input class="pulsanti" type="reset" value="Riprova">
		</form>		
	</div>
	
	
	
	
				
	<%}else{			
%>	

  <form name="SignIn" class= "email" action="SignIn?action=Dettagli" method="post" id="SignIn" > 
	<div>
 		
 		
 		<label>Email:</label><br>
         <input name = "email" class="form-input" id="e-mail" maxlength="60" type="text" value="<%=user.getEmail() %> " readonly>
    	  <br>
 		
 		
      <label class="">Password attuale:</label><br>
         <input class="form-input" type="password" placeholder="Password attuale" id="pswOld"  name="pswOld" onblur="checkPassword()" >
         <label for="eyeOld"><img id = "mostraOld" src="https://i.imgur.com/t85zx0r.png" /></label>
      	 <input aria-hidden="true"  type="checkbox" id="eyeOld"><br>
        <input type="text" class="form-input" id="PswOld"  value="La Password è Errata.*" readonly>
        
        <br>

      <label class="">Password nuova:</label><br>
      <input class="form-input" type="password" placeholder="Password" id="password"  name="psw" >
      <label for="eyePsw"><img id = "mostraPsw" src="https://i.imgur.com/t85zx0r.png" /></label>
      	 <input aria-hidden="true"  type="checkbox" id="eyePsw"><br>
       <input type="text" class="form-input" id="Psw"  value="Inserire la Password." readonly>

        <br>

   	 <label class="">Conferma Password nuova:</label><br>
     <input class="form-input" type="password" placeholder="Conferma Password" id="conferma"  name="conferma"  >
     <label for="eyeConferma"><img id = "mostraConferma" src="https://i.imgur.com/t85zx0r.png" /></label>
      	 <input aria-hidden="true"  type="checkbox" id="eyeConferma"><br>
     <input type="text" class="form-input" id="Conferma"  value="La Password non corrisponde alla Conferma." readonly>
     

      <br>
		
		<label class="">Nome:</label><br>
        <input  name="nome" type="text" maxlength="15" class="form-input"  placeholder="Inserire qui il Nome" value="<%=user.getNome() %>"> 
        <input type="text" class="form-input" id="Nome"  value="Inserire il Nome qui." readonly>
        <br>

        <label class="">Cognome:</label><br>
        <input name="cognome" type="text" min="0"  maxlength="20" class="form-input"  placeholder="Inserire qui il Cognome" value="<%=user.getCognome() %>" >
        <input type="text" class="form-input" id="Cognome"  value="Inserire il cognome qui." readonly>
        <br>
		
		<label class="">Numero di Telefono:</label><br>
		<input name="telefono" type="text"   maxlength="10" class="form-input"  value="<%=user.getTelefono() %>">
		<input type="text" class="form-input" id="Telefono"  value="Inserire un Numero di telefono valido.*" readonly>
				
		<br>
		
      <input type="submit" id="submit" class="pulsanti" value="Conferma"> <input type="reset" id = "reset" class="pulsanti" value="Cancella tutto">    
   </div>
  </form>

	
	
<%}%>	

<%}%>

	
		</div>
</div>

<jsp:include page="footer.jsp" flush="true" />

</body>
</html>

