package Model;

public class OrderedProductBean {
	String idprodotto;
	String nome;
	int quantity;
	Float costo; 
	Float iva;
	String numeroordine;
	
	public String getIdprodotto() {
		return idprodotto;
	}
	public void setIdprodotto(String idprodotto) {
		this.idprodotto = idprodotto;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantità(int quantity) {
		this.quantity = quantity;
	}
	public Float getCosto() {
		return costo;
	}
	public void setCosto(Float costo) {
		this.costo = costo;
	}
	public Float getIva() {
		return iva;
	}
	public void setIva(Float iva) {
		this.iva = iva;
	}
	public String getNumeroordine() {
		return numeroordine;
	}
	public void setNumeroordine(String numeroordine) {
		this.numeroordine = numeroordine;
	}
	public OrderedProductBean(String idprodotto, String nome, int quantity, Float costo, Float iva,
			String numeroordine) {
		super();
		this.idprodotto = idprodotto;
		this.nome = nome;
		this.quantity = quantity;
		this.costo = costo;
		this.iva = iva;
		this.numeroordine = numeroordine;
	}
	public OrderedProductBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	
}
