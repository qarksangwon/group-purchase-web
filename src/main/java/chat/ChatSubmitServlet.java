package chat;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ChatSubmitServlet")
public class ChatSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userID = request.getParameter("userID");
		String getID = request.getParameter("getID");
		String chatContent = request.getParameter("chatContent");
		
		if(userID==null||userID.equals("")||getID==null||getID.equals("") 
				||chatContent.equals("")|| chatContent==null) {
			response.getWriter().write("0");
		}else {
			userID = URLDecoder.decode(userID,"UTF-8");
			getID = URLDecoder.decode(getID,"UTF-8");
			chatContent = URLDecoder.decode(chatContent,"UTF-8");
			response.getWriter().write(new ChatDAO().submit(userID, getID, chatContent)+ "");
			
		}
	}

}
