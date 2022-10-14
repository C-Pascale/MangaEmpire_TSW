package Model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Collection;
import java.util.LinkedList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class OrderModel {

private static final String TABLE_NAME = "ordine";
private static final String TABLE_NAME_Prod = "prodottiacquistati";
	
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
	
		
		public static String GenerateCode() throws SQLException {
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			Integer codice=0;

			String selectSQL = "SELECT codice from "+ OrderModel.TABLE_NAME + " ORDER BY codice+0 DESC";
			connection = ds.getConnection();
			
			try {
				preparedStatement = connection.prepareStatement(selectSQL);
	
				ResultSet rs = preparedStatement.executeQuery();
				if(!rs.next())
					codice=0;
				codice = Integer.parseInt(rs.getString("codice")) +1;

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return codice.toString();
		
	}
		
		public static String GenerateCodeProd() throws SQLException {
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			Integer codice=0;

			String selectSQL = "SELECT idprodotto from "+ OrderModel.TABLE_NAME_Prod + " ORDER BY idprodotto+0 DESC";
			connection = ds.getConnection();
			
			try {
				preparedStatement = connection.prepareStatement(selectSQL);
	
				ResultSet rs = preparedStatement.executeQuery();
				if(!rs.next())
					codice=0;
				else
					codice = Integer.parseInt(rs.getString("idprodotto")) +1;

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return codice.toString();
		
	}
	
public static void doSave(OrderBean order) throws SQLException{
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;

			String insertSQL = "INSERT INTO " + OrderModel.TABLE_NAME
					+ " (codice, totale, indirizzo, data, costospedizione, status, arrivoprevisto, utente) VALUES ( ?, ?, ? , ?, ?, ?, ?, ?)";
			

			try {
				connection = ds.getConnection();
				connection.setAutoCommit(false);
				preparedStatement = connection.prepareStatement(insertSQL);
				
				preparedStatement.setString(1, order.getCodice());
				preparedStatement.setDouble(2, order.getTotale());
				preparedStatement.setString(3, order.getIndirizzo());
				preparedStatement.setDate(4, Date.valueOf(order.getData()));
				preparedStatement.setDouble(5, order.getCostoSpedizione());
				preparedStatement.setString(6, order.getStatus());
				preparedStatement.setDate(7, Date.valueOf(order.getArrivoprevisto()));
				preparedStatement.setString(8, order.getUtente());

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
			
public static void doSaveProd(OrderedProductBean prod) throws SQLException{
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;
		

			String insertSQL = "INSERT INTO prodottiacquistati" 
					+ " (idprodotto, nome, quantità, costo, iva, numeroordine) VALUES ( ?, ?, ? , ?, ?, ?)";
			

			try {
				 
				connection = ds.getConnection();
				 connection.setAutoCommit(false);
				preparedStatement = connection.prepareStatement(insertSQL);
				
				preparedStatement.setString(1, prod.getIdprodotto());
				preparedStatement.setString(2, prod.getNome());
				preparedStatement.setInt(3, prod.getQuantity());
				preparedStatement.setDouble(4, prod.getCosto());
				preparedStatement.setDouble(5, prod.getIva());
				preparedStatement.setString(6, prod.getNumeroordine());

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
			

		public static Collection<OrderBean> doRetrieveByUser(String userId) throws SQLException{
			Connection connection = null;
			PreparedStatement preparedStatement = null;

			Collection<OrderBean> orders = new LinkedList<OrderBean>();


			String selectSQL = "SELECT * FROM " + OrderModel.TABLE_NAME + " WHERE utente = ?";

			
			try {
				connection = ds.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL);
				preparedStatement.setString(1, userId);
				ResultSet rs = preparedStatement.executeQuery();
			

				while (rs.next()) {
					OrderBean bean = new OrderBean();
					bean.setCodice(rs.getString("codice"));
					bean.setTotale(rs.getFloat("totale"));
					bean.setIndirizzo(rs.getString("indirizzo"));
					bean.setData((rs.getDate("data").toLocalDate()));
					bean.setCostoSpedizione(rs.getDouble("costospedizione"));
					bean.setStatus(rs.getString("status"));
					bean.setArrivoprevisto((rs.getDate("arrivoprevisto").toLocalDate()));
					bean.setUtente(userId);	

					orders.add(bean);

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
			return orders;
		}
		
		
		public static OrderBean doRetrieveByKey(String key) throws SQLException{
			Connection connection = null;
			PreparedStatement preparedStatement = null;

			OrderBean bean = new OrderBean();


			String selectSQL = "SELECT * FROM " + OrderModel.TABLE_NAME + " WHERE codice = ?";

			
			try {
				connection = ds.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL);
				preparedStatement.setString(1, key);
				ResultSet rs = preparedStatement.executeQuery();
			

				while (rs.next()) {
					bean.setCodice(rs.getString("codice"));
					bean.setTotale(rs.getFloat("totale"));
					bean.setIndirizzo(rs.getString("indirizzo"));
					bean.setData((rs.getDate("data").toLocalDate()));
					bean.setCostoSpedizione(rs.getDouble("costospedizione"));
					bean.setStatus(rs.getString("status"));
					bean.setArrivoprevisto((rs.getDate("arrivoprevisto").toLocalDate()));
					bean.setUtente(rs.getString("utente"));	

					

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
		
		
		public static Collection<OrderedProductBean> doRetrieveProdotti(String ordine) throws SQLException{
			Connection connection = null;
			PreparedStatement preparedStatement = null;

			Collection<OrderedProductBean> products = new LinkedList<OrderedProductBean>();


			String selectSQL = "SELECT * FROM " + OrderModel.TABLE_NAME_Prod + " WHERE numeroordine = ?";

			
			try {
				connection = ds.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL);
				preparedStatement.setString(1, ordine);
				ResultSet rs = preparedStatement.executeQuery();
			

				while (rs.next()) {
					OrderedProductBean bean = new OrderedProductBean();
					bean.setIdprodotto(rs.getString("idprodotto"));
					bean.setNome(rs.getString("nome"));
					bean.setQuantità(rs.getInt("quantità"));
					bean.setCosto(rs.getFloat("costo"));
					bean.setIva(rs.getFloat("iva"));		
					bean.setNumeroordine(ordine);	

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
}
