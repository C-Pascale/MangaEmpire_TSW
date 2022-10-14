<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SignIn</title>
<style>
	<%@ include file="./Css/Login.css"  %>
</style>

</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src = ./JScript/Login.js></script>
<script src = ./FormControl/SigninFormControl.js></script>
<div class="overlay">
<div class="con">
<form name="SignIn" class= "email" action="SignIn?action=SignIn" method="post" id="SignIn" >

   

   <header class="head-form">
      <h2>Registrati</h2>

      <p>Registrati inserendo i tuoi dati</p>
   </header>

   <br>
   <div>
    

       
	
         <input name = "email" class="form-input" id="e-mail" maxlength="60" type="text" placeholder="@E-mail"  >
     	<input type="text" class="form-input" id="Email"  value="Inserire un indirizzo email valido.*" readonly>
      <br>
     

     
     

	
      <input class="form-input" type="password" placeholder="Password" id="password"  name="psw" >
      <label for="eye"><img id = "mostra" src="https://i.imgur.com/t85zx0r.png" ></label>
      	 <input aria-hidden="true"  type="checkbox" id="eye"><br>
     <input type="text" class="form-input" id="Psw"  value="Inserire la Password.*" readonly><br>
     	<br>
             
       
        
     
     <input class="form-input" type="password" placeholder="Conferma Password" id="conferma"  name="conferma" >
      <label for="eyeConferma"><img id = "mostraConferma" src="https://i.imgur.com/t85zx0r.png" ></label>
      	 <input aria-hidden="true"  type="checkbox" id="eyeConferma"><br>
     <input type="text" class="form-input" id="Conferma"  value="La Password non corrisponde alla Conferma.*" readonly><br>
     	<br>
         
           
    
		
		<input  name="nome" type="text" maxlength="15" class="form-input"  placeholder="Inserire qui il Nome" ><br> 
		<input type="text" class="form-input" id="Nome"  value="Inserire il Nome qui.*" readonly>
		
		<input name="cognome" type="text" min="0"  maxlength="20" class="form-input"  placeholder="Inserire qui il Cognome" ><br>
		<input type="text" class="form-input" id="Cognome"  value="Inserire il cognome qui.*" readonly>
		
		<select name="paese" form="SignIn"  class="form-input" required ><option>Paese</option>
		
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

<input type="text" class="form-input" id="Paese"  value="Selezionare il Paese giusto.*" readonly>

<br>

		
		<input name="telefono" type="number" min="0"  class="form-input"  placeholder="Inserire qui il numero di telefono�"><br>
		<input type="text" class="form-input" id="Telefono"  value="Inserire un Numero di telefono valido.*" readonly>
		
		<input name="indirizzodispedizione" type="text" maxlength="50" class="form-input"  placeholder="Inserire qui l'indirizzo di spedizione"><br>
		<input name="cap" type="text" maxlength="50" class="form-input"  placeholder="Inserire qui il cap\zip"><br>
		<input type="text" class="form-input" id="Indirizzo"  value="Inserire l'indirizzo di spedizione qui.*" readonly>
		
		<input name="indirizzodifatturazione" type="text" maxlength="50" class="form-input" placeholder="Inserire qui l'indirizzo di fatturazione se diverso da quello di spedizione"><br>
		<input name="capF" type="text" maxlength="50" class="form-input"  placeholder="Inserire qui il cap\zip"><br>
		<input type="text" class="form-input" id="Fatturazione"  value="Inserire un indirizzo di fatturazione.*" readonly>
		
		
      <input type="submit" id="submit" class="pulsanti" value="Registrati"> <input type="reset" class="pulsanti" value="Riprova" id="reset">    
   </div>
  </form>


   <div class="other">

      <a href= "login-form.jsp"><button class="frgt-pass">Accedi</button></a>

      

     

   </div>
  </div>

</div>
<jsp:include page="footer.jsp" flush="true" />
</body>
</html>