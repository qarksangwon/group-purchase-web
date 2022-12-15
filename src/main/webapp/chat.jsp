<%@page import="chat.ChatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
<title>배달 요금 절약 시스템</title>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href = "css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/messageBox.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src = "js/bootstrap.js"></script>
<script>
function mykeyup() {
    if(window.event.keyCode==13)
    {
    	submitFunction();
    	
    }
}
</script>
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
	
	function submitFunction(){
		var userID = '<%=userID %>';
		var getID = '<%=getID %>';
		var chatContent = $('#chatContent').val();
		$.ajax({
			type:"POST",
			url:"./ChatSubmitServlet",
			data:{
				userID: encodeURIComponent(userID),
				getID: encodeURIComponent(getID),
				chatContent: encodeURIComponent(chatContent)
			},
			success:function(result){
				if(result==1){
					$('#chatContent').html("");
				}else if(result == 0){
					$('#chatContent').html("실패");;
				}else{
					$('#chatContent').html("뭐여");
				}
			}
		
		});
		$('#chatContent').val('');
		
	}
	 var lastID = 0;
	 function chatListFunction(type){
		var userID = '<%= userID %>';
		var getID = '<%=getID%>';
		$.ajax({
			type: "POST",
			url: "./ChatListServlet",
			data: {
				userID: encodeURIComponent(userID),
				getID: encodeURIComponent(getID),
				listType: type
			},
			success: function(data){
				if(data=="") return;
				var parsed = JSON.parse(data);
				var result = parsed.result;
				for(var i =0; i < result.length; i++){
					if(result[i][0].value== userID){
						result[i][0].value='나';
					}
					addChat(result[i][0].value, result[i][2].value, result[i][3].value);
				}
				lastID = Number(parsed.last);
			}
		});
	}
	function addChat(chatName, chatContent, chatTime){
		$('#chatList').append('<div class="row">' + 
				'<div class="col-lg-12">' +
				'<div class="media">' +
				'<a class="pull-left" href="#">' +
				'<img class="media-object img-circle" style="width: 30px; height : 30px;" src="images/icon.png" alt="">' +
				'</a>' +
				'<div class="media-body">' +
				'<h4 class="media-heading">' +
				chatName +
				'<span class="small pull-right">' +
				chatTime +
				'</span>' +
				'</h4>' +
				'<p>' +
				chatContent +
				'</p>' +
				'</div>' +
				'</div>' +
				'</div>' +
				'</div>' +
				'<hr>');
		
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
	}
	
	function getInfiniteChat(){
			setInterval(function(){
				chatListFunction(lastID);
		},100)
	} 
</script>
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
	<div class="container bootstrap snippet">
		<div class="row">
			<div class="col-xs-12">
				<div class="portlet portlet-default">
					<div class="portlet-heading">
						<div class="portlet-title">
							<h4><i class="fa fa-circle text-white">실시간 채팅창</i></h4>
						</div>
						<div class="clearfix"></div>
					</div>
					<div id="chat" class="panel-collapse collapse in">
						<div id="chatList" class="portlet-body chat-widget" style="overflow-y: auto; width: auto; height:600px;">
						</div>
						<div class="portlet-footer">
							<div class="row" style="height: 90px">
								<div class="form-group col-xs-10">
									<textarea style="height:80px;" id="chatContent" class="form-control" placeholder="메세지를 입력하세요" maxlength="100" onkeyup='mykeyup()'></textarea>
									<textarea style="display:none" id="useBackspace"></textarea>
								</div>
								<div class="form-group col-xs-2">
									<button id="submitButton" type="button" class="btn btn-default pull-right" onclick="submitFunction()">전송</button>
									<div class="clearfix"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="alert alert-success" id='successMessage' style="display:none;">
		<strong>메시지 전송에 성공했습니다.</strong>
	</div>
	<div class="alert alert-danger" id="dangerMessage" style="display:none;">
		<strong>이름과 내용을 모두 입력해 주세요.</strong>
	</div>
	<div class="alert alert-warning" id="warningMessage" style="display:none;">
		<strong>데이터 베이스 오류 입니다.</strong>
	</div>
	<script type="text/javascript">
	$(document).ready(function(){
	    chatListFunction('0');
		getInfiniteChat(); 
		getUnread();
		getInfiniteUnread();
	});
	</script>
</body>
</html>