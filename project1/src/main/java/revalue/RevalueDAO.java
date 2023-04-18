package revalue;

import java.util.ArrayList;
import java.util.List;

import member.OracleServer;

public class RevalueDAO extends OracleServer {
	private static RevalueDAO instance = new RevalueDAO();
	public static RevalueDAO getInstance() { return instance;}
	private RevalueDAO() {}
	
	public int getMyArticleCount(String id) {
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from revalue where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return x;
	}

	public List getMyArticles(String id, int start, int end) {
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

}
