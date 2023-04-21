package admin;

import java.sql.Timestamp;

public class HelperDTO {
	
	private int num;
	private String name; // 작성자
	private String pw;
	private String email;
	private String subject;
	private String content; // 글 내용
	private int readcount; // 조회수
	private String type; // 유저타입
	private String ip;
	private Timestamp reg; // 작성일시
	
	public void setNum(int num) {this.num = num;}
	public void setName(String name) {this.name = name;}
	public void setPw(String pw) {this.pw = pw;}
	public void setEmail(String email) {this.email = email;}
	public void setSubject(String subject) {this.subject = subject;}
	public void setContent(String content) {this.content = content;}
	public void setReadcount(int readcount) {this.readcount = readcount;}
	public void setType(String type) {this.type = type;}
	public void setIp(String ip) {this.ip = ip;}
	public void setReg(Timestamp reg) {this.reg = reg;}
	
	public int getNum() {return num;}
	public String getName() {return name;}
	public String getPw() {return pw;}
	public String getEmail() {return email;}
	public String getSubject() {return subject;}
	public String getContent() {return content;}
	public int getReadcount() {return readcount;}
	public String getType() {return type;}
	public String getIp() {return ip;}
	public Timestamp getReg() {return reg;}
} // public class HelperDTO {
