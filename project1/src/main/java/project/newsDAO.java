package project;

import java.sql.*;
import javax.sql.*;

import board2.BoardDataBean;

import javax.naming.*;
import java.util.*;

public class newsDAO extends OracleServer {

	private static newsDAO instance = new newsDAO();
	public static newsDAO getInstance() {return instance;}
	private newsDAO() {}
	
	// 게시글 수를 구하는 메서드
	public int getNewsCount() throws Exception{
		int x = 0;
		
		try {
			conn = getConnection();
			sql = "select count(*) from news";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleclose();
		}
		return x;
	}
	
	// 게시글 목록을 가져옴 리스트 조회 후 list 형태로 변환
	public List getNews(int start, int end) throws Exception{
		
		List newsList = null;
		
		try {
			conn = getConnection();
			sql = "SELECT * FROM news ORDER BY reg DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				newsList = new ArrayList(end);
				do {
					newsDTO article = new newsDTO();
					article.setNum(rs.getInt("num"));
					article.setId(rs.getString("id"));
					article.setNewstype(rs.getString("newstype"));
					article.setTitle(rs.getString("title"));
					article.setCon(rs.getString("con"));
					article.setReg(rs.getTimestamp("reg"));
					article.setPw(rs.getString("pw"));
					article.setViews(rs.getInt("views"));
					article.setPress(rs.getString("press"));
					article.setIp(rs.getString("ip"));
					newsList.add(article);
				} while(rs.next());
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleclose();
		}
		return newsList;
	}
}
