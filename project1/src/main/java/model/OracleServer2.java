package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class OracleServer2 {
	protected Connection conn = null;
	protected PreparedStatement pstmt = null;
	protected ResultSet rs = null;
	protected String sql = null;
	
	protected Connection getConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String user ="java01", pass = "java";
			String dburl ="jdbc:oracle:thin:@nullmaster.sytes.net:1521:orcl";
			conn = DriverManager.getConnection(dburl, user, pass);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	} // protected Connection getConnection() {
	
	protected void oracleClose() {
		if(rs != null) {try {rs.close();} catch(Exception se) {}}
		if(pstmt != null) {try {pstmt.close();} catch(Exception se) {}}
		if(conn != null) {try {conn.close();} catch(Exception se) {}}
	} // protected void oracleClose() {
}
