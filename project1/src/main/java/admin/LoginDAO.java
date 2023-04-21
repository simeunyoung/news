package admin;

import java.util.List;
import java.util.ArrayList;

public class LoginDAO extends OracleServer {
	
	private static LoginDAO instance = new LoginDAO();
	public static LoginDAO getInstance() {return instance;}
	private LoginDAO() {}
	
	public boolean signUp(LoginDTO dto) {
		boolean result = false;
		try {
			conn = getConnection();
			sql = "insert into plogin values(?,?,?,'0',?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getIp());
			pstmt.executeUpdate();
			result = true;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	} // public int signUp(LoginDTO dto) {
	
	public boolean signIn(String id, String pw) {
		boolean result = false;
		try {
			conn = getConnection();
			sql = "select * from plogin where id=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}
	
	public String addJournalist(String id) {
		String result = "";
		try {
			conn = getConnection();
			sql = "select * from plogin where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getString("type");
			}
			if(result.equals("0")) {
				sql = "update plogin set type=1 where id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
				result = "1";
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	} // public String addJournalist(String id) {
	
	public LoginDTO typeChk(String sid) {
		LoginDTO dto = new LoginDTO();
		try {
			conn = getConnection();
			sql = "select * from plogin where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setEmail(rs.getString("email"));
				dto.setType(rs.getString("type"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return dto;
	}
	
	public void insertPJ(LoginDTO dto) {
		try {
			conn = getConnection();
			sql = "insert into pj values(?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getType());
			pstmt.setString(3, dto.getEmail());
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	} // public void insertPJ(LoginDTO dto) {
	
	public int getJCount() {
		int result = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from pj";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	} // public int getPJCount() {
	
	public List getJList() {
		List JList = new ArrayList();
		try {
			conn = getConnection();
			sql = "select * from pj";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				LoginDTO dto = new LoginDTO();
				dto.setId(rs.getString("id"));
				dto.setType(rs.getString("Type"));
				dto.setEmail(rs.getString("email"));
				JList.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return JList;
	} // public List getJList() {
	
} // public class LoginDAO extends OracleServer {
