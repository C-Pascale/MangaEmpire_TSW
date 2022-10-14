package Searchbar;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Model.ProductBean;
import Model.ProductModel;

/**
 * Servlet implementation class getProductJson
 */
@WebServlet("/getProductJson")
public class getProductJson extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getProductJson() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Collection<ProductBean> products = new ArrayList<>();
		Gson gson = new Gson();
		
		String JsonProd = null;
		
		try {
			products = ProductModel.doRetrieveAll(null);
			JsonProd = gson.toJson(products);
		} catch (SQLException e) {
			JsonProd = e.toString();
		}
	
		
		response.getWriter().write(JsonProd);
	
		

		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
