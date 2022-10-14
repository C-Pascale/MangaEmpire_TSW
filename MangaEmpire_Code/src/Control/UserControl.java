package Control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.OrderBean;
import Model.OrderModel;
import Model.OrderedProductBean;
import Model.ProductModel;
import Model.UserBean;
import Model.UserModel;

/**
 * Servlet implementation class UserControl
 */
@WebServlet("/UserControl")
public class UserControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserControl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher dispatcher = null;
		String sort = request.getParameter("sort");
		String action = request.getParameter("action");
		String page = (String) request.getSession().getAttribute("page");
		
		try {
			request.removeAttribute("users");
			request.setAttribute("users", UserModel.doRetrieveAll(sort));
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
	
		
		if(action!= null) {
		try {
			
			
			if(action.equals("setAdmin")) {
				String id = request.getParameter("id");
				UserBean bean = UserModel.doRetrieveByKey(id);
				bean.setAdmin(true);
				UserModel.doUpdate(bean);
		
			}else if(action.equals("removeAdmin")) {
				String id = request.getParameter("id");
				UserBean bean = UserModel.doRetrieveByKey(id);
				bean.setAdmin(false);
				UserModel.doUpdate(bean);
			}else if(action.equals("showOrder")) {		//prende gli ordini dato l'utente, e tutti i prodotti di ogni ordine
			
				request.removeAttribute("UserAction");
				request.setAttribute("UserAction","ordini");
				
				String id =request.getParameter("id");
				request.removeAttribute("ShowedUser");
				request.setAttribute("ShowedUser", UserModel.doRetrieveByKey(id));
				Collection<OrderBean> orders =  OrderModel.doRetrieveByUser(id);
				request.removeAttribute("Userorders");
				request.setAttribute("Userorders", orders);
				
				HashMap<String,Collection<OrderedProductBean>> products = new HashMap<>();				
				for(OrderBean o : orders) {
					products.put(o.getCodice(),OrderModel.doRetrieveProdotti(o.getCodice()));
				}
				request.removeAttribute("ProdAcquistati");
				request.setAttribute("ProdAcquistati", products);
			}else if(action.equals("modificaIndirizzo")) {	
				request.removeAttribute("UserAction");
				request.setAttribute("UserAction","indirizzo");
				
				UserBean userbean = (UserBean) request.getSession().getAttribute("User");
				String user = request.getParameter("id");
				String tipo = request.getParameter("tipo");
				String indirizzo = request.getParameter("indirizzo");
				String cap = request.getParameter("cap");
				String paese = request.getParameter("paese");
				if(paese==null || paese.length()<1) {		//nel caso metto indirizzo di fatturazione come spedizione dal form
					paese= userbean.getPaese();
				}
				
				if(tipo!=null) {	
					
					if(tipo.equals("spedizione")){
			
						userbean.setIndirizzo(indirizzo + "\t" + cap);
						userbean.setPaese(paese);
					}else if(tipo.equals("fatturazione")){
						userbean.setIndirizzoF(indirizzo + " " + cap + " " + paese);
					}else {
						userbean.setIndirizzoF(userbean.getIndirizzo() + " " + paese);
					}
					
					
					UserModel.doUpdate(userbean);
					request.getSession().removeAttribute("User"); 
					request.getSession().setAttribute("User",userbean); 
					
				}}else if(action.equals("modificaDettagli")) {	
					request.removeAttribute("UserAction");
					request.setAttribute("UserAction","dettagli");
			
			}else if(action.equals("fattura")) {	

				String orderID = request.getParameter("order");
				
				OrderBean order = OrderModel.doRetrieveByKey(orderID);
				Collection<OrderedProductBean> prodotti = OrderModel.doRetrieveProdotti(orderID);
				
				request.setAttribute("Order",order);
				request.setAttribute("ProdottiOrdine",prodotti);
				
				page = "/fattura.jsp";
				
				
		
		}

				
		}catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		
	}
		
	
			if(dispatcher == null) {
			
				if(page== null) {
					page = "/MainPage.jsp";
				}
				dispatcher = getServletContext().getRequestDispatcher(page);
				dispatcher.forward(request, response);
			
			}
			
		
	
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
