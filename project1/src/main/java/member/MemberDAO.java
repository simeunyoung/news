package member;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;



public class MemberDAO {
private static MemberDAO instance = new MemberDAO();
    
    public static MemberDAO getInstance() {return instance; }	//객체생성 된걸 return해줌 
    
    private MemberDAO() {}
    
    public Connection getConnection() {
    	//Connection conn = null;
    	Connection conn = null;	//연결
    	//PreparedStatement pstmt = null;	//query
    	//ResultSet rs = null;	//추출
    	//String sql = null;	//sql 작성
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String user = "team01", pw = "team", dburl = "jdbc:oracle:thin:@192.168.219.123:1521:orcl";
			conn = DriverManager.getConnection(dburl, user, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
    public ArrayList<MemberDTO> select() {
		ArrayList<MemberDTO> list = new ArrayList<>();
		Connection conn = getConnection();
		String sql = "select * from member";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try { pstmt = conn.prepareStatement(sql);
		 		rs = pstmt.executeQuery();
			while(rs.next()) {
		 		MemberDTO dto = new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setPress(rs.getString("press"));
				//dto.setNickame(rs.getString("nickname"));
				//dto.setTel(rs.getString("tel"));
				//dto.setDeptno(rs.getInt("deptno"));
				//dto.setReg(rs.getTimestamp("reg"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception se) {

				}
			}
			
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception se) {

				}
			}
			
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception se) {

				}
			}
			
		}
		return list;
	}
    public ArrayList<MemberDTO> pressReporter(String press) {
		ArrayList<MemberDTO> list = new ArrayList<>();
		Connection conn = getConnection();
		String sql = "select id, name from member where press=? and membertype='-1'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try { 	pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, press);
		 		rs = pstmt.executeQuery();
			while(rs.next()) {
		 		MemberDTO dto = new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception se) {

				}
			}
			
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception se) {

				}
			}
			
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception se) {

				}
			}
			
		}
		return list;
	}
    
}
