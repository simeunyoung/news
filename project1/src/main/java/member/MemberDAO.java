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
				pstmt = conn.prepareStatement("insert into member values(?,?,?,?,?,?,?,?,sysdate,'0')");
				pstmt.setString(1, member.getId());
				pstmt.setString(2, member.getPw());
				pstmt.setString(3, member.getName());
				pstmt.setString(4, member.getPress());
				pstmt.setString(5, member.getNick());
				pstmt.setString(6, member.getEmail());
				pstmt.setString(7, member.getTel());
				pstmt.setString(8, member.getBirthdate());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
		}
		
		public String idFind(MemberDTO member) {
			String result = null;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select id from member where name=? and birthdate=?");
				pstmt.setString(1, member.getName());
				pstmt.setString(2, member.getBirthdate());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getString("id");
				}
			}catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return result;
		}
		
		public String pwFind(MemberDTO member) {
			String result = null;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select pw from member where id=? and email=?");
				pstmt.setString(1, member.getId());
				pstmt.setString(2, member.getEmail());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getString("pw");
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return result;
		}

		public MemberDTO getMember(String id) {
			MemberDTO member = null;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select * from member where id = ?");
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					member = new MemberDTO();
					member.setId(rs.getString("id"));
					member.setPw(rs.getString("pw"));
					member.setName(rs.getString("name"));
					member.setNick(rs.getString("nick"));
					member.setEmail(rs.getString("email"));
					member.setTel(rs.getString("tel"));
					member.setBirthdate(rs.getString("birthdate"));
					member.setReg(rs.getTimestamp("reg"));
					member.setMemberType(rs.getString("memberType"));
				}
			}catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return member;
		}

		public void updateMember(MemberDTO member) {
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("update member set pw=?,name=?,press=?,nick=?,email=?,tel=?,birthdate=?,reg=?,membertype=? where id=?");
				pstmt.setString(1, member.getPw());
				pstmt.setString(2, member.getName());
				pstmt.setString(3, member.getPress());
				pstmt.setString(4, member.getNick());
				pstmt.setString(5, member.getEmail());
				pstmt.setString(6, member.getTel());
				pstmt.setString(7, member.getBirthdate());			
				pstmt.setTimestamp(8, member.getReg());			
				pstmt.setString(9, member.getMemberType());
				pstmt.setString(10, member.getId());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
		}

		public int deleteMember(String id, String pw) {
			int x = -1;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select pw from member where id =? ");
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					String dbpw=rs.getString("pw");
					if(dbpw.equals(pw)) {
						pstmt = conn.prepareStatement("delete from member where id = ?");
						pstmt.setString(1, id);
						pstmt.executeUpdate();
						x = 1;
					}else {
						x = 0;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return x;
		}

}
