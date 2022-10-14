package Control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.ProductModel;
import Model.UserModel;

/**
 * Servlet implementation class CheckISBN
 */
@WebServlet("/CheckISBN")
public class CheckISBN extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckISBN() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String isbn = (String) request.getParameter("isbn");	
		String possibleIsbn = "false";
		try {
			Boolean verifica = ProductModel.possibleIsbn(Long.parseLong(isbn));
			if(verifica == true) {
				possibleIsbn = "true";
			}
		} catch (SQLException e) {
			
		}
		
		response.getWriter().write(possibleIsbn);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
