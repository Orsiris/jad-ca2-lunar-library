package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;


public class PaidOrderDAO {
	
	public ArrayList<PaidOrder> getAllPaidOrders(int userid) throws SQLException, ClassNotFoundException {
	    ArrayList<PaidOrder> paidOrders = new ArrayList<>();
	    
	    
	    Connection conn = DBConnection.getConnection();
	    
	    
	    String sql = "SELECT * FROM orders WHERE user_id = ?";
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	    pstmt.setInt(1, userid);
	    
	    ResultSet rs = pstmt.executeQuery();
	    
	    
	    while (rs.next()) {
	        
	        int userId = rs.getInt("user_id");
	        int orderId = rs.getInt("order_id");
	        double total = rs.getDouble("total_price");
	        Date orderDate = rs.getTimestamp("order_date");
	        
	       
	        PaidOrder paidOrder = new PaidOrder(userId, orderId, total, orderDate);
	        paidOrders.add(paidOrder);
	    }
	    
	    
	    rs.close();
	    pstmt.close();
	    conn.close();
	    
	    
	    return paidOrders;
	}

	public ArrayList<Integer> getAllOrderIdsByUserid (int userid) throws SQLException, ClassNotFoundException{
		
		 ArrayList<Integer> allOrderIds = new ArrayList<>();
		    
		   
		    Connection conn = DBConnection.getConnection();
		    
		    String sql = "SELECT order_id FROM orders WHERE user_id = ?";
		    PreparedStatement pstmt = conn.prepareStatement(sql);
		    pstmt.setInt(1, userid);
		    
		    ResultSet rs = pstmt.executeQuery();
		    
		    while (rs.next()) {
		       
		        int orderid = rs.getInt("order_id");
		        
		        
		       
		       
		        allOrderIds.add(orderid);
		    }
		    
		    
		    rs.close();
		    pstmt.close();
		    conn.close();
		    
		    
		    return allOrderIds;
		
	}
	
	public ArrayList<User> getCustomerValueRanking () throws SQLException, ClassNotFoundException{
		
		 ArrayList<User> allUsers = new ArrayList<>();
		    
		    
		    Connection conn = DBConnection.getConnection();
		    
		    String sql = "SELECT orders.user_id, users.username ,SUM(orders.total_price) as grandTotal FROM orders, users WHERE orders.user_id = users.user_id GROUP BY user_id ORDER BY grandTotal DESC LIMIT 10;";
		    PreparedStatement pstmt = conn.prepareStatement(sql);
		    ResultSet rs = pstmt.executeQuery();
		    
		    while (rs.next()) {
		        int userid = rs.getInt("user_id");
		        String username = rs.getString("username");
		        double grandtotal = rs.getDouble("grandTotal");
		        
		        User user = new User(userid, username, grandtotal);
		       
		        
		       
		        allUsers.add(user);
		    }
		    
		    rs.close();
		    pstmt.close();
		    conn.close();
		    
		    return allUsers;
		
	}
	
	public ArrayList<PaidOrder> getAllPaidOrdersAdmin(String sortBy, String sortDirection) throws SQLException, ClassNotFoundException {
	    ArrayList<PaidOrder> paidOrders = new ArrayList<>();

	    Connection conn = DBConnection.getConnection();

	    String sql = "SELECT orders.order_date, users.username, orders.total_price FROM orders, users WHERE orders.user_id = users.user_id ORDER BY " + sortBy + " " + sortDirection;
	    PreparedStatement pstmt = conn.prepareStatement(sql);

	    ResultSet rs = pstmt.executeQuery();

	    while (rs.next()) {
	        String username = rs.getString("username");
	        double total = rs.getDouble("total_price");
	        Date orderDate = rs.getTimestamp("order_date");

	        PaidOrder paidOrder = new PaidOrder(total, orderDate, username);
	        paidOrders.add(paidOrder);
	    }

	    rs.close();
	    pstmt.close();
	    conn.close();

	    return paidOrders;
	}

	
	
	
	

}
