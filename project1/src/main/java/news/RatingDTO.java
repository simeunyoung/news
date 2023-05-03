package news;

public class RatingDTO {
	private int num;			//뉴스의 글번호
	private String id;			//세션으로 받아온 아이디
	private int good;			//좋아요
	private int bad;			//싫어요
	private int total;			//종점
	
	public void setNum(int num) {this.num = num;}
	public void setId(String id) {this.id = id;}
	public void setGood(int good) {this.good = good;}
	public void setBad(int bad) {this.bad = bad;}
	public void setTotal(int total) {this.total = total;}
	
	public int getNum() {return num;}
	public String getId() {return id;}
	public int getGood() {return good;}
	public int getBad() {return bad;}
	public int getTotal() {return total;}
	
}
