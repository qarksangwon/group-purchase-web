<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
	<%
		String userID = null;
		if(session.getAttribute("userID")!= null){
			userID = (String)session.getAttribute("userID");
		}%>
<html>
<head>
<meta http-equiv="Content-Type" content = "text/html" charset="UTF-8">
<meta name= "viewport" content = "width = device-width" initial-scale = "1">
<link rel="stylesheet" href = "css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<script src = "http://code.jquery.com/jquery-3.1.1.min.js"> </script>
<script src = "js/bootstrap.js"></script>
<title>배달 요금 절약 시스템</title>
</head>
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
<%
		int bbsID=0;
		if(request.getParameter("bbsID")!= null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID != 0){
			Bbs bbs = new BbsDAO().getBbs(bbsID);
	%>
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
				<li class = "active "><a href="bbs.jsp">게시판</a></li>
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
	<div class ="container">
		<div class = "row">
			<table class = "table table-striped" style="text-align : center ; border : 1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="3" style="background-color: #eeeeee; text-align : center;">구인 정보</th>
				</tr>
			</thead>
			<tbody>
				<tr> 
					<td>배달시킬 곳</td>
					<td colspan="2"><%=bbs.getBbsTitle() %> / <%=bbs.getBbsContent() %></td>
				</tr>
				<tr> 
					<td>작성자</td>
					<td colspan="2"><%=bbs.getUserID()%></td>
				</tr>
				<tr> 
					<td>학교</td>
					<td colspan="2"><%=bbs.getUserUC()%></td>
				</tr>
				<tr> 
					<td>작성일자</td>
					<td colspan="2"><%=bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13)+"시"+bbs.getBbsDate().substring(14,16)+"분" %></td>
				</tr>
				<tr> 
					<td>구인시간</td>
					<td colspan="2" style="text-align:center;"><%=bbs.getBbsTime() %></td>
				</tr>
				<tr>
				<td colspan="3" style="text-align:center; color:red;">메뉴와 브랜드, 학교 및 작성시간과 구인시간을 확인해 주시기 바랍니다.</td>
				</tr>
			</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-info">목록</a>
			<%
				if(userID!=null&&userID.equals(bbs.getUserID())){
					%><a onclick="return confirm('삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-danger">삭제</a>
			<%	}else{%>
				<a href="chat.jsp?getID=<%=bbs.getUserID() %>" class="btn btn-info">해당 사용자와 대화 시작</a>
				<% }
			%>
		</div>	
	</div>


</body>
</html>
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
<%}

		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
%>