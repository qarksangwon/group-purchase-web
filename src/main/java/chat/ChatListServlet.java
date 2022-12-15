package chat;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ChatListServlet")
public class ChatListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userID = request.getParameter("userID");
		String getID = request.getParameter("getID");
		String listType = request.getParameter("listType");
		
		if(userID==null||userID.equals("")||getID==null||getID.equals("") 
				||listType.equals("")|| listType==null) {
			response.getWriter().write("");
		}
		else if(listType.equals("ten")) {
			response.getWriter().write(getTen(URLDecoder.decode(userID,"UTF-8"),URLDecoder.decode(getID,"UTF-8")));
		}
		else {
			try {
				response.getWriter().write(getID(URLDecoder.decode(userID,"UTF-8"),URLDecoder.decode(getID,"UTF-8"),listType));
			} catch (Exception e) {
				response.getWriter().write("");
			}
		}
			
	
	}
	public String getTen(String userID,String getID) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDAO chatDAO = new ChatDAO();
		ArrayList<Chat> chatList = chatDAO.getChatListByRecent(userID, getID, 100);
		if(chatList.size()==0) return "";
		for(int i = 0; i<chatList.size(); i++) {
			result.append("[{\"value\":\""+chatList.get(i).getUserID()+"\"},");
			result.append("{\"value\":\""+chatList.get(i).getGetID()+"\"},");
			result.append("{\"value\":\""+chatList.get(i).getChatContent()+"\"},");
			result.append("{\"value\":\""+chatList.get(i).getChatTime()+"\"}]");
			if(i != chatList.size()-1) {
				result.append(",");
			}
		}
		result.append("],\"last\":\""+chatList.get(chatList.size()-1).getChatID()+"\"}");
		chatDAO.readChat(userID, getID);
		return result.toString();	
	}
	
	
	public String getID(String userID,String getID, String chatID) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDAO chatDAO = new ChatDAO();
		ArrayList<Chat> chatList = chatDAO.getChatListByID(userID, getID, chatID);
		if(chatList.size()==0) return "";
		for(int i = 0; i<chatList.size(); i++) {
			result.append("[{\"value\":\""+chatList.get(i).getUserID()+"\"},");
			result.append("{\"value\":\""+chatList.get(i).getGetID()+"\"},");
			result.append("{\"value\":\""+chatList.get(i).getChatContent()+"\"},");
			result.append("{\"value\":\""+chatList.get(i).getChatTime()+"\"}]");
			if(i != chatList.size()-1)
				result.append(",");
			
		}
		result.append("],\"last\":\""+chatList.get(chatList.size()-1).getChatID()+"\"}");
		chatDAO.readChat(userID, getID);
		return result.toString();
	}
}
