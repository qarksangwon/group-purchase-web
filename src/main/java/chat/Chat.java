package chat;

public class Chat {

	int chatID;
	String userID; //fromID
	String getID;  //toID
	String chatContent;
	String chatTime;
	public int getChatID() {
		return chatID;
	}
	public void setChatID(int chatID) {
		this.chatID = chatID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getGetID() {
		return getID;
	}
	public void setGetID(String getID) {
		this.getID = getID;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public String getChatTime() {
		return chatTime;
	}
	public void setChatTime(String chatTime) {
		this.chatTime = chatTime;
	}
	
	
}
