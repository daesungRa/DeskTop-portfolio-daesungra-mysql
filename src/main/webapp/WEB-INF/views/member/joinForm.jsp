<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join Page</title>
	<!-- <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css' />
	<link rel='stylesheet' href='/desktop/resources/css/main.css' />
	
	<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js'></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js'></script>
	<script src='https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js'></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src='/desktop/resources/js/main.js'></script> -->
</head>
<body>

	<!-- middle component -->
	<div class='container' id='joinFormBody' style='height: 720px;'>
		<br/>
		<div class='container' id='joinForm'>
			<div class='container' style='width: 90%; margin: 0 auto; text-align: center;'>
				<p/>
				<h3>회원가입 페이지</h3><hr/>
				<form class='form' name='joinFrm' action='/desktop/member/join' method='post' enctype='multipart/form-data'>
					<div class='form-group'>
						<div class='form-inline'>
							<input class='form-control' type='text' id='userId' name='userId' maxlength='30' placeholder='아이디 입력 (필수)' autofocus style='width: 48%; margin-right: 10px;'/>
							<input class='btn btn-primary' type='button' id='btnIdChk' name='btnIdChk' value='중복확인' style='margin-right: 10px;'></input>
							<input type='hidden' id='userIdChk' value='unChecked' readonly/>
							<div id='userIdChkResult' style='color: #0000ff; width: 40%;'></div>
						</div>
					</div>
					<div class='form-group'>
						<input class='form-control' type='password' id='userPwd01' name='userPwd' maxlength='30' placeholder='비밀번호 입력 (필수)' style='width: 60%;' />
						<input class='form-control' type='password' id='userPwd02' name='userPwdChk' maxlength='30' placeholder='비밀번호 확인 (필수)' style='width: 60%;' />
						<input type='hidden' id='userPwdChk' value='unChecked' readonly/>
						<div id='userPwdChkResult' style='color: #ff0000;'></div>
					</div>
					<div class='form-group'>
						<input class='form-control' type='text' id='userName' name='userName' placeholder='이름 입력 (필수)' />
						<input type='hidden' id='userNameChk' value='unChecked' readonly/>
						<div id='userNameChkResult' style='color: #ff0000;'></div>
					</div>
					<div class='form-group'>
						<input class='form-control' type='email' id='email' name='email' placeholder='이메일 입력 (필수)' />
						<input type='hidden' id='emailChk' value='unChecked' readonly/>
						<div id='emailChkResult' style='color: #ff0000;'></div>
					</div>
					<div class='form-group'>
						<input class='form-control' type='text' id='phone' name='phone' placeholder="연락처 입력 ('-' 포함, 필수)" />
						<input type='hidden' id='phoneChk' value='unChecked' readonly/>
						<div id='phoneChkResult' style='color: #ff0000;'></div>
					</div>
					<div class='form-group'>
						<div class='form-inline'>
							<input class='form-control' type='text' id='postal' name='postal' placeholder='우편번호' style='width: 30%; margin-right: 10px;' readonly/>
							<input class='btn btn-primary' type='button' id='btnPostal' name='btnPostal' value='주소 찾기'></input>
						</div>
							<input class='form-control' type='text' id='address' name='address' placeholder='주소 입력' readonly/>
							<input class='form-control' type='text' id='addressAdd' name='addressAdd' value='' placeholder='추가 주소 입력' />
					</div>
					<div class='form-group'>
						<input type='file' id='photo' name='photo' value='photo' multiple="multiple" required="required"/><br/>
					</div>
					<div class='form-group'>
						<input class='btn btn-primary' type='button' id='btnJoinSubmit' name='btnJoinSubmit' value='제 출' />
						<input class='btn btn-primary' type='button' id='btnJoinCancel' name='btnJoinCancel' value='초기화' />
					</div>
				</form>
			</div>
		</div>
		<div class='container' id='memberImg'>
			<img id='image' src='/desktop/resources/imgs/blank_profile01.png' width='150px' height='150px' /><br/>
			<p style='margin-top: 10px;'>이미지 미리보기</p>
		</div>
	</div>
	
</body>
</html>