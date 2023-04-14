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
				info.setRecon(rs.getString("recon"));
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
	
	public List gettexts(int a, int b) throws Exception {
		List textList = null;
		try {
			conn = getConnection();
			sql = "select * from (select e.*,rownum r from (select num,id,newstype,title,con,reg,pw,ip,recon,views,press from news order by reg desc) e )"
					+ " where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, a);
			pstmt.setInt(2, b);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				textList = new ArrayList(b); // end는 list의 최대 공간을 의미한다.
					NewsDTO allinfo = new NewsDTO();
					while(rs.next()) {
					allinfo = new NewsDTO();
					allinfo.setNum(rs.getInt("num"));
					allinfo.setId(rs.getString("id"));
					allinfo.setNewstype(rs.getString("newstype"));
					allinfo.setTitle(rs.getString("title"));
					allinfo.setCon(rs.getString("con"));
					allinfo.setReg(rs.getTimestamp("reg"));
					allinfo.setPw(rs.getString("pw"));
					allinfo.setIp(rs.getString("ip"));
					allinfo.setRecon(rs.getString("recon"));
					allinfo.setViews(rs.getInt("views"));
					allinfo.setPress(rs.getString("press"));
					textList.add(allinfo);
					}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return textList;
	} // public List getTexts(int start, int end) throws Exception {
	
	
	public List gettt() throws Exception {
		List textList = null;
		try {
			conn = getConnection();
			sql = "select * from news";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				textList = new ArrayList(10); // end는 list의 최대 공간을 의미한다.
					NewsDTO allinfo = new NewsDTO();
					while(rs.next()) {
					allinfo = new NewsDTO();
					allinfo.setNum(rs.getInt("num"));
					allinfo.setId(rs.getString("id"));
					allinfo.setNewstype(rs.getString("newstype"));
					allinfo.setTitle(rs.getString("title"));
					allinfo.setCon(rs.getString("con"));
					allinfo.setReg(rs.getTimestamp("reg"));
					allinfo.setPw(rs.getString("pw"));
					allinfo.setIp(rs.getString("ip"));
					allinfo.setRecon(rs.getString("recon"));
					allinfo.setViews(rs.getInt("views"));
					allinfo.setPress(rs.getString("press"));
					textList.add(allinfo);
					}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return textList;
	} // public List getTexts(int start, int end) throws Exception {
	
	
} // public class NewsDAO {
