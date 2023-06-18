package helper;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import server.OracleServer;


public class Svcenter1DAO extends OracleServer {
	
	private static Svcenter1DAO instance = new Svcenter1DAO();
	public static Svcenter1DAO getInstance() {return instance;}
	
	private Svcenter1DAO() {}
	
	public void insertSvcenter1(Svcenter1DTO svDTO1) throws Exception{				//자주묻는질문을 작성시 테이블에 저장
		
		try {
			conn = getConnection();
			
			sql = "insert into svcenter1(num,id,title,con,reg) values(svcenter_seq.nextval,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, svDTO1.getId());
			pstmt.setString(2, svDTO1.getTitle());
			pstmt.setString(3, svDTO1.getCon());
			pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
	}
	
	public int getSvcenterCount1() throws Exception{						//작성된 글이 있는지 없는지 확인
		int x = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from svcenter1");	
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
	
	public List getSvcenter1(int start, int end) throws Exception{			//작성된 글이 있다면 1부터 10까지의 번호로 글을 꺼내 리스트로 저장
		List svcenterList1 = new ArrayList();
		
		try {
			conn = getConnection();
			sql = "select * from(select e.*, rownum r from(select * from svcenter1 order by reg desc)e) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Svcenter1DTO svdto1 = new Svcenter1DTO();
				svdto1.setNum(rs.getInt("num"));
				svdto1.setId(rs.getString("id"));
				svdto1.setTitle(rs.getString("title"));
				svdto1.setCon(rs.getString("con"));
				svdto1.setReg(rs.getTimestamp("reg"));
				svcenterList1.add(svdto1);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
		return svcenterList1;
	}
	
	public Svcenter1DTO getSvdto1(int num) throws Exception{				//글번호를 대입해서 테이블에 검색하고 해당 글번호의 정보를 꺼내옴
		Svcenter1DTO svdto1 = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from svcenter1 where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				svdto1 = new Svcenter1DTO();
				svdto1.setNum(rs.getInt("num"));
				svdto1.setId(rs.getString("id"));
				svdto1.setTitle(rs.getString("title"));
				svdto1.setCon(rs.getString("con"));
				svdto1.setReg(rs.getTimestamp("reg"));
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
		return svdto1;
	}
	
	public Svcenter1DTO updateGetSvcenter1(int num) throws Exception{		//글보는 창에서 수정버튼을 눌렀을 때 해당 글번호에 저장된 값을 꺼내서 출력
		Svcenter1DTO svdto1 = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from svcenter1 where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
		if(rs.next()) {
			svdto1 = new Svcenter1DTO();
			svdto1.setNum(rs.getInt("num"));
			svdto1.setId(rs.getString("id"));
			svdto1.setTitle(rs.getString("title"));
			svdto1.setCon(rs.getString("con"));
			svdto1.setReg(rs.getTimestamp("reg"));			
		}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
		return svdto1;
	}
	
	public void updateSvcenter1(Svcenter1DTO svdto1) throws Exception{		//수정을 하고 수정완료를 눌렀을 때 테이블에 업데이트
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "update svcenter1 set id = ?, title = ?, con = ? where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, svdto1.getId());
			pstmt.setString(2, svdto1.getTitle());
			pstmt.setString(3, svdto1.getCon());
			pstmt.setInt(4, svdto1.getNum());
			pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
	}
	
	public void deleteSvcenter1(int num) throws Exception{					//해당 글번호를 삭제
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "delete from svcenter1 where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally{
			oracleClose();
		}
	}
}