/*
 * 작성자: 라대성
 * 작성일: 190309
 * 기능: admin 페이지 관련 스크립트 모음
 */
$(function () {
	// top 부분의 관리자 페이지 표시
	$('#indexTop #adminComponentInTop').css({"display":"block"});
	
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
	 * board report admin
	 */
	// 게시글 신고정보 조회
	$('#boardReportListBody .my-adminList-row').click(function () {
		var brSerial = $(this).find('#boardReportSerial').text();
		
		funcShowBoardReportInfo(brSerial);
	});
	
	// 일자별 조회
	$('#boardReportListForm #dateFlag').on('change', function () {
		var nowPage = 1;
		
		funcBoardReportChangePage(nowPage);
	});
	
	// 페이지 이동
	$('#btnBoardReportChangeGrp .btnAdminBtn').click(function () {
		var nowPage = $(this).find('span').text();
		
		funcBoardReportChangePage(nowPage);
	});
	
	/*
	 * admin book register part
	 */
	// 새 책 등록요청 조회
	$('#bookRegisterListBody .my-adminList-row').click(function () {
		var bkSerial = $(this).find('#bookRegisterBookNo').text();
		
		funcShowBookRegisterInfo(bkSerial);
	});
	
	// 일자별 조회
	$('#bookRegisterListForm #dateFlag').on('change', function () {
		var nowPage = 1;
		
		funcBookRegisterChangePage(nowPage);
	});
	
	// 페이지 이동
	$('#btnBookRegisterChangeGrp .btnAdminBtn').click(function () {
		var nowPage = $(this).find('span').text();
		
		funcBookRegisterChangePage(nowPage);
	});
	
	/*
	 * new board list part
	 */
	// 새로운 게시글 정보 조회
	$('#newBoardListBody .my-adminList-row').click(function () {
		var bdSerial = $(this).find('#newBoardSerial').text();
		
		funcShowNewBoardInfo(bdSerial);
	});
	
	// 일자별 조회
	$('#newBoardListForm #dateFlag').on('change', function () {
		var nowPage = 1;
		
		funcNewBoardChangePage(nowPage);
	});
	
	// 페이지 이동
	$('#btnNewBoardChangeGrp .btnAdminBtn').click(function () {
		var nowPage = $(this).find('span').text();
		
		funcNewBoardChangePage(nowPage);
	});
	
	/*
	 * member admin
	 */
	// navbar 의 회원관리 버튼 클릭 시 member admin component 보여주기
	$('#collapsibleNavbar #showMemberAdminComponentNav').click(function () {
		$('#adminPageTitle #showMemberAdminComponent').trigger('click');
	});
	
	// show member admin component
	$('#adminArticle #showMemberAdminComponent').click(function () {
		$.ajax({
			type: 'get',
			url: '/desktop/admin/getMemberControlPart',
			dataType: 'html',
			success: function (html) {
				$('#modalWindow #innerModalContent').html(html);
				$('#btnShowModal').trigger('click');
				
				// 회원 정보 검색
				$('#memberInfoForm #btnSearchMemberInfo').click(function () {
					funcSearchMemberInfo();
				});
			}
		});
	});
})

/*
 * function board report
 */
// 게시글 신고목록 페이지 이동
function funcBoardReportChangePage (nowPage) {
	$('#boardReportListComponent #boardReportListForm #nowPage').val(nowPage); // 제출 form 에 선택된 nowPage 값 세팅
	var formData = $('#boardReportListComponent #boardReportListForm').serialize();
	$.ajax({
		type: 'post',
		url: '/desktop/admin/getBoardReportList',
		data: formData,
		dataType: 'html',
		success: function (html) {
			$('#boardReportListComponent #brlBody').html(html);
			
			// 게시글 신고목록 페이지 이동
			$('#btnBoardReportChangeGrp .btnAdminBtn').click(function () {
				var nowPage = $(this).find('span').text();
				
				funcBoardReportChangePage(nowPage);
			});
			
			// 게시글 신고 정보 조회
			$('#boardReportListBody .my-adminList-row').click(function () {
				var brSerial = $(this).find('#boardReportSerial').text();
				
				funcShowBoardReportInfo(brSerial);
			});
		}
	});
}

// 게시글 신고 정보 조회
function funcShowBoardReportInfo (brSerial) {
	$.ajax({
		type: 'get',
		url: '/desktop/admin/getBoardReportInfo/' + brSerial,
		dataType: 'html',
		success: function (html) {
			$('#modalWindow #innerModalContent').html(html);
			$('#btnShowModal').trigger('click');
			
			// 게시글 신고 완료처리
			$('#adminReportBody #boardReportComplete').click(function () {
				var result = confirm('해당 신고요청을 완료 처리 하시겠습니까?');
				
				if (result) {
					var formData = $('#adminReportBody #reportCompleteForm').serialize();
					$.ajax({
						type: 'post',
						url: '/desktop/admin/boardReportComplete',
						data: formData,
						dataType: 'text',
						success: function (text) {
							if (text == '1') {
								alert('게시글 신고 처리 완료\npage reload');
								location.reload();
							} else if (text == '0') {
								alert('게시글 신고 처리 실패');
							} else {
								alert('에러 발생, 관리자에게 문의하십시오');
							}
						}
					});
				} else {
					alert('취소됨');
				}
			});
			
			// 게시글 블럭처리
			$('#boardContentInBoardReportPage #boardBlockAction').click(function () {
				var result = confirm('신고된 게시글을 블럭처리 하시겠습니까?');
				
				if (result) {
					var formData = $('#boardContentInBoardReportPage #boardControlForm').serialize();
					$.ajax({
						type: 'post',
						url: '/desktop/admin/boardBlockAction',
						data: formData,
						dataType: 'text',
						success: function (text) {
							if (text == '1') {
								alert('게시글 블럭 처리 완료\npage reload');
								location.reload();
							} else if (text == '0') {
								alert('게시글 블럭 처리 실패');
							} else {
								alert('에러 발생, 관리자에게 문의하십시오');
							}
						}
					});
				} else {
					alert('취소됨');
				}
			});
			
			// 게시글 블럭 해제
			$('#boardContentInBoardReportPage #boardBlockFreeAction').click(function () {
				var result = confirm('블럭 해제 하시겠습니까?');
				
				if (result) {
					var formData = $('#boardContentInBoardReportPage #boardControlForm').serialize();
					$.ajax({
						type: 'post',
						url: '/desktop/admin/boardBlockFreeAction',
						data: formData,
						dataType: 'text',
						success: function (text) {
							if (text == '1') {
								alert('게시글 블럭 해제 완료\npage reload');
								location.reload();
							} else if (text == '0') {
								alert('게시글 블럭 해제 실패');
							} else {
								alert('에러 발생, 관리자에게 문의하십시오');
							}
						}
					});
				} else {
					alert('취소됨');
				}
			});
			
			// 게시글 삭제처리
			
			// 해당 게시글 뷰 페이지로 이동
			$('#boardContentInBoardReportPage #toBoardViewPageFromBoardReportPage').click(function () {
				var boardSerial = $(this).find('#boardSerialInBoardReportPage').text();
				var boardCategory = $(this).find('#boardCategoryInBoardReportPage').text();
				var requestUrl = '/desktop/board/boardViewPage/' + boardSerial + '/' + boardCategory;
				
				location.href = requestUrl;
			});
		}
	});
}

/*
 * function book register
 */
// 책 등록요청 리스트 페이지 이동
function funcBookRegisterChangePage (nowPage) {
	$('#bookRegisterListBody #bookRegisterListForm #nowPage').val(nowPage); // 제출 form 에 선택된 nowPage 값 세팅
	var formData = $('#bookRegisterListBody #bookRegisterListForm').serialize();
	$.ajax({
		type: 'post',
		url: '/desktop/admin/getBookRegisterList',
		data: formData,
		dataType: 'html',
		success: function (html) {
			$('#bookRegisterListBody #bkrBody').html(html);
			
			// 페이지 이동
			$('#btnBookRegisterChangeGrp .btnAdminBtn').click(function () {
				var nowPage = $(this).find('span').text();
				
				funcBookRegisterChangePage(nowPage);
			});
			
			// 책 등록요청 조회
			$('#bookRegisterListBody .my-adminList-row').click(function () {
				var bkSerial = $(this).find('#bookRegisterBookNo').text();
				
				funcShowBookRegisterInfo(bkSerial);
			});
		}
	});
}

// 책 등록요청 처리
function funcShowBookRegisterInfo (bkSerial) {
	$.ajax({
		type: 'get',
		url: '/desktop/admin/getBookRegisterInfo/' + bkSerial,
		dataType: 'html',
		success: function (html) {
			$('#modalWindow #innerModalContent').html(html);
			$('#btnShowModal').trigger('click');
			
			// 이미지 프리뷰
			// joinFrm.photo.onchange = imagePreView;
			var coverImg = document.getElementById('coverImg');
			coverImg.onchange = imagePreView;
			
			// 등록 거부처리
			$('#bookRegisterInfoInModal #bookRegisterProhibitAction').click(function () {
				var result = confirm('해당 책 등록요청을 거부 처리 하시겠습니까?\n관련 내용은 삭제됩니다.');
				
				if (result) {
					var formData = $('#bookRegisterInfoInModal #bookRegisterProhibitForm').serialize();
					$.ajax({
						type: 'post',
						url: '/desktop/admin/bookRegisterProhibitAction',
						data: formData,
						dataType: 'text',
						success: function (text) {
							if (text == '1') {
								alert('등록요청 거부 완료\npage reload');
								location.reload();
							} else if (text == '0') {
								alert('등록요청 거부 실패');
							} else {
								alert('에러 발생, 관리자에게 문의하십시오');
							}
						}
					});
				} else {
					alert('취소됨');
				}
			});
			
			// 등록 허가처리
			$('#bookRegisterInfoInModal #bookRegisterPermitAction').click(function () {
				var result = confirm('해당 책 등록요청을 허가하시겠습니까?\n하단의 내용대로 입력되니 상세히 확인 후 등록하세요');
				
				if (result) {
					var frm = document.getElementById('bookRegisterPermitForm');
					var formData = new FormData(frm);
					$.ajax({
						type: 'post',
						url: '/desktop/admin/bookRegisterPermitAction',
						data: formData,
						contentType: false,
						processData: false,
						dataType: 'text',
						success: function (text) {
							if (text == '1') {
								alert('등록 허가 처리 완료\npage reload');
								location.reload();
							} else if (text == '0') {
								alert('등록 허가 처리 실패');
							} else {
								alert('에러 발생, 관리자에게 문의하십시오');
							}
						}
					});
				} else {
					alert('취소됨');
				}
			});
			
			/*// 등록 허가 해제
			$('#boardContentInBoardReportPage #boardBlockFreeAction').click(function () {
				var result = confirm('블럭 해제 하시겠습니까?');
				
				if (result) {
					var formData = $('#boardContentInBoardReportPage #boardControlForm').serialize();
					$.ajax({
						type: 'post',
						url: '/desktop/admin/boardBlockFreeAction',
						data: formData,
						dataType: 'text',
						success: function (text) {
							if (text == '1') {
								alert('게시글 블럭 해제 완료\npage reload');
								location.reload();
							} else if (text == '0') {
								alert('게시글 블럭 해제 실패');
							} else {
								alert('에러 발생, 관리자에게 문의하십시오');
							}
						}
					});
				} else {
					alert('취소됨');
				}
			});
			
			// 게시글 삭제처리
			
			// 해당 게시글 뷰 페이지로 이동
			$('#boardContentInBoardReportPage #toBoardViewPageFromBoardReportPage').click(function () {
				var boardSerial = $(this).find('#boardSerialInBoardReportPage').text();
				var boardCategory = $(this).find('#boardCategoryInBoardReportPage').text();
				var requestUrl = '/desktop/board/boardViewPage/' + boardSerial + '/' + boardCategory;
				
				location.href = requestUrl;
			});*/
		}
	});
}

/*
 * function new board
 */
//게시글 신고목록 페이지 이동
function funcNewBoardChangePage (nowPage) {
	$('#newBoardListComponent #newBoardListForm #nowPage').val(nowPage); // 제출 form 에 선택된 nowPage 값 세팅
	var formData = $('#newBoardListComponent #newBoardListForm').serialize();
	$.ajax({
		type: 'post',
		url: '/desktop/admin/getNewBoardList',
		data: formData,
		dataType: 'html',
		success: function (html) {
			$('#newBoardListComponent #bdlBody').html(html);
			
			// 게시글 신고목록 페이지 이동
			$('#btnNewBoardChangeGrp .btnAdminBtn').click(function () {
				var nowPage = $(this).find('span').text();
				
				funcNewBoardChangePage(nowPage);
			});
			
			// 게시글 신고 정보 조회
			$('#newBoardListBody .my-adminList-row').click(function () {
				var bdSerial = $(this).find('#newBoardSerial').text();
				
				funcShowNewBoardInfo(bdSerial);
			});
		}
	});
}

// 새로운 게시글 정보 조회
function funcShowNewBoardInfo (bdSerial) {
	$.ajax({
		type: 'get',
		url: '/desktop/admin/getNewBoardInfo/' + bdSerial,
		dataType: 'html',
		success: function (html) {
			$('#modalWindow #innerModalContent').html(html);
			$('#btnShowModal').trigger('click');
			
			// 게시글 블럭처리
			$('#newBoardInfoInModal #newBoardBlockAction').click(function () {
				var result = confirm('해당 게시글을 블럭처리 하시겠습니까?');
				
				if (result) {
					var formData = $('#newBoardInfoInModal #newBoardBlockForm').serialize();
					$.ajax({
						type: 'post',
						url: '/desktop/admin/boardBlockAction',
						data: formData,
						dataType: 'text',
						success: function (text) {
							if (text == '1') {
								alert('게시글 블럭 처리 완료\npage reload');
								location.reload();
							} else if (text == '0') {
								alert('게시글 블럭 처리 실패');
							} else {
								alert('에러 발생, 관리자에게 문의하십시오');
							}
						}
					});
				} else {
					alert('취소됨');
				}
			});
			
			// 게시글 블럭 해제
			$('#newBoardInfoInModal #newBoardBlockFreeAction').click(function () {
				var result = confirm('블럭 해제 하시겠습니까?');
				
				if (result) {
					var formData = $('#newBoardInfoInModal #newBoardBlockForm').serialize();
					$.ajax({
						type: 'post',
						url: '/desktop/admin/boardBlockFreeAction',
						data: formData,
						dataType: 'text',
						success: function (text) {
							if (text == '1') {
								alert('게시글 블럭 해제 완료\npage reload');
								location.reload();
							} else if (text == '0') {
								alert('게시글 블럭 해제 실패');
							} else {
								alert('에러 발생, 관리자에게 문의하십시오');
							}
						}
					});
				} else {
					alert('취소됨');
				}
			});
			
			// 게시글 삭제처리
			
			/*// 해당 게시글 뷰 페이지로 이동
			$('#boardContentInBoardReportPage #toBoardViewPageFromBoardReportPage').click(function () {
				var boardSerial = $(this).find('#boardSerialInBoardReportPage').text();
				var boardCategory = $(this).find('#boardCategoryInBoardReportPage').text();
				var requestUrl = '/desktop/board/boardViewPage/' + boardSerial + '/' + boardCategory;
				
				location.href = requestUrl;
			});*/
		}
	});
}

/*
 * function member control
 */
function funcSearchMemberInfo () {
	var params = $('#memberInfoModal #memberInfoForm').serialize();
	$.ajax({
		type: 'post',
		url: '/desktop/admin/searchMemberInfo',
		data: params,
		dataType: 'html',
		success: function (html) {
			$('#adminMemberControlBody #memberSearchResult').html(html);
			
			// 회원 정보 검색
			$('#memberInfoForm #btnSearchMemberInfo').click(function () {
				funcSearchMemberInfo();
			});
			
			// 해당 유저 블럭 처리
			$('#memberInfoModal #existMemberInfo #btnMemberBlockAction').click(function () {
				var result = confirm('해당 유저를 블럭 처리 하시겠습니까?');
				
				if (result){
					var params = $('#memberInfoModal #memberBlockActionForm').serialize();
					$.ajax({
						type: 'post',
						url: '/desktop/admin/memberBlockAction',
						data: params,
						dataType: 'text',
						success: function (text) {
							if (text == '1') {
								alert('회원 블럭 처리 완료');
								location.reload();
							} else {
								alert('회원 블럭 처리 실패');
							}
						}
					});
				} else {
					alert('취소됨');
				}
			});
			
			// 해당 유저 블럭 해제
			$('#memberInfoModal #existMemberInfo #btnMemberBlockFreeAction').click(function () {
				var result = confirm('해당 유저를 블럭 처리 하시겠습니까?');
				
				if (result){
					var params = $('#memberInfoModal #memberBlockActionForm').serialize();
					$.ajax({
						type: 'post',
						url: '/desktop/admin/memberBlockFreeAction',
						data: params,
						dataType: 'text',
						success: function (text) {
							if (text == '1') {
								alert('회원 블럭 해제 완료');
								location.reload();
							} else {
								alert('회원 블럭 해제 실패');
							}
						}
					});
				} else {
					alert('취소됨');
				}
			});
		}
	});
}

// 이미지 미리보기 함수
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
    }
}