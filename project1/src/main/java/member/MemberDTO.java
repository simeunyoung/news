package member;

import java.sql.Timestamp;

public class MemberDTO {

	private String id;
	private String pw;
	private String name;
	private String nick;
	private String birthdate;
	private String email;
	private String tel;
	private Timestamp reg;
	private String memberType;
	private String press;
	private String pressSubcribe;
	private String reporterSubcribe;
	private String ip;
	private String img;
	private String scrap;
	
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
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
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
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getScrap() {
		return scrap;
	}
	public void setScrap(String scrap) {
		this.scrap = scrap;
	}
}