package member;
import java.sql.Timestamp;

public class LogonDataBean{

	private String id;
	private String passwd;
	private String name;
	private String jumin1;
	private String jumin2;
	private String email;
	private String blog;
	private Timestamp reg_date;

	public void setId (String id){
		this.id = id;
	}
    public void setPasswd (String passwd){
		this.passwd = passwd;
	}
	public void setName (String name){
		this.name = name;
	}
	public void setJumin1 (String jumin1){
		this.jumin1 = jumin1;
	}
	public void setJumin2 (String jumin2){
		this.jumin2 = jumin2;
	}
	public void setEmail (String email){
		this.email = email;
	}
	public void setBlog (String blog){
		this.blog = blog;
	}
	public void setReg_date (Timestamp reg_date){
		this.reg_date = reg_date;
	}

	public String getId(){
 		return id; 
 	}
	public String getPasswd(){
 		return passwd; 
 	}
	public String getName(){
 		return name; 
 	}
	public String getJumin1(){
 		return jumin1; 
 	}
	public String getJumin2(){
 		return jumin2; 
 	}
	public String getEmail(){
 		return email; 
 	}
	public String getBlog(){
 		return blog; 
 	}

	public Timestamp getReg_date(){
 		return reg_date; 
 	}
}