package member;

public class MemberDAO extends OracleServer {

		private static MemberDAO instance = new MemberDAO();
		
		public static MemberDAO getInstance() { return instance; }
		
		private MemberDAO() {}
		
		// 로그인 체크 메서드
		public int userCheck(String id, String pw) {
			String dbpw = "";
			int x = -1;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select pw from member where id = ?"); // 입력된 아이디에 해당하는 비밀번호를 찾는다.
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) { // 아이디가 있을 때
					dbpw = rs.getString("pw");
					if(dbpw.equals(pw)) {
						x = 1; // pw 있을 때 반환 값
					}else {
						x = 0; // pw 없을 때 반환 값
					}
				}else { // id가 없을 때 반환 값
					x = -1;
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return x;
		}

		// 중복 ID 체크 메서드
		public int confirmId(String id) {
			int x = -1;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select id from member where id = ?"); // 입력받은 id와 같은 id가 있는지 체크
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					x = 1; // 있으면 1 반환
				}else {
					x = -1; // 없으면 -1 반환
				}
			}catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return x;
		}

		public void insertMember(MemberDTO member) {
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("insert into member values(?,?,?,?,?,?,?,sysdate,'0',?)");
				pstmt.setString(1, member.getId());
				pstmt.setString(2, member.getPw());
				pstmt.setString(3, member.getName());
				pstmt.setString(4, member.getNickName());
				pstmt.setInt(5, member.getBirthday());
				pstmt.setString(6, member.getEmail());
				pstmt.setInt(7, member.getPNum());
				pstmt.setString(8, member.getPress());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
		}
}
