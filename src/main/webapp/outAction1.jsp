<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="user.UserDAO" %>
<%@ page import ="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id ="user" class = "user.User" scope="page" />
<jsp:setProperty name ="user" property="userID" />
<%String ID = request.getParameter("userID"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content = "text/html" charset="UTF-8">
<meta name= "viewport" content = "width = device-width" initial-scale = "1">
<link rel="stylesheet" href = "css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>배달 요금 절약 시스템</title>
</head>
<body>
	<%
		UserDAO userDAO = new UserDAO(); 
		int result = userDAO.outcheck(user.getUserID());
		if(result ==1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			%>
		<div class="container">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="jumbotron" style="padding-top : 20px;">
					<form method="post" action="outAction2.jsp">
						<h4 style="text-align:center;">질문에 답을 입력해주십시오</h4>
						<div class="form-group" align="center">
							<p style="font-size:14px; color:black; font-weight:bold;" >ID : <%=ID %> </p>
							<input type="text" name="userID" value="<%=ID%>" style="display:none;"> 
							<p style="font-size:14px; color:black; font-weight:bold;">본인확인 질문 : <%=userDAO.ucGet(ID)%></p>
						</div>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
						</div>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="본인확인 질문 답변" name="userCheckAnswer" maxlength="20">
						</div>						
						<input type="submit" class="btn btn-info form-control" value="탈퇴하기">
					</form>
				</div>
			</div>
			<div class="col-lg-4"></div>
		</div>
				<% 
			script.println("</script>");
		}
		else if(result ==-2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('없는 아이디 입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('!?')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>