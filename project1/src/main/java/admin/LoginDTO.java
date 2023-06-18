package admin;

import java.sql.Timestamp;

public class LoginDTO {
	
	private String id;
	private String pw;
	private String email;
	private String type; // 유저 권한설정 0회원 1기자 2관리자
	private String ip;
	private Timestamp reg;
	
	public void setId(String id) {this.id = id;}
	public void setPw(String pw) {this.pw = pw;}
	public void setEmail(String email) {this.email = email;}
	public void setType(String type) {this.type = type;}
	public void setIp(String ip) {this.ip = ip;}
	public void setReg(Timestamp reg) {this.reg = reg;}
	
	public String getId() {return id;}
	public String getPw() {return pw;}
	public String getEmail() {return email;}
	public String getType() {return type;}
	public String getIp() {return ip;}
	public Timestamp getReg() {return reg;}
} // public class LoginDTO {