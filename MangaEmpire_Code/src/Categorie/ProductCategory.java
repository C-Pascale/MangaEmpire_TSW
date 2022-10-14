package Categorie;

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

/**
 * Servlet implementation class ProductCategory
 */
@WebServlet("/ProductCategory")
public class ProductCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductCategory() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
			String ISBN = (String) request.getParameter("product");
			Collection<String> categorie = new ArrayList<>();
			Gson gson = new Gson();
			String JsonCategory = null;
			
			try {
				categorie = CategoryModel.doRetrieveByKey(Long.parseLong(ISBN));
				JsonCategory = gson.toJson(categorie);
			} catch (SQLException e) {
				JsonCategory = e.toString();
			}
		
			
			response.getWriter().write(JsonCategory);
		
			
			
	        
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
