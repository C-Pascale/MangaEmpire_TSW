package Control;

import java.io.IOException;


import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.ProductBean;
import Model.ProductModel;

/**
 * Servlet implementation class ProductListControl
 */
@WebServlet("/lista_prodotti")
public class ProductListControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductListControl() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		HashMap<String,Collection<ProductBean>> ListeProdotti = new HashMap<>();
		String page = (String) request.getSession().getAttribute("page");

		try {
			request.removeAttribute("ProductLists");
			ListeProdotti.put("popolari", ProductModel.doRetrievebyCondition("popolari"));
			ListeProdotti.put("novita", ProductModel.doRetrievebyCondition("novita") );
			ListeProdotti.put("consigliati", ProductModel.doRetrievebyCondition("consigliati") );
			request.setAttribute("ProductLists",ListeProdotti);
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(page);
		dispatcher.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
