package Model;

import java.time.LocalDate;

public class OrderBean {
	String codice;
	double totale;
	String indirizzo;
	java.time.LocalDate data;
	double CostoSpedizione;
	String status;
	java.time.LocalDate arrivoprevisto;
	String Utente;
	
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCodice() {
		return codice;
	}

	public void setCodice(String codice) {
		this.codice = codice;
	}

	public double getTotale() {
		return totale;
	}

	public void setTotale(double totale) {
		this.totale = totale;
	}

	public String getIndirizzo() {
		return indirizzo;
	}

	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}

	public java.time.LocalDate getData() {
		return data;
	}

	public void setData(java.time.LocalDate data) {
		this.data = data;
	}

	public double getCostoSpedizione() {
		return CostoSpedizione;
	}

	public void setCostoSpedizione(double costoSpedizione) {
		CostoSpedizione = costoSpedizione;
	}

	public java.time.LocalDate getArrivoprevisto() {
		return arrivoprevisto;
	}

	public void setArrivoprevisto(java.time.LocalDate arrivoprevisto) {
		this.arrivoprevisto = arrivoprevisto;
	}


	public String getUtente() {
		return Utente;
	}


	public void setUtente(String utente) {
		Utente = utente;
	}
	
	public OrderBean(String codice, double totale, String indirizzo, LocalDate data, double costoSpedizione,
			String status, LocalDate arrivoprevisto, String utente) {
		super();
		this.codice = codice;
		this.totale = totale;
		this.indirizzo = indirizzo;
		this.data = data;
		CostoSpedizione = costoSpedizione;
		this.status = status;
		this.arrivoprevisto = arrivoprevisto;
		Utente = utente;
	}



	public OrderBean() {
		// TODO Auto-generated constructor stub
	}

	
}
