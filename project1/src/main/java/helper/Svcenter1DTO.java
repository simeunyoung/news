package helper;
import java.sql.Timestamp;
public class Svcenter1DTO {		//자주묻는질문
	private int num;			//글번호
	private String id;			//작성자
	private String title;		//글제목
	private String con;			//글내용
	private Timestamp reg;		//작성날짜
	
	public void setNum(int num) {this.num = num;}
	public void setId(String id) {this.id = id;}
	public void setTitle(String title) {this.title = title;}
	public void setCon(String con) {this.con = con;}
	public void setReg(Timestamp reg) {this.reg = reg;}
	
	public int getNum() {return num;}
	public String getId() {return id;}
	public String getTitle() {return title;}
	public String getCon() {return con;}
	public Timestamp getReg() {return reg;}
}
