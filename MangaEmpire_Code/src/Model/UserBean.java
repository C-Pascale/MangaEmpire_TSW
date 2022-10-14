package Model;

public class UserBean {
	String password;
	String email;
	String nome;
	String cognome;
	String paese;
	String indirizzo;
	String indirizzoF;
	long telefono;
	Boolean admin = false;
	

	public UserBean(String password, String email, String nome, String cognome, String paese,String indirizzo, String indirizzoF, long telefono, Boolean admin) {
		super();
		this.password = password;
		this.email = email;
		this.nome = nome;
		this.cognome = cognome;
		this.indirizzo = indirizzo;
		this.indirizzoF = indirizzoF;
		this.admin = admin;
		this.paese=paese;
		this.telefono=telefono;
	}
	
	public UserBean() {
		// TODO Auto-generated constructor stub
	}

	public String getIndirizzoF() {
		return indirizzoF;
	}

	public void setIndirizzoF(String indirizzoF) {
		this.indirizzoF = indirizzoF;
	}

	public long getTelefono() {
		return telefono;
	}

	public void setTelefono(long telefono) {
		this.telefono = telefono;
	}

	public String getPaese() {
		return paese;
	}

	public void setPaese(String paese) {
		this.paese = paese;
	}

	public String getIndirizzo() {
		return indirizzo;
	}

	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}

	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
		
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getCognome() {
		return cognome;
	}
	public void setCognome(String cognome) {
		this.cognome = cognome;
	}
	
	public Boolean getAdmin() {
		return admin;
	}
	public void setAdmin(Boolean admin) {
		this.admin = admin;
	}


	@Override
	public String toString() {
		return "LoginInfo [password=" + password + ", email=" + email + "]";
	}
	
	
	

}
