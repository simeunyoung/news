package admin;

import java.util.ArrayList;
import java.util.List;

public class QnaDAO extends OracleServer {
	
	private static QnaDAO instance = new QnaDAO();
	public static QnaDAO getInstance() {return instance;}
	private QnaDAO() {}
	
	public boolean insertQna(QnaDTO dto) {
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
	
	public List getQnaList(int start, int end) {
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
	
} // public class qnaDAO extends OracleServer {
