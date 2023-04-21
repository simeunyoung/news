package admin;

import java.util.List;
import java.util.ArrayList;

public class HelperDAO extends OracleServer {
	
	private static HelperDAO instance = new HelperDAO(); // 인스턴스 객체 생성
	public static HelperDAO getInstance() {return instance;} // 이미 만들어진 인스턴스 객체 불러옮
	private HelperDAO() {} // 기본생성자 사용불가
	
	// 1-1Form에서 받은 데이터를 받아 db에 입력해주는 메서드
	public boolean insertQna(HelperDTO dto) {
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
	
	// db에 있는 데이터 수를 result에 대입해주는 메서드
	public int getQnaCount() {
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
	public List getQnaList(int start, int end) {
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
	public HelperDTO getQna(int num) {
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
	
} // public class HelperDAO extends OracleServer {