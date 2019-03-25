/*
 * 작성자: 라대성
 * 작성일: 190304
 * 기능: boardViewPage
 */
$(function () {	
	// [답글 보기] 종속된 답글 객체들 저장
	var replyList = new Array();
	
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
	// top 부분으로 이동
	$('.my-btn-toTop').click(function () {
		funcMovePage('indexTop');
	});
	// 게시글 카테고리 바꾸기
	$('#changeCategoryInWritePage').change(function () {
		var category3 = $(this).children('option:selected').val();
		var requestUrl = '/desktop/board/boardListPage/' + category3 + '/1';
		
		location.href = requestUrl;
	});
	
	/*
	 * right side component
	 */
	// 추천하기 / 해제
	$('#rightSideComponent #thumbUp').click(function () {
		var boardSerial = $('#boardTitleContent #inputBoardSerial').text();
		var status = $('#rightSideComponent #status').text();
		
		if (status == '0') { // 추천하기
			$.post(
				'/desktop/board/boardThumbUp',
				{serial:boardSerial},
				function (data) {
					if (data == '1') {
						// alert('추천 완료');
						$('#rightSideComponent #iconThumbUpDown').attr('src', '/desktop/resources/imgs/sample/heart_filled01.svg');
						$('#rightSideComponent #iconThumbUpDown').attr('title', '추천해제');
						$('#rightSideComponent #status').text('1');
					} else if (data == '0') {
						alert('로그인 후 이용하십시오');
					}
				}
			);
		} else if (status == '1') { // 추천해제
			$.post(
				'/desktop/board/boardThumbUpFree',
				{serial:boardSerial},
				function (data) {
					if (data == '1') {
						// alert('추천 해제 완료');
						$('#rightSideComponent #iconThumbUpDown').attr('src', '/desktop/resources/imgs/sample/heart_empty01.svg');
						$('#rightSideComponent #iconThumbUpDown').attr('title', '추천하기');
						$('#rightSideComponent #status').text('0');
					} else if (data == '0') {
						alert('로그인 후 이용하십시오');
					}
				}
			);
		}
		
	});
	
	// 신고 페이지 로드
	$('.showReportPage').click(function (){
		getBoardReportPart();
	});
	
	// 댓글, 좋아요, 설정 부분의 tooltip
	$('#rightSideComponent #iconComment').tooltip();
	$('#rightSideComponent #iconThumbUpDown').tooltip();
	$('#rightSideComponent #iconSettings').tooltip();
	
	$('#iconThumbUpDown').click(function () {
		
	});
	
	// 댓글 부분으로 이동
	$('#rightSideComponent #iconComment').click(function () {
		funcMovePage('boardCommentContent');
	});
	
	// 댓글에 대한 답글 쓰기
	$('#listOfComment .writeCommentReply').click(function () {
		if ($(this).text() == '답글 쓰기') {
			// 현재 시리얼 구하기
			var nowSerial = $(this).parent().children('.serialWithWriteCommentReply').text();
			//alert('nowSerial : ' + nowSerial);
			$(this).text('닫기');
			
			$('#listOfComment #commentReplyForm' + nowSerial).css({"display":"block"});
		} else if ($(this).text() == '닫기') {
			// 현재 시리얼 구하기
			var nowSerial = $(this).parent().children('.serialWithWriteCommentReply').text();
			//alert('nowSerial : ' + nowSerial);
			$(this).text('답글 쓰기');
			
			$('#listOfComment #commentReplyForm' + nowSerial).css({"display":"none"});
		}
	});
	
	// 댓글에 대한 답글 보기
	$('#listOfComment .showCommentReply').click(function () {
		var nextSerial = $(this).parent().children('.serialWithShowCommentReply').text();
		
		if ($(this).text().substring(0, 5) == '답글 보기') {
			$(this).text('닫기');

			// 다음번 시리얼 태그 객체정보를 배열에 저장 후 보여주기
			replyList.push($('#commentContainer' + nextSerial + 'reply'));
			$('#commentContainer' + nextSerial + 'reply').css({"display":"block"});
			
			// 다음 답글 버튼이 있는지 확인 후 보여주기
			if ($('#commentContainer' + nextSerial + 'reply').find('.showCommentReply') != null) {
				$('#commentContainer' + nextSerial + 'reply').find('.showCommentReply').trigger('click');
			}
		} else if ($(this).text().substring(0, 2) == '닫기') {
			$(this).text('답글 보기');

			for (var i = 0; i < replyList.length; i++) {
				replyList[i].css({"display":"none"});
				var btn = replyList[i].find('.showCommentReply');
				if (btn != null) {
					btn.text('답글 보기');
				}
			}
			replyList = new Array();
		}
	});
	
	// 댓글 로그인
	$('#btnLoginInComment').click(function () {
		$.ajax({
			type: 'get',
			url: '/desktop/member/loginForm',
			dataType: 'html',
			success: function (html, status) {
				$('#innerModalContent').html(html);
				$('#btnShowModal').trigger('click');
				
				funcLoginAction();
			}
		});
	});
	
	// 댓글 제출
	$('#btnSubmitCommentMain').click(function () {
		var categoryNum = $('#boardViewContainer #saveCategoryNum').text();
		if ($('#commentForm #content').val() == "") {
			alert('댓글 내용을 입력하세요');
		} else {
			var params = $('#commentForm').serialize();
			$.ajax({
				type: 'POST',
				url: '/desktop/board/commentWriteAction',
				data: params,
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
				dataType: 'html',
				success: function (data) {
					var boardSerial = data; // 게시글의 시리얼이 반환됨
					
					if (boardSerial != "") {
						location.reload();
						// location.href = '/desktop/board/boardViewPage/' + boardSerial + "/" + categoryNum; // view 페이지 요청
						// alert('요청 serial, category : ' + boardSerial + ", " + categoryNum);
					} else {
						alert('댓글 작성 실패');
					}
				}
			});
		}
	});
	
	// 댓글의 답글 제출
	$('.btnSubmitCommentSub').click(function () {
		var form = $(this).closest('form');
		if ($(this).closest('form').find('textarea').val() == "") {
			alert('답글 내용을 입력하세요')
		} else {
			var params = form.serialize();
			$.ajax({
				type: 'post',
				url: '/desktop/board/commentWriteAction',
				data: params,
				dataType: 'html',
				success: function (data) {
					var boardSerial = data; // 게시글의 시리얼이 반환됨
					
					if (boardSerial != "") {
						location.reload();
					} else {
						alert('댓글 작성 실패');
					}
				}
			});
		}
	});
	
	// 댓글 삭제
	$('#boardCommentContent .my-toCommentDeleteAction').click(function () {
		var delCommit = confirm('댓글을 삭제하시겠습니까?');
		var delSerial = $(this).find('span').text();
		if (delCommit) {
			alert('삭제 실행 : ' + delSerial);
			$.ajax({
				type: 'post',
				url: '/desktop/board/commentDeleteAction',
				data: {serial: delSerial},
				dataType: 'html',
				success: function (data) {
					if (data == '1') {
						location.reload();
					} else if (data == '0') {
						alert('댓글 삭제 실패');
					} else {
						alert('error!');
					}
				}
			});
		}
	});
	
	/*
	 * modify 페이지로 변경
	 */
	$('#toBoardModifyPage').click(function () {
		$('#categoryContent #titleName').text('글수정');
		$('#boardTitleContent').css({"display":"none"});
		$('#boardTextContent').css({"display":"none"});
		$('#boardModifyPage').css({"display":"block"});
		$('#boardCommentContent').css({"display":"none"});
		
		$('#summernote').summernote({
			minHeight: 300,
			maxHeight: 1000
		});
		
		$('.my-btn-toTop').trigger('click');
	});
	// modify submit
	$('#btnBoardModifySubmit').click(function () {
		var result = confirm('게시글을 수정하시겠습니까?');
		if (result) {
			$('#boardModifyAction').submit();
		}
	});
	// modify cancel
	$('#btnBoardModifyCancel').click(function () {
		location.reload();
	});
	
	/*
	 * 게시글 삭제
	 */
	$('#toBoardDeleteAction').click(function () {
		var serial = $('#boardModifyAction #serial').val();
		var result = confirm('해당 게시글을 삭제하시겠습니까?');
		if (result) {
			$.ajax({
				type: 'get',
				url: '/desktop/board/boardRemoveAction',
				dataType: 'html',
				data: {serial: serial},
				success: function (data) {
					if (data == '1') {
						var categoryNum = $('#boardViewContainer #saveCategoryNum').text();
						location.href = '/desktop/board/boardListPage/' + categoryNum + '/1';
					} else if (data == '0') {
						alert('게시글 삭제에 실패했습니다');
					}
				}
			});
		}
	});
});