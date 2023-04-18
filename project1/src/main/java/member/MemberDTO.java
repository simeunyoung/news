package member;

import java.sql.Timestamp;

public class MemberDTO {

	private String id;
	private String pw;
	private String name;
	private String nickName;
	private Timestamp birthday;
	private String email;
	private String pNum;
	private Timestamp reg;
	private String memberType;
	private String press;
	private String pressSubcribe;
	private String reporterSubcribe;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public Timestamp getBirthday() {
		return birthday;
	}
	public void setBirthday(Timestamp birthday) {
		this.birthday = birthday;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getpNum() {
		return pNum;
	}
	public void setpNum(String pNum) {
		this.pNum = pNum;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public String getMemberType() {
		return memberType;
	}
	public void setMemberType(String memberType) {
		this.memberType = memberType;
	}
	public String getPress() {
		return press;
	}
	public void setPress(String press) {
		this.press = press;
	}
	public String getPressSubcribe() {
		return pressSubcribe;
	}
	public void setPressSubcribe(String pressSubcribe) {
		this.pressSubcribe = pressSubcribe;
	}
	public String getReporterSubcribe() {
		return reporterSubcribe;
	}
	public void setReporterSubcribe(String reporterSubcribe) {
		this.reporterSubcribe = reporterSubcribe;
	}
}
