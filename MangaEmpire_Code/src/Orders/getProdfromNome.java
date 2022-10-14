package Orders;

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

/**
 * Servlet implementation class getProdfromNome
 */
@WebServlet("/getProdfromNome")
public class getProdfromNome extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getProdfromNome() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String nome = (String) request.getParameter("product");
		Gson gson = new Gson();
		String JsonProduct = null;
		ProductBean prod = new ProductBean();
		
		try {
			prod =ProductModel.doRetrieveByName(nome);
			if(prod!=null) {
				JsonProduct = gson.toJson(prod);
			}else {
				JsonProduct = "null";
			}
		
		} catch (SQLException e) {
			JsonProduct = e.toString();
		}
		
		response.getWriter().write(JsonProduct);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
