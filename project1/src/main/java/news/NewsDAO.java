package news;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import member.MemberDTO;

import java.util.ArrayList;

public class NewsDAO extends OracleServer {
	private static NewsDAO instance = new NewsDAO();

	public static NewsDAO getInstance() {
		return instance;
	}

	private NewsDAO() {
	}

	// new-main
	public int CountAllList() throws Exception { // 뉴스의 작성된 글 수를 전부 읽어준다.
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from news";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return x;
	} // public int CountAllList() throws Exception {

	public void insert(NewsDTO dto) {
		try {
			conn = getConnection();
			sql = "insert into news(num,pw,title,con,newstype,ip,reg,nick) values(news_seq.nextval,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPw());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getCon());
			pstmt.setString(4, dto.getNewstype());
			pstmt.setString(5, dto.getIp());
			pstmt.setTimestamp(6, dto.getReg());
			pstmt.setString(7, dto.getNick());
			pstmt.executeUpdate();
		} catch (Exception e) {
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	} // public void insertrecon(NewsDTO dto) {

	public NewsDTO getCon(int num) throws Exception {
		NewsDTO info = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update news set views=views+1 where num = ?"); // 조회수가 1씩 증가한다. 게시글 번호에 맞는
																							// 곳에서
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("select * from news where num = ?"); // 게시글 번호의 정보를 찾기
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) { // 게시글 번호에 맞는 정보를 찾기
				info = new NewsDTO();
				info.setNum(rs.getInt("num"));
				info.setNick(rs.getString("nick"));
				info.setNewstype(rs.getString("newstype"));
				info.setTitle(rs.getString("title"));
				info.setCon(rs.getString("con"));
				info.setReg(rs.getTimestamp("reg"));
				info.setPw(rs.getString("pw"));
				info.setIp(rs.getString("ip"));
				info.setViews(rs.getInt("views"));
				info.setPress(rs.getString("press"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}

		return info;
	}

	public NewsDTO getdata(int num) throws Exception { // form페이지에서 기존 데이터를 가져와서 변경하고 보내는 역활
		NewsDTO info = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from news where num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			rs = pstmt.executeQuery();
			if (rs.next()) { // 게시글 번호에 맞는 정보를 찾기
				info = new NewsDTO();
				info.setNum(rs.getInt("num"));
				info.setNick(rs.getString("nick"));
				info.setNewstype(rs.getString("newstype"));
				info.setTitle(rs.getString("title"));
				info.setCon(rs.getString("con"));
				info.setReg(rs.getTimestamp("reg"));
				info.setPw(rs.getString("pw"));
				info.setIp(rs.getString("ip"));
				info.setViews(rs.getInt("views"));
				info.setPress(rs.getString("press"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}

		return info;
	} // public NewsDTO getdata(int num) throws Exception {

	public NewsDTO getRecon(int num) throws Exception { // form페이지에서 기존 데이터를 가져와서 변경하고 보내는 역활
		NewsDTO info = null;
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
		} catch (Exception ex) {
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
			pstmt = conn.prepareStatement("select pw from news where num=?"); // 해당 게시글 비번을 불러와서 삭제 전 글 비번과 입력한 비번과 비교
			pstmt.setInt(1, info.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				checkpw = rs.getString("pw");
				if (checkpw.equals(info.getPw())) {
					result = 1;
					sql = "update news set nick=?,newstype=?,title=?,con=?,pw=? where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, info.getNick());
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
			pstmt = conn.prepareStatement("update revalue set recon=? where num=?"); // 해당 게시글 비번을 불러와서 삭제 전 글 비번과 입력한
																						// 비번과 비교
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
			sql = "select * from (select e.*,rownum r from (select num,nick,newstype,title,con,reg,pw,ip,views,press from news order by reg desc) e )"
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
					allinfo.setNick(rs.getString("nick"));
					allinfo.setNewstype(rs.getString("newstype"));
					allinfo.setTitle(rs.getString("title"));
					allinfo.setCon(rs.getString("con"));
					allinfo.setReg(rs.getTimestamp("reg"));
					allinfo.setPw(rs.getString("pw"));
					allinfo.setIp(rs.getString("ip"));
					allinfo.setViews(rs.getInt("views"));
					allinfo.setPress(rs.getString("press"));
					textList.add(allinfo);
				} while (rs.next()); // while문으로 하면 최근 작성한 게시글이 나오지 않기 때문에 do-while문을 사용
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return textList;
	} // public List getTexts(int start, int end) throws Exception {

	public List getRecon(String title, String con) throws Exception {
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
				} while (rs.next());
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

	// news2
	// 게시글 수를 구하는 메서드
	public int getNewsCount() throws Exception {
		int x = 0;

		try {
			conn = getConnection();
			sql = "select count(*) from news";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return x;
	}

	// 게시글 목록을 가져옴 리스트 조회 후 list 형태로 변환
	public List getNews(int start, int end) throws Exception {

		List newsList = new ArrayList();

		try {
			conn = getConnection();
			sql = "select * from(select e.*, rownum r from(select * from news order by reg desc) e) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				NewsDTO article = new NewsDTO();
				article.setNum(rs.getInt("num"));
				article.setNick(rs.getString("nick"));
				article.setNewstype(rs.getString("newstype"));
				article.setTitle(rs.getString("title"));
				article.setCon(rs.getString("con"));
				article.setReg(rs.getTimestamp("reg"));
				article.setPw(rs.getString("pw"));
				article.setViews(rs.getInt("views"));
				article.setPress(rs.getString("press"));
				article.setIp(rs.getString("ip"));
				newsList.add(article);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return newsList;
	}

	// 뉴스 타입별로 수를 구하는 메서드
	public int getNewstypeCount(String newstype) throws Exception {

		int x = 0;

		try {
			conn = getConnection();
			sql = "select count(*) from news where newstype = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newstype);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return x;
	}

	// 뉴스 타입별로 목록을 리스트로 가져옴
	public List<NewsDTO> getNewsType(int start, int end, String newstype) throws Exception {

		List<NewsDTO> newsList = new ArrayList<>();

		try {
			conn = getConnection();
			sql = "select * from (select e.*, rownum r from (select * from news where newstype = ? order by reg desc) e) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newstype);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				NewsDTO article = new NewsDTO();
				article.setNum(rs.getInt("num"));
				article.setNick(rs.getString("nick"));
				article.setNewstype(rs.getString("newstype"));
				article.setTitle(rs.getString("title"));
				article.setCon(rs.getString("con"));
				article.setReg(rs.getTimestamp("reg"));
				article.setPw(rs.getString("pw"));
				article.setViews(rs.getInt("views"));
				article.setPress(rs.getString("press"));
				article.setIp(rs.getString("ip"));
				newsList.add(article);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return newsList;
	}

	// member
	public int getMyNewsCount(String nick) { // 기자 자신의 기사 카운트 메서드
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from news where nick = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nick);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return x;
	} // public int getMyNewsCount(String id) {

	public List getMyNewsList(String nick, int startNum, int endNum) { // 기자 자신의 기사 리스트
		List newsList = new ArrayList();
		try {
			conn = getConnection();
			sql = "select * from (select e.*,rownum r from (select * from news where nick = ? order by num)e) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nick);
			pstmt.setInt(2, startNum);
			pstmt.setInt(3, endNum);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				NewsDTO news = new NewsDTO();
				news.setNum(rs.getInt("num"));
				news.setNick(rs.getString("nick"));
				news.setNewstype(rs.getString("newstype"));
				news.setTitle(rs.getString("title"));
				news.setCon(rs.getString("con"));
				news.setIp(rs.getString("ip"));
				news.setReg(rs.getTimestamp("reg"));
				news.setViews(rs.getInt("views"));
				newsList.add(news);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return newsList;
	} // public List getMyNewsList(String id, int startNum, int endNum) {

	// 게시글 목록 중 핫 토픽 리스트 조회 후 list 형태로 변환
	public List gethotNews(int start, int end) throws Exception {

		List newsList = new ArrayList();

		try {
			conn = getConnection();
			sql = "select * from(select e.*, rownum r from(select * from news order by views desc) e) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				NewsDTO article = new NewsDTO();
				article.setNum(rs.getInt("num"));
				article.setNick(rs.getString("nick"));
				article.setNewstype(rs.getString("newstype"));
				article.setTitle(rs.getString("title"));
				article.setCon(rs.getString("con"));
				article.setReg(rs.getTimestamp("reg"));
				article.setPw(rs.getString("pw"));
				article.setViews(rs.getInt("views"));
				article.setPress(rs.getString("press"));
				article.setIp(rs.getString("ip"));
				newsList.add(article);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return newsList;
	}
	//언론사별 기사 목록
    public ArrayList<NewsDTO> selectArticle(String press) {
		ArrayList<NewsDTO> list = new ArrayList<>();
		conn = getConnection();
		String sql = "select * from news where press = ? ";
		try { 	pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, press);
		 		rs = pstmt.executeQuery();
			while(rs.next()) {
		 		NewsDTO dto = new NewsDTO();
		 		dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setTitle(rs.getString("title"));
				dto.setReg(rs.getTimestamp("reg"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return list;
	}
} // public class NewsDAO {
