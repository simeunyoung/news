package admin;

import java.util.ArrayList;
import java.util.List;
import member.MemberDTO;

public class AdminDAO extends OracleServer {
	
	private static AdminDAO instance = new AdminDAO(); // 인스턴스 객체 생성
	public static AdminDAO getInstance() {return instance;} // 인스턴스 객체 리턴
	private AdminDAO() {} // 기본생성자 사용불가

	// 매개변수인 id를 통해 db를 검색
	// 검색된 정보에서 type이 1이면 -1로 변경하는 메서드
	// journalistListPro.jsp
	// 4.25 수정
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
	
	// 매개변수인 id를 통해 db를 검색
	// 검색된 정보중 아이디, 이메일, 타입을 dto에 set
	// dto를 리턴
	// journalistForm.jsp
	// 4.25 수정
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
	
	// journalistForm에서 전달받은 내용을
	// 데이터베이스에 추가
	// journalistPro.jsp
	// 4.25 수정
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
	
	// db에 총 몇줄의 데이터가 있는지 검색
	// 반환된 데이터를 result에 대입 및 리턴
	// journalistList.jsp
	// 4.25 수정
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
	
	// db에 총 몇줄의 데이터가 있는지 검색
	// 검색된 데이터를 dto에 대입
	// dto를 리스트에 대입 및 리턴
	// journalistList.jsp
	// 4.25 수정
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
	
	// 1-1Form에서 보내온 정보를 받음
	// 해당 정보를 db에 추가후 result에 true 대입 및 리턴
	// 1-1Pro.jsp
	// 4.25 수정
	public boolean oneononeInsert(AdminDTO dto) {
		boolean result = false;
		try {
			conn = getConnection();
			sql = "insert into oneonone values(0,oneonone_seq.nextval,?,?,?,?,?,?,0,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getTitle());
			pstmt.setString(6, dto.getCon());
			pstmt.setString(7, dto.getMemberType());
			pstmt.setString(8, dto.getQuestionType());
			pstmt.setString(9, dto.getImg());
			pstmt.setString(10, dto.getIp());
			pstmt.executeUpdate();
			result = true;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	} // public boolean oneononeInsert(AdminDTO dto) {
		
	// db에 데이터 몇줄인지 검색
	// result에 대입 및 리턴
	// 1-1List.jsp
	// 4.25 수정
	public int oneononeCount() {
		int result = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from oneonone";
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
	// 1-1List.jsp
	// 4.25 수정
	public List oneononeList(int start, int end) {
		List oneononeList = new ArrayList();
		try {
			conn = getConnection();
			sql = "select * from (select e.*, rownum r from (select * from oneonone order by num desc) e) where r >=? and r <=?";
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
				oneononeList.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return oneononeList;
	} // public List oneononeList(int start, int end) {

	// 
	// 
	public AdminDTO oneononeGet(int num) {
		AdminDTO dto = null;
		int count = 0;
		try {
			conn = getConnection();
			sql = "update oneonone set readcount=readcount+1 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "select readcount from oneonone where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
				if(count >= 100) {
					sql = "update oneonone set resultType=1 where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
				}
			}
		
			sql = "select * from oneonone where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new AdminDTO();
				dto.setResultType(rs.getString("resultType"));
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
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
		
	// Q&A db에 데이터를 입력하는 메서드
	public boolean qnaInsert(AdminDTO dto) {
		boolean result = false;
		try {
			conn = getConnection();
			sql = "insert into qna values(oneonone_seq.nextval,?,?,?,?,0,?,?,?,?,sysdate)";
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
				qnaList.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return qnaList;
	} // public List qnaList(int start, int end) {
	
	// Q&A의 갯수를 확인하는 메서드
	public int getQnaCount() {
		int result = 0;
		try {
			conn = getConnection();
			sql ="select count(*) from qna";
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
	public AdminDTO qnaGet(int num) {
		AdminDTO dto = null;
		try {
			conn = getConnection();
			sql = "update qna set readcount=readcount+1 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "select * from qna where num=?";
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
	

} // public class AdminDAO extends OracleServer {