package gamerParty;

public class Account {
	private int aid;
	private String email;
	private String password;
	private String nickname;
	private String prefergame;
	private String preferrole;
	private String icon;
	private int ban;
	private int type; // admin 페이지에서만 사용 , db에는 X
	private int action_uid; // 위와동일 
	public Account() {
		email = "없음";
		password = "없음";
		nickname = "없음";
		prefergame = "없음";
		preferrole = "없음";
		icon = "없음";
		ban = 0;
	}
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPrefergame() {
		return prefergame;
	}
	public void setPrefergame(String prefergame) {
		this.prefergame = prefergame;
	}
	public String getPreferrole() {
		return preferrole;
	}
	public void setPreferrole(String preferrole) {
		this.preferrole = preferrole;
	}
	public int getBan() {
		return ban;
	}
	public void setBan(int ban) {
		this.ban = ban;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getAction_uid() {
		return action_uid;
	}
	public void setAction_uid(int action_uid) {
		this.action_uid = action_uid;
	}
}
