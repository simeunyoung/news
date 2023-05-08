package member;
import java.util.*;

import server.OracleServer;

public class MemberDAO extends OracleServer {

		private static MemberDAO instance = new MemberDAO();
		
		public static MemberDAO getInstance() { return instance; }
		
		private MemberDAO() {}
		
		// 로그인 체크 메서드
		public int userCheck(String id, String pw) {
			String dbpw = "";
			int x = -1;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select pw from member where id = ?"); // 입력된 아이디에 해당하는 비밀번호를 찾는다.
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) { // 아이디가 있을 때
					dbpw = rs.getString("pw");
					if(dbpw.equals(pw)) {
						x = 1; // pw 있을 때 반환 값
					}else {
						x = 0; // pw 없을 때 반환 값
					}
				}else { // id가 없을 때 반환 값
					x = -1;
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return x;
		}

		// 중복 ID 체크 메서드
		public int confirmId(String id) {
			int x = -1;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select id from member where id = ?"); // 입력받은 id와 같은 id가 있는지 체크
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					x = 1; // 있으면 1 반환
				}else {
					x = -1; // 없으면 -1 반환
				}
			}catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return x;
		}

		// 회원가입 메서드
		public int insertMember(MemberDTO member) {
			int result= 0;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("insert into member(id,pw,name,nick,email,tel,birthdate,memberType,press,reg) values(?,?,?,?,?,?,?,'1',?,sysdate)");
				pstmt.setString(1, member.getId());
				pstmt.setString(2, member.getPw());
				pstmt.setString(3, member.getName());
				pstmt.setString(4, member.getNick());
				pstmt.setString(5, member.getEmail());
				pstmt.setString(6, member.getTel());
				pstmt.setString(7, member.getBirthdate());
				pstmt.setString(8, member.getPress());
				result = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return result;
		}
		
		// 아이디 찾기 메서드
		public String idFind(MemberDTO member) { // 아이디와 생년월일이 일치하면 아이디 반환
			String result = null;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select id from member where name=? and birthdate=?");
				pstmt.setString(1, member.getName());
				pstmt.setString(2, member.getBirthdate());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getString("id");
				}
			}catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return result;
		}
		
		// 비밀번호 찾기
		public String pwFind(MemberDTO member) { // id와 email을 받아서 해당 id의 비밀번호 반환
			String result = null;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select pw from member where id=? and email=?");
				pstmt.setString(1, member.getId());
				pstmt.setString(2, member.getEmail());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getString("pw");
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return result;
		}

		// 회원 정보 가져오기
		public MemberDTO getMember(String id) {
			MemberDTO member = null;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select * from member where id = ?");
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					member = new MemberDTO();
					member.setId(rs.getString("id"));
					member.setPw(rs.getString("pw"));
					member.setName(rs.getString("name"));
					member.setNick(rs.getString("nick"));
					member.setEmail(rs.getString("email"));
					member.setTel(rs.getString("tel"));
					member.setBirthdate(rs.getString("birthdate"));
					member.setReg(rs.getTimestamp("reg"));
					member.setMemberType(rs.getString("memberType"));
					member.setImg(rs.getString("img"));
				}
			}catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return member;
		}
		
		public MemberDTO getmember(String id) { 
			// this method used to news file which made by hyoung joo kim [Do not Delete]
			// method which didn't same as getMember(String id)
			MemberDTO member = null;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select * from member where id = ?");
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) { // from session to get all data into list
					member = new MemberDTO();
					member.setId(rs.getString("id"));
					member.setPw(rs.getString("pw"));
					member.setName(rs.getString("name"));
					member.setNick(rs.getString("nick"));
					member.setEmail(rs.getString("email"));
					member.setTel(rs.getString("tel"));
					member.setBirthdate(rs.getString("birthdate"));
					member.setReg(rs.getTimestamp("reg"));
					member.setMemberType(rs.getString("memberType"));
				}
			}catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return member;
		} // public MemberDTO getmember(String id) { this is only for news file
			
		// 정보 수정
		public void updateMember(MemberDTO member) {
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("update member set pw=?,name=?,press=?,nick=?,email=?,tel=?,birthdate=?,reg=?,membertype=? where id=?");
				pstmt.setString(1, member.getPw());
				pstmt.setString(2, member.getName());
				pstmt.setString(3, member.getPress());
				pstmt.setString(4, member.getNick());
				pstmt.setString(5, member.getEmail());
				pstmt.setString(6, member.getTel());
				pstmt.setString(7, member.getBirthdate());			
				pstmt.setTimestamp(8, member.getReg());			
				pstmt.setString(9, member.getMemberType());
				pstmt.setString(10, member.getId());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
		}

		// 회원탈퇴(닉네임변경)
		public int deleteMember(String id, String pw) {
			int x = -1;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select pw from member where id =? ");
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					String dbpw=rs.getString("pw");
					if(dbpw.equals(pw)) {
						pstmt = conn.prepareStatement("update member set nick ='404(탈퇴한 회원)', pw='null' where id = ?");
						pstmt.setString(1, id);
						pstmt.executeUpdate();
						x = 1;
					}else {
						x = 0;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return x;
		}
		
		// 멤버타입 체크 메서드
		public int typeCheck(String id) { // 아이디에 해당하는 멤버타입 반환
			int result = 0;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select membertype from member where id = ?");
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = Integer.parseInt(rs.getString("membertype"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
			return result;
		}
		
		// 이미지 업로드 메서드
        public void updateImg(String sysName, String id) { // 아이디에 해당하는 img에 업데이트
            try {
                conn = getConnection();
                sql ="update member set img = ? where id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, sysName);
                pstmt.setString(2, id);
                pstmt.executeUpdate();
            }catch (Exception e) {
                e.printStackTrace();
            } finally {
                oracleClose();
            }
        }
        
        // 구독 목록 가져오기
        public String selectBookList(String id) {
        	String result = "";
        	try {
				conn = getConnection();
				sql="select reportersubscribe from member where id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					MemberDTO dto = new MemberDTO();
					dto.setReporterSubcribe(rs.getString("reportersubscribe"));
					result = dto.getReporterSubcribe();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
        	return result;
        }
     
        // 구독하기
        public void bookMarkInsert(String id, String id2, String books) {        
        	String[] parts = books.split("@");// 구독한 기자 목록을 @를 기준으로 나눠서 list에 저장
        		boolean include = false;
		    	for (String part : parts) {// 나눈 기자 id를 String으로 id2와 비교
		    	    if (part.equals(id2)) {
		    	        include = true;
		    	        break;
		    	    }
		    	}
        	try {
				conn = getConnection();
				sql="update member set reportersubscribe = ? where id =?";
				pstmt = conn.prepareStatement(sql);
				  if(!include) { // 구독한 기자가 아니면 구독목록에 추가
				pstmt.setString(1, books + "@" + id2);
				pstmt.setString(2, id);
				  }
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
        }
        
        // 구독 취소 메서드
        public void bookMarkDelete(String id, String id2, String books) {  
        	String[] parts = books.split("@"); // 구독한 기자 목록을 @를 기준으로 나눠서 list에 저장
        		boolean include = false;
		    	for (String part : parts) { // 나눈 기자 id를 String으로 id2와 비교
		    	    if (part.equals(id2)) {
		    	        include = true;
		    	        break;
		    	    }
		    	}
        	try {
				conn = getConnection();
				sql="update member set reportersubscribe = ? where id =?";
				pstmt = conn.prepareStatement(sql);
				  if(include) { // 구독한 기자면 공백 처리 
					 String bmDelete = "@"+id2;
					 String aId = books.replace(bmDelete, "");
				pstmt.setString(1, aId);
				pstmt.setString(2, id);
				  }
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
        }
		// company
        //member테이블 press컬럼에 있는 값(언론사)들을 TreeSet<String> 에 넣어 리턴 
		  public TreeSet<String> selectPress() {					
			  	TreeSet<String> list = new TreeSet<>();
			  	try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select press from member where press is not null and press != 'null'");
				rs = pstmt.executeQuery();
				while(rs.next()) {
				 	MemberDTO dto = new MemberDTO();
					dto.setPress(rs.getString("press"));
					list.add(dto.getPress());
				}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					oracleClose();
				}
				return list;
			}
		  	//언론사를 매개변수로 받아서 언론사에 해당하는 기자들 DTO ArrayList에 담아서 리턴 
		    public ArrayList<MemberDTO> pressReporter(String press) {
				ArrayList<MemberDTO> list = new ArrayList<>();
				conn = getConnection();
				String sql = "select id, name from member where press=? and membertype='-1'";
				try { 	pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, press);
				 		rs = pstmt.executeQuery();
					while(rs.next()) {
				 		MemberDTO dto = new MemberDTO();
						dto.setId(rs.getString("id"));
						dto.setName(rs.getString("name"));
						list.add(dto);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					oracleClose();
				}
				return list;
			}
		    //언론사를 매개변수로 받고 오름차순으로 해당 언론사 기자들 출력
		    public ArrayList<MemberDTO> selectReporter(String press) {
				ArrayList<MemberDTO> list = new ArrayList<>();
				conn = getConnection();
				String sql = "select * from member where press=? order by name asc";
				try { 	pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, press);
				 		rs = pstmt.executeQuery();
					while(rs.next()) {
				 		MemberDTO dto = new MemberDTO();
						dto.setId(rs.getString("id"));
						dto.setName(rs.getString("name"));
						list.add(dto);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					oracleClose();
				}
				return list;
			}
		    //id와 구독한 언론사를 매개변수로 받아서 언론사 구독목록(db)에 추가
		    public void PSubscribe(String id, String Wpress) {
				   	try {
					conn = getConnection();
					pstmt = conn.prepareStatement("update member set presssubscribe=? where id=?");
					pstmt.setString(1, Wpress);
					pstmt.setString(2, id);
					pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					oracleClose();
				}
			}
		    //id에 해당하는 presssubscribe(구독한 언론사) 리턴 
		    public String selectExist(String id) {				
		        String exist = "";
		        try {
		            conn = getConnection();
		            pstmt = conn.prepareStatement("select presssubscribe from member where id = ?");
		            pstmt.setString(1, id);
		            rs = pstmt.executeQuery();
		            while (rs.next()) {
		            MemberDTO dto = new MemberDTO();
		            dto.setPressSubcribe(rs.getString("presssubscribe"));
		            exist = dto.getPressSubcribe();
		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		        } finally {
		            oracleClose();
		        }
		        return exist;
		    }
		    //현재 구독되어있는 언론사, 구독하려는 언론사, id 매개변수로 받아서 구독하려는 언론사 추가 String타입 리턴
		    public String savePress(String exist, String press, String id) {
		    	String[] parts = exist.split("@");
		    	boolean include = false;
		    	for (String part : parts) {
		    	    if (part.equals(press)) {
		    	        include = true;
		    	        break;
		    	    }
		    	}
		        try {
		            conn = getConnection();
		            pstmt = conn.prepareStatement("update member set presssubscribe=? where id=?");
		            if(!include) {
		            pstmt.setString(1, exist+"@"+press);
		            pstmt.setString(2, id);
		            }
		            else {return "window.location.href='pressPage.jsp?press="+press+"'";}
		            pstmt.executeUpdate();
		            }catch (Exception e) {
		            e.printStackTrace();
		        } finally {
		            oracleClose();
		        }
		        return "window.location.href='pressPage.jsp?press="+press+"'";
		    }
		    //현재 구독되어있는 언론사, 구독취소하려는 언론사, id 매개변수로 받아서 구독취소하려는 언론사 빼고 String타입 리턴
		    public String unSavePress(String exist, String press, String id) {
		    	String[] parts = exist.split("@");
		    	String wPress = "";
		    	boolean include = false;
		    	for (String part : parts) {
		    	    if (part.equals(press)) {
		    	        include = true;
		    	        break;
		    	    }
		    	}
		        try {
		            conn = getConnection();
		            pstmt = conn.prepareStatement("update member set presssubscribe=? where id=?");
		            if(include) {
		            String aPress = "@"+press;
		            wPress = exist.replace(aPress , "");
		            pstmt.setString(1, wPress);
		            pstmt.setString(2, id);
		            }
		            pstmt.executeUpdate();
		            }catch (Exception e) {
		            e.printStackTrace();
		        } finally {
		            oracleClose();
		        }
		        return "window.location.href='pressPage.jsp?press="+press+"'";
		    }
		    public ArrayList<MemberDTO> memForType(String type) {			//membertype을 매개변수로 받아서 id, name, reportersubscribe을 
				ArrayList<MemberDTO> set = new ArrayList<>();				//ArrayList에 DTO넣고 리턴
				conn = getConnection();
				String sql = "select * from member where membertype=?";
				try { 	pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, type);
				 		rs = pstmt.executeQuery();
					while(rs.next()) {
				 		MemberDTO dto = new MemberDTO();
						dto.setId(rs.getString("id"));
						dto.setName(rs.getString("name"));
						dto.setReporterSubcribe(rs.getString("reportersubscribe"));
						set.add(dto);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					oracleClose();
				}
				return set;
			}
		    //id를 매개변수로 받고 기자 구독목록을 리턴해줌
		    public String subscribeR(String id) {
		    	String sub = "1212";
		        try {
		            conn = getConnection();
		            pstmt = conn.prepareStatement("select reportersubscribe from member where id = ?");
		            pstmt.setString(1, id);
		            rs = pstmt.executeQuery();
		            if (rs.next()) {
		            MemberDTO dto = new MemberDTO();
		            dto.setReporterSubcribe(rs.getString("reportersubscribe"));
		            sub = dto.getReporterSubcribe();
		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		        } finally {
		            oracleClose();
		        }
		        return sub;
		    }
		    //pressForm페이지에서 id, 구독체크한 언론사목록 매개변수로 받아서 db에 저장
		    public void RSubscribe(String id, String result) {
		    	try {
					conn = getConnection();
					pstmt = conn.prepareStatement("update member set reportersubscribe=? where id=?");
					pstmt.setString(1, result);
					pstmt.setString(2, id);
					pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					oracleClose();
				}
			}
}
