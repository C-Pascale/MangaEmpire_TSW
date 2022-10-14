package Control;

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import Model.UserModel;
import Model.UserBean;


/**
 * Servlet implementation class LoginForm
 */
@WebServlet("/login")
public class LoginForm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginForm() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
			request.getSession().removeAttribute("adminRoles");			
			request.getSession().removeAttribute("User");
			String page = (String) request.getSession().getAttribute("page");
			
			RequestDispatcher dispatcher = null;
			String user=request.getParameter("e-mail");
			String password=request.getParameter("password");
			
			UserBean credenziali = new UserBean();
			credenziali.setEmail(user);
			credenziali.setPassword(password);

	
			try {
				if( UserModel.CheckUser(credenziali) == true ) {
					request.getSession().setAttribute("adminRoles", new Boolean(true));		
					request.getSession().setAttribute("User",credenziali);		
					if(page==null  || page.equals("/login-form.jsp")) {
						dispatcher = getServletContext().getRequestDispatcher("/MainPage.jsp");
					}else {
						dispatcher = getServletContext().getRequestDispatcher(page);
					}
						
				
				}
				else {
					request.getSession().setAttribute("adminRoles", new Boolean(false));
					request.setAttribute("LoginFail",true);	
					dispatcher = getServletContext().getRequestDispatcher("/login-form.jsp");
					
				}
			} catch (SQLException e) {
				dispatcher = getServletContext().getRequestDispatcher("/loginerror.jsp");
				e.printStackTrace();
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
