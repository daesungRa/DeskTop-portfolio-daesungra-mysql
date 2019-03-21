/*
 * 작성자: 라대성
 * 작성일: 190217
 * 기능: 페이지를 구성하는 요소들를 대상으로 하는 스크립트 (top, navbar, loginForm, joinForm, header, footer, toTop)
 */

/* 페이지 내 링크 이동 함수 */
function funcMovePage (page) {
	if (page == 'main') { // 최상단 타이틀 클릭시
		location.href = '/desktop';
		
		return;
	}
	var offset = $("#" + page).offset();
    $('html, body').animate({scrollTop : offset.top}, 400);
    
    switch (page) {
    case 'indexTop':
    	$('.my-jumbo > h1').fadeOut(0);
    	$('.my-jumbo > p').fadeOut(0);
    	$('.my-jumbo > a').fadeOut(0);
    	
    	$('.my-jumbo > h1').fadeIn(1000);
    	$('.my-jumbo > p').delay('slow').fadeIn(1000);
    	$('.my-jumbo > a').delay('slow').fadeIn(1000);
    	break;
    case 'indexHeader':
    	$('.my-jumbo > h1').fadeOut(0);
    	$('.my-jumbo > p').fadeOut(0);
    	$('.my-jumbo > a').fadeOut(0);
    	
    	$('.my-jumbo > h1').fadeIn(1000);
    	$('.my-jumbo > p').delay('slow').fadeIn(1000);
    	$('.my-jumbo > a').delay('slow').fadeIn(1000);
    	
    	break;
    case 'indexContent':
    	
    	break;
    case 'indexFooter':
    	
    	break;
    }
}

/* 브라우저 사이즈 표시 함수 */
function getWindowSize () {
	var width = window.outerWidth;
	$('#windowSize').text('window size : ' + width);
}

// 모달창에 책 등록 페이지 로드
// 무조건 모달창에서 띄워지므로 component 로 취급
function getBookRegisterPart () {
	$.ajax({
		type: 'get',
		url: '/desktop/board/getBookRegisterForm',
		dataType: 'html',
		success: function (html) {
			$('#modalWindow #innerModalContent').html(html);
			$('#btnShowModal').trigger('click');
			
			funcBookRegister();
		}
	});
}
// 책 등록 페이지 로드 후 실행되는 함수
function funcBookRegister () {
	// 커버 이미지 미리보기
	var coverImg = document.getElementById('coverImg');
	coverImg.onchange = imagePreView;
	
	// 등록 요청 폼 submit
	$('#btnBookRegisterSubmit').click(function () {
		var formData = new FormData(document.getElementById('bookRegisterForm'));
		$.ajax({
			type: 'post',
			url: '/desktop/board/bookRegisterAction',
			data: formData,
			contentType: false,
			processData: false,
			dataType: 'text',
			success: function (data) {
				if (data == '1') {
					alert('책 정보 등록 요청 성공');
					
					// 모달 창 닫기
					$('#modalWindow #closeModal').trigger('click');
				} else if (data == '0') {
					alert('책 정보 등록 실패');
				} else if (data == '2') {
					alert('접속 정보가 없습니다. 로그인 후 이용하세요');
				} else {
					alert('에러 발생, 관리자에게 문의하십시오');
				}
			}
		});
	});
}

// 이미지 프리뷰 함수
function imagePreView (e) {
    var profile = document.getElementById('image');
    var url = e.srcElement;
    var file = url.files[0];
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function (e2) {
        var img = new Image();
        img.src = e2.target.result;
        profile.src = img.src;
        
        var imgName = $('#coverImg').val().substring($('#coverImg').val().lastIndexOf('\\') + 1, $('#coverImg').val().length);
        $('#imgName').text(imgName);
    }
}

// 모달창에 게시글 신고 페이지
// 무조건 모달창에서 띄워지므로 component 로 취급
function getBoardReportPart () {
	$.ajax({
		type: 'get',
		url: '/desktop/board/getBoardReportForm',
		dataType: 'html',
		success: function (html) {
			$('#modalWindow #innerModalContent').html(html);
			$('#btnShowModal').trigger('click');
			
			funcBoardReport();
		}
	});
}

// 게시글 신고 함수
function funcBoardReport () {
	var boardSerial = $('#boardTitleContent #inputBoardSerial').text();
	var boardTitle = $('#boardTitleContent #inputBoardTitle').text();
	var writer = $('#boardTitleContent #inputBoardUserId').text();
	var rUserId = $('#rightSideComponent #viewUserId').text();

	$('#boardReportForm #reportBoardTitle').val(boardTitle + ' / ' + writer);
	$('#boardReportForm #fSerial').val(boardSerial);
	$('#boardReportForm #rUserId').val(rUserId);
	
	$('#boardReportForm #btnBoardReportSubmit').click(function () {
		var result = confirm('해당 게시글을 신고하시겠습니까?');
		
		if (result){
			if ($('#boardReportForm #rContent').val() != '') {
				alert($('#boardReportForm #rContent').val());
				var params = $('#boardReportForm').serialize();
				$.ajax({
					type: 'post',
					url: '/desktop/board/boardReportAction',
					data: params,
					dataType: 'text',
					success: function (data) {
						if (data == '1') {
							alert('게시글 신고 완료');
							
							// 모달 창 닫기
							$('#modalWindow #closeModal').trigger('click');
						} else if (data == '0') {
							alert('게시글 신고 실패');
						} else if (data == '2') {
							alert('접속 정보가 없습니다. 로그인 후 이용하세요');
						} else {
							alert('에러 발생, 관리자에게 문의하십시오');
						}
					}
				})
			} else {
				alert('신고 내용을 입력하세요 (가급적 상세히 적어주세요)');
			}
		} else {
			alert('취소됨');
		}
	});
}