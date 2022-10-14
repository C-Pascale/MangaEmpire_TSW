<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,Model.*"%>
    
 <% 
	AbstractMap<?,Collection<?>> ProductList = (AbstractMap<?,Collection<?>> ) request.getAttribute("ProductLists");
 request.getSession().removeAttribute("page");
request.getSession().setAttribute("page","/pagamento.jsp");
	
//Check user credentials

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
		
CarrelloBean carrello = (CarrelloBean) request.getSession().getAttribute("carrello");	
if(carrello == null || carrello.getTotale()<0){
	 response.sendRedirect("./MainPage.jsp");
	 return;
}
%>


<!DOCTYPE html>
<html>
<style>

<%@ include file="./Css/pagamento.css"  %>

</style>
<head>


<meta charset="ISO-8859-1">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script type="text/javascript" src="./JScript/DragScrollPagamento.js"></script>
<script type="text/javascript" src="./FormControl/PagamentoformControl.js"></script>

<title>Pagamento</title>
<jsp:include page="header.jsp" flush="true" />
</head>
<body>
	<div class= "page">
	 	
	 	
	 	<form name="pagamento" class= "pagamento" action="carrello?action=paga" method="post" id="pagamento" > 
	
	
            
            <h2>Payment</h2>
            
            
            <label for="cname">Intestatario della Carta</label><br>
            <input type="text" id="cname" name="nome" placeholder="Nome" class = "form-input"><br>
            <input type="text" id="Nome" value = "Intestatario non valido" class = "form-input" readonly><br>
            
            <label for="ccnum">Numero della Carta</label><br>
            <input type="text" maxlength="19" id="numc" name="numc" placeholder="1111-2222-3333-4444" class = "form-input"><br>
            <input type="text" id="NumC" value = "Numero della carta non valido" class = "form-input" readonly><br>
            
            <label for="expmonth">Mese di Scadenza</label><br>
            <input type="month" id="mese" name="mese" placeholder="September" class = "form-input"><br>
			<input type="text" id="Mese" value = "Mese Errato" class = "form-input" readonly ><br>
              
              <div>
                
                <label for="cvv">CVV</label><br>
                <input type="text" id="cvv" name="cvv" maxlength = "3" placeholder="XXX" class = "cvv"><br>
             	<input type="text" id="Cvv" placeholder = "CVV Errato" class = "form-input" readonly><br>
             	
            	<div>
            	
              	<label>Scegliere la Spedizione</label><br>
              	
              	<input type="radio" required  name="spedizione" value = "spedizioneS">
              	<label for="spedizioneS">Spedizione Standard</label><br>
              	
              	<input type="radio" required  name="spedizione" value = "spedizioneR">
              	<label for="spedizioneR">Spedizione Rapida(+4.99 &euro;)</label><br>
              	<input type="text" id="Spedizione" value = "Scegliere una delle opzioni" class = "form-input" readonly ><br>
              	
              	
              	
              	</div>
              	
            	</div>
            	
            	
              
            	
	
<input type = "submit" value = "Paga Ora" class = "pulsanti" id = "submit"><input type = "reset" value = "Ricompila" class = "pulsanti" id="reset">
  </form>
	
	 	
			
	
	
		<div class="group">
		<input type="text" readonly class = "form-input-totale" value="TOTALE:<%=  carrello.getTotale() %>"><br>
	 	<div class="carrello">
	 	
	 	
	 	
	 	<%
	 			
			if (carrello != null && carrello.size() != 0) {
				Iterator<?> it = carrello.iterator();
				while(it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
			
	 		
	 	%>	
	 	
	 	<div class="prodottoCart" >
	 	
	 			<a href="product?action=read&id=<%=bean.getISBN()%>"><img src=<%=bean.getCopertina() %> class="copertina"> </a>
	 		<div class = "infoprodotto" value="<%=ProductBean.stringify(bean) %>">
	 			<h3 class="articolo"><%=bean.getSerie() +" Vol."+bean.getVolume() %>   </h3>
	 			<h3><%= bean.getPrezzo()%> &euro;    </h3>
	 			<h3>Quantità:    <input type="text" class="quantità" readonly value="<%= carrello.getQuantity(bean)%>">
	 			</h3>
	 		</div>
	 	</div> 	
	 		
	 	<%}}%>
	 		
	 	</div>
		</div>
		
	</div>
  
</body>
<jsp:include page="footer.jsp" flush="true" />
</html>