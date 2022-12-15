<%@page import="user.UserDAO"%>
<%@page import="user.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
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
	<%
		String userID = null;
		if(session.getAttribute("userID")!= null){
			userID = (String)session.getAttribute("userID");
		}
		
	%>
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
		<form action="writeAction.jsp">	
			<table class = "table table-striped" style="text-align : center ; border : 1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="4" style="background-color: #eeeeee; text-align : center;">게시판 글쓰기</th>
				</tr>
			</thead>
			<tbody>
				<tr height = "50px"> 
					<td>
					<b>음식</b> &nbsp;&nbsp; :&nbsp;&nbsp; 
					<select id="bbsTitle" onchange="titleChange(this)" name="bbsTitle" style="width:150px; height:20px;">
							<option value="선택">선택</option>
							<option value="치킨">치킨</option>
							<option value="피자" >피자</option>
							<option value="햄버거">햄버거</option>
						</select>
					</td>
					<td>
					<b>브랜드</b>&nbsp;&nbsp; :&nbsp;&nbsp; 
						<select id="bbsContent" name="bbsContent" style="width:150px; height:20px;">
						</select>
					</td>
					<script> 
					function titleChange(e) {
						var chicken = ["bbq","bhc","교촌치킨","네네치킨"]
						var pizza = ["피자헛","도미노피자","피자스쿨","피자알볼로"]
						var hamburger = ["롯데리아","버거킹","맘스터치","맥도날드"]
						const btn = document.getElementById('btn');
						var target = document.getElementById("bbsContent");
						
						if(e.value=="치킨"){ 
							var lst = chicken;
							btn.disabled = false;
							message.innerHTML = ""
						}
						else if(e.value=="피자"){
							var lst = pizza;
							btn.disabled = false;
							message.innerHTML = ""
						}
						else if(e.value=="햄버거"){
							var lst = hamburger;
							btn.disabled = false;
							message.innerHTML = ""
						}
						else{
							btn.disabled = true;
							message.innerHTML = "음식을 선택해 주십시오"
						}
						
						target.options.length = 0;
						for(i in lst){
							var opt = document.createElement("option");
							opt.value = lst[i];
							opt.innerHTML = lst[i];
							target.appendChild(opt);
						}
					}
					</script>
					<td>
					<b>시간</b> &nbsp;&nbsp; :&nbsp;&nbsp; 
					<select id="bbsTime" name="bbsTime" style="width:150px; height:20px;">
							<option value="시간제한 없음">시간제한 없음</option>
							<option value="10분">10분</option>
							<option value="20분">20분</option>
							<option value="30분" >30분</option>
						</select>
					</td>
					<td>
				</tr>
			</tbody>
			</table>
		<input type="submit" id="btn" class="btn btn-info pull-right" value="글쓰기" disabled="disabled">
		<span id="message" style="color : Red">음식을 선택해 주십시오</span>
		</form>
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