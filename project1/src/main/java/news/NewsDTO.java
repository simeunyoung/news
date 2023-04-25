package news;
import java.sql.Timestamp;

public class NewsDTO {
	private int num;
	private String id;
	private String nick;
	private String con;
	private String newstype;
	private Timestamp reg;
	private String pw;
	private String ip;
	private String recon;
	private int views;
	private String title;
	private String press; // member , news
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getCon() {
		return con;
	}
	public void setCon(String con) {
		this.con = con;
	}
	public String getNewstype() {
		return newstype;
	}
	public void setNewstype(String newstype) {
		this.newstype = newstype;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getRecon() {
		return recon;
	}
	public void setRecon(String recon) {
		this.recon = recon;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPress() {
		return press;
	}
	public void setPress(String press) {
		this.press = press;
	}
	
	
}
