package Control;

import java.io.IOException;


import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.ProductBean;
import Model.ProductModel;


/**
 * Servlet implementation class ProductControl
 */
@WebServlet("/product")
public class ProductControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductControl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("null")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");
		String page = (String) request.getSession().getAttribute("page");
		RequestDispatcher dispatcher = null;
	

		try {
			if (action != null) {
				
				//update product
				if (action.equalsIgnoreCase("update")) {
					long ISBN = Long.parseLong(request.getParameter("isbn"));
					String prezzoS = request.getParameter("prezzoM");
					
					float prezzo = Float.parseFloat(prezzoS);
					String autore = request.getParameter("autoreM");
					int quantità = Integer.parseInt(request.getParameter("quantityM"));
					float iva = ProductBean.getIva(prezzo);
					String serie = request.getParameter("serieM");
					int volume = Integer.parseInt(request.getParameter("volumeM"));
					String descrizione = request.getParameter("descrizioneM");
					String copertina = request.getParameter("copertinaM");
					String cat1 = request.getParameter("categoria1M");
					String cat2 = request.getParameter("categoria2M");

	
					Model.ProductBean bean = new Model.ProductBean();
					bean.setISBN(ISBN);
					bean.setPrezzo(prezzo);
					bean.setAutore(autore);
					bean.setQuantity(quantità);
					bean.setIva(iva);
					bean.setSerie(serie);
					bean.setVolume(volume);
					bean.setDescrizione(descrizione);
					bean.setCopertina(copertina);
					bean.setDataInserimento(java.time.LocalDate.now());
		
					Model.ProductModel.doDelete(ISBN);
					Model.ProductModel.doSave(bean);
					Model.CategoryModel.doDelete(ISBN);
					Model.CategoryModel.doSave(ISBN,cat1);
					if(cat2 != null) {
						Model.CategoryModel.doSave(ISBN,cat2);
					}
					
				//open modify form
				}else if (action.equalsIgnoreCase("modify")) {
					long ISBN = Long.parseLong(request.getParameter("id"));
					request.removeAttribute("product");
					request.setAttribute("product", ProductModel.doRetrieveByKey(ISBN));
					
				//open product page
				}else if (action.equalsIgnoreCase("read")) {
					long ISBN = Long.parseLong(request.getParameter("id"));
					request.removeAttribute("product");
					request.setAttribute("product", ProductModel.doRetrieveByKey(ISBN));
					dispatcher = getServletContext().getRequestDispatcher("/productpage.jsp");
					dispatcher.forward(request, response);
				
				//delete product
				} else if (action.equalsIgnoreCase("delete")) {
					int id = (int)Integer.parseInt(request.getParameter("id"));
					ProductModel.doDelete(id);
				
				//insert product from form
				}else if (action.equalsIgnoreCase("insert")) {
					String ISBNS = request.getParameter("isbn");
					long ISBN = Long.parseLong(ISBNS);
					String serie = request.getParameter("serie");
					String prezzoString = request.getParameter("prezzo");
					float prezzo = Float.parseFloat(prezzoString);
					String autore = request.getParameter("autore");
					int quantità = Integer.parseInt(request.getParameter("quantity"));
					float iva = ProductBean.getIva(prezzo);
					int volume = Integer.parseInt(request.getParameter("volume"));
					String descrizione = request.getParameter("descrizione");
					String copertina = request.getParameter("copertina");
					String cat1 = request.getParameter("categoria1");
					String cat2 = request.getParameter("categoria2");
	
					
					Model.ProductBean bean = new Model.ProductBean();
					bean.setISBN(ISBN);
					bean.setPrezzo(prezzo);
					bean.setAutore(autore);
					bean.setQuantity(quantità);
					bean.setIva(ProductBean.getIva(prezzo));
					bean.setSerie(serie);
					bean.setVolume(volume);
					bean.setDescrizione(descrizione);
					bean.setCopertina(copertina);
					bean.setDataInserimento(java.time.LocalDate.now());
					Model.ProductModel.doSave(bean);	

					Model.CategoryModel.doSave(ISBN,cat1);
					if(cat2 != null) {
						Model.CategoryModel.doSave(ISBN,cat2);
					}
				}else if(action.equalsIgnoreCase("listaCategory")) {
						String category = request.getParameter("categoria").toLowerCase();
						Collection<ProductBean> products = new ArrayList<>();
						products=ProductModel.doRetrievebyCategory(category);
						request.setAttribute("prodottiCategory", products);
						request.setAttribute("categoria",category);
						dispatcher = getServletContext().getRequestDispatcher("/productByCategory.jsp");
						dispatcher.forward(request, response);
					

			}
		 } 			
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		
		
		
		
		
		
		String sort = request.getParameter("sort");
		

		try {
			request.removeAttribute("products");
			request.setAttribute("products", ProductModel.doRetrieveAll(sort));
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
	
			if(dispatcher == null) {
				if(page == null) {
					page="/catalogoAdmin.jsp";
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
