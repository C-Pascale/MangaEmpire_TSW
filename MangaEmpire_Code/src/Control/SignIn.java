package Control;

import java.io.IOException;


import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.ProductBean;
import Model.ProductModel;
import Model.UserBean;
import Model.UserModel;


/**
 * Servlet implementation class ProductControl
 */
@WebServlet("/SignIn")
public class SignIn extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignIn() {
        super();
        // TODO Auto-generated constructor stub
    
    }
	


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("null")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");
		RequestDispatcher dispatcher = null;
	

		try {
			if (action != null) {
							
				
				if (action.equalsIgnoreCase("SignIn")) {
				String email = request.getParameter("email");
				String nome = request.getParameter("nome");
				String cognome = request.getParameter("cognome");
				String paese = request.getParameter("paese");
				long telefono = Long.parseLong(request.getParameter("telefono"));
				String psw = request.getParameter("psw");
			
				String cap = request.getParameter("cap");
				String indirizzodispedizione = request.getParameter("indirizzodispedizione")+" " +cap ;
				
				String indirizzof=request.getParameter("indirizzodifatturazione");				
				String capf = request.getParameter("capF");
				String indirizzodifatturazione = indirizzof;
				
				if(capf != null && indirizzof != null && capf.length()>1 && indirizzof.length()>1) {
					indirizzodifatturazione = indirizzof + " " +capf+ " " + paese ;
				}				
				
				UserBean bean = new UserBean();
				bean.setEmail(email);
				bean.setNome(nome);
				bean.setCognome(cognome);
				bean.setPaese(paese);
				bean.setTelefono(telefono);
				bean.setPassword(psw);
				bean.setIndirizzo(indirizzodispedizione);
				bean.setIndirizzoF(indirizzodifatturazione);
				bean.setAdmin(false);
				
		
				UserModel.doSave(bean);	
				request.getSession().removeAttribute("User");
				request.getSession().setAttribute("User",bean);
				
			}else if(action.equalsIgnoreCase("Dettagli")) {
				
				UserBean user = (UserBean) request.getSession().getAttribute("User");
				String id=user.getEmail();
				
				String nome = request.getParameter("nome");
				String cognome = request.getParameter("cognome");
				String telefonoS=request.getParameter("telefono");	
				long telefono = Long.parseLong(telefonoS);
				String psw = request.getParameter("psw");
				
				UserBean bean = new UserBean();
				bean.setNome(nome);
				bean.setCognome(cognome);
				bean.setTelefono(telefono);
				if(psw==null || psw.length()<1) {
					psw=user.getPassword();
				}
				bean.setPassword(psw);					
	
				UserModel.doUpdate(bean,id);	
				request.getSession().removeAttribute("User");
				request.getSession().setAttribute("User", UserModel.doRetrieveByKey(id)); 
				dispatcher = getServletContext().getRequestDispatcher("/protected.jsp");
		
				}
				
				
			}
				
			
			
					
		}
			
	 catch (SQLException e) {
		System.out.println("Error:" + e.getMessage());}
		
	

		if(dispatcher == null) {
			dispatcher = getServletContext().getRequestDispatcher("/MainPage.jsp");
		}
		dispatcher.forward(request, response);

	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}