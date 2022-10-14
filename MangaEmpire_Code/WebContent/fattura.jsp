<%

UserBean user =(UserBean) request.getSession().getAttribute("User"); 
if ((user == null) )
{	
    response.sendRedirect("./login-form.jsp");
    return;
}
OrderBean order = (OrderBean) request.getAttribute("Order");
Collection<OrderedProductBean> prodotti = (Collection<OrderedProductBean>) request.getAttribute("ProdottiOrdine");

DecimalFormat df = new DecimalFormat("###.##");

%>

<%@ page language="java" import="java.util.*,Model.*,java.text.DecimalFormat" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<style type="text/css">
		<%@ include file="./Css/Fattura.css"  %>
</style>

<meta charset="ISO-8859-1">
<title>Fattura</title>
</head>
<body>

<h1>FATTURA n° <%= order.getCodice()%></h1>

<div class="hr-line"></div>

	<div class = "informazioni">
		<h2>Informazioni Utente</h2>
		<h3><%=user.getNome() + " " + user.getCognome()%></h3>
		<h3><%=user.getIndirizzo()%>  </h3>
		<h3><%=user.getPaese()%>  </h3>
	</div>
	
		<div class="hr-line"></div>
	
	<div style=display:flex>
		<div>
			<h2>Indirizzo spedizione</h2>
				<h3><%=user.getNome() + " " + user.getCognome()%></h3>
				<h3><%=user.getIndirizzo()%>  </h3>
				<h3><%=user.getPaese()%>  </h3>
		</div>
		
			<div class="vr-line"></div>
		
		<div>
			<h2>Indirizzo fatturazione</h2>
				<h3><%=user.getNome() + " " + user.getCognome()%></h3>
				<h3><%=user.getIndirizzo()%>  </h3>
				<h3><%=user.getPaese()%>  </h3>
		</div>
		
	</div>
		
		<div class="hr-line"></div>
		
	<div>
				<h2>Info su ordine</h2>
				<h3>Data ordine = <%= order.getData()%></h3>
				<h3>Codice ordine = <%= order.getCodice()%></h3>
	</div>
	
	<div class="hr-line"></div>
	
		<div>
				<h2>Dettagli fattura</h2>
				
				<table>
					<tr>
						<th>Nome</th>
						<th>Quantita</th>
						<th>P. Unitario(IVA esclusa)</th>
						<th>IVA %</th>
						<th> P. Unitario(IVA inclusa)</th>
						<th>Prezzo Totale(IVA inclusa)</th>
					</tr>
					
				<%	
				
					
					Iterator<?> itP = prodotti.iterator();
				
				OrderedProductBean prod = (OrderedProductBean) itP.next();
				float iva = (prod.getIva()*100)/prod.getCosto();	
				int i=0;
					while (itP.hasNext() || i==0) {
						OrderedProductBean product = new OrderedProductBean();
						if(i==0){
							i++;
							 product = prod;
							
						}else{
							 product = (OrderedProductBean) itP.next();
						}	
	
				%>	
					<tr>
						<td> <%=product.getNome()%></td>
						<td> <%=product.getQuantity()%></td>
						<td><%=df.format(product.getCosto() - product.getIva()) %>&euro;</td>
						<td><%=df.format(iva)%></td>
						<td> <%=df.format(product.getCosto())%>&euro;</td>
						<td><%=df.format(product.getCosto() * product.getQuantity())%>&euro;</td>
					</tr>
				
				
				
			<%}	%>
				</table>
				
				<div class="hr-line"></div>
				
				<div>	
					<h1>Totale  <%=df.format(order.getTotale())%> &euro;</h1>
					<table>
					<tr>
						<th>IVA %</th>
						<th>Prezzo Totale(IVA esclusa)</th>
						<th>Subtotale IV</th>
					</tr>
					<tr>
						<td><%=iva%></td>
						<%double totale=order.getTotale() - (order.getTotale() * iva)/100;  %>
						<th><%= df.format(totale)%>&euro;</th>
						<%double totaleIVA=order.getTotale() - (order.getTotale() * iva)/100;  %>
						<th><%= df.format(totaleIVA) %>  &euro;</th>
					</tr>
					
					</table>
					
				</div>


	</div>





</body>
</html>