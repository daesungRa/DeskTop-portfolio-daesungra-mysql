/*
 * 작성자: 라대성
 * 작성일: 190209
 * 기능: index 페이지, member 정보와 관련된 모든 스크립트 모음
 */

$(function () {
	// modal
	var modalWindow = document.getElementById('modalWindow');
	var modalContent = document.getElementById('modalContent');
	var innerModalContent = document.getElementById('innerModalContent');
	
	
    // navbar
    var memberProfileAnc = document.getElementById('memberProfileAnc');
	var memberInfoAnc = document.getElementById('memberInfoAnc');
	var guestbookAnc = document.getElementById('guestbookAnc');
	var categoryAnc = document.getElementById('categoryAnc');
	var todayAnc = document.getElementById('todayAnc');
	var logoutAnc = document.getElementById('logoutAnc');
	var loginAnc = document.getElementById('loginAnc');
	var joinAnc = document.getElementById('joinAnc');
	
	/*
	 * index page
	 */
		// get window size
	$(window).resize(function () {
		getWindowSize();
	});
		// fade in
	$('.my-jumbo > h1').fadeOut(0);
	$('.my-jumbo > p').fadeOut(0);
	$('.my-jumbo > a').fadeOut(0);
	
	$('.my-jumbo > h1').fadeIn(1000);
	$('.my-jumbo > p').delay('slow').fadeIn(1000);
	$('.my-jumbo > a').delay('slow').fadeIn(1000);
		// modal action
	$(window).click(function (ev) { // 모달 외 화면 클릭 시
		if (ev.target == modalWindow) {
			$('#btnShowModal').trigger('click');
		}
	});
	$(window).keydown(function (ev) { // esc 버튼 입력 시
		if (ev.keyCode == '27') {
			$('#btnShowModal').trigger('click');
		}
	});
	$('#closeModal').click(function () {
		$('#btnShowModal').trigger('click');
	});
	
	/*
	 * navBar
	 */	
		// 모달에 로그인 폼 로드
		// 이후 funcLoginAction 함수 실행
	$('#loginAnc').click(function () {
		$.ajax({
			type: 'get',
			url: '/desktop/member/loginForm',
			dataType: 'html',
			success: function (html, status) {
				innerModalContent.innerHTML = html;
				$('#btnShowModal').trigger('click');
				
				funcLoginAction();
			}
		});
	});
	$('.my-guide-part .loginAnc').click(function () {
		alert();
		$.ajax({
			type: 'get',
			url: '/desktop/member/loginForm',
			dataType: 'html',
			success: function (html, status) {
				innerModalContent.innerHTML = html;
				
				funcLoginAction();
			}
		});
	});
		// 조인 모달 창 불러오기
		// 이후 funcJoinAction 함수 실행
	$('#joinAnc').click(function () {
		$.ajax({
			type: 'get',
			url: '/desktop/member/joinForm',
			dataType: 'html',
			success: function (html, status) {				
				innerModalContent.innerHTML = html;
				$('#btnShowModal').trigger('click');
				
				funcJoinAction();
			}
		})
	});
	$('.my-guide-part .joinAnc').click(function () {
		$.ajax({
			type: 'get',
			url: '/desktop/member/joinForm',
			dataType: 'html',
			success: function (html, status) {
				innerModalContent.innerHTML = html;
				
				funcJoinAction();
			}
		});
	});
		// 로그아웃
	$('#logoutAnc').click(function(){
		location.href ='/desktop/member/logout';
		$.ajax({
			
		});
	});
	
	// 회원정보 조회
	$('#loadMemberInfo').click(function(){
		$.ajax({
			type: 'get',
			url: '/desktop/member/memberInfoForm',
			dataType: 'html',
			success: function (html, status) {
				modalContent.setAttribute('style', 'height: 82%; margin: 7% auto;');
				innerModalContent.setAttribute('style', 'position: absolute; width: 97%; height: 94%; top: 0;');
				
				innerModalContent.innerHTML = html;
				alert('조회 결과 플래그: ' + $('#flag').text());
				
				// 에러코드 0 이면 세션아이디 없음, 에러코드 1 이면 조회된 결과 없음
				if ($('#flag').text() == "0") { // 세션아이디 없음
					alert('접속 정보가 존재하지 않습니다. 로그인 후 이용하세요.');
					innerModalContent.innerHTML = "";
					$.ajax({
						type: 'get',
						url: '/desktop/member/loginForm',
						dataType: 'html',
						success: function (html, status) {
							modalContent.setAttribute('style', 'height: 60%; margin: 12% auto;');
							innerModalContent.setAttribute('style', 'position: absolute; width: 96%; height: 90%; top: -10px;');
							
							innerModalContent.innerHTML = html;
							$('#btnShowModal').trigger('click');
							
							funcLoginAction();
						}
					});
				} else if ($('#flag').text() == "1") { // 조회결과 없음 (vo == null)
					alert('현재 접속정보로 조회된 회원정보가 존재하지 않습니다. 확인 후 이용해주세요.');
					innerModalContent.innerHTML = "";
					location.href = '/desktop';
				} else if ($('#flag').text() == "2"){
					$('#btnShowModal').trigger('click');
					
					funcMemberInfo();
				} else {
					alert('예상치 못한 에러 발생. 관리자에게 문의하십시오.');
					innerModalContent.innerHTML = "";
					location.href = '/desktop';
				}
			}
		});
	});
	
	// navbar 의 회원관리 버튼 클릭 시 member admin component 보여주기
	$('#collapsibleNavbar #showMemberAdminComponentNav').click(function () {
		location.href = '/desktop/admin/getAdminPage/1';
		$('#adminArticle #showMemberAdminComponent').trigger('click');
	});
	
	// 웹사이트 소개 부분
	$('#header #header-title #site-introduce').click(function () {
		$('body .my-btn-guide').trigger('click');
	});
	// 각 파트로 이동
	$('#header #header-title #dev-introduce').click(function () {
		funcMovePage('devPart');
	});
	$('#introducePart #introPart-left').click(function () {
		funcMovePage('bookSharePart');
	});
	$('#introducePart #introPart-center').click(function () {
		funcMovePage('communicationPart');
	});
	$('#introducePart #introPart-right').click(function () {
		funcMovePage('encryptionPart');
	});
	$('#introducePart #introPart-end').click(function () {
		funcMovePage('authorityPart');
	});
	
	// guide button
	$('body .my-btn-guide').click(function () {
		$.ajax({
			type: 'get',
			url: '/desktop/getGuidePage',
			dataType: 'html',
			success: function (html) {				
				innerModalContent.innerHTML = html;
				$('#modalWindow #closeModal').css({"display":"none"});
				$('#btnShowModal').trigger('click');
				
				funcRunningGuid();
			}
		});
	});
	// (쿠키) 오늘하루 그만보기
	if (getCookie('notToday') != 'Y') {
		$('body .my-btn-guide').trigger('click');
	}
	
	// 샘플 코드 보기
	$('#article #showSampleSecurityCode').click(function () {
		$.ajax({
			type: 'get',
			url: '/desktop/getSampleCode',
			dataType: 'html',
			success: function (html) {				
				innerModalContent.innerHTML = html;
				$('#modalWindow #closeModal').css({"display":"none"});
				$('#btnShowModal').trigger('click');
				
				$('.my-guide-part #btnCloseSampleCode').click(function () {
					$('#btnShowModal').trigger('click');
				});
			}
		});
	});
	
	// 깃헙 소스로 이동
	$('.my-index-article-dev .githubAnc').click(function () {
		window.open('https://github.com/daesungRa/DeskTop-portfolio-daesungra-mysql', '_blank');
	});
});

function funcRunningGuid () {
	// 시작하기 버튼을 클릭하면 모달창 꺼짐
	$('.my-guide-part #btnGuideStart').click(function () {
		$('#btnShowModal').trigger('click');
	});
	
	// 모달에 로그인 폼 로드
	// 이후 funcLoginAction 함수 실행
	$('.my-guide-part .loginAnc').click(function () {
		$.ajax({
			type: 'get',
			url: '/desktop/member/loginForm',
			dataType: 'html',
			success: function (html, status) {
				innerModalContent.innerHTML = html;
				
				funcLoginAction();
			}
		});
	});
		// 조인 모달 창 불러오기
		// 이후 funcJoinAction 함수 실행
	$('.my-guide-part .joinAnc').click(function () {
		$.ajax({
			type: 'get',
			url: '/desktop/member/joinForm',
			dataType: 'html',
			success: function (html, status) {
				innerModalContent.innerHTML = html;
				
				funcJoinAction();
			}
		});
	});
}

// 오늘하루 그만보기
function closePopupNotToday(){	             
	setCookie('notToday','Y', 1);
	$('#btnShowModal').trigger('click');
}
function setCookie(name, value, expiredays) {
	var today = new Date();
	today.setDate(today.getDate() + expiredays);

	document.cookie = name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';'
}
function getCookie(name) { 
    var cName = name + "="; 
    var x = 0; 
    while ( x <= document.cookie.length ) 
    { 
        var y = (x+cName.length); 
        if ( document.cookie.substring( x, y ) == cName ) 
        { 
            if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
                endOfCookie = document.cookie.length;
            return unescape( document.cookie.substring( y, endOfCookie ) ); 
        } 
        x = document.cookie.indexOf( " ", x ) + 1; 
        if ( x == 0 ) 
            break; 
    } 
    return ""; 
}

/*
 * memberInfo.jsp (프로필 관리 페이지 혹은 회원정보 조회 페이지로 분기, 전자가 디폴트)
 * 각 분기는 ajax 로 비동기 로드
 * 각 분기에 따라 navbar 스크립트를 다르게 해야 한다 (해당 항목에 하이라이트 속성 추가)
 */
