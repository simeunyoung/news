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
	
	// 작성자의 id의 게시글의 수를 구하는 메서드
	public int getMyArticleCount(String id) throws Exception{
		
		int x = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from board where writer = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleclose();
			}
		return x;
	}
	
	// 게시판 글을 조회, 해당 작성자가 작성한 글들을 페이징 처리하여 가져오는 메서드
	public List getMyArticles(String id, int start, int end) throws Exception{
		
		List articleList = null;
		
		try {
			conn = getConnection();
			// 작성자 id를 조건으로 board테이블에서 ref값을 기준으로 내림차순, re_step값을 기준으로 오름차순 정렬 후, start - end 범위 까지 결과 조회
			pstmt = conn.prepareStatement("select num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip, readcount, r" +
										"from (select num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip, readcount, rownum r" +
										"from (select * from board where writer = ? order by ref desc, re_step asc) order by ref desc, re_step asc) where r >= ? and r <= ?");
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articleList = new ArrayList(end);
				do {
					BoardDataBean article = new BoardDataBean();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
					articleList.add(article);
				} while(rs.next());
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleclose();
		}
		return articleList;
	}
}
