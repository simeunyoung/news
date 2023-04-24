package admin;

import java.util.ArrayList;
import java.util.List;
import member.MemberDTO;

public class AdminDAO extends OracleServer {
	
	private static AdminDAO instance = new AdminDAO(); // 인스턴스 객체 생성
	public static AdminDAO getInstance() {return instance;} // 인스턴스 객체 리턴
	private AdminDAO() {} // 기본생성자 사용불가

	// 로그인 관련 ------------------------------------------------
	
	// id를 통해 db를 확인하고 type이 0이면 1로 바꾸는 메서드
	public String addJournalist(String id) {
		String result = "";
		try {
			conn = getConnection();
			sql = "select * from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getString("membertype");
			}
			if(result.equals("0")) {
				sql = "update member set type=1 where id=?";
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
	
	// id를 통해 db를 확인하고 dto에 id, email, type을 set하는 메서드
	// set 부분이 더 추가되야할 수 있음
	public MemberDTO memberTypeCheck(String sid) {
		MemberDTO dto = new MemberDTO();
		try {
			conn = getConnection();
			sql = "select * from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setEmail(rs.getString("email"));
				dto.setMemberType(rs.getString("memberType"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return dto;
	} // public LoginDTO typeChk(String sid) {
	
	// 로그인 관련 ------------------------------------------------	
	// 고객센터 관련 -----------------------------------------------
	
	// dto를 입력받아 기자신청명단 db에 등록하는 메서드
	// set값 추가되야할듯
	public void insertPJ(MemberDTO dto) {
		try {
			conn = getConnection();
			sql = "insert into pj values(?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getMemberType());
			pstmt.setString(3, dto.getEmail());
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	} // public void insertPJ(LoginDTO dto) {
	
	// 기자신청명단 db에 몇명이 등록되어있는지 확인하는 메서드
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
	
	// 기자신청 명단에 있는 데이터들을 List로 꺼내주는 메서드
	public List getJList() {
		List JList = new ArrayList();
		try {
			conn = getConnection();
			sql = "select * from pj";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setMemberType(rs.getString("memberType"));
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
	
	// 고객센터 관련 -----------------------------------------------	
	// 1:1 관련 --------------------------------------------------
	
	// 1-1Form에서 받은 데이터를 받아 db에 입력해주는 메서드
	// dto 통합후 확인
		public boolean oneononeInsert(HelperDTO dto) {
			boolean result = false;
			try {
				conn = getConnection();
				sql = "insert into project1(num,name,pw,email,subject,content,readcount,ip,reg) values(project1_seq.nextval,?,?,?,?,?,?,?,sysdate)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getName());
				pstmt.setString(2, dto.getPw());
				pstmt.setString(3, dto.getEmail());
				pstmt.setString(4, dto.getSubject());
				pstmt.setString(5, dto.getContent());
				pstmt.setInt(6, dto.getReadcount());
				pstmt.setString(7, dto.getIp());
				pstmt.executeUpdate();
				result = true;
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return result;
		} // public boolean insertQNA(HelperDTO dto) {
		
		// 1:1 문의 db 데이터수를 result에 대입
		// 테이블명 확인요망
		public int oneononeCount() {
			int result = 0;
			try {
				conn = getConnection();
				sql = "select count(*) from project1";
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
		} // public int getQnaCount() {
		
		// db 데이터를 리스트에 넣는 메서드인데 전부다 한꺼번에 꺼내오도록 되어있음
		// 추후에 일정 갯수만 가져오도록 수정요망
		public List oneononeList(int start, int end) {
			List qnaList = new ArrayList();
			try {
				conn = getConnection();
				sql = "select * from (select e.*, rownum r from (select * from project1 order by num desc) e) where r >=? and r <=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					HelperDTO dto = new HelperDTO();
					dto.setNum(rs.getInt("num"));
					dto.setName(rs.getString("name"));
					dto.setPw(rs.getString("pw"));
					dto.setEmail(rs.getString("email"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setType(rs.getString("type"));
					dto.setIp(rs.getString("ip"));
					dto.setReg(rs.getTimestamp("reg"));
					qnaList.add(dto);
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return qnaList;
		} // public List getQnaList() {
		
		// 글 고유번호를 입력받아서 그 고유번호의 데이터를 dto에 대입해주는 메소드
		public HelperDTO oneononeGet(int num) {
			HelperDTO dto = null;
			try {
				conn = getConnection();
				sql = "update project1 set readcount = readcount+1 where num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				sql = "select * from project1 where num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					dto = new HelperDTO();
					dto.setNum(rs.getInt("num"));
					dto.setName(rs.getString("name"));
					dto.setPw(rs.getString("pw"));
					dto.setEmail(rs.getString("email"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setType(rs.getString("type"));
					dto.setIp(rs.getString("ip"));
					dto.setReg(rs.getTimestamp("reg"));
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return dto;
		} // public HelperDTO getQna(int num) {
		
		// 고객센터 관련 ------------------------------------------------
		// Q&A 관련 ---------------------------------------------------
		
		// Q&A db에 데이터를 입력하는 메서드
		public boolean qnaInsert(QnaDTO dto) {
			boolean result = false;
			try {
				conn = getConnection();
				sql = "insert into pqna values(pqna_seq.nextval,?,?,?,sysdate)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getId());
				pstmt.setString(2, dto.getSubject());
				pstmt.setString(3, dto.getContent());
				pstmt.executeUpdate();
				result = true;
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return result;
		} // public boolean insertQNA(HelperDTO dto) {
		
		// 시작값과 끝값을 입력하여 1~10 11~20등 특정 형식에 맞게 db 내 데이터를 List로 꺼내는 메서드
		public List qnaList(int start, int end) {
			List qnaList = new ArrayList();
			try {
				conn = getConnection();
				sql = "select * from (select e.*, rownum r from (select * from pqna order by num desc) e) where r >=? and r <=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					QnaDTO dto = new QnaDTO();
					dto.setNum(rs.getInt("num"));
					dto.setId(rs.getString("id"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setReg(rs.getTimestamp("reg"));
					qnaList.add(dto);
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return qnaList;
		} // public List getQnaList(int start, int end) {
		
		// Q&A의 갯수를 확인하는 메서드
		public int getQnaCount() {
			int result = 0;
			try {
				conn = getConnection();
				sql ="select count(*) from pqna";
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
		} // public int getQnaCount() {
		
		// 아이디를 입력받아 Type을 확인하는 메서드
		public int typeChk(String id) {
			int result = 0;
			try {
				conn = getConnection();
				sql = "select type from plogin where id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					result = Integer.parseInt(rs.getString("type"));
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return result;
		} // public int typeChk(String id) {
		
		// num을 이용하여 Q&A 정보를 dto에 set하는 메서드
		public QnaDTO getQna(int num) {
			QnaDTO dto = null;
			try {
				conn = getConnection();
				sql = "select * from pqna where num=?";
				pstmt= conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					dto = new QnaDTO();
					dto.setNum(rs.getInt("num"));
					dto.setId(rs.getString("id"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setReg(rs.getTimestamp("reg"));
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return dto;
		} // public QnaDTO getQna(int num) {
		// Q&A 관련 ---------------------------------------------------
		
}
