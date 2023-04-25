package helper;
import java.sql.Timestamp;
public class GijaDTO {
	private int num;
	private String id;
	private String name;
	private String press;
	private String email;
	private String tel;
	private String membertype;
	private Timestamp reg;
	
	public void setNum(int num) {this.num = num;}
	public void setId(String id) {this.id = id;}
	public void setName(String name) {this.name = name;}
	public void setPress(String press) {this.press = press;}
	public void setEmail(String email) {this.email = email;}
	public void setTel(String tel) {this.tel = tel;}
	public void setMembertype(String membertype) {this.membertype = membertype;}
	public void setReg(Timestamp reg) {this.reg = reg;}
	
	public int getNum() {return num;}
	public String getId() {return id;}
	public String getName() {return name;}
	public String getPress() {return press;}
	public String getEmail() {return email;}
	public String getTel() {return tel;}
	public String getMembertype() {return membertype;}
	public Timestamp getReg() {return reg;}
}
