/*
 * 작성자: 라대성
 * 작성일: 190314
 * 기능: mypage 관련 스크립트
 */
$(function () {
	// 모달 창 컨트롤
	$(window).click(function (ev) {
		if (ev.target == modalWindow) {
			$('#btnShowModal').trigger('click');
		}
	});
	$(window).keydown(function (ev) {
		if (ev.keyCode == '27') {
			$('#btnShowModal').trigger('click');
		}
	});
	$('#modalWindow #closeModal').click(function () {
		$('#btnShowModal').trigger('click');
	});
	
	/*
	 * navbar aside
	 */   			
	$('#btnShowNavbar').click(function () {
		$('#navbarAside').animate({width:'toggle'}, 350);
		if ($('#btnShowNavbar').text() == '<<') {
			$('#btnShowNavbar').text('>>');
			$('#btnShowNavbar').animate({left:'-=17%'}, 350);
			$('#boardContent').animate({margin: '0 0 0 0'}, 350);
			/*$('#navbarAside').css({"display":"none"});*/
		} else if ($('#btnShowNavbar').text() == '>>') {
			$('#btnShowNavbar').text('<<');
			$('#btnShowNavbar').animate({left: '+=17%'}, 350);
			$('#boardContent').animate({margin: '0 0 0 17%'}, 350);
			/*$('#navbarAside').css({"display":"block"});*/
		}
	});
	 
	/*
	 * 프로필, 회원정보
	 */
	$('#navtab-profile-tag').click(function () {
		$('#navtab-info-tag-li').css({'border':'none'});
		$('#navtab-profile-tag-li').css({'border':'1px solid #bbb', 'border-bottom':'none'});
		
		$.ajax({
			type: 'get',
			url: '/desktop/member/memberProfileForm',
			dataType: 'html',
			success: function (html, status) {
				
				$('#memberProfileContent').html(html);
				$('.my-myPage-memberinfo #profileImagePreview').attr('src', $('#profileForm #photoPath').val());
				$('.my-myPage-memberinfo #inputFNum').text($('#profileForm #fNum').val() + ' 명');
				$('.my-myPage-memberinfo #inputMDate').text($('#profileForm #mDate').val());
				
				// 에러코드 0 이면 세션아이디 없음, 에러코드 1 이면 조회된 결과 없음
				if ($('#flag').text() == "0") { // 세션아이디 없음
					alert('접속 정보가 존재하지 않습니다. 로그인 후 이용하세요.');
					/* $.ajax({
						type: 'get',
						url: '/desktop/member/loginForm',
						dataType: 'html',
						success: function (html, status) {
							
							innerModalContent.innerHTML = html;
							modalWindow.style.display = 'block';
							
							funcLoginAction();
						}
					}); */
					location.href = '/desktop';
				} else if ($('#flag').text() == "1") { // 조회결과 없음 (vo == null)
					alert('현재 접속정보로 조회된 회원정보가 존재하지 않습니다. 확인 후 이용해주세요.');
					location.href = '/desktop';
				} else if ($('#flag').text() == "2"){
					funcMemberInfo();
				} else {
					alert('예상치 못한 에러 발생. 관리자에게 문의하십시오.');
					location.href = '/desktop';
				}
			}
		});
	});
	
	$('#navtab-info-tag').click(function () {
		$('#navtab-profile-tag-li').css({'border':'none'});
		$('#navtab-info-tag-li').css({'border':'1px solid #bbb', 'border-bottom':'none'});
		
		$.ajax({
			type: 'get',
			url: '/desktop/member/memberInfoForm',
			dataType: 'html',
			success: function (html, status) {
				
				$('#memberInfoContent').html(html);
				$('#memberImg').css({'display':'none'});
				$('.my-myPage-memberinfo #profileImagePreview').attr('src', $('#memberImg #image').attr('src'));
				$('.my-myPage-memberinfo #inputFNum').text($('#joinFrm #fNum').val() + ' 명');
				$('.my-myPage-memberinfo #inputMDate').text($('#joinFrm #mDate').val());
				
				// 에러코드 0 이면 세션아이디 없음, 에러코드 1 이면 조회된 결과 없음
				if ($('#flag').text() == "0") { // 세션아이디 없음
					alert('접속 정보가 존재하지 않습니다. 로그인 후 이용하세요.');
					/* $.ajax({
						type: 'get',
						url: '/desktop/member/loginForm',
						dataType: 'html',
						success: function (html, status) {
							
							innerModalContent.innerHTML = html;
							modalWindow.style.display = 'block';
							
							funcLoginAction();
						}
					}); */
					location.href = '/desktop';
				} else if ($('#flag').text() == "1") { // 조회결과 없음 (vo == null)
					alert('현재 접속정보로 조회된 회원정보가 존재하지 않습니다. 확인 후 이용해주세요.');
					location.href = '/desktop';
				} else if ($('#flag').text() == "2"){
					funcMemberInfo();
				} else {
					alert('예상치 못한 에러 발생. 관리자에게 문의하십시오.');
					location.href = '/desktop';
				}
			}
		});
	});
	
	// 최초 로드 시 프로필 부분 실행
	$('#navtab-profile-tag').trigger('click');
	
	// followee 리스트 보기
	$('#myPageLeftComponent #inputFollowee').click(function () {
		$.ajax({
			type: 'get',
			url: '/desktop/member/getFolloweeList',
			dataType: 'html',
			success: function (html) {
				// 결과 페이지를 모달에 띄우기
				$('#modalWindow #innerModalContent').html(html);
				$('#btnShowModal').trigger('click');
				
				$('#followeeListBody .my-followee').click(function () {
					var userId = $(this).find('.userId').text();
					
					location.href = '/desktop/member/getWriterListPage';
					$('#writerListPageBody #searchWriterForm #search').val(userId);
					funcSearchWriterForm();
				});
			}
		});
	});
	
	// 선택한 게시글로 이동
	$('#newBoardListBody .my-adminList-row').click(function () {
		var serial = $(this).find('#myBoardSerial').text();
		var category = $(this).find('#myBoardCategory').text();
		var requestUrl = '/desktop/board/boardViewPage/' + serial + '/' + category;
		
		location.href = requestUrl;
	});
});