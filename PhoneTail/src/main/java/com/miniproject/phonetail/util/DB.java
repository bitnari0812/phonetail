package com.miniproject.phonetail.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DB {
	
	static String driver = "com.mysql.cj.jdbc.Driver";
	static String url = "jdbc:mysql://localhost:3306/phonetail";
	static String id = "root";
	static String pass= "adminuser";
	public static Connection getConnection(){
		Connection con = null;
	try {
		Class.forName(driver);
		con = DriverManager.getConnection(url, id, pass);
		
	} catch (ClassNotFoundException e) { e.printStackTrace();
	} catch (Exception e){ e. printStackTrace();}
		return con;
	} 
	
	public static void close(Connection con, PreparedStatement pstmt, ResultSet rs){
		
		try{
			if(con!=null) con.close();
			if(pstmt!=null) pstmt.close();
			if(rs!=null) rs.close();
		}catch(Exception e){e. printStackTrace();}
		
}

}
