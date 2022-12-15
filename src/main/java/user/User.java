package user;

public class User {
	private String userID;
	private String userPassword;
	private String userName;
	private String userGender;
	private String userUC;
	private String userCheck;
	private String userCheckAnswer;
	
	
	public String getUserCheck() {
		return userCheck;
	}
	public void setUserCheck(String userCheck) {
		this.userCheck = userCheck;
	}


	public String getUserCheckAnswer() {
		return userCheckAnswer;
	}
	public void setUserCheckAnswer(String userCheckAnswer) {
		this.userCheckAnswer = userCheckAnswer;
	}

	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender; 
	}
	public String getUserUC() {
		return userUC;
	}
	public void setUserUC(String userUC) {
		this.userUC = userUC;
	}
}
