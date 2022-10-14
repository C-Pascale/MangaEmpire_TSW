package Control;

import java.io.IOException;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.CarrelloBean;
import Model.OrderBean;
import Model.OrderModel;
import Model.OrderedProductBean;
import Model.ProductBean;
import Model.ProductModel;
import Model.UserBean;

/**
 * Servlet implementation class CartControl
 */
@WebServlet("/carrello")
public class CartControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final double costoSpedizioneRapida = 4.99;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartControl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		RequestDispatcher dispatcher = null;
	

		try {
			if (action != null) {
				if(action.equalsIgnoreCase("add")) {
					long ISBN = Long.parseLong(request.getParameter("id"));
					ProductBean product = ProductModel.doRetrieveByKey(ISBN);
					request.removeAttribute("product");
					request.setAttribute("product", product);
					ProductBean inserito = ProductModel.doRetrieveByKey(ISBN);
					
					CarrelloBean carrello=(CarrelloBean) request.getSession().getAttribute("carrello");		
					if(carrello==null) {
						carrello=new CarrelloBean();
					}
					carrello.add(inserito);
					request.getSession().setAttribute("carrello", carrello);
				}
				else if(action.equalsIgnoreCase("remove")) {
					long ISBN = Long.parseLong(request.getParameter("id"));
					ProductBean product = ProductModel.doRetrieveByKey(ISBN);
					request.removeAttribute("product");
					request.setAttribute("product", product);
					CarrelloBean carrello=(CarrelloBean) request.getSession().getAttribute("carrello");		
					if(carrello==null) {
						carrello=new CarrelloBean();
					}
					carrello.reduce(product);
					request.getSession().setAttribute("carrello", carrello);
				}
				
				else if(action.equalsIgnoreCase("empty")) {
					request.getSession().removeAttribute("carrello");
					request.getSession().setAttribute("carrello", new CarrelloBean());
				}
				else if(action.equalsIgnoreCase("paga")) {
					dispatcher = getServletContext().getRequestDispatcher("/protected.jsp");
					
					CarrelloBean carrello=(CarrelloBean) request.getSession().getAttribute("carrello");		
					Boolean adminRoles = (Boolean) request.getSession().getAttribute("adminRoles");
					UserBean user =(UserBean) request.getSession().getAttribute("User");
					if( adminRoles == null || adminRoles == false || user==null) {
						dispatcher = getServletContext().getRequestDispatcher("/login-form.jsp");
						dispatcher.forward(request, response);
					}else {
						
						double spedizione=0;
						String spedizioneString = request.getParameter("spedizione");
						if(spedizioneString.equals("spedizioneR")) {
							spedizione=CartControl.costoSpedizioneRapida;
						}
					
					
						String ordercode=OrderModel.GenerateCode();
						
							//salvataggio ordine
							OrderBean order= new OrderBean();
							order.setData(java.time.LocalDate.now());	
							order.setCostoSpedizione(spedizione);	
							order.setUtente(user.getEmail());
							order.setCodice(ordercode);
							order.setIndirizzo(user.getIndirizzo());
							order.setTotale(carrello.getTotale());
							order.setStatus("in Lavorazione");
							
							if(spedizione>0.00)
								order.setArrivoprevisto(java.time.LocalDate.now().plusDays(2));
							else
								order.setArrivoprevisto(java.time.LocalDate.now().plusDays(5));
							
							Model.OrderModel.doSave(order);
							
							//salvataggio singoli prodotti
							Iterator<ProductBean> it = carrello.iterator();
									
							while(it.hasNext()) {
								
								ProductBean prod= it.next();
								Model.ProductModel.doSaveOrdinato(prod.getISBN(), ordercode);
								Model.ProductModel.AggiornaProdQuantity(Model.ProductModel.doRetrieveByKey(prod.getISBN()),prod.getQuantity());//prod ha la quantità nel carrello, così aggiorno il prodotto nel db					
								
								OrderedProductBean saved = new OrderedProductBean();
								saved.setIdprodotto(OrderModel.GenerateCodeProd());
								saved.setCosto(prod.getPrezzo());
								saved.setIva(ProductBean.getIva(prod.getPrezzo()));
								saved.setNome(prod.getSerie() + " " + prod.getVolume() );
								saved.setNumeroordine(ordercode);
								saved.setQuantità(prod.getQuantity());
								
								Model.OrderModel.doSaveProd(saved);

							}				
							request.getSession().setAttribute("carrello", new CarrelloBean());
							dispatcher = getServletContext().getRequestDispatcher("/protected.jsp");
							dispatcher.forward(request, response);
						}																							
					
					}
				
		}
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		

	
			if(dispatcher == null) {
				dispatcher = getServletContext().getRequestDispatcher(request.getParameter("page"));
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
