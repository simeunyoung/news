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
		if(id.matches("^[a-z0-9]{5,20}$"))
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		if(pw.matches("^(?=.*[a-zA-Z])(?=.*[!@#$%^&*])[a-zA-Z!@#$%^&*0-9]{8,16}$"))
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		if (name.length() <= 40)
		this.name = name;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		if (nick.length() <= 40)
		this.nick = nick;
	}
	public String getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(String birthdate) {
		if (birthdate.length() == 8)
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
		if (memberType.equals("-1") || memberType.equals("0") || memberType.equals("1") || memberType.equals("2"))
		this.memberType = memberType;
	}
	public String getPress() {
		return press;
	}
	public void setPress(String press) {
        if (!press.contains("@"))
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