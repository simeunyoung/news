package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class OracleServer {
	protected Connection conn = null;
	protected PreparedStatement pstmt = null;
	protected ResultSet rs = null;
	protected String sql = null;
	
	protected Connection getConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String user = "team01", pass="team";
			String dburl = "jdbc:oracle:thin:@192.168.219.123:1521:orcl";
			conn = DriverManager.getConnection(dburl, user, pass);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	protected void oracleClose() {
		if(rs != null) { try { rs.close(); } catch(Exception ex) {}}
		if(pstmt != null) { try { pstmt.close(); } catch(Exception ex) {}}
		if(conn != null) { try { conn.close(); } catch(Exception ex) {}}
	}
}
