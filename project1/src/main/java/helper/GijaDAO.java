package helper;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import admin.OracleServer;

public class GijaDAO extends OracleServer {
	private static GijaDAO instance = new GijaDAO();
	
	public static GijaDAO getInstance() {return instance;}
	private GijaDAO() {}
	
	public void insertGija(GijaDTO gdto) throws Exception{
		try { 
			conn = getConnection();
			sql = "insert into gijasub values(svcenter_seq.nextval,?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, gdto.getId());
			pstmt.setString(2, gdto.getName());
			pstmt.setString(3, gdto.getPress());
			pstmt.setString(4, gdto.getEmail());
			pstmt.setString(5, gdto.getTel());
			pstmt.setString(6, gdto.getMembertype());
			pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
	}
	
	public GijaDTO getGjdto(int num) throws Exception{
		GijaDTO gdto = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from gijasub where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
		if(rs.next()) {
			gdto = new GijaDTO();
			gdto.setNum(rs.getInt("num"));
			gdto.setId(rs.getString("id"));
			gdto.setName(rs.getString("name"));
			gdto.setPress(rs.getString("press"));
			gdto.setEmail(rs.getString("email"));
			gdto.setTel(rs.getString("tel"));
			gdto.setMembertype(rs.getString("membertype"));
			gdto.setReg(rs.getTimestamp("reg"));
		}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
		return gdto;
	}
	
	public int getGijaCount() throws Exception{
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from gijasub");
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
	
	public List getGija(int start, int end) throws Exception{
		List gijaList = new ArrayList();
		
		try {
			conn = getConnection();
			sql = "select * from(select e.*, rownum r from(select * from gijasub order by reg desc)e) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
		while(rs.next()) {
			GijaDTO gdto = new GijaDTO();
			gdto.setNum(rs.getInt("num"));
			gdto.setId(rs.getString("id"));
			gdto.setName(rs.getString("name"));
			gdto.setPress(rs.getString("press"));
			gdto.setEmail(rs.getString("email"));
			gdto.setTel(rs.getString("tel"));
			gdto.setMembertype(rs.getString("membertype"));
			gdto.setReg(rs.getTimestamp("reg"));
			gijaList.add(gdto);
		}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
		return gijaList;
	}
}
