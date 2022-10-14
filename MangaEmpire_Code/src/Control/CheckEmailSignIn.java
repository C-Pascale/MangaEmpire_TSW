package Control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Model.CategoryModel;
import Model.ProductBean;
import Model.ProductModel;
import Model.UserModel;

/**
 * Servlet implementation class CheckEmailSignIn
 */
@WebServlet("/CheckEmailSignIn")
public class CheckEmailSignIn extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckEmailSignIn() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String email = (String) request.getParameter("email");	
		String possibleEmail = "false";
		try {
			Boolean verifica = UserModel.possibleEmail(email);
			if(verifica == true) {
				possibleEmail = "true";
			}
		} catch (SQLException e) {
			
		}
		
		response.getWriter().write(possibleEmail);
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
