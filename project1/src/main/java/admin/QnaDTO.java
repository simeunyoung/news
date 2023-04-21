package admin;

import java.sql.Timestamp;

public class QnaDTO {
	
	private int num;
	private String id;
	private String subject;
	private String content;
	private Timestamp reg;
	
	public void setNum(int num) {this.num = num;}
	public void setId(String id) {this.id = id;}
	public void setSubject(String subject) {this.subject = subject;}
	public void setContent(String content) {this.content = content;}
	public void setReg(Timestamp reg) {this.reg = reg;}
	
	public int getNum() {return num;}
	public String getId() {return id;}
	public String getSubject() {return subject;}
	public String getContent() {return content;}
	public Timestamp getReg() {return reg;}
} // public class qnaDTO {
