package admin;

import java.sql.Timestamp;

public class AdminDTO {
	private int num;
	private String id;
	private String pw;
	private String email;
	private String tel;
	private String name;
	private String memberType;
	private String title;
	private String con;
	private String ip;
	private Timestamp reg;
	
	public int getNum() {
		return num;
	}
	public String getId() {
		return id;
	}
	public String getPw() {
		return pw;
	}
	public String getEmail() {
		return email;
	}
	public String getTel() {
		return tel;
	}
	public String getName() {
		return name;
	}
	public String getMemberType() {
		return memberType;
	}
	public String getTitle() {
		return title;
	}
	public String getCon() {
		return con;
	}
	public String getIp() {
		return ip;
	}
	public Timestamp getReg() {
		return reg;
	}
	
	public void setNum(int num) {
		this.num = num;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setMemberType(String memberType) {
		this.memberType = memberType;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setCon(String con) {
		this.con = con;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	
} // public class AdminDTO {