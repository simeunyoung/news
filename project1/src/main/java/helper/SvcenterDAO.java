package helper;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import admin.OracleServer;


public class SvcenterDAO extends OracleServer{
	
	private static SvcenterDAO instance = new SvcenterDAO();
	
	public static SvcenterDAO getInstance() {return instance;}
	private SvcenterDAO() {}
	
	public void insertSvcenter(SvcenterDTO svDTO) throws Exception{
		try {
			conn = getConnection();
			sql = "insert into svcenter values(svcenter_seq.nextval,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, svDTO.getId());
			pstmt.setString(2, svDTO.getTitle());
			pstmt.setString(3, svDTO.getEmail());
			pstmt.setString(4, svDTO.getCon());
			pstmt.setString(5, svDTO.getPw());
			pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
	}
	
	public SvcenterDTO getSvDTO(int num1) throws Exception{
		SvcenterDTO svdto = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from svcenter where num1 = ?");
			pstmt.setInt(1, num1);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				svdto = new SvcenterDTO();
				svdto.setNum1(rs.getInt("num1"));
				svdto.setId(rs.getString("id"));
				svdto.setTitle(rs.getString("title"));
				svdto.setEmail(rs.getString("email"));
				svdto.setCon(rs.getString("con"));
				svdto.setPw(rs.getString("pw"));
				svdto.setReg(rs.getTimestamp("reg"));
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
		return svdto;
	}
	
	public int getSvcenterCount() throws Exception{
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from svcenter");
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
	
	public int getMySvcenterCount(String id) throws Exception{
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from svcenter");
			pstmt.setString(1, id);
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
	
	public List getSvcenter(int start, int end) throws Exception{
		List svcenterList = new ArrayList();
		
		try {
			conn = getConnection();
			sql = "select * from(select e.*, rownum r from(select * from svcenter order by reg desc)e) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
					SvcenterDTO svdto = new SvcenterDTO();
					svdto.setNum1(rs.getInt("num1"));
					svdto.setId(rs.getString("id"));
					svdto.setTitle(rs.getString("title"));
					svdto.setEmail(rs.getString("email"));
					svdto.setCon(rs.getString("con"));
					svdto.setPw(rs.getString("pw"));
					svdto.setReg(rs.getTimestamp("reg"));
					svcenterList.add(svdto);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
		return svcenterList;
	}
	
	public List getMySvcenter(String id, int start, int end) throws Exception{
		List svcenterList = new ArrayList();
		
		try {
			conn = getConnection();
			sql = "select * from(select e.*, rownum r from(select * from svcenter order by reg desc)e) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			
		while(rs.next()) {
			SvcenterDTO svdto = new SvcenterDTO();
			svdto.setNum1(rs.getInt("num1"));
			svdto.setId(rs.getNString("id"));
			svdto.setTitle(rs.getString("title"));
			svdto.setEmail(rs.getString("email"));
			svdto.setCon(rs.getString("con"));
			svdto.setPw(rs.getString("pw"));
			svdto.setReg(rs.getTimestamp("reg"));
			svcenterList.add(svdto);
		}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
		return svcenterList;
	}
	
	public SvcenterDTO updateGetSvcenter(int num) throws Exception{
		SvcenterDTO svdto = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from svcenter where num1 = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
		if(rs.next()) {
			svdto = new SvcenterDTO();
			svdto.setNum1(rs.getInt("num1"));
			svdto.setId(rs.getString("id"));
			svdto.setTitle(rs.getString("title"));
			svdto.setEmail(rs.getString("email"));
			svdto.setCon(rs.getString("con"));
			svdto.setPw(rs.getString("pw"));
			svdto.setReg(rs.getTimestamp("reg"));
		}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
		return svdto;
	}
	
	public int updateSvcenter(SvcenterDTO svdto) throws Exception{
		String dbpasswd = "";
		String sql = "";
		int x = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select pw from svcenter where num1 = ?");
			pstmt.setInt(1, svdto.getNum1());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {dbpasswd = rs.getString("pw");
			
			if(dbpasswd.equals(svdto.getPw())) {
				sql = "update svcenter set id = ?, title = ?, email = ?, con = ?, pw = ? where num1 = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, svdto.getId());
				pstmt.setString(2, svdto.getTitle());
				pstmt.setString(3, svdto.getEmail());
				pstmt.setString(4, svdto.getCon());
				pstmt.setString(5, svdto.getPw());
				pstmt.setInt(6, svdto.getNum1());
				pstmt.executeUpdate();
				x = 1;
			}else {
				x = 0;
			}
				}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
	return x;
	}
	
	public int deleteSvcenter(int num, String pw) throws Exception{
		String dbpasswd = "";
		int x = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select pw from svcenter where num1 = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
		if(rs.next()) {
			dbpasswd = rs.getString("pw");
			if(dbpasswd.equals(pw)) {
				pstmt = conn.prepareStatement("delete from svcenter where num1 = ?");
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				x = 1;
			}else {
				x = 0;
			}
		}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
		return x;
	}
}
