package board2;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import java.util.*;

public class BoardDBBean {

		private static BoardDBBean instance = new BoardDBBean();
		
		public static BoardDBBean getInstance() {
			return instance;
		}
		
		private BoardDBBean() {}
		
		public Connection getConnection() {
	    	Connection conn = null;
			try {
				Class.forName("oracle.jdbc.driver.OracleDriver");
				String user ="scott" , pass="tiger"; 
				String dburl ="jdbc:oracle:thin:@192.168.219.123:1521:orcl";
				conn = DriverManager.getConnection(dburl,user,pass);
			}catch(Exception e) {
				e.printStackTrace();
			}
			return conn;
		}
		
		// 게시판에 새로운 글을 추가하는 메서드
		public void insertArticle(BoardDataBean article) throws Exception{
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			int num = article.getNum(); // 게시글 번호
			int ref = article.getRef(); // 그룹 번호
			int re_step = article.getRe_step(); // 답글 순서
			int re_level = article.getRe_level(); // 답글 레벨
			int number = 0; // 게시글 번호
			String sql = "";
			
			try {
				// 새로운 글은 게시글 번호를 생성, 답글은 기존 글의 답글 순서, 레벨 조정
				conn = getConnection();
				pstmt = conn.prepareStatement("select max(num) from board");
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					number = rs.getInt(1) + 1;
				} else {
					number = 1;
				}if(num != 0) {
					sql = "update board set re_step = re_step + 1 where ref = ? and re_step > ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, ref);
					pstmt.setInt(2, re_step);
					pstmt.executeUpdate();
					re_step = re_step + 1;
					re_level = re_level + 1;
				} else {
					ref = number;
					re_step = 0;
					re_level = 0;
				}
				
				// 쿼리문을 사용해서 데이터에 글 추가를 함
				// 쿼리문에는 게시글의 작성자, 이메일, 제목, 비밀번호, 작성 일자, 그룹 번호, 답글 순서, 답글 레벨, 내용, ip를 포함
				sql = "insert into board(num, writer, email, subject, passwd, reg_date,";
				sql += "ref, re_step, re_level, content, ip) values(board_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, article.getWriter());
				pstmt.setString(2, article.getEmail());
				pstmt.setString(3, article.getSubject());
				pstmt.setString(4, article.getPasswd());
				pstmt.setTimestamp(5, article.getReg_date());
				pstmt.setInt(6, ref);
				pstmt.setInt(7, re_step);
				pstmt.setInt(8, re_level);
				pstmt.setString(9, article.getContent());
				pstmt.setString(10, article.getIp());
				pstmt.executeUpdate();
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException ex) {
						
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException ex) {
						
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException ex) {
						
					}
				}
			}
		}
		
		// 게시글 수를 구하는 메서드
		public int getArticleCount() throws Exception{
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int x = 0;
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select count(*) from board");
				rs = pstmt.executeQuery();
				if (rs.next()) {
					x = rs.getInt(1);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException ex) {
						
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException ex) {
						
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException ex) {
						
					}
				}
			}
			return x;
		}
		
		// 작성자의 id의 게시글의 수를 구하는 메서드
		public int getMyArticleCount(String id) throws Exception{
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int x = 0;
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select count(*) from board where writer = ?");
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					x = rs.getInt(1);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException ex) {
						
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException ex) {
						
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException ex) {
						
					}
				}
			}
			return x;
		}
		
		// 게시글 목록을 가져오는 메서드
		// 게시글 리스트를 조회 후 lsit 형태로 반환
		public List getArticles(int start, int end) throws Exception{
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List articleList = null;
			
			try {
				conn = getConnection();
				// 첫 번째 서브 쿼리는 게시글을 ref 필드로 내림차순 정렬, re_step 필드로 오름차순 정렬
				// 두 번째 서브 쿼리는 첫 번째 서브 쿼리에서 정렬한 결과를 rownum을 붙여서 r이 start - end까지의 범위 내에 있는 결과만 조회
				pstmt = conn.prepareStatement("select num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip, readcount, r" +
											"from (select num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip, readcount, rownum r" +
											"from (select * from board order by ref desc, re_step asc) order by ref desc, re_step asc) where r >= ? and r <= ?");
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				
				// 조회된 결과를 반복해서 databean객체에 저장하고, articleList에 추가
				if(rs.next()) {
					articleList = new ArrayList(end);
					do {
						BoardDataBean article = new BoardDataBean();
						article.setNum(rs.getInt("num"));
						article.setWriter(rs.getString("writer"));
						article.setEmail(rs.getString("email"));
						article.setSubject(rs.getString("subject"));
						article.setPasswd(rs.getString("passwd"));
						article.setReg_date(rs.getTimestamp("reg_date"));
						article.setReadcount(rs.getInt("readcount"));
						article.setRef(rs.getInt("ref"));
						article.setRe_step(rs.getInt("re_step"));
						article.setRe_level(rs.getInt("re_level"));
						article.setContent(rs.getString("content"));
						article.setIp(rs.getString("ip"));
						articleList.add(article);
					} while(rs.next());
				}
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException ex) {
						
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException ex) {
						
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException ex) {
						
					}
				}
			}
			return articleList;
		}
		
		// 게시판 글을 조회하고, 해당 작성자가 작성한 글들을 페이징 처리하여 가져오는 메서드
		public List getMyArticles(String id, int start, int end) throws Exception{
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List articleList = null;
			
			try {
				conn = getConnection();
				// 작성자 id를 조건으로 board테이블에서 ref값을 기준으로 내림차순, re_step값을 기준으로 오름차순 정렬 후, start - end 범위 까지 결과 조회
				pstmt = conn.prepareStatement("select num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip, readcount, r" +
											"from (select num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip, readcount, rownum r" +
											"from (select * from board where writer = ? order by ref desc, re_step asc) order by ref desc, re_step asc) where r >= ? and r <= ?");
				pstmt.setString(1, id);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					articleList = new ArrayList(end);
					do {
						BoardDataBean article = new BoardDataBean();
						article.setNum(rs.getInt("num"));
						article.setWriter(rs.getString("writer"));
						article.setEmail(rs.getString("email"));
						article.setSubject(rs.getString("subject"));
						article.setPasswd(rs.getString("passwd"));
						article.setReg_date(rs.getTimestamp("reg_date"));
						article.setReadcount(rs.getInt("readcount"));
						article.setRef(rs.getInt("ref"));
						article.setRe_step(rs.getInt("re_step"));
						article.setRe_level(rs.getInt("re_level"));
						article.setContent(rs.getString("content"));
						article.setIp(rs.getString("ip"));
						articleList.add(article);
					} while(rs.next());
				}
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException ex) {
						
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException ex) {
						
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException ex) {
						
					}
				}
			}
			return articleList;
		}
		
		// 게시판에서 게시글 조회수의 게시글 정보를 조회하는 메서드
		public BoardDataBean getArticle(int num) throws Exception{
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			BoardDataBean article = null;
			
			try {
				conn = getConnection();
				// 게시글 조회수를 1 증가시키는 쿼리문
				pstmt = conn.prepareStatement("update board set readcount = readcount + 1 where num = ?");
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				// 게시글의 정보를 조회하기 위한 쿼리문
				pstmt = conn.prepareStatement("select * from board where num = ?");
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					article = new BoardDataBean();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("rs_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
				}
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException ex) {
						
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException ex) {
						
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException ex) {
						
					}
				}
			}
			return article;
		}
		
		// 게시글 수정 메서드(num에 해당하는 게시글을 가져옴)
		public BoardDataBean updateGetArticle(int num) throws Exception{
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			BoardDataBean article = null;
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select * from board where num = ?");
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					article = new BoardDataBean();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("rs_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
				}
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException ex) {
						
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException ex) {
						
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException ex) {
						
					}
				}
			}
			return article;
		}
		
		// 게시글 수정하는 메서드(위의 메서드의 반환받은 값을 매개변수로 활용)
		public int updateArticle(BoardDataBean article) throws Exception{
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String dbpasswd = "";
			String sql = "";
			int x = -1; // 예외 발생으로 수정 실패
			
			try {
				conn = getConnection();
				// 비밀번호를 조회하는 쿼리문
				pstmt = conn.prepareStatement("select passwd from board where num = ?");
				pstmt.setInt(1, article.getNum());
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					dbpasswd = rs.getString("passwd");
					if(dbpasswd.equals(article.getPasswd())) {
						// update쿼리를 사용하여 작성자, 이메일, 제목, 비번, 내용 갱신
						sql = "update board set witer = ?, email = ?, subject = ?, passwd = ?";
						sql += ", content = ? where num = ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, article.getWriter());
						pstmt.setString(2, article.getEmail());
						pstmt.setString(3, article.getSubject());
						pstmt.setString(4, article.getPasswd());
						pstmt.setString(5, article.getContent());
						pstmt.setInt(6, article.getNum());
						pstmt.executeUpdate();
						x = 1; // 수정 성공
					} else {
						x = 0; // 비밀번호 불일치 수정 실패
					}
				}
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException ex) {
						
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException ex) {
						
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException ex) {
						
					}
				}
			}
			return x;
		}
		
		// 글 삭제 메서드
		public int deleteArticle(int num, String passwd) throws Exception{
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String dbpasswd = "";
			int x = -1;
			
			try {
				conn = getConnection();
				// 입력받은 게시판 글 번호(num)에 해당하는 비번을 가져옴
				pstmt = conn.prepareStatement("select passwd from board where num = ?");
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					dbpasswd = rs.getString("passwd");
					// 비번 비교 후, 글 삭제
					if(dbpasswd.equals(passwd)) {
						pstmt = conn.prepareStatement("delete from board where num = ?");
						pstmt.setInt(1, num);
						pstmt.executeUpdate();
						x = 1; // 글 삭제 성공
					} else {
						x = 0; // 글 삭제 실패
					}
				}
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException ex) {
						
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException ex) {
						
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException ex) {
						
					}
				}
			}
			return x;
		}
}
