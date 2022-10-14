package Model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class CarrelloBean {
	List<ProductBean> carrello=new ArrayList<>();

	public List<ProductBean> getCarrello() {
		return carrello;
	}

	public void setCarrello(List<ProductBean> carrello) {
		this.carrello = carrello;
	}

	@Override
	public String toString() {
		return "CarrelloBean [carrello=" + carrello + "]";
	}

	public CarrelloBean(List<ProductBean> carrello) {
		super();
		this.carrello = carrello;
	}

	public CarrelloBean() {
		// TODO Auto-generated constructor stub
	}
	
	public int getQuantity(ProductBean product) {	
		Iterator<ProductBean> it = carrello.iterator();
		
		while(it.hasNext()) {
			ProductBean el = it.next();
			if(el.getISBN()==(product.getISBN())   ) {
				return el.getQuantity();			
			}
		}
		return 0;
	}

	public void add(ProductBean product) {
		int rimasti = product.getQuantity();
		ProductBean inserito = product;
		inserito.setQuantity(1);
	
		Iterator<ProductBean> it = carrello.iterator();
		
		while(it.hasNext()) {
			ProductBean el = it.next();
			if(el.getISBN()==(product.getISBN())   ) {
				if(el.getQuantity()<rimasti) {
					inserito.setQuantity(el.getQuantity()+1);
					carrello.remove(el);
					break;	
			}else {
					return;
				}
								
			}
		}
		carrello.add(inserito);
	
		
	}
	
	public Iterator<ProductBean> iterator() {
		return carrello.iterator();
		
	}
	
	public int size() {
		return carrello.size();
		
	}

	public void reduce(ProductBean product) {
		ProductBean rimosso = product;
		rimosso.setQuantity(0);
	
		Iterator<ProductBean> it = carrello.iterator();
		
		while(it.hasNext()) {
			ProductBean el = it.next();
			if(el.getISBN()==(product.getISBN())   ) {
			
				carrello.remove(el);
				break;				
			}
		}
	
		
	
		
	}
	
	
	public double getTotale(){
		Iterator<ProductBean> it = carrello.iterator();
		double tot=0;
		
		while(it.hasNext()) {
			
			ProductBean prod= it.next();
			tot +=  (prod.getPrezzo() * prod.getQuantity());

		}
		
		
		return (double)Math.round(tot*100)/100;

	}

	public void addTot(ProductBean product, Integer i) {
		int rimasti = product.getQuantity();
		ProductBean inserito = product;
		inserito.setQuantity(i);
	
		Iterator<ProductBean> it = carrello.iterator();
		
		while(it.hasNext()) {
			ProductBean el = it.next();
			if(el.getISBN()==(product.getISBN())   ) {
				int inseribili = product.getQuantity() - el.getQuantity();
				if(inseribili < i)
					inserito.setQuantity(inseribili);
				inserito.setQuantity(el.getQuantity()+i);
				carrello.remove(el);
				break;				
			}
		}
		carrello.add(inserito);
		
	}
	public void removeTot(ProductBean product, Integer i) {
		ProductBean rimosso = product;
		rimosso.setQuantity(0);
	
		Iterator<ProductBean> it = carrello.iterator();
		
		while(it.hasNext()) {
			ProductBean el = it.next();
			if(el.getISBN()==(product.getISBN())   ) {
				rimosso.setQuantity(el.getQuantity()-i);
				carrello.remove(el);
				break;				
			}
		}
		
		if(	rimosso.getQuantity()>0)
			carrello.add(rimosso);
	
		
	}
		
		
			
}
