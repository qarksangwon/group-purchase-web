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
		if(userID ==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('현재 로그인이 되어있지 않습니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
			return;
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
<script type="text/javascript">	
	function chatBoxFunction(){
		var userID = '<%=userID %>'
		$.ajax({
			type: "POST",
			url: "./ChatBoxServlet",
			data: {
				userID: encodeURIComponent('<%=userID%>'),
			},
			success: function(data){
				if(data == "") return;
				$('#boxTable').html('');
				var parsed = JSON.parse(data);
				var result = parsed.result;
				for(var i = 0; i <result.length; i++){
					if(result[i][0].value==userID){
						result[i][0].vlaue=result[i][1].value;
					}else{
						result[i][1].value=result[i][0].value;
					}
					addBox(result[i][0].value, result[i][1].value, result[i][2].value, result[i][3].value , result[i][4].value);
				}
			}
		});
	}
	
	function addBox(lastID, getID, chatContent, chatTime, unread){
		$('#boxTable').append('<tr onclick="location.href=\'chat.jsp?getID=' + encodeURIComponent(getID)+'\'">' +
			'<td style="width:150px;"><h5>' + getID + '</h5></td>'+
			'<td>' +
			'<h5>' + chatContent +
			'<span class="label label-info">'+unread+'</span></h5>' +
			'<div class=pull-right>' + chatTime + '</div>' +
			'</td>' +
			'</tr>');
	}
	
	function getInfiniteBox() {
		setInterval(function(){
			chatBoxFunction()
		},300);
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
				<li class="active"><a href="message.jsp">메세지함<span id="unread" class="label label-info"></span></a></li>
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
		<table class="table" style="margin:0 auto;">
			<thead>
				<tr class="info">
					<th style="text-align:center;"><h4>주고받은 메세지 목록</h4></th>
				</tr>
			</thead> 
			<div style="over-flow-y:auto; width:100%; max-height:450px;">
			 <table class ="table table-bordered table-hover" style="text-align : center ; border : 1px solid #dddddd">
			 	<tbody id="boxTable">
			 	</tbody>
			 </table>
			</div>
		</table>
	</div>
	<%
	if(userID !=null){%>
		<script type="text/javascript">
			$(document).ready(function(){
				getUnread();
				getInfiniteUnread();
				chatBoxFunction();
				getInfiniteBox();
			})
		</script>
	<%
	}
	%>
</body>
</html>