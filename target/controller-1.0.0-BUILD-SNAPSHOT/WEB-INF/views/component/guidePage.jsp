<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>guide this website</title>
</head>
<body>

	<div class="container my-guide-part">
	    <div class="row" style='margin: 40px auto;'>
	    	<div class='col-sm-1'></div>
	        <div class="col-md-10" id='findIdBody'>
	            <div class="account-wall">
	            	<div class='container' style='text-align: center;'>
	                	<span id='guideTitle'>웹사이트 이용방법</span><hr style=''/><br/>
	                </div>
	                <p class='guideDesc'>이 웹사이트는 신입 개발자 라대성의 포트폴리오입니다<br/>다음 안내에 따라 테스트해 보십시오</p><br/>
	                <div class='row' id='guideNav' style='border-top: 1px solid #cecece; padding-top: 20px;'>
	                	<div class='col-md-3'>
	                		ID
	                	</div>
	                	<div class='col-md-2'>
	                		PWD
	                	</div>
	                	<div class='col-md-7'>
	                		권한목록
	                	</div>
	                </div>
	                <div class='row'>
	                	<div class='col-md-3'>
	                		admin
	                	</div>
	                	<div class='col-md-2'>
	                		1111
	                	</div>
	                	<div class='col-md-7'>
	                		신고, 책 등록요청, 새 게시물, 회원 관리
	                	</div>
	                </div>
	                <div class='row'>
	                	<div class='col-md-3'>
	                		daesungra
	                	</div>
	                	<div class='col-md-2'>
	                		1111
	                	</div>
	                	<div class='col-md-7'>
	                		신고, 책 등록요청, 새 게시물 관리
	                	</div>
	                </div>
	                <div class='row'>
	                	<div class='col-md-3'>
	                		kim
	                	</div>
	                	<div class='col-md-2'>
	                		1111
	                	</div>
	                	<div class='col-md-7'>
	                		책 등록요청, 게시글, 댓글 등 활동
	                	</div>
	                </div>
	                <div class='row' style='border-bottom: 1px solid #cecece; padding-bottom: 20px;'>
	                	<div class='col-md-3'>
	                		hong
	                	</div>
	                	<div class='col-md-2'>
	                		1111
	                	</div>
	                	<div class='col-md-7'>
	                		책 등록요청, 게시글, 댓글 등 활동
	                	</div>
	                </div><br/><br/>
	                <p class='guideDesc'>admin 과 daesungra 계정은 <span class='loginAnc' data-toggle='tooltip' data-placement='right' title='로그인 페이지로 이동합니다.'>관리자</span>이며<br/><span class='loginAnc' data-toggle='tooltip' data-placement='right' title='로그인 페이지로 이동합니다.'>수퍼 관리자</span>인 admin 은 추가적으로 회원 관리를 수행합니다.</p>
	                <p class='guideDesc'>kim 과 hong 은 <span class='loginAnc' data-toggle='tooltip' data-placement='right' title='로그인 페이지로 이동합니다.'>일반 사용자</span>로 책 등록요청,<br/>게시글 쓰기, 댓글 쓰기, 게시글 추천, 팔로우 등이 가능합니다.</p>
	                <p class='guideDesc'>추가적인 <span class='joinAnc' data-toggle='tooltip' data-placement='right' title='회원가입 페이지로 이동합니다.'>회원가입</span>으로 새로운 계정에서 테스트할 수 있습니다.</p>
	                <br/><br/>
	                <form class="form" id='findIdForm' name='findIdForm' method='post' action ='#findId'>
		                <!-- <input type="text" class="form-control" id='userName' name ='userName' placeholder="이름" value='' required autofocus autocomplete='off'>
		                <input type="text" class="form-control" id='receiver' name ='receiver' placeholder="이메일" value='' required autofocus autocomplete='off'>
		                <input type ='hidden' name='sender' value='chaeksang2018@gmail.com'>
		                <input type= 'hidden' name ='subject' value ='[세상의 모든 책 리뷰, 책상 입니다] 아이디 조회 결과'><br/> -->
		                <input type="button" class="btn btn-md btn-info btn-block" id='btnGuideStart' value='시작하기'>
	                </form>
	                <a href="javascript:closePopupNotToday()" class="white" id='toLoginPart'>오늘하루 그만보기</a>
	            </div>
	        </div>
	        <div class='col-sm-1'></div>
	    </div>
	</div>

</body>
</html>