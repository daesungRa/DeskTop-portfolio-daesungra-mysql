<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login Page</title>
</head>
<body>
	
	<!-- middle component -->
	<div class='container' id='loginForm'>
		<div class='container' id='innerLoginForm'>
			<p/>
			<h3>로그인</h3><hr/>
			<form class='form-group' name='loginFrm' id='loginFrm' action='#loginAction' method='post'>
				<input class='form-control' type='text' name='userId' id='userId' placeholder='아이디 입력' required autofocus /><br/>
				<input class='form-control' type='password' name='userPwd' id='userPwd' placeholder='비밀번호 입력' required autofocus /><br/>
				<input type="button" class="btn btn-md btn-info btn-block" id='btnLoginSubmit' value='제 출' style='width: 65%; margin: 10px auto;' />
			</form>
			<a id='finduserIdAnc' href='#findId'>아이디 찾기</a>&nbsp;&nbsp;
			<a id='finduserPwdAnc' href='#findPwd'>비밀번호 찾기</a>&nbsp;&nbsp;
			<a id='logintojoinAnc' href='#join'>회원가입</a>
			<p/>
		</div><br/><br/><br/>
	</div>

</body>
</html>