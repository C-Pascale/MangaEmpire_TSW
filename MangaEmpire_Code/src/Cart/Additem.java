package Cart;

import java.io.IOException;



import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.*;

import Model.CarrelloBean;
import Model.ProductBean;

/**
 * Servlet implementation class Additem
 */
@WebServlet("/Additem")
public class Additem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Additem() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String productString = (String) request.getParameter("product");
		Gson gson = new Gson();
		ProductBean product  = gson.fromJson(productString,ProductBean.class );

         			
			CarrelloBean carrello=(CarrelloBean) request.getSession().getAttribute("carrello");		
			if(carrello==null) {
				carrello=new CarrelloBean();
			}
		
			carrello.add(product);
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
