package helper;
import java.sql.Timestamp;
public class SvcenterDTO {		//1대1 문의하기
	private int num1;
	private String id;
	private String title;
	private String email;
	private String con;
	private String pw;
	private Timestamp reg;
	
	public void setNum1(int num1) {this.num1 = num1;}
	public void setId(String id) {this.id = id;}	
	public void setTitle(String title) {this.title = title;}
	public void setEmail(String email) {this.email = email;}
	public void setCon(String con) {this.con = con;}
	public void setPw(String pw) {this.pw = pw;}
	public void setReg(Timestamp reg) {this.reg = reg;}
	
	public int getNum1() {return num1;}
	public String getId() {return id;}
	public String getTitle() {return title;}
	public String getEmail() {return email;}
	public String getCon() {return con;}
	public String getPw() {return pw;}
	public Timestamp getReg() {return reg;}
}
