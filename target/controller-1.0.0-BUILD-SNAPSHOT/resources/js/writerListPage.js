/*
 * 작성자: 라대성
 * 작성일: 190313
 * 기능: 작가별 조회 페이지
 */
$(function () {
	// modal
	var modalWindow = document.getElementById('modalWindow');
	var modalContent = document.getElementById('modalContent');
	var innerModalContent = document.getElementById('innerModalContent');
	
	// get window size
	$(window).resize(function () {
		getWindowSize();
	});
	
	/*
	 * component
	 */
	// top 의 돋보기 아이콘 배치
	$('.searchForm .icon').css({"margin-top":"-12px"});
	// 좌측 네비게이션 바 토글
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
	 * 인기 작가, 작가 검색
	 */
	// 인기 작가 클릭시
	$('#writerListPageBody .my-popularWriter').click(function () {
		// 검색 폼에 아이디 입력 후 검색
		var search = $(this).find('#userId').text();
		$('#writerListPageBody #searchWriterForm #search').val(search);
		
		funcSearchWriterForm();
	});
	// 검색 버튼 눌렀을 때
	$('#writerListPageBody #searchWriterForm #btnSearchWriter').click(function () {
		funcSearchWriterForm();
	});
	
});

// 작가 검색 함수
function funcSearchWriterForm () {
	var search = $('#writerListPageBody #searchWriterForm #search').val();
	
	if (search != '') {
		var searchForm = $('#writerListPageBody #searchWriterForm').serialize();
		
		$.ajax({
			type: 'post',
			url: '/desktop/member/searchWriterAction',
			data: searchForm,
			dataType: 'html',
			success: function (html) {
				$('#selectedWriterBody').html(html);
				
				// 해당 파트로 이동
				funcMovePage('selectedWriterBody');
				
				// 게시글 클릭시 해당 뷰로 이동
				$('#selectedWriterBody .my-selectedWriter').click(function () {
					var boardSerial = $(this).find('.boardSerial').text();
					var boardCategory = $(this).find('.boardCategory').text();
					
					location.href = '/desktop/board/boardViewPage/' + boardSerial + '/' + boardCategory;
				});
				
				// 팔로우 하기
				$('#selectedWriterBody #followAction').click(function () {
					var userId = $(this).find('span').text();
					
					$.ajax({
						type: 'post',
						url: '/desktop/member/followAction',
						data: {userId:userId},
						dataType: 'text',
						success: function (text) {
							if (text == '1') {
								alert('팔로우 완료');
								
								$('#writerListPageBody #searchWriterForm #search').val(userId);
								funcSearchWriterForm();
							} else if (text == '0') {
								alert('팔로우 실패');
							}						
						}
					});
				});
				
				// 언팔로우
				$('#selectedWriterBody #unFollowAction').click(function () {
					var userId = $(this).find('span').text();
					
					$.ajax({
						type: 'post',
						url: '/desktop/member/unFollowAction',
						data: {userId:userId},
						dataType: 'text',
						success: function (text) {
							if (text == '1') {
								alert('언팔로우 완료');
								
								$('#writerListPageBody #searchWriterForm #search').val(userId);
								funcSearchWriterForm();
							} else if (text == '0') {
								alert('언팔로우 실패');
							}						
						}
					});
				});
			}
		});
	} else {
		alert('조회할 작가를 입력해주세요');
	}
}