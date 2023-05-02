package news;

import news.OracleServer;

public class RatingDAO extends OracleServer {
	
	private static RatingDAO instance = new RatingDAO();
	public static RatingDAO getInstance() {return instance;}
	private RatingDAO() {}
	
	public int goodinsert(String id , int num) throws Exception{		//추가는 될텐대 계속 눌릴 것.
		String dbid = "";
		int result = -1;
		try {
			conn = getConnection();					
			sql = "select id from rating where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
				
			if(rs.next()) {dbid = rs.getString("id");
				
			if(dbid.equals(id)) {			//세션에서 받아온 id와 평점 테이블에 같은 id가 있는지 확인
				result = 0;
			}else{
			sql = "insert into rating values(?,?,?+1)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, id);
			pstmt.setInt(3, rs.getInt("good"));
			result = 1;
			}
		}		
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
	return result;
	}

	public int badinsert(String id, int num) throws Exception{
		String dbid = "";
		int result = -1;
		
		try {
			conn = getConnection();
			sql = "select id from rating where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
				
			if(rs.next()) {dbid = rs.getString(id);
				
			if(dbid.equals(id)) {
				result = 0;
			}else{
				sql = "insert into rating values(?,?,?-1)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, id);
				pstmt.setInt(3, rs.getInt("bad"));
				result = 1;
				}
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
		return result;
	} 
}
