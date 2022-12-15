<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="bbs.BbsDAO" %>
<%@ page import ="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id ="bbs" class = "bbs.Bbs" scope="page" />
<jsp:setProperty name ="bbs" property="bbsTitle" />
<jsp:setProperty name ="bbs" property="bbsContent" />
<jsp:setProperty name ="bbs" property="bbsTime" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content = "text/html" charset="UTF-8">
<title>배달 요금 절약 시스템</title>
</head>
<body>
	<%
	String userID = null;
	String userUC = null;
	if(session.getAttribute("userID")!=null){
		userID = (String)session.getAttribute("userID");
		userUC = new UserDAO().getUserUC(userID);
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해야 글쓰기가 가능합니다.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}else{
		BbsDAO bbsDAO = new BbsDAO();
		int result = bbsDAO.write(bbs.getBbsTitle(), userID,userUC, bbs.getBbsContent(), bbs.getBbsTime());
		if(result ==-1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('작성이 완료되었습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
	}
	%>
</body>
</html>