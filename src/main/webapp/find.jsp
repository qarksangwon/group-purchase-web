<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		String userID = null;
		if(session.getAttribute("userID")!= null){
			userID = (String)session.getAttribute("userID");
		}
		String getID = null;
		if(request.getParameter("getID") !=null){
			getID = (String)request.getParameter("getID");
		}
		if(userID ==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('현재 로그인이 되어있지 않습니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
			return;
		}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content = "text/html" charset="UTF-8">
<meta name= "viewport" content = "width = device-width" initial-scale = "1">
<link rel="stylesheet" href = "css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<script src = "http://code.jquery.com/jquery-3.1.1.min.js"> </script>
<script src = "js/bootstrap.js"></script>
<script type="text/javascript">
	function getUnread(){
		$.ajax({
			type: "POST",
			url: "./ChatUnreadServlet",
			data: {
				userID: encodeURIComponent('<%=userID%>'),
			},
			success: function(result){
				if(result >= 1){
					showUnread(result);
				}else{
					showUnread('');
				}
			}
		});
	}
	function getInfiniteUnread() {
		setInterval(function(){
			getUnread();
		},300);
	}
	function showUnread(result){
		$('#unread').html(result);
	}
</script>
<title>배달 요금 절약 시스템</title>
</head>
<body>
	<nav class = "navbar navbar-default">
		<div class = "navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class = "icon-bar"></span>
				<span class = "icon-bar"></span>
				<span class = "icon-bar"></span>
			</button>
			<a class = "navbar-brand" href="main.jsp">배달공동구매</a>
		</div>
		<div class = "collapse navbar-collapse" id = "bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="bbs.jsp">게시판</a></li>
				<li><a href="message.jsp">메세지함<span id="unread" class="label label-info"></span></a></li>
				<li><a href="find.jsp">대화 시작하기</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" 
					aria-haspopup="true" aria-expanded="false"><%=userID %>님, 안녕하세요!<span class="caret"></span></a> 
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top : 20px;">
				<form method="post" action="findAction.jsp">
					<h3 style="text-align:center;">유저와 대화 시작하기</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<input type="submit" class="btn btn-info form-control" value="대화 시작하기">
				</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
	<%
	if(userID !=null){%>
		<script type="text/javascript">
			$(document).ready(function(){
				getUnread();
				getInfiniteUnread();
			})
		</script>
	<%
	}
	%>
</body>
</html>