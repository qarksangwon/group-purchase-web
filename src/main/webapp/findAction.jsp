<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="user.UserDAO" %>
<%@ page import ="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id ="user" class = "user.User" scope="page" />
<jsp:setProperty name ="user" property="userID" />
<jsp:setProperty name ="user" property="userPassword" />
<% String PasswordCheck = request.getParameter("PasswordCheck"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content = "text/html" charset="UTF-8">
<title>배달 요금 절약 시스템</title>
</head>
<body>
	<%
	if(user.getUserID() ==null || user.getUserID().equals("")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유저를 입력하지 않았습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	if (session.getAttribute("userID").equals(user.getUserID())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('본인과는 대화할 수 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	UserDAO userDAO = new UserDAO();
	String findUser = user.getUserID();
	
	if(userDAO.outcheck(findUser)==1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('"+findUser+"님과 대화를 시작합니다.')");
		script.println("location.href = 'chat.jsp?getID="+findUser+"'");
		script.println("</script>");
	}else if(userDAO.outcheck(findUser)== -2){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('없는 사용자 입니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
		


	%>
</body>
</html>