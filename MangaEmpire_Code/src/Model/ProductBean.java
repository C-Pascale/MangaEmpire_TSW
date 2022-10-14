package Model;

import java.sql.Date;
import com.google.gson.Gson;


public class ProductBean {
	static public final float IVA = (float) 22.00;
	long ISBN;
	float prezzo;
	String autore;
	Integer quantity;
	float iva;
	String serie;
	Integer volume;
	String descrizione;
	String copertina;
	java.time.LocalDate DataInserimento;
	
	
	public java.time.LocalDate getDataInserimento() {
		return DataInserimento;
	}
	public void setDataInserimento(java.time.LocalDate date) {
		DataInserimento = date;
	}
	public void setISBN(long iSBN) {
		ISBN = iSBN;
	}
	
	public long getISBN() {
		return ISBN;
	}
	
	public float getPrezzo() {
		return prezzo;
	}
	public void setPrezzo(float prezzo) {
		this.prezzo = prezzo;
	}
	public String getAutore() {
		return autore;
	}
	public void setAutore(String autore) {
		this.autore = autore;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public static float getIva(float prezzo) {
		return prezzo/100 * IVA;
	}
	
	public void setIva(float iva) {
		this.iva = iva;
	}
	
	public String getSerie() {
		return serie;
	}
	public void setSerie(String serie) {
		this.serie = serie;
	}
	public Integer getVolume() {
		return volume;
	}
	public void setVolume(Integer volume) {
		this.volume = volume;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public String getCopertina() {
		return copertina;
	}
	public void setCopertina(String copertina) {
		this.copertina = copertina;
	}
	
	public ProductBean() {
		super();
		this.ISBN = 0;
		this.prezzo = 0;
		this.autore = null;
		this.quantity = 0;
		this.iva = 0;
		this.serie = null;
		this.volume = 0;
		this.descrizione = null;
		this.copertina = null;
		this.DataInserimento = null;
	}
	@Override
	public String toString() {
		return "ProductBean [ISBN=" + ISBN + ", prezzo=" + prezzo + ", autore=" + autore + ", quantity=" + quantity
				+ ", iva=" + iva + ", serie=" + serie + ", volume=" + volume + ", descrizione=" + descrizione
				+ ", copertina=" + copertina + "]";
	}
	
	public static String stringify(ProductBean bean) {
		Gson gson = new Gson();
		String str =  gson.toJson(bean);
		return str;
	}
	
}
