package Model;

import java.sql.Connection;
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



public class UserModel {
	
		private static final String TABLE_NAME = "utente";
		
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
			

			

		public synchronized static boolean CheckUser(UserBean credenziali) throws SQLException {
			
				Connection connection = null;
				PreparedStatement preparedStatement = null;
				boolean UserExists = false;

				String insertSQL = 				
				 "SELECT * FROM " + UserModel.TABLE_NAME + " WHERE email = ? AND psw = ?";

				try {
					connection = ds.getConnection();
					preparedStatement = connection.prepareStatement(insertSQL);
					preparedStatement.setString(1, credenziali.getEmail());
					preparedStatement.setString(2, credenziali.getPassword());
					
					ResultSet rs = preparedStatement.executeQuery();
					
					
				
					if(rs == null)
						UserExists = false;  //non trova l'utente
					
					while(rs.next()) {
						credenziali.setNome(rs.getString("nome"));
						credenziali.setCognome(rs.getString("cognome"));
						credenziali.setAdmin(rs.getBoolean("admin"));
						credenziali.setIndirizzoF(rs.getString("indirizzodifatturazione"));
						credenziali.setIndirizzo(rs.getString("Indirizzodispedizione"));
						credenziali.setTelefono(rs.getLong("telefono"));
						credenziali.setPaese(rs.getString("paese"));
						UserExists = true;
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
				
				return UserExists;
			}
		
		public static void doSave(UserBean user) throws SQLException{
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;

			String insertSQL = "INSERT INTO " + UserModel.TABLE_NAME
					+ " (email, nome, cognome, paese, telefono, psw, indirizzodispedizione, indirizzodifatturazione, admin) VALUES (?, ?, ?, ?, ? , ?, ?, ?, ?)";
			

			try {
				connection = ds.getConnection();
				connection.setAutoCommit(false);
				preparedStatement = connection.prepareStatement(insertSQL);
				preparedStatement.setString(1, user.getEmail());
				preparedStatement.setString(2, user.getNome());
				preparedStatement.setString(3, user.getCognome());
				preparedStatement.setString(4, user.getPaese());
				preparedStatement.setLong(5, user.getTelefono());
				preparedStatement.setString(6, user.getPassword());
				preparedStatement.setString(7, user.getIndirizzo());
				preparedStatement.setString(8, user.getIndirizzoF());
				preparedStatement.setBoolean(9, user.getAdmin());

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

		public static Collection<UserBean> doRetrieveAll(String order) throws SQLException{
			Connection connection = null;
			PreparedStatement preparedStatement = null;

			Collection<UserBean> users = new ArrayList<UserBean>();


			String selectSQL = "SELECT * FROM " + UserModel.TABLE_NAME;
			
			if (order != null && !order.equals("")) {
				selectSQL += " ORDER BY " + order;
			}

			try {
				connection = ds.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL);

				ResultSet rs = preparedStatement.executeQuery();

				while (rs.next()) {
					UserBean bean = new UserBean();
					bean.setEmail(rs.getString("email"));
					bean.setPassword(rs.getString("psw"));
					bean.setNome(rs.getString("nome"));
					bean.setCognome(rs.getString("cognome"));
					bean.setAdmin(rs.getBoolean("admin"));
					bean.setIndirizzoF(rs.getString("indirizzodifatturazione"));
					bean.setIndirizzo(rs.getString("Indirizzodispedizione"));
					bean.setTelefono(rs.getLong("telefono"));
					bean.setPaese(rs.getString("paese"));
					users.add(bean);
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
			return users;
		}

		public static UserBean doRetrieveByKey(String email) throws SQLException{
			Connection connection = null;
			PreparedStatement preparedStatement = null;

			UserBean bean = new UserBean();

			String selectSQL = "SELECT * FROM " + UserModel.TABLE_NAME + " WHERE email = ?";

			try {
				connection = ds.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL);
				preparedStatement.setString(1, email);

				ResultSet rs = preparedStatement.executeQuery();

				while (rs.next()) {
					bean.setEmail(rs.getString("email"));
					bean.setPassword(rs.getString("psw"));
					bean.setNome(rs.getString("nome"));
					bean.setCognome(rs.getString("cognome"));
					bean.setAdmin(rs.getBoolean("admin"));
					bean.setIndirizzoF(rs.getString("indirizzodifatturazione"));
					bean.setIndirizzo(rs.getString("Indirizzodispedizione"));
					bean.setTelefono(rs.getLong("telefono"));
					bean.setPaese(rs.getString("paese"));
					
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
		
		
		public static boolean doDelete(String email) throws SQLException{
			Connection connection = null;
			PreparedStatement preparedStatement = null;

			int result = 0;

			String deleteSQL = "DELETE FROM " + UserModel.TABLE_NAME + " WHERE email = ?";

			try {
				connection = ds.getConnection();
				preparedStatement = connection.prepareStatement(deleteSQL);
				preparedStatement.setString(1, email);

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
		
			
		}
	

		public static Boolean possibleEmail(String email) throws SQLException {
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			boolean UserExists = false;
			
			String insertSQL = 				
					 "SELECT * FROM " + UserModel.TABLE_NAME + " WHERE email = ?";
			
			

			try {
				connection = ds.getConnection();
				preparedStatement = connection.prepareStatement(insertSQL);
				preparedStatement.setString(1, email);

				
				ResultSet rs = preparedStatement.executeQuery();
				
				
			
				if(rs == null)
					UserExists = false;  //non trova l'utente
				
				while(rs.next()) {
					UserBean user = new UserBean();
					user.setNome(rs.getString("nome"));
					UserExists = true;
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

			return !UserExists;
		};
		
		
		public static void doUpdate(UserBean user) throws SQLException{
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			String insertSQL = "UPDATE " + UserModel.TABLE_NAME + " SET"
					+ " email = ?, nome= ?, cognome= ?, paese= ?, telefono= ?, psw= ?, indirizzodispedizione= ?, indirizzodifatturazione= ?, admin= ?  "  
					+ "WHERE email = ?";
			

			try {
				connection = ds.getConnection();
				connection.setAutoCommit(false);
				preparedStatement = connection.prepareStatement(insertSQL);
				preparedStatement.setString(1, user.getEmail());
				preparedStatement.setString(2, user.getNome());
				preparedStatement.setString(3, user.getCognome());
				preparedStatement.setString(4, user.getPaese());
				preparedStatement.setLong(5, user.getTelefono());
				preparedStatement.setString(6, user.getPassword());
				preparedStatement.setString(7, user.getIndirizzo());
				preparedStatement.setString(8, user.getIndirizzoF());
				preparedStatement.setBoolean(9, user.getAdmin());
				preparedStatement.setString(10, user.getEmail());

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

		public static void doUpdate(UserBean user,String email) throws SQLException{
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			String insertSQL = "UPDATE " + UserModel.TABLE_NAME + " SET"
					+ " nome= ?, cognome= ?, telefono= ?, psw= ? "  
					+ " WHERE email = ? ";
		
			try {
				connection = ds.getConnection();
				connection.setAutoCommit(false);
				preparedStatement = connection.prepareStatement(insertSQL);
				preparedStatement.setString(1, user.getNome());
				preparedStatement.setString(2, user.getCognome());
				preparedStatement.setLong(3, user.getTelefono());
				preparedStatement.setString(4, user.getPassword());
				preparedStatement.setString(5, email);

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

}
