 package member;
 
 import java.sql.*;
 import javax.sql.*; 
 import javax.naming.*;
 
 public class LogonDBBean {
    
 	private static LogonDBBean instance = new LogonDBBean();
    
    public static LogonDBBean getInstance() {return instance; }	//객체생성 된걸 return해줌 
    
    private LogonDBBean() {}
    
    public Connection getConnection() {
    	Connection conn = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String user = "team01", pw = "team", dburl = "jdbc:oracle:thin:@192.168.219.123:1521:orcl";
			conn = DriverManager.getConnection(dburl, user, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
 
 
 /*   public void insertMember(LogonDataBean member) 
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            	"insert into MEMBER values (?,?,?,?,?,?,?,?)");
            pstmt.setString(1, member.getId());
            pstmt.setString(2, member.getPasswd());
            pstmt.setString(3, member.getName());
            pstmt.setString(4, member.getJumin1());
            pstmt.setString(5, member.getJumin2());
            pstmt.setString(6, member.getEmail());
            pstmt.setString(7, member.getBlog());
			pstmt.setTimestamp(8, member.getReg_date());
            pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
 
	public int userCheck(String id, String passwd) 
	throws Exception {
		Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs= null;
        String dbpasswd="";
		int x=-1;
        
		try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            	"select passwd from MEMBER where id = ?");
            pstmt.setString(1, id);
            rs= pstmt.executeQuery();

			if(rs.next()){
				dbpasswd= rs.getString("passwd"); 
				if(dbpasswd.equals(passwd))
					x= 1; //���� ����
				else
					x= 0; //��й�ȣ Ʋ��
			}else
				x= -1;//�ش� ���̵� ����
			
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return x;
	}

	public int confirmId(String id) 
	throws Exception {
		Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs= null;
        String dbpasswd="";
		int x=-1;
        
		try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            	"select id from MEMBER where id = ?");
            pstmt.setString(1, id);
            rs= pstmt.executeQuery();

			if(rs.next())
				x= 1; //�ش� ���̵� ����
			else
				x= -1;//�ش� ���̵� ����		
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return x;
	}


    public LogonDataBean getMember(String id)
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        LogonDataBean member=null;
        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            	"select * from MEMBER where id = ?");
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                member = new LogonDataBean();
                member.setId(rs.getString("id"));
                member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
                member.setJumin1(rs.getString("jumin1"));
                member.setJumin2(rs.getString("jumin2"));
				member.setEmail(rs.getString("email"));
				member.setBlog(rs.getString("blog"));
                member.setReg_date(rs.getTimestamp("reg_date"));     
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return member;
    }
    
    public void updateMember(LogonDataBean member)
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
              "update MEMBER set passwd=?,name=?,email=?,blog=? "+
              "where id=?");
            pstmt.setString(1, member.getPasswd());
            pstmt.setString(2, member.getName());
            pstmt.setString(3, member.getEmail());
            pstmt.setString(4, member.getBlog());
            pstmt.setString(5, member.getId());
            
            pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    public int deleteMember(String id, String passwd)
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        String dbpasswd="";
        int x=-1;
        try {
			conn = getConnection();

            pstmt = conn.prepareStatement(
            	"select passwd from MEMBER where id = ?");
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            
			if(rs.next()){
				dbpasswd= rs.getString("passwd"); 
				if(dbpasswd.equals(passwd)){
					pstmt = conn.prepareStatement(
            	      "delete from MEMBER where id=?");
                    pstmt.setString(1, id);
                    pstmt.executeUpdate();
					x= 1; //ȸ��Ż�� ����
				}else
					x= 0; //��й�ȣ Ʋ��
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return x;
    }
    public String idFind(LogonDataBean dto)throws Exception{
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs= null;
    	String result= null;
    	try {
    		conn = getConnection();
    		String sql = "select id from member where name=? and jumin1=? and jumin2=?";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, dto.getName());
    		pstmt.setString(2, dto.getJumin1());
    		pstmt.setString(3, dto.getJumin2());
    		rs = pstmt.executeQuery();
    		if(rs.next()) {
    			result = rs.getString("id");
    		}
    	}catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    	return result;
    }
 	public LogonDataBean getReporter(String pageNum)
		    throws Exception {
     Connection conn = null;
     PreparedStatement pstmt = null;
     ResultSet rs = null;
     LogonDataBean member=null;
     try {
         conn = getConnection();
         
         pstmt = conn.prepareStatement(
         	"select * from MEMBER where id = ?");
         pstmt.setString(1, id);
         rs = pstmt.executeQuery();

         if (rs.next()) {
             member = new LogonDataBean();
             member.setId(rs.getString("id"));
             member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
             member.setJumin1(rs.getString("jumin1"));
             member.setJumin2(rs.getString("jumin2"));
				member.setEmail(rs.getString("email"));
				member.setBlog(rs.getString("blog"));
             member.setReg_date(rs.getTimestamp("reg_date"));     
			}
     } catch(Exception ex) {
         ex.printStackTrace();
     } finally {
         if (rs != null) try { rs.close(); } catch(SQLException ex) {}
         if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
         if (conn != null) try { conn.close(); } catch(SQLException ex) {}
     }
		return member;
 }
    */
 }
   
    