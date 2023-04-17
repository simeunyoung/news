package revalue;

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
}
