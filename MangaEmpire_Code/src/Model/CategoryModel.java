package Model;

import java.sql.Connection;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CategoryModel {
private static final String TABLE_NAME = "categoria";
private static final String TABLE_NAME_APPARTIENE = "appartiene";
	
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
	
		
		public static Collection<String> doRetrieveAll() throws SQLException{
			Connection connection = null;
			PreparedStatement preparedStatement = null;

			Collection<String> categorie = new ArrayList<String>();


			String selectSQL = "SELECT * FROM " + CategoryModel.TABLE_NAME;

			
			try {
				connection = ds.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL);

				ResultSet rs = preparedStatement.executeQuery();

				while (rs.next()) {
					String category = rs.getString("nome");
					categorie.add(category);
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
			return categorie;
		}


		public static void doSave(long iSBN, String cat)  throws SQLException{
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			if(cat==null) {
				return;
			}
			
			String insertSQL = "INSERT INTO " + CategoryModel.TABLE_NAME_APPARTIENE
						+ " (prodotto, categoria ) VALUES (?, ?)";
			
			
				

				try {
					connection = ds.getConnection();
					connection.setAutoCommit(false);
					preparedStatement = connection.prepareStatement(insertSQL);
					preparedStatement.setLong(1, iSBN);
					preparedStatement.setString(2, cat);
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


		public static boolean doDelete(long iSBN)throws SQLException{

				Connection connection = null;
				PreparedStatement preparedStatement = null;

				int result = 0;

				String deleteSQL = "DELETE FROM " + CategoryModel.TABLE_NAME_APPARTIENE + " WHERE prodotto = ?";

				try {
					connection = ds.getConnection();
					connection.setAutoCommit(false);
					preparedStatement = connection.prepareStatement(deleteSQL);
					preparedStatement.setLong(1, iSBN);

					result = preparedStatement.executeUpdate();
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
				return (result != 0);
			
				
			
		}
		

		public static Collection<String> doRetrieveByKey(long l) throws SQLException{
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			Collection<String> categorie = new ArrayList<>();


			String selectSQL = "SELECT * FROM " + CategoryModel.TABLE_NAME_APPARTIENE + " WHERE prodotto = ?";

			try {
				connection = ds.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL);
				preparedStatement.setLong(1, l);

				ResultSet rs = preparedStatement.executeQuery();

				while (rs.next()) {
					String categoria = rs.getString("categoria");
					categorie.add(categoria);
					
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
			return categorie;
		};
			
		

		
		
		
		
		
}
