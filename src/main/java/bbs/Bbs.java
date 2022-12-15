package bbs;

public class Bbs {
	private int bbsID;
	private String bbsTitle;
	private String userID;
	private String userUC;
	
	public String getUserUC() {
		return userUC;
	}

	public void setUserUC(String userUC) {
		this.userUC = userUC;
	}

	private String bbsDate;
	private String bbsContent;
	private String bbsTime;
	
	
	public String getBbsTime() {
		return bbsTime;
	}
	public void setBbsTime(String bbsTime) {
		this.bbsTime = bbsTime;
	}
	private int bbsAvailable;
	
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbsDate() {
		return bbsDate;
	}
	public void setBbsDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}
	public String getBbsContent() {
		return bbsContent;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	public int getBbsAvailable() {
		return bbsAvailable;
	}
	public void setBbsAvailable(int bbsAvailable) {
		this.bbsAvailable = bbsAvailable;
	}
	
}
