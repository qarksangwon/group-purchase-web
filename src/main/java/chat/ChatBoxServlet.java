package chat;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ChatBoxServlet")
public class ChatBoxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userID = request.getParameter("userID");
		String getID = request.getParameter("getID");
		if(userID == null || userID.equals("")) {
			response.getWriter().write("");
		}else {
			try {
				userID = URLDecoder.decode(userID,"UTF-8");
				response.getWriter().write(getBox(userID));
			} catch (Exception e) {
				System.out.println("오류발생");
				response.getWriter().write("");
			}	
		}
	}

	public String getBox(String userID) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDAO chatDAO = new ChatDAO();
		ArrayList<Chat> chatList = chatDAO.getBox(userID);
		if(chatList.size()==0) return "";
		for(int i = 0; i<chatList.size(); i++) {
			String unread="";
			if(userID.equals(chatList.get(i).getGetID())) {
				unread = chatDAO.getUnreadChat(chatList.get(i).getUserID(),userID);
				if(unread.equals("0")) unread="";
			}
			result.append("[{\"value\":\""+chatList.get(i).getUserID()+"\"},");
			result.append("{\"value\":\""+chatList.get(i).getGetID()+"\"},");
			result.append("{\"value\":\""+chatList.get(i).getChatContent()+"\"},");
			result.append("{\"value\":\""+chatList.get(i).getChatTime()+"\"},");
			result.append("{\"value\":\""+unread+"\"}]");
			if(i != chatList.size()-1)
				result.append(",");
			
		}
		result.append("],\"last\":\""+chatList.get(chatList.size()-1).getChatID()+"\"}");
		return result.toString();
	}
}
