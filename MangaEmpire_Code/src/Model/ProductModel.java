package Model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;



public class ProductModel {
	
	
	private static final String TABLE_NAME = "prodotto";
	
	private static DataSource ds;

		static {
			try {
				Context initCtx = new InitialContext();
				Context envCtx = (Context) initCtx.lookup("java:comp/env");

				ds = (DataSource) envCtx.lookup("jdbc/website");

			} catch (NamingException e) {
				System.out.println("Error:" + e.getMessage());
			}
		}
	
	public static void doSave(ProductBean product) throws SQLException{
			
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + ProductModel.TABLE_NAME
				+ " (isbn, prezzo, autore, quantità, iva, serie, volume, descrizione, copertina, dataInserimento ) VALUES (?, ?, ?, ?, ? , ?, ?, ?, ?, ?)";
		

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setLong(1, product.getISBN());
			preparedStatement.setFloat(2, product.getPrezzo());
			preparedStatement.setString(3, product.getAutore());
			preparedStatement.setInt(4, product.getQuantity());
			preparedStatement.setFloat(5, product.getIva(product.getPrezzo()));
			preparedStatement.setString(6, product.getSerie());
			preparedStatement.setInt(7, product.getVolume());
			preparedStatement.setString(8, product.getDescrizione());
			preparedStatement.setString(9, product.getCopertina());
			preparedStatement.setDate(10, Date.valueOf(product.getDataInserimento()));
			
		;

			preparedStatement.executeUpdate();

			connection.commit();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		
		
	};

	public static boolean doDelete(long iSBN) throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + ProductModel.TABLE_NAME + " WHERE ISBN = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setLong(1, iSBN);

			result = preparedStatement.executeUpdate();

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return (result != 0);
	
		
	};

	public static ProductBean doRetrieveByKey(long iSBN) throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		ProductBean bean = new ProductBean();

		String selectSQL = "SELECT * FROM " + ProductModel.TABLE_NAME + " WHERE ISBN = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setLong(1, iSBN);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setISBN(rs.getLong("ISBN"));
				bean.setPrezzo(rs.getFloat("prezzo"));
				bean.setAutore(rs.getString("autore"));
				bean.setQuantity(rs.getInt("quantità"));
				bean.setIva(rs.getFloat("iva"));
				bean.setSerie(rs.getString("serie"));
				bean.setVolume(rs.getInt("volume"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setCopertina(rs.getString("copertina"));
				bean.setDataInserimento(rs.getDate("dataInserimento").toLocalDate());
				
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return bean;
	};
	
	public static Collection<ProductBean> doRetrieveAll(String order) throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<ProductBean> products = new LinkedList<ProductBean>();


		String selectSQL = "SELECT * FROM " + ProductModel.TABLE_NAME;

		if (order != null && !order.equals("")) {
			if(order.equals("ISBN")) {
				selectSQL += " ORDER BY " + order+ "+ 0";;
				
			}else {
				selectSQL += " ORDER BY " + order;
			}
			
		}
		

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setISBN(rs.getLong("ISBN"));
				bean.setPrezzo(rs.getFloat("prezzo"));
				bean.setAutore(rs.getString("autore"));
				bean.setQuantity(rs.getInt("quantità"));
				bean.setIva(rs.getFloat("iva"));
				bean.setSerie(rs.getString("serie"));
				bean.setVolume(rs.getInt("volume"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setCopertina(rs.getString("copertina"));	
				bean.setDataInserimento(rs.getDate("dataInserimento").toLocalDate());
				products.add(bean);
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return products;
	}

	public static Collection<ProductBean> doRetrievebyCondition(String selection) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		Collection<ProductBean> products = new LinkedList<ProductBean>();
		int listsize=6;
		
		String selectSQL = null;
		
		if(selection.equals("popolari")) {
			 selectSQL = "SELECT count(ISBN) as venduto ,dataInserimento, ISBN, prezzo, autore, quantità, iva, serie, volume, descrizione, copertina  FROM "
			+ ProductModel.TABLE_NAME + " JOIN ordinato   WHERE ISBNprodotto=ISBN " + "GROUP BY ISBNprodotto "  + "ORDER BY venduto+0  DESC";
		}
		else if(selection.equals("consigliati"))  {
			 selectSQL = "SELECT *  FROM "
			+ ProductModel.TABLE_NAME + " ORDER BY quantità+0 DESC";
		}
		else {
			 selectSQL = "SELECT *  FROM "
			+ ProductModel.TABLE_NAME + " ORDER BY dataInserimento  DESC";
		}
	
		try {
			connection = ds.getConnection();			
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();
			
			while (rs.next() &&  listsize>0) {
				ProductBean bean = new ProductBean();
				bean.setISBN(rs.getLong("ISBN"));
				bean.setPrezzo(rs.getFloat("prezzo"));
				bean.setAutore(rs.getString("autore"));
				bean.setQuantity(rs.getInt("quantità"));
				bean.setIva(rs.getFloat("iva"));
				bean.setSerie(rs.getString("serie"));
				bean.setVolume(rs.getInt("volume"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setCopertina(rs.getString("copertina"));	
				bean.setDataInserimento(rs.getDate("dataInserimento").toLocalDate());
				
				if(bean.getQuantity()>0) {
					products.add(bean);
					listsize++;
				}
				
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return products;
		
	};
	
	
	public static void doSaveOrdinato(long l, String codice) throws SQLException{
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO ordinato VALUES (?, ?)" ;
	
		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setLong(1, l);
			preparedStatement.setString(2, codice);

			preparedStatement.executeUpdate();

			connection.commit();
					
			
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		
		
	}

	public static void AggiornaProdQuantity(ProductBean prod, Integer quantity)  throws SQLException{

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "UPDATE "  + ProductModel.TABLE_NAME + " SET quantità = ?" + " WHERE ISBN=?" ;
	
		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);
			
			int prodRimasti = prod.getQuantity() - quantity ;
			while(prodRimasti < 0)
				prodRimasti++;
		
			preparedStatement.setInt(1, prodRimasti);
			preparedStatement.setLong(2, prod.getISBN());

			preparedStatement.executeUpdate();

			connection.commit();
			
			
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		
		
	}
	
	public static ProductBean doRetrieveByName(String nome) throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		ProductBean bean = new ProductBean();
		
		String selectSQL = "SELECT * FROM " + ProductModel.TABLE_NAME;

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				
				String rowName = rs.getString("serie") + " " + rs.getInt("volume");
				if(rowName.equals(nome)) {
					
					bean.setISBN(rs.getLong("ISBN"));
					bean.setPrezzo(rs.getFloat("prezzo"));
					bean.setAutore(rs.getString("autore"));
					bean.setQuantity(rs.getInt("quantità"));
					bean.setIva(rs.getFloat("iva"));
					bean.setSerie(rs.getString("serie"));
					bean.setVolume(rs.getInt("volume"));
					bean.setDescrizione(rs.getString("descrizione"));
					bean.setCopertina(rs.getString("copertina"));
					bean.setDataInserimento(rs.getDate("dataInserimento").toLocalDate());
					break;
				}
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return bean;
	}

	public static Collection<ProductBean> doRetrievebyCategory(String category) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		Collection<ProductBean> products = new LinkedList<ProductBean>();

		
		String selectSQL = null;
		if(category.equals("none")) {
			
			 selectSQL = "SELECT count(ISBN) as venduto ,dataInserimento, ISBN, prezzo, autore, quantità, iva, serie, volume, descrizione, copertina  FROM "
						+ ProductModel.TABLE_NAME + " LEFT JOIN ordinato "+
						"on ISBNprodotto=ISBN group by ISBN ORDER BY venduto+0 DESC";	
			
			 
		}else {
			
			selectSQL = "SELECT dataInserimento, ISBN, prezzo, autore, quantità, iva, serie, volume, descrizione, copertina  FROM "
					+ ProductModel.TABLE_NAME + " JOIN appartiene "+
					"WHERE categoria = ? && prodotto=ISBN ";	
		}
		

		
		try {
			connection = ds.getConnection();			
			preparedStatement = connection.prepareStatement(selectSQL);
			if(!category.equals("none")) {
				preparedStatement.setString(1, category);
			}
			ResultSet rs = preparedStatement.executeQuery();
			
			while (rs.next()) {
				ProductBean bean = new ProductBean();
				
				bean.setISBN(rs.getLong("ISBN"));
				bean.setPrezzo(rs.getFloat("prezzo"));
				bean.setAutore(rs.getString("autore"));
				bean.setQuantity(rs.getInt("quantità"));
				bean.setIva(rs.getFloat("iva"));
				bean.setSerie(rs.getString("serie"));
				bean.setVolume(rs.getInt("volume"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setCopertina(rs.getString("copertina"));	
				bean.setDataInserimento(rs.getDate("dataInserimento").toLocalDate());
				
				if(bean.getQuantity()>0) {
					products.add(bean);
					
				}
				
			
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return products;
		
	}

	public static Boolean possibleIsbn(Long isbn) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		boolean IsbnExists = false;
		
		String insertSQL = 				
				 "SELECT * FROM " + ProductModel.TABLE_NAME + " WHERE ISBN = ?";
		
		

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, isbn.toString());

			
			ResultSet rs = preparedStatement.executeQuery();
			
			
		
			if(rs == null)
				IsbnExists = false;  //non trova l'utente
			
			while(rs.next()) {
				ProductBean prod = new ProductBean();
				prod.setISBN(rs.getLong("nome"));
				IsbnExists = true;
			}
			
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}

		return !IsbnExists;
	};
	


	
	
}
