<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="user.UserDAO" %>
<%@ page import ="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id ="user" class = "user.User" scope="page" />
<jsp:setProperty name ="user" property="userID" />
<jsp:setProperty name ="user" property="userPassword" />
<jsp:setProperty name ="user" property="userName" />
<jsp:setProperty name ="user" property="userGender" />
<jsp:setProperty name ="user" property="userUC" />
<jsp:setProperty name ="user" property="userCheck" />
<jsp:setProperty name ="user" property="userCheckAnswer" />
<% String PasswordCheck = request.getParameter("PasswordCheck"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content = "text/html" charset="UTF-8">
<title>배달 요금 절약 시스템</title>
</head>
<body>
	<%
		if(user.getUserID() ==null || user.getUserPassword()==null || user.getUserName()==null || user.getUserCheckAnswer()==null|| PasswordCheck.equals("")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 되지 않은 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(!user.getUserPassword().equals(PasswordCheck)){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('패스워드가 다릅니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if(result ==-1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원가입이 완료되었습니다.')");
				script.println("location.href = 'login.jsp'");
				script.println("</script>");
			}
		}
		
	%>
</body>
</html>