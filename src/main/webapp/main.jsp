<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
	<%
		String userID = null;
		if(session.getAttribute("userID")!= null){
			userID = (String)session.getAttribute("userID");
		}
	%> 
<head>
<meta http-equiv="Content-Type" content = "text/html" charset="UTF-8">
<meta name= "viewport" content = "width = device-width" initial-scale = "1">
<link rel="stylesheet" href = "css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<script src = "http://code.jquery.com/jquery-3.1.1.min.js"></script>
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
			<%
				if(userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" 
					aria-haspopup="true" aria-expanded="false">접속하기<span class="caret"></span></a> 
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
						<li><a href="out.jsp">탈퇴</a></li>
					</ul>
				</li>
			</ul>
			<%
			} else{
			%>
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
			<%
			}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h2>배달 공동구매</h2>
				<p style="font-size:16px">배달비가 부담되는 학생들을 위한 배달음식 공동구매 웹 사이트</p>
				<p><a class="btn btn-info btn-pull" href="bbs.jsp" role="button">모집공고 바로가기</a></p>
			</div>
		</div>
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