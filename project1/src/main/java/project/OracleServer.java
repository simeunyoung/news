package project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class OracleServer {
	
	protected Connection conn = null; // 연결
	protected PreparedStatement pstmt=null; // query
	protected String sql = null; // 추출
	protected ResultSet rs= null; // sql 작성
	
	protected Connection getConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver"); // 드라이버 로딩
			String user = "java14", pass="java";
			String dburl= "jdbc:oracle:thin:@192.168.219.123:1521:orcl";
			conn = DriverManager.getConnection(dburl, user, pass);
		}catch(Exception e){
			e.printStackTrace();
		}
		return conn;
	}
	
	protected void oracleclose() {
		if(pstmt!=null) {try {pstmt.close();}catch(Exception e) {}}
        if(conn!=null) {try {conn.close();}catch(Exception e) {}}
        if(rs!=null) {try {rs.close();}catch(Exception e) {}}
	}
}
