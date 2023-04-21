package revalue;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.List;

import member.MemberDAO;

public class RevalueDAO {
	private static RevalueDAO instance = new RevalueDAO();
    
    public static RevalueDAO getInstance() {return instance; }	//객체생성 된걸 return해줌 
    
    private RevalueDAO() {}
    
    public Connection getConnection() {
    	//Connection conn = null;
    	Connection conn = null;	//연결
    	//PreparedStatement pstmt = null;	//query
    	//ResultSet rs = null;	//추출
    	//String sql = null;	//sql 작성
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String user = "team01", pw = "team", dburl = "jdbc:oracle:thin:@192.168.219.123:1521:orcl";
			conn = DriverManager.getConnection(dburl, user, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	/*public List getMyArticles(String id, int start, int end) {
		List articleList = new ArrayList();
		try {
			conn = getConnection();
			String sql = "select * from (select e.*,rownum r from (select * from revalue where id = ? order by num desc) e)where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);	
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
				while(rs.next()) {
					RevalueDTO article = new RevalueDTO();
					article.setNum(rs.getInt("num"));
					article.setId(rs.getString("id"));
					article.setTitle(rs.getString("title"));
					article.setCon(rs.getString("con"));
					article.setReCon(rs.getString("recon"));
					article.setIp(rs.getString("ip"));	
					article.setReg(rs.getTimestamp("reg"));									
					articleList.add(article);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return articleList;
	}
	*/
}