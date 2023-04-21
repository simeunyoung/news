package project;

import java.sql.*;
import javax.sql.*;

import project.newsDTO;

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
		
		List newsList = new ArrayList();
		
		try {
			conn = getConnection();
			sql = "select * from(select e.*, rownum r from(select * from news order by reg desc) e) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
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
				}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleclose();
		}
		return newsList;
	}
	
	// 뉴스 타입별로 수를 구하는 메서드
	public int getNewstypeCount(String newstype) throws Exception {
	    
		int x = 0;

	    try {
	        conn = getConnection();
	        sql = "select count(*) from news where newstype = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, newstype);
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
	
	// 뉴스 타입별로 목록을 리스트로 가져옴
	public List<newsDTO> getNewsType(int start, int end, String newstype) throws Exception{
		
		List<newsDTO> newsList = new ArrayList<>();
		
		try {
			conn = getConnection();
			sql = "select * from (select e.*, rownum r from (select * from news where newstype = ? order by reg desc) e) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newstype);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
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
				}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleclose();
		}
		return newsList;
	}
}
