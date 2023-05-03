package news;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import server.OracleServer;

public class RatingDAO extends OracleServer {
	
	private static RatingDAO instance = new RatingDAO();
	public static RatingDAO getInstance() {return instance;}
	private RatingDAO() {}
	
	public int goodinsert(String id , int num , RatingDTO rDTO) throws Exception{	//좋아요를 눌렀을때 동작하는 메소드
		String dbid = "";
		int result = -1;
		try {
			conn = getConnection();					
			sql = "select id from rating where num = ?";			//넘겨받은 글번호를 넣고 테이블에 id를 검색
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
				
			if(rs.next()) {
				dbid = rs.getString("id");
			}
			
			if(dbid.equals(id)) {									//세션에서 받아온 id와 평점 테이블을 검색해서 같은 id가 있는지 확인
				sql = "delete from rating where id = ? and num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, num);
				pstmt.executeUpdate();
				result = 0;
			}else{
				sql = "insert into rating values(?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, id);
				pstmt.setInt(3, rDTO.getGood()+1);
				pstmt.setInt(4, rDTO.getBad());
				pstmt.setInt(5, rDTO.getTotal()+1);
				pstmt.executeUpdate();
				result = 1;
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
	return result;
	}

	public int badinsert(String id, int num, RatingDTO rDTO) throws Exception{
		String dbid = "";
		int result = -1;
		
		try {
			conn = getConnection();
			sql = "select id from rating where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
				
			if(rs.next()) {dbid = rs.getString("id");}
				
			if(dbid.equals(id)) {
				sql = "delete from rating where id = ? and num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, num);
				pstmt.executeUpdate();
				result = 0;
			}else{
				sql = "insert into rating values(?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, id);
				pstmt.setInt(3, rDTO.getGood());
				pstmt.setInt(4, rDTO.getBad()-1);
				pstmt.setInt(5, rDTO.getTotal()-1);
				pstmt.executeUpdate();
				result = 1;
				}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
		return result;
	}
	
	public int ratingcount(int num) throws Exception{				//좋아요 싫어요를 합쳐서 뉴스 content.jsp의 Count에 대입을 함
		int x = 0;
		
		try {
			conn = getConnection();
			sql = "select sum(good + bad) from rating where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
		if(rs.next()) {
			x = rs.getInt(1);
		}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
		return x;
	}
	
	public RatingDTO getRatingDTO(int num) throws Exception{
		RatingDTO rdto = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select sum(good),sum(bad),sum(total) from rating where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				rdto = new RatingDTO();
				rdto.setGood(rs.getInt("sum(good)"));
				rdto.setBad(rs.getInt("sum(bad)"));
				rdto.setTotal(rs.getInt("sum(total)"));
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
		return rdto;
	}
}
