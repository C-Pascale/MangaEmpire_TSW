<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Error</title>
<style>
<%@ include file="./Css/Layout.css"  %>
</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true" />
	<h1>Qualcosa è andato storto</h1>
	
	 <a class= "home" href="login-form.jsp">Riprova</a>
	
<jsp:include page="footer.jsp" flush="true" />
</body>
</html>