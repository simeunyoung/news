package news;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import member.MemberDTO;
import server.OracleServer;

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
			conn = getConnection(); // java와 sql 연동 oracleserver getConnection메소드 사용
			sql = "select count(*) from news"; // 쿼리문 작성
			pstmt = conn.prepareStatement(sql); // 쿼리문을 getConnection에 preparestatement로 적용
			rs = pstmt.executeQuery(); // sql에서 테이블을 사용
			if (rs.next()) { // pstmt.executeQuery()이 해당할 때
				x = rs.getInt(1); // pstmt.executeQuery()가 해당할 때 1을 적용
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return x;
	} // public int CountAllList() throws Exception {

	public void insert(NewsDTO dto) {
		if(dto.getCon().contains("&nbsp;")) {
			dto.setCon(dto.getCon().replace("&nbsp;", ""));
		}
		if(dto.getCon().contains("<p>")) {
			dto.setCon(dto.getCon().replace("<p>", ""));
		}
		if(dto.getCon().contains("</p>")) {
			dto.setCon(dto.getCon().replace("</p>", ""));
		}
		
		try {
			conn = getConnection();
			sql = "insert into news(num,nick,title,con,reg,pw,ip,id,newstype,press) values(news_seq.nextval,?,?,?,?,?,?,?,?,?)";
			// 쿼리문 작성
			pstmt = conn.prepareStatement(sql); // 쿼리문 적용
			pstmt.setString(1, dto.getNick()); // ?의 순서에 맞는 데이터 적용
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getCon());
			pstmt.setTimestamp(4, dto.getReg());
			pstmt.setString(5, dto.getPw());
			pstmt.setString(6, dto.getIp());
			pstmt.setString(7, dto.getId());
			pstmt.setString(8, dto.getNewstype());
			pstmt.setString(9, dto.getPress());
			pstmt.executeUpdate(); 
			//executeQuery은 테이블에 데이터를 가져오는 것/ executeUpdate는 테이블에 데이터를 적용시키는 것
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	} // public boolean insert(NewsDTO dto) {

	public void insertRecon(NewsDTO dto) {
		try {
			conn = getConnection();
			sql = "insert into revalue values(revalue_seq.nextval,?,?,?,?,?,?)"; //쿼리문 작성
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
			// getCon()의 메소드가 작동할 때 해당 컬럼이 작동																				// 곳에서
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("select * from news where num = ?"); // 게시글 번호의 정보를 찾기
			pstmt.setInt(1, num); // 해당 num에 맞는 데이터 가져오기
			rs = pstmt.executeQuery();
			if (rs.next()) { // 게시글 번호에 맞는 정보를 찾기
				info = new NewsDTO();
				info.setNum(rs.getInt("num")); // num에 맞는 데이터를 DTO에 주입
				info.setId(rs.getString("id"));
				info.setNick(rs.getString("Nick"));
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
				info.setId(rs.getString("nick"));
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
			pstmt.setInt(1, info.getNum()); //num에 맞는 pw컬럼의 데이터 가져오기
			rs = pstmt.executeQuery();
			if (rs.next()) { // 위 쿼리문에 맞는 pw가 일치할 때 작동
				checkpw = rs.getString("pw"); // 위 쿼리문에 일치하는 pw의 변수 선언
				if (checkpw.equals(info.getPw())) { 
					// 위 쿼리문의 pw와 메소드에서 가져온 값과 일치 할 때
					result = 1; // if문에 true일 때 result의 값이 0에서 1로 변경
					sql = "update news set id =?, nick=?,newstype=?,title=?,con=?,pw=? where num=?";
					// 쿼리문 작성
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, info.getId());// 쿼리문 적용
					pstmt.setString(1, info.getNick()); // 쿼리문에 맞는 데이터 저장
					pstmt.setString(2, info.getNewstype());
					pstmt.setString(3, info.getTitle());
					pstmt.setString(4, info.getCon());
					pstmt.setString(5, info.getPw());
					pstmt.setInt(6, info.getNum());
					pstmt.executeUpdate(); // 해당 쿼리문에 맞는 데이터가 변경할 시 변경 내용 적용
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
			// 쿼리문 작성 rownum으로 적용된 데이터 순서 정하기
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, a);
			pstmt.setInt(2, b);
			rs = pstmt.executeQuery(); // 데이터 가져오기
			if (rs.next()) { // 위 쿼리문에 적용된 데이터일 때 true
				textList = new ArrayList(b); 
				// end는 list의 최대 공간을 의미한다. list 클래스로 집합 만들기
				NewsDTO allinfo = new NewsDTO(); // 새 DTO 객체 생성
				do {
					allinfo = new NewsDTO();
					allinfo.setNum(rs.getInt("num")); // DTO에 데이터 추가
					allinfo.setNick(rs.getString("nick"));
					allinfo.setNewstype(rs.getString("newstype"));
					allinfo.setTitle(rs.getString("title"));
					allinfo.setCon(rs.getString("con"));
					allinfo.setReg(rs.getTimestamp("reg"));
					allinfo.setPw(rs.getString("pw"));
					allinfo.setIp(rs.getString("ip"));
					allinfo.setViews(rs.getInt("views"));
					allinfo.setPress(rs.getString("press"));
					textList.add(allinfo); // 추가한 데이터 list에 추가
				} while (rs.next()); // while문으로 하면 최근 작성한 게시글이 나오지 않기 때문에 do-while문을 사용
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return textList;
	} // public List getTexts(int start, int end) throws Exception {

	public List getrecon(String title, String con) throws Exception {
		List textList = null;
		try {
			conn = getConnection();
			sql = "select * from revalue where title=? and con=?"; // 쿼리문 작성
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, con);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				textList = new ArrayList(30); // list의 데이터를 30개로 제한
				do {
					NewsDTO info = new NewsDTO(); //DTO 객체 생성
					info.setNum(rs.getInt("num"));
					info.setId(rs.getString("id"));
					info.setId(rs.getString("nick"));
					info.setTitle(rs.getString("title"));
					info.setCon(rs.getString("con"));
					info.setReg(rs.getTimestamp("reg"));
					info.setIp(rs.getString("ip"));
					info.setRecon(rs.getString("recon"));
					textList.add(info); //DTO에 저장된 데이터를 list에 저장
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return textList;
	} // public List getRecon(String title,String con) throws Exception {
	
	public List getRecon(String title,String con,int a, int b) throws Exception {
		List textList = null; // 위에 30으로 제한한 부분 수정 메소드
		try {
			conn = getConnection();
			sql = "select * from (select e.*,rownum r from (select * from revalue where title=? and con=? order by reg desc) e )"
					+ " where r >= ? and r <= ?"; 
			//직접 수기로 숫자를 제한하지 않고 rownum을 사용해서 recon의 데이터를 제한하고 저장
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, con);
			pstmt.setInt(3, a);
			pstmt.setInt(4, b);
			rs = pstmt.executeQuery(); // sql에서 데이터를 가져오기
			if (rs.next()) {
				textList = new ArrayList(b); //list의 데이터 생성
				NewsDTO allinfo = new NewsDTO(); //DTO 객체 생성
				do {
					allinfo = new NewsDTO();
					allinfo.setNum(rs.getInt("num"));
					allinfo.setNick(rs.getString("id"));
					allinfo.setTitle(rs.getString("title"));
					allinfo.setCon(rs.getString("con"));
					allinfo.setReg(rs.getTimestamp("reg"));
					allinfo.setIp(rs.getString("ip"));
					allinfo.setRecon(rs.getString("recon"));
					textList.add(allinfo); //list로 DTO 데이터 저장
				} while (rs.next()); 
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return textList;
	} // public List getRecon(String title,String con,int a, int b) throws Exception { a ~ b get to recon from revalue table which get to work

	public int deleteNews(int num, String pw) throws Exception { // 게시글 삭제 메소드
		String sqlpw = "";
		int result = 0;
		try {
			conn = getConnection();
			sql = "select pw from news where num = ?";
			// 쿼리문 작성 ( 쿼리문에 적용된 pw 데이터 찾기)
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) { //해당 num에 맞는 pw가 있을 때
				sqlpw = rs.getString("pw"); // 위 쿼리문의 pw 데이터를 변수로 임시 선언 (if문) 
				if (sqlpw.equals(pw)) {// 메소드의 데이터가 쿼리문 변수와 일치할 때
					pstmt = conn.prepareStatement("delete from news where num=?");
					pstmt.setInt(1, num);
					pstmt.executeUpdate(); // 데이터 값 변경
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
	
	public void deleteAdminNews(int num) throws Exception { // 운영자 게시글 삭제 메소드

		try {
			conn = getConnection();
			sql = "delete from news where num=?"; 
			// 위의 경우 사용자가 일치하고 비밀번호가 맞을 때 반대로 지금 메소드는 운영자의 권한을 갖고 있을 때
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
	} // public int deleteAdminNews(int num) throws Exception {
	
	public void deleteRecon(int num) throws Exception { // 댓글 삭제 메소드
		try {
			conn = getConnection();
			sql = "delete from revalue where num=?";
			// 댓글 삭제의 경우 내부적으로 id가 일치하는 유저에 한해서만 적용되게 유효성 검사를 하고 진행되는 메소드
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate(); // 데이터 수정

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}

	} // public void deleteRecon(int num) throws Exception {
	
	public int getReconCount(String title,String con) throws Exception {
		int x = 0;

		try {
			conn = getConnection();
			sql = "select count(*) from revalue where title=? and con=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, con);
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
				article.setId(rs.getString("id"));
				newsList.add(article);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return newsList;
	}
	
	public List getNews7days() throws Exception {

		List newsList = new ArrayList(38);

		try {
			conn = getConnection();
			sql = "select * from(select e.*, rownum r from"
					+ "(select * from news where reg between trunc(sysdate - 6) and trunc(sysdate+1)) e )"
					+ " where r >= 1 and r <= 38";
			//trunc는 sysdate의 시간을 생략하는 명령어
			pstmt = conn.prepareStatement(sql);
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
				article.setId(rs.getString("id"));
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
				article.setId(rs.getString("id"));
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
	// 기자 자신의 기사 카운트 메서드
	public int getMyNewsCount(String id) { 
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from news where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
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

	// 기자 자신의 기사 리스트
	public List getMyNewsList(String id, int startNum, int endNum) { 
		List newsList = new ArrayList();
		try {
			conn = getConnection();
			sql = "select * from (select e.*,rownum r from (select * from news where id = ? order by num)e) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
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
	
    public List getSearchList(String search) {
        List searchList=null;
        try {
           conn = getConnection();
           pstmt = conn.prepareStatement(
                 "SELECT * FROM news WHERE title LIKE '%' || ? || '%' order by reg desc");
                 pstmt.setString(1, search);
                 rs = pstmt.executeQuery();
                 if (rs.next()) {
                    searchList = new ArrayList(); 
                    do{ 
                       NewsDTO dto= new NewsDTO();
                       dto.setNum(rs.getInt("num"));
                       dto.setTitle(rs.getString("title"));
                       dto.setId(rs.getString("id"));
                       dto.setPress(rs.getString("press"));
                       dto.setReg(rs.getTimestamp("reg"));                       
                       dto.setViews(rs.getInt("views"));
                       searchList.add(dto); 
                    }while(rs.next());
                 }
        } catch(Exception ex) {
           ex.printStackTrace();
        } finally {
        oracleClose();
        }
        return searchList;
    }
    
    public List getSearchDateList(String startDate, String endDate) {
    	List searchDateList = null;
    	try {
    		conn = getConnection();
    		sql = "select * from news where reg between ? and ? order by reg desc";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, startDate);
    		pstmt.setString(2, endDate);
    		rs = pstmt.executeQuery();
    		if (rs.next()) {
    			searchDateList = new ArrayList();
    			do {
    			NewsDTO dto = new NewsDTO();
    			dto.setNum(rs.getInt("num"));
    			dto.setId(rs.getString("id"));
                dto.setNewstype(rs.getString("newstype"));
                dto.setTitle(rs.getString("title"));
                dto.setReg(rs.getTimestamp("reg"));
                searchDateList.add(dto); 
    			}while(rs.next());
    		}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
    	return searchDateList;
    }
    
    public List getSearchTodayList(String date) {
    	List searchTodayList = null;
    	try {
			conn = getConnection();
			sql = "select * from news where";
			switch(date) {
			case "today" : 
				sql +=" trunc(reg) = trunc(sysdate) ";
				break;
			case "week" : 
				sql +=" reg between sysdate - 6 and sysdate";
				break;
			case "month" : 
				sql +=" reg >= add_months(sysdate , -1) and reg < sysdate";
				break;
			case "year" : 
				sql +=" REG BETWEEN SYSDATE - 365 AND SYSDATE";
				break;
			}
			sql += " order by reg desc";
			System.out.println(date);
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				searchTodayList = new ArrayList();
				while(rs.next()) {
					NewsDTO dto = new NewsDTO();
					dto.setNum(rs.getInt("num"));
	    			dto.setId(rs.getString("id"));
	                dto.setNewstype(rs.getString("newstype"));
	                dto.setTitle(rs.getString("title"));
	                dto.setReg(rs.getTimestamp("reg"));
					searchTodayList.add(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
    	return searchTodayList;
    }
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
    
    // 해당 사용자의 스크랩한 뉴스의 목록을 담고있음
    public String newsscrap(String id) {
        String scrap = "";
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement("select scrap from member where id = ?");
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
            MemberDTO dto = new MemberDTO();
            dto.setScrap(rs.getString("scrap"));
            scrap = dto.getScrap();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            oracleClose();
        }
        return scrap;
    }
    
    // 스크랩 기능
    public void save_news(String news_scrap, int num, String loginuser) {
    	// 스크랩 정보를 @로 나눠 parts에 저장
    	// parts의 각 원소가 인자로 받은 num이랑 같은지 비교
    	String[] parts = news_scrap.split("@");
    	boolean include = false;
    	for (String part : parts) {
    	    if (part.equals(num)) {
    	        include = true;
    	        break;
    	    }
    	}
    	// include가 false일때 스크랩한 뉴스 번호를 저장
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement("update member set scrap=? where id=?");
            if(!include) {
            pstmt.setString(1, news_scrap+"@"+num);
            pstmt.setString(2, loginuser);
            }
            pstmt.executeUpdate();
            }catch (Exception e) {
            e.printStackTrace();
        } finally {
            oracleClose();
        }
    }
    
    // 스크랩 취소 기능
    public void unsave_news(String news_scrap, int num, String loginuser) {
    	// 스크랩 정보를 @로 나눠 parts에 저장
    	// num값이 포함되어 있는지 판단
    	String[] parts = news_scrap.split("@");
    	String wPress = "";
    	boolean include = false;
    	for (String part : parts) {
    	    if (part.equals(Integer.toString(num))) {
    	        include = true;
    	        break;
    	    }
    	}
    	// include가 true일때 스크랩한 뉴스 번호를 제거
        try {
            conn = getConnection();
            sql="update member set scrap=? where id=?";
            pstmt = conn.prepareStatement(sql);
            if(include) {
	            String aPress = "@"+num;
	            wPress = news_scrap.replace(aPress , "");
	            pstmt.setString(1, wPress);
	            pstmt.setString(2, loginuser);
            }
            pstmt.executeUpdate();
            }catch (Exception e) {
            e.printStackTrace();
        } finally {
            oracleClose();
        }
        
    }
    public String getNick(String id) {
    	String nick= null;
    	try {
    		conn = getConnection();
    		sql = "select nick from member where id =?";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, id);
    		rs = pstmt.executeQuery();
    		if(rs.next()) {
    			nick = rs.getString(1);
    		}
    	}catch(Exception ex) {
    		ex.printStackTrace();
    	}finally{
    		oracleClose();
    	}
    	return nick;
    }
   
}



 // public class NewsDAO {
