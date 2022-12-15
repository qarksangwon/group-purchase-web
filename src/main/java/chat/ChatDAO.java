package chat;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class ChatDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public ChatDAO() {
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
	
	public ArrayList<Chat> getChatListByID(String userID,String getID,String chatID){
		ArrayList<Chat> chatList = null;
		String SQL = "SELECT * FROM CHAT WHERE(((userID = ? AND getID = ?) OR (userID = ? AND getID = ?)) AND chatID > ?) ORDER BY chatTime";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, getID);
			pstmt.setString(3, getID);
			pstmt.setString(4, userID);
			pstmt.setInt(5, Integer.parseInt(chatID));
			rs = pstmt.executeQuery();
			chatList = new ArrayList<Chat>();
			while(rs.next()) {
				Chat chat = new Chat();
				chat.setChatID(rs.getInt("chatID"));
				chat.setUserID(rs.getString("userID").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>"));
				chat.setGetID(rs.getString("getID").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>").replaceAll("\"","&quot;"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType = "오전";
				if(chatTime > 12) {
					timeType = "오후";
					chatTime -=12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11)+" "+timeType+" "+chatTime+":"+rs.getString("chatTime").substring(14,16));
				chatList.add(chat);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return chatList;
	}
	
	public ArrayList<Chat> getChatListByRecent(String userID,String getID,int number){
		ArrayList<Chat> chatList = null;
		String SQL = "SELECT * FROM CHAT WHERE((userID = ? AND getID = ?) OR (userID = ? AND getID = ?)) AND chatID > (SELECT MAX(chatID) - ? FROM CHAT WHERE (userID = ? AND getID = ?) OR (userID = ? AND getID = ?)) ORDER BY chatTime";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, getID);
			pstmt.setString(3, getID);
			pstmt.setString(4, userID);
			pstmt.setInt(5, number);
			pstmt.setString(6, userID);
			pstmt.setString(7, getID);
			pstmt.setString(8, getID);
			pstmt.setString(9, userID);
			rs = pstmt.executeQuery();
			chatList = new ArrayList<Chat>();
			while(rs.next()) {
				Chat chat = new Chat();
				chat.setChatID(rs.getInt("chatID"));
				chat.setUserID(rs.getString("userID").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>"));
				chat.setGetID(rs.getString("getID").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>").replaceAll("\"","&quot;"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType = "오전";
				if(chatTime > 12) {
					timeType = "오후";
					chatTime -=12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11)+" "+timeType+" "+chatTime+":"+rs.getString("chatTime").substring(14,16));
				chatList.add(chat);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return chatList;
	}
	
	public int submit(String userID,String getID,String chatContent){

		String SQL = "INSERT INTO CHAT VALUES(NULL, ?, ?, ?, NOW(),0)";
			
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, getID);
			pstmt.setString(3, chatContent);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //디비오류
	}
	
	public int readChat(String userID, String getID) {
		String SQL = "UPDATE CHAT SET chatRead = 1 WHERE (userID = ? AND getID = ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, getID);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 디비오류
	}
	
	public int getAllUnreadChat(String userID) {
		String SQL = "SELECT COUNT(chatID) FROM CHAT WHERE getID = ? AND chatRead = 0";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("COUNT(chatID)");
			}
			return 0;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 디비오류
	}
	
	
	public ArrayList<Chat> getBox(String userID){
		ArrayList<Chat> chatList = null;
		String SQL = "SELECT * FROM chat WHERE chatID IN (SELECT MAX(chatID) FROM CHAT WHERE getID = ? OR userID = ? GROUP BY userID,getID)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userID);
			rs = pstmt.executeQuery();
			chatList = new ArrayList<Chat>();
			while(rs.next()) {
				Chat chat = new Chat();
				chat.setChatID(rs.getInt("chatID"));
				chat.setUserID(rs.getString("userID").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>"));
				chat.setGetID(rs.getString("getID").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>").replaceAll("\"","&quot;"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType = "오전";
				if(chatTime > 12) {
					timeType = "오후";
					chatTime -=12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11)+" "+timeType+" "+chatTime+":"+rs.getString("chatTime").substring(14,16));
				chatList.add(chat);
			}
			for ( int i = 0; i< chatList.size(); i++) {
				Chat x = chatList.get(i);
				for(int j = 0; j < chatList.size(); j++) {
					Chat y = chatList.get(j);
					if(x.getUserID().equals(y.getGetID())&&x.getGetID().equals(y.getUserID())){
						if(x.getChatID()<y.getChatID()) {
							chatList.remove(x);
							i--;
							break;
						}
						else {
							chatList.remove(y);
							i--;
							break;
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return chatList;
	}
	
	
	public String getUnreadChat(String userID, String getID) {
		String SQL = "SELECT COUNT(chatID) FROM CHAT WHERE userID = ? AND getID = ? AND chatRead = 0";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, getID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString("COUNT(chatID)");
			}
			return "0";
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 디비오류
	}

}
