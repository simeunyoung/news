package project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

public class NewsDAO extends OracleServer {
	private static NewsDAO instance = new NewsDAO();
	public static NewsDAO getInstance() {return instance;}
	private NewsDAO() {}
	
	// new-main
	public int CountAllList() throws Exception { // 뉴스의 작성된 글 수를 전부 읽어준다.
		int x=0;
		try {
			conn = getConnection();
			sql="select count(*) from news";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x= rs.getInt(1); 
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return x; 
	} // public int CountAllList() throws Exception {
	

	
	public void insert(NewsDTO dto) {
		try {
			conn = getConnection();
			sql = "insert into news(num,pw,title,con,newstype,ip,reg,id) values(news_seq.nextval,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPw());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getCon());
			pstmt.setString(4, dto.getNewstype());
			pstmt.setString(5, dto.getIp());
			pstmt.setTimestamp(6, dto.getReg());
			pstmt.setString(7, dto.getId());
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	} // public boolean insert(NewsDTO dto) {
	
	public void insertRecon(NewsDTO dto) {
		try {
			conn = getConnection();
			sql = "insert into revalue values(revalue_seq.nextval,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getCon());
			pstmt.setString(4, dto.getRecon());
			pstmt.setString(5, dto.getIp());
			pstmt.setTimestamp(6, dto.getReg());
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	} // public void insertrecon(NewsDTO dto) {
	
	public NewsDTO getCon(int num) throws Exception {
		NewsDTO info=null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
			"update news set views=views+1 where num = ?");  // 조회수가 1씩 증가한다. 게시글 번호에 맞는 곳에서
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement(
			"select * from news where num = ?");  // 게시글 번호의 정보를 찾기
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) { // 게시글 번호에 맞는 정보를 찾기
				info = new NewsDTO();
				info.setNum(rs.getInt("num"));
				info.setId(rs.getString("id"));
				info.setNewstype(rs.getString("newstype"));
				info.setTitle(rs.getString("title"));
				info.setCon(rs.getString("con"));
				info.setReg(rs.getTimestamp("reg"));
				info.setPw(rs.getString("pw"));
				info.setIp(rs.getString("ip"));
				info.setViews(rs.getInt("views"));
				info.setPress(rs.getString("press"));
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		
		return info;
	}
	
	public NewsDTO getdata(int num) throws Exception { //form페이지에서 기존 데이터를 가져와서 변경하고 보내는 역활
		NewsDTO info=null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from news where num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			rs = pstmt.executeQuery();
			if (rs.next()) { // 게시글 번호에 맞는 정보를 찾기
				info = new NewsDTO();
				info.setNum(rs.getInt("num"));
				info.setId(rs.getString("id"));
				info.setNewstype(rs.getString("newstype"));
				info.setTitle(rs.getString("title"));
				info.setCon(rs.getString("con"));
				info.setReg(rs.getTimestamp("reg"));
				info.setPw(rs.getString("pw"));
				info.setIp(rs.getString("ip"));
				info.setViews(rs.getInt("views"));
				info.setPress(rs.getString("press"));
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		
		return info;
	} // public NewsDTO getdata(int num) throws Exception {
	
	public NewsDTO getRecon(int num) throws Exception { //form페이지에서 기존 데이터를 가져와서 변경하고 보내는 역활
		NewsDTO info=null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from revalue where num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			rs = pstmt.executeQuery();
			if (rs.next()) { // 게시글 번호에 맞는 정보를 찾기
				info = new NewsDTO();
				info.setNum(rs.getInt("num"));
				info.setId(rs.getString("id"));
				info.setTitle(rs.getString("title"));
				info.setCon(rs.getString("con"));
				info.setRecon(rs.getString("recon"));
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		
		return info;
	} // public NewsDTO getRecon(int num) throws Exception {
	
	public int update(NewsDTO info) throws Exception { // 폼페이지에서 변경한 데이터를 sql에 전달하는 역활
		String checkpw = "";
		int result = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"select pw from news where num=?"); // 해당 게시글 비번을 불러와서 삭제 전 글 비번과 입력한 비번과 비교
			pstmt.setInt(1, info.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				checkpw = rs.getString("pw");
				if (checkpw.equals(info.getPw())) {
					result = 1;
					sql = "update news set id=?,newstype=?,title=?,con=?,pw=? where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, info.getId());
					pstmt.setString(2, info.getNewstype());
					pstmt.setString(3, info.getTitle());
					pstmt.setString(4, info.getCon());
					pstmt.setString(5, info.getPw());
					pstmt.setInt(6, info.getNum());
					pstmt.executeUpdate();
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	} // public int update(NewsDTO info) throws Exception {
	
	public void reconupdate(NewsDTO info) throws Exception { // 폼페이지에서 변경한 데이터를 sql에 전달하는 역활
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update revalue set recon=? where num=?"); // 해당 게시글 비번을 불러와서 삭제 전 글 비번과 입력한 비번과 비교
			pstmt.setString(1, info.getRecon());
			pstmt.setInt(2, info.getNum());
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		
	} // public int reconupdate(NewsDTO info) throws Exception {
	
	public List gettexts(int a, int b) throws Exception {
		List textList = null;
		try {
			conn = getConnection();
			sql = "select * from (select e.*,rownum r from (select num,id,newstype,title,con,reg,pw,ip,views,press from news order by reg desc) e )"
					+ " where r >= ? and r <= ?";  
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, a);
			pstmt.setInt(2, b);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				textList = new ArrayList(b); // end는 list의 최대 공간을 의미한다.
					NewsDTO allinfo = new NewsDTO();
					do {
					allinfo = new NewsDTO();
					allinfo.setNum(rs.getInt("num"));
					allinfo.setId(rs.getString("id"));
					allinfo.setNewstype(rs.getString("newstype"));
					allinfo.setTitle(rs.getString("title"));
					allinfo.setCon(rs.getString("con"));
					allinfo.setReg(rs.getTimestamp("reg"));
					allinfo.setPw(rs.getString("pw"));
					allinfo.setIp(rs.getString("ip"));
					allinfo.setViews(rs.getInt("views"));
					allinfo.setPress(rs.getString("press"));
					textList.add(allinfo);
					}while(rs.next()); // while문으로 하면 최근 작성한 게시글이 나오지 않기 때문에 do-while문을 사용
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return textList;
	} // public List getTexts(int start, int end) throws Exception {
	
	
	public List getRecon(String title,String con) throws Exception {
		List textList = null;
		try {
			conn = getConnection();
			sql = "select * from revalue where title=? and con=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, con);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				textList = new ArrayList(30);
					do {
					NewsDTO info = new NewsDTO();
					info.setNum(rs.getInt("num"));
					info.setId(rs.getString("id"));
					info.setTitle(rs.getString("title"));
					info.setCon(rs.getString("con"));
					info.setReg(rs.getTimestamp("reg"));
					info.setIp(rs.getString("ip"));
					info.setRecon(rs.getString("recon"));
					textList.add(info);
					}while(rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return textList;
	} // public List getRecon(String title,String con) throws Exception {
	
	public int deleteNews(int num, String pw) throws Exception { // 게시글 삭제 메소드
		String sqlpw = "";
		int result = 0;
		try {
			conn = getConnection();
			sql = "select pw from news where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				sqlpw = rs.getString("pw");
				if (sqlpw.equals(pw)) {
					pstmt = conn.prepareStatement("delete from news where num=?");
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					result = 1;
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	} // public int deleteNews(int num, String pw) throws Exception {
	
	public void deleteRecon(int num) throws Exception { // 댓글 삭제 메소드
		try {
			conn = getConnection();
			sql = "delete from revalue where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		
	} // public void deleteRecon(int num) throws Exception {
	
	// member
	public int getMyNewsCount(String id) { // 기자 자신의 기사 카운트 메서드
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from news where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return x;
	} //public int getMyNewsCount(String id) {
	
} // public class NewsDAO {
