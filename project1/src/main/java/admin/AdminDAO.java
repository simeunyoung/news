package admin;

import java.util.ArrayList;
import java.util.List;
import member.MemberDTO;
import server.OracleServer;

public class AdminDAO extends OracleServer {
	
	private static AdminDAO instance = new AdminDAO(); // 인스턴스 객체 생성
	public static AdminDAO getInstance() {return instance;} // 인스턴스 객체 리턴
	private AdminDAO() {} // 기본생성자 사용불가

	// 매개변수인 id를 통해 member 테이블에서 레코드값 검색
	// 검색된 정보에서 membertype을 result에 대입
	// 대입된 값이 1(회원)이면 -1(기자)로 변경
	// 이후 매개변수인 id를 통해 jas 테이블에서 레코드값 검색
	// 값이 있으면 해당 레코드의 resulttype을 1로 변경 
	public String changeType(String id) {
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
			if(result.equals("1")) {
				sql = "update member set membertype=-1 where id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
				result = "-1";
			} // member mebertype 변경부분
			
			sql = "select * from jas where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sql = "update jas set resulttype=1 where id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
			} // jas resulttype 변경부분
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	} // public String changeType(String id) {
	
	// id를 통해 member테이블에서 검색
	// 검색된 레코드값 중 id, name, nick, email, tel, membertype을 dto에 set
	public MemberDTO setMember(String sid) {
		MemberDTO dto = new MemberDTO();
		try {
			conn = getConnection();
			sql = "select * from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setNick(rs.getString("nick"));
				dto.setEmail(rs.getString("email"));
				dto.setTel(rs.getString("tel"));
				dto.setMemberType(rs.getString("memberType"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return dto;
	} // public MemberDTO setMember(String sid) {
	
	// dto를 매개변수로 받아 jas 테이블에 insert
	public void insertJas(AdminDTO dto) {
		try {
			conn = getConnection();
			sql = "insert into jas values('0',?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getMemberType());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getIp());
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	} // public void insertJas(MemberDTO dto) {

	// jas 테이블에 총 몇줄의 레코드가 있는지 검색, result에 대입 후 return
	public int getJCount() {
		int result = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from jas where resulttype=0";
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
	} // public int getJCount() {
	
	// jas 테이블 매 레코드마다 dto를 만들고 레코드의 값을 dto에 set한 후 JList에 add
	public List getJList() {
		List JList = new ArrayList();
		try {
			conn = getConnection();
			sql = "select * from jas";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AdminDTO dto = new AdminDTO();
				dto.setResultType(rs.getString("resultType"));
				dto.setId(rs.getString("id"));
				dto.setMemberType(rs.getString("memberType"));
				dto.setEmail(rs.getString("email"));
				dto.setTel(rs.getString("tel"));
				dto.setIp(rs.getString("ip"));
				dto.setReg(rs.getTimestamp("reg"));
				JList.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return JList;
	} // public List getJList() {
	
	// id를 통해 jas테이블의 레코드를 검색, 해당하는 레코드가 있으면 resulttype을 2로 수정
	public int denyJas(MemberDTO dto) {
		int result = 0;
		try {
			conn = getConnection();
			sql = "update jas set resultType=2 where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}
	
	// 매개변수로 받은 dto의 데이터를 qna 테이블에 insert
	public boolean qnaInsert(AdminDTO dto) {
		boolean result = false;
		try {
			conn = getConnection();
			sql = "insert into qna values(0,qna_seq.nextval,?,?,?,?,?,?,?,0,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getTel());
			pstmt.setString(6, dto.getTitle());
			pstmt.setString(7, dto.getCon());
			pstmt.setString(8, dto.getMemberType());
			pstmt.setString(9, dto.getQuestionType());
			pstmt.setString(10, dto.getImg());
			pstmt.setString(11, dto.getIp());
			pstmt.executeUpdate();
			result = true;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	} // public boolean oneononeInsert(AdminDTO dto) {
	
	// qna 테이블에 레코드 갯수를 세고 result에 대입 및 return
	public int qnaCount() {
		int result = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from qna";
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
	} // public int oneononeCount() {
	
	// qna 테이블에서 resultType이 0인 레코드의 갯수를 result에 대입 및 return
	public int qnaCount2() {
		int result = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from qna where resultType=0";
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
	} // public int oneononeCount() {
	
	// db에 있는 정보를 num을 기준으로 내림차순, 위에서부터 아래로 로우넘 부여
	// 매개변수로 받은 start, end로 로우넘을 구분
	// 새로운 dto를 생성하고 해당하는 로우넘 번호 한 줄마다 dto에 입력
	// 입력된 dto를 리스트에 저장하는 작업을 반복
	// dto가 저장된 리스트를 리턴
	public List qnaList(int start, int end) {
		List qnaList = new ArrayList();
		try {
			conn = getConnection();
			sql = "select * from (select e.*, rownum r from (select * from qna order by num desc) e) where r >=? and r <=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AdminDTO dto = new AdminDTO();
				dto.setResultType(rs.getString("resultType"));
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setTel(rs.getString("tel"));
				dto.setTitle(rs.getString("title"));
				dto.setCon(rs.getString("con"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setQuestionType(rs.getString("questionType"));
				dto.setMemberType(rs.getString("memberType"));
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
	} // public List oneononeList(int start, int end) {
	
	// qna 테이블에서 num값으로 레코드를 찾고 readcount에 1을 더하고
	// 다시 qna 테이블에서 num값으로 레코드를 검색한 후 값이 있으면 resulttype에 readcount를 대입 // 5.2 5:37
	public AdminDTO qnaGet(int num) {
		AdminDTO dto = null;
		int count = 0;
		try {
			conn = getConnection();
			sql = "update qna set readcount=readcount+1 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "select readcount from qna where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
				if(count >= 100) {
					sql = "update qna set resultType=1 where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
				}
			}
		
			sql = "select * from qna where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new AdminDTO();
				dto.setResultType(rs.getString("resultType"));
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setTel(rs.getString("tel"));
				dto.setTitle(rs.getString("title"));
				dto.setCon(rs.getString("con"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setMemberType(rs.getString("memberType"));
				dto.setQuestionType(rs.getString("questionType"));
				dto.setImg(rs.getString("img"));
				dto.setIp(rs.getString("ip"));
				dto.setReg(rs.getTimestamp("reg"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return dto;
	} // public AdminDTO oneononeGet(int num) {
	
	public AdminDTO qnaUpdateGet(int num) {
		AdminDTO dto = null;
		int count = 0;
		try {
			conn = getConnection();
			sql = "select * from qnaRecon where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new AdminDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setCon(rs.getString("con"));
				dto.setRecon(rs.getString("recon"));
				dto.setIp(rs.getString("ip"));
				dto.setReg(rs.getTimestamp("reg"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return dto;
	} // public AdminDTO oneononeGet(int num) {
	
	public int qnaUpdate(AdminDTO dto) {
	int result = 0;
	try {
		conn = getConnection();
		sql = "update qna set questionType=?,title=?,pw=?,con=? where num=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getQuestionType());
		pstmt.setString(2, dto.getTitle());
		pstmt.setString(3, dto.getPw());
		pstmt.setString(4, dto.getCon());
		pstmt.setInt(5, dto.getNum());
		result = pstmt.executeUpdate();
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		oracleClose();
	}
	return result;
	}
	
	public int qnaDelete(AdminDTO dto) {
		int result = 0;
		try {
			conn = getConnection();
			sql = "delete from qna where num=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getPw());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	} // public int qnaDelete(AdminDTO dto) {
		
	// Q&A db에 데이터를 입력하는 메서드
	public boolean faqInsert(AdminDTO dto) {
		boolean result = false;
		try {
			conn = getConnection();
			sql = "insert into faq values(qna_seq.nextval,?,?,?,?,0,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getCon());
			pstmt.setString(5, dto.getMemberType());
			pstmt.setString(6, dto.getQuestionType());
			pstmt.setString(7, dto.getImg());
			pstmt.setString(8, dto.getIp());
			pstmt.executeUpdate();
			result = true;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	} // public boolean qnaInsert(AdminDTO dto) {
	
	// 시작값과 끝값을 입력하여 1~10 11~20등 특정 형식에 맞게 db 내 데이터를 List로 꺼내는 메서드
	public List faqList(int start, int end) {
		List faqList = new ArrayList();
		try {
			conn = getConnection();
			sql = "select * from (select e.*, rownum r from (select * from faq order by num desc) e) where r >=? and r <=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AdminDTO dto = new AdminDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setCon(rs.getString("con"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setMemberType(rs.getString("memberType"));
				dto.setQuestionType(rs.getString("questionType"));
				dto.setImg(rs.getString("img"));
				dto.setIp(rs.getString("ip"));
				dto.setReg(rs.getTimestamp("reg"));
				faqList.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return faqList;
	} // public List qnaList(int start, int end) {
	
	// Q&A의 갯수를 확인하는 메서드
	public int getfaqCount() {
		int result = 0;
		try {
			conn = getConnection();
			sql ="select count(*) from faq";
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
			sql = "select MemberType from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = Integer.parseInt(rs.getString("memberType"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	} // public int typeChk(String id) {
	
	// num을 이용하여 Q&A 정보를 dto에 set하는 메서드
	// 4.27 확인필요
	public AdminDTO faqGet(int num) {
		AdminDTO dto = null;
		try {
			conn = getConnection();
			sql = "update faq set readcount=readcount+1 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "select * from faq where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new AdminDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setCon(rs.getString("con"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setMemberType(rs.getString("memberType"));
				dto.setQuestionType(rs.getString("questionType"));
				dto.setImg(rs.getString("img"));
				dto.setIp(rs.getString("ip"));
				dto.setReg(rs.getTimestamp("reg"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return dto;
	} // public AdminDTO getQna(int num) {
	
	public int qnaReconCount() {
		int result = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from qnaRecon";
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
	} // public int qnaReconCount() {
	
	public List qnaReconList(int start, int end) {
		List qnaReconList = new ArrayList();
		try {
			conn = getConnection();
			sql = "select * from (select e.*, rownum r from (select * from qnaRecon order by num desc) e) where r >=? and r <=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AdminDTO dto = new AdminDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setCon(rs.getString("con"));
				dto.setRecon(rs.getString("recon"));
				dto.setIp(rs.getString("ip"));
				dto.setReg(rs.getTimestamp("reg"));
				qnaReconList.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return qnaReconList;
	} // public List oneononeList(int start, int end) {
	
	public void qnaReconInsert(AdminDTO dto) {
		try {
			conn = getConnection();
			sql = "insert into qnaRecon values(qnaRecon_seq.nextval,?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getCon());
			pstmt.setString(5, dto.getRecon());
			pstmt.setString(6, dto.getIp());
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	} // public void qnaReconInsert(AdminDTO dto) {
	
} // public class AdminDAO extends OracleServer {