package project;

import java.util.ArrayList;
import java.util.List;

import member.OracleServer;

public class newsDAO extends OracleServer {

	private static newsDAO instance = new newsDAO();
	public static newsDAO getInstance() {return instance;}
	private newsDAO() {}

	public int getMyNewsCount(String id) {
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from news where id = ?";
			pstmt = conn.prepareStatement(sql);
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
	
	public List getMyNewsList(String id, int startNum, int endNum) {
		List newsList = new ArrayList();
		try {
			conn = getConnection();
			sql ="select * from (select e.*,rownum r from (select * from news where id = ? order by num)e) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, startNum);
			pstmt.setInt(3, endNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				newsDTO news = new newsDTO();
				news.setNum(rs.getInt("num"));
				news.setId(rs.getString("id"));
				news.setNewsType(rs.getString("newstype"));
				news.setTitle(rs.getString("title"));
				news.setCon(rs.getString("con"));
				news.setIp(rs.getString("ip"));
				news.setReg(rs.getTimestamp("reg"));
				news.setViews(rs.getInt("views"));
				newsList.add(news);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return newsList;
	}
	
}
