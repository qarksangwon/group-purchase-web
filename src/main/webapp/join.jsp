<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				<li><a href="message.jsp">메세지함</a></li>
				<li><a href="find.jsp">대화 시작하기</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" 
					aria-haspopup="true" aria-expanded="false">접속하기<span class="caret"></span></a> 
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li class="active"><a href="join.jsp">회원가입</a></li>
						<li><a href="out.jsp">탈퇴</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top : 20px;">
				<form method="post" action="joinAction.jsp">
					<h3 style="text-align:center;">회원가입 화면</h3>
					<div class="form-group">
						<input type="text" id="input" class="form-control" placeholder="아이디" name="userID" maxlength="20">
						<span id="message" style="color : Red"></span>
						<script>
						let pos1 = false;
						input.oninput = function() {
							const btn = document.getElementById('btn');
							var value = /[^A-Za-z0-9]/g;
							var temp = document.getElementById('input').value;
							pos1 = temp.match(value);
							if(pos1){
								message.innerHTML = "최대 20자의 영문 대, 소문자와 숫자만 입력해주세요."
								if(pos1||pos2||pos3){
								btn.disabled = true;
								}
							}
							else{
								message.innerHTML ="";
								if(!(pos1||pos2||pos3)){
								btn.disabled = false;
								}
							}
						}
						</script>
					</div>
					<div class="form-group">
						<input type="password" id ="pwinput" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
						<span id="pwmessage" style="color : Red"></span>
						<script>
						let pos2=false;
						pwinput.oninput = function() {
							var value = /[^A-Za-z0-9\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g;
							var temp = document.getElementById('pwinput').value;
							pos2 = temp.match(value);
							var result2;
							if(pos2){
								pwmessage.innerHTML = "최대 20자의 영문 대, 소문자와 숫자, 공백을 제외한 키보드 특수문자만 입력해주세요."
								if(pos1||pos2||pos3){
									btn.disabled = true;
									}
							}
							else{
								pwmessage.innerHTML ="";
								if(!(pos1||pos2||pos3)){
									btn.disabled = false;
									}
								}
						}
						</script>
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호 확인" name="PasswordCheck" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" id ="nameinput" class="form-control" placeholder="이름" name="userName" maxlength="20">
					</div>
						<span id="namemessage" style="color : Red"></span>
						<script>
						let pos3=false;
						nameinput.oninput = function() {
							var value = /[^가-힣a-z|A-Z]/g;
							var temp = document.getElementById('nameinput').value;
							pos3 = temp.match(value);	
							if(pos3){
								namemessage.innerHTML = "이름은 20자 미만 영문 대,소문자와 한글만 입력 가능합니다."
								if(pos1||pos2||pos3){
									btn.disabled = true;
									}
								}
							else{
								namemessage.innerHTML ="";
								if(!(pos1||pos2||pos3)){
									btn.disabled = false;
									}
								}
						}
						</script>					
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-info active">
								<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자 
							</label>
							<label class="btn btn-info "> 
								<input type="radio" name="userGender" autocomplete="off" value="여자" >여자 
							</label>
						</div>
					</div>
					<div class="form-group">
					학교명 :
						<select name="userUC">
							<option value="인하공업전문대학">인하공업전문대학</option>
							<option value="충남대학교">충남대학교</option>
							<option value="수원대학교">수원대학교</option>
							<option value="성결대학교">성결대학교</option>
							<option value="가톨릭관동대학교">가톨릭관동대학교</option>
							<option value="신안산대학교">신안산대학교</option>
						</select>
					</div>
					<div class="form-group">
					본인확인 질문 :
						<select name="userCheck">
							<option value="졸업 고등학교">본인이 졸업한 고등학교는?</option>
							<option value="졸업 초등학교">본인이 졸업한 초등학교는?</option>
							<option value="학창시절 별명">학창시절 별명은?</option>
						</select>
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="본인확인 질문 답변" name="userCheckAnswer" maxlength="20">
					</div>
					<input type="submit" id='btn' class="btn btn-info form-control" value="회원가입">
					<script>
					
					</script>
				</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
	<script src = "http://code.jquery.com/jquery-3.1.1.min.js"> </script>
	<script src = "js/bootstrap.js"></script>

</body>
</html>