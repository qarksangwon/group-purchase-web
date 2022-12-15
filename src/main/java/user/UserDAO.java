package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import user.User;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/SWP";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver"); 
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID =?";
		try {
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				}
				else
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디 없음
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	
	public int outcheck(String userID) {
		String SQL = "SELECT * FROM USER WHERE userID =?";
		try {
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(!(rs.getString(1).isEmpty())) {
					return 1; // 아이디 있음
				}
				else
					return 0;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 아이디 없음
	}
	
	public int checkPW(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID =?";
		try {
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 비밀번호 일치
				}
				else
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디 없음
		}catch (Exception e) {
			e.printStackTrace();
		}
		return 3; // 데이터베이스 오류
	}
	
	public int checkAnswer(String userID, String userCheckAnswer) {
		String SQL = "SELECT userCheckAnswer FROM USER WHERE userID =?";
		try {
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(userCheckAnswer)) {
					return 2; // 본인확인 일치
				}
				else
					return 0; // 본인확인 불일치
			}
			return -1; 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return 2; 
	}
	
	public int out(String userID) {
		String SQL="DELETE FROM user WHERE userID=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			pstmt.executeUpdate();
			return 3;
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // 데이터베이스 오류
	}
	
	
	
	public String ucGet(String userID) {
		String SQL = "SELECT userCheck FROM USER WHERE userID =?";
		try {
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(!(rs.getString(1).isEmpty())) {
					return rs.getString(1);
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "데이터베이스 오류";
	}
	
	
	public int join(User user) {
		String SQL="INSERT INTO USER VALUES(?,?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,user.getUserID());
			pstmt.setString(2,user.getUserPassword());
			pstmt.setString(3,user.getUserName());
			pstmt.setString(4,user.getUserGender());
			pstmt.setString(5,user.getUserUC());
			pstmt.setString(6,user.getUserCheck());
			pstmt.setString(7,user.getUserCheckAnswer());
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // 데이터베이스 오류
	}
	public String getUserUC(String userID) {
		String SQL = "SELECT userUC FROM USER WHERE userID =?";
		try {
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(!(rs.getString(1).isEmpty())) {
					return rs.getString(1);
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "데이터베이스 오류";
	}
	public User getUser(String userID) {
		String SQL = "SELECT * FROM user WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserUC(rs.getString(5));
				user.setUserCheck(rs.getString(6));
				user.setUserCheckAnswer(rs.getString(7));
				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
