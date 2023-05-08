package helper;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import admin.AdminDTO;

import server.OracleServer;


public class SvcenterDAO extends OracleServer{
	
	private static SvcenterDAO instance = new SvcenterDAO();
	
	public static SvcenterDAO getInstance() {return instance;}
	private SvcenterDAO() {}
	
	public void insertSvcenter(SvcenterDTO svDTO, String id) throws Exception{				
		try {
			conn = getConnection();
			sql = "insert into svcenter values(svcenter_seq.nextval,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);					//세션에서 넘겨받은 id값을 대입
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
	
	public SvcenterDTO getSvDTO(int num1) throws Exception{				//글번호를 대입해서 테이블에 검색하고 해당 글번호의 정보를 꺼내옴
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
	
	public int getSvcenterCount() throws Exception{				//1대1 문의글이 있는지 없는지 확인
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
	
	public int getMySvcenterCount(String id) throws Exception{	//본인이 작성한 글이 있는지 없는지 세션에서 넘겨받은 id로 테이블에 검색
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from qna where id = ?");
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
	
	public List getSvcenter(int start, int end) throws Exception{	//작성된 글이 있다면 1부터 10까지의 번호로 글을 꺼내 리스트로 저장
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
	
	public List getMySvcenter(String id, int start, int end) throws Exception{	//본인이 작성한 글이 있다면 1부터 10까지의 번호로 글을 꺼내옴
		List svcenterList = new ArrayList();
		
		try {
			conn = getConnection();
			sql = "select * from (select e.*, rownum r from (select * from qna where id = ? order by num desc) e) where r >=? and r <=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
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
			svcenterList.add(dto);
		}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
		return svcenterList;
	}
	
	public SvcenterDTO updateGetSvcenter(int num) throws Exception{			//파라미터로 글번호 값을 받아와서 대입하여 테이블에 검색하고 저장된 값을 꺼냄
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
		String dbpasswd = "";												//작성시 넣은 패스워드를 저장할 변수
		String sql = "";
		int x = -1;															//테이블에 저장된 비밀번호 값과 입력받은 비밀번호가 맞는지 틀린지 확인하기 위한 변수
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select pw from svcenter where num1 = ?");		//해당 글번호를 넣고 테이블에 비밀번호를 검색해서 꺼내옴
			pstmt.setInt(1, svdto.getNum1());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {dbpasswd = rs.getString("pw");									//꺼내온 값을 저장함
			
			if(dbpasswd.equals(svdto.getPw())) {											//테이블에 저장된 값과 입력받은 비밀번호를 비교
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
	
	public int deleteSvcenter(int num, String pw) throws Exception{						//넘겨받은 글번호와 비밀번호	
		String dbpasswd = "";															//작성시 넣은 패스워드를 저장할 변수
		int x = -1;																		//테이블에 저장된 비밀번호 값과 입력받은 비밀번호가 맞는지 틀린지 확인하기 위한 변수
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select pw from svcenter where num1 = ?");	//테이블에 넘겨받은 글번호를 넣고 테이블에 저장된 해당 글번호의 비밀번호를 검색
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
		if(rs.next()) {
			dbpasswd = rs.getString("pw");
			if(dbpasswd.equals(pw)) {													//테이블에서 검색한 비밀번호와 입력받아서 가지고 온 비밀번호를 비교
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
