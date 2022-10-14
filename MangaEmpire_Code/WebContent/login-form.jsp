<%
// Check user credentials
Boolean LoginFail = (Boolean)request.getAttribute("LoginFail");	
if(LoginFail==null){
	LoginFail=false;
}
%>




<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
<style>
	<%@ include file="./Css/Login.css"  %>
</style>

</head>

<body>
<jsp:include page="header.jsp" flush="true" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src = "./JScript/Login.js"></script>
<div class="overlay">
<div class="con">

<form name="login" class= "email" action="login" method="post">

   

   <header class="head-form">
      <h2>Accedi</h2>

      <p>Accedi inserendo email e password</p>
   </header>

   <br>
   <div class="field-set">
    

       
	<label for = "e-mail"></label>
         <input class="form-input" id="e-mail" type="text" placeholder="@E-mail" name = "e-mail" >
         <%if (LoginFail==true){ %>
         <input type="text" class="form-input" id="Email"  value="Inserire un indirizzo email valido.*" readonly emailLogin>
     	<%} %>
      <br>
     

     
     
 <div>
 <label for = "password"></label>
     
      <input class="form-input" type="password" placeholder="Password" id="password"  name="password" >
      <label for="eye"><img id = "mostra" src="https://i.imgur.com/t85zx0r.png" /></label>
      	 <input aria-hidden="true"  type="checkbox" id="eye"><br>
      <%if (LoginFail==true){ %>
        <input type="text" class="form-input" id="Psw"  value="Inserire la Password.*" readonly pswLogin>
        <%} %>
      
       
     
     
     </div>
      <br>

      <input type="submit" class="log-in" value="Log In">
   </div>
  </form>


   <div class="other">

      

      <a href="SignIn.jsp"><input type="button" class="sign-up" value="Registrati"></a>

   </div>
  </div>

</div>
<jsp:include page="footer.jsp" flush="true" />

</body>
</html>
