package member;
import java.util.*;

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

		public void insertMember(MemberDTO member) {
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
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				oracleClose();
			}
		}
		
		public String idFind(MemberDTO member) {
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
		
		public String pwFind(MemberDTO member) {
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
						pstmt = conn.prepareStatement("update member set nick ='404', pw='' where id = ?");
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
		
		public int typeCheck(String id) {
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
		
        public void updateImg(String sysName, String id) {
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
     
        public void bookMarkInsert(String id, String id2, String books) {        
        	String[] parts = books.split("@");
        		boolean include = false;
		    	for (String part : parts) {
		    	    if (part.equals(id2)) {
		    	        include = true;
		    	        break;
		    	    }
		    	}
        	try {
				conn = getConnection();
				sql="update member set reportersubscribe = ? where id =?";
				pstmt = conn.prepareStatement(sql);
				  if(!include) {
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
        
        public void bookMarkDelete(String id, String id2, String books) {        
        	String[] parts = books.split("@");
        		boolean include = false;
		    	for (String part : parts) {
		    	    if (part.equals(id2)) {
		    	        include = true;
		    	        break;
		    	    }
		    	}
        	try {
				conn = getConnection();
				sql="update member set reportersubscribe = ? where id =?";
				pstmt = conn.prepareStatement(sql);
				  if(include) {
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

}
