package Cart;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Model.CarrelloBean;
import Model.ProductBean;

/**
 * Servlet implementation class ChangeQuantity
 */
@WebServlet("/ChangeQuantity")
public class ChangeQuantity extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeQuantity() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Gson gson = new Gson();
		String prodString =  request.getParameter("product");		
		ProductBean product = new ProductBean();
		
		String QuantityJson =  request.getParameter("productQuantity");		
		Integer productQuantity = Integer.parseInt(QuantityJson);
		
		try {
			product = Model.ProductModel.doRetrieveByKey(Long.parseLong(prodString));
			if(productQuantity>product.getQuantity()) {
				productQuantity=product.getQuantity();
			}		
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
 
		
			CarrelloBean carrello=(CarrelloBean) request.getSession().getAttribute("carrello");		
			if(carrello==null) {
				carrello=new CarrelloBean();
			}
			
			int prodInCart = carrello.getQuantity(product);
			Integer i = productQuantity - prodInCart;
			if(i>0)
				carrello.addTot(product,i);
			else
				carrello.removeTot(product,Math.abs(i));
			
		
			request.getSession().setAttribute("carrello", carrello);    
         // return success  
			response.setStatus(200);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
