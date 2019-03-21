<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>find id part</title>
</head>
<body>

	<div class="container my-find-part">
	    <div class="row" style='width: 90%; margin: 100px auto;'>
	    	<div class='col-sm-2'></div>
	        <div class="col-md-8" id='findIdBody'>
	            <div class="account-wall">
	                <label for='findIdForm'>아이디 찾기</label><hr/><br/>
	                <p class='findDesc' id='findIdDesc'>가입 시 입력한 이름과 이메일로 인증 후<br/>해당 메일로 아이디를 발송합니다</p>
	                <form class="form" id='findIdForm' name='findIdForm' method='post' action ='#findId'>
		                <input type="text" class="form-control" id='userName' name ='userName' placeholder="이름" value='' required autofocus autocomplete='off'>
		                <input type="text" class="form-control" id='receiver' name ='receiver' placeholder="이메일" value='' required autofocus autocomplete='off'>
		                <input type ='hidden' name='sender' value='chaeksang2018@gmail.com'>
		                <input type= 'hidden' name ='subject' value ='[세상의 모든 책 리뷰, 책상 입니다] 아이디 조회 결과'><br/>
		                <input type="button" class="btn btn-md btn-info btn-block" id='btnFindId' value='아이디 찾기'>
	                </form>
	                <span id='toLoginPart'>뒤로가기</span>
	            </div>
	        </div>
	        <div class='col-sm-2'></div>
	    </div>
	</div>

</body>
</html>