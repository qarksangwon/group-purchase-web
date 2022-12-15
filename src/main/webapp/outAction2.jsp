<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="user.UserDAO" %>
<%@ page import ="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id ="user" class = "user.User" scope="page" />
<%String ID = request.getParameter("userID"); %>
<jsp:setProperty name ="user" property="userPassword" />
<jsp:setProperty name ="user" property="userCheckAnswer" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content = "text/html" charset="UTF-8">
<title>배달 요금 절약 시스템</title>
</head>
<body>
	<%
		UserDAO userDAO = new UserDAO();
		int result= 0;
		int check1 = userDAO.checkPW(ID, user.getUserPassword());
		int check2 = userDAO.checkAnswer(ID, user.getUserCheckAnswer());
		result = check1+check2;
		if(result ==3){
			int lastCheck = userDAO.out(ID);
			if(lastCheck == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('db오류')");
				script.println("history.back()");
				script.println("</script>");
			}
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('탈퇴가 완료되었습니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		else if(result == 2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('패스워드가 틀렸습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('본인확인 답변이 틀렸습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == 5){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('몰?루5')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('맞는게 하나도 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>