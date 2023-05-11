package revalue;

import java.util.ArrayList;
import java.util.List;
import news.NewsDTO;
import server.OracleServer;


public class RevalueDAO extends OracleServer {
	private static RevalueDAO instance = new RevalueDAO();
	public static RevalueDAO getInstance() { return instance;}
	private RevalueDAO() {}
	
	public int getMyReconCount(String id) {
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

	public List getMyReconList(String id, int startNum, int endNum) {
		List userList = new ArrayList();
		try {
			conn = getConnection();
			String sql = "select * from (select e.*,rownum r from (select * from revalue where id = ? order by num desc) e)where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);	
			pstmt.setString(1, id);
			pstmt.setInt(2, startNum);
			pstmt.setInt(3, endNum);
			rs = pstmt.executeQuery();
				while(rs.next()) {
					RevalueDTO recon = new RevalueDTO();
					recon.setNum(rs.getInt("num"));
					recon.setId(rs.getString("id"));
					recon.setTitle(rs.getString("title"));
					recon.setCon(rs.getString("con"));
					recon.setReCon(rs.getString("recon"));
					recon.setIp(rs.getString("ip"));	
					recon.setReg(rs.getTimestamp("reg"));									
					userList.add(recon);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return userList;
	}
	public int getReconNum(String title){
		int result = 0;
		try {
			conn = getConnection();
			sql = "select num from news where title=?"; 
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, title);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt("num");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}
}
