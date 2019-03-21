/*
 * 작성자: 라대성
 * 작성일: 190218
 * 기능: boardListPage
 */
function funcBoardListPage () {
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
	// 게시글 쓰기 페이지로 이동
	$('.toBoardWritePage').click(function () {
		var categoryNum = $('#saveCategoryNum').text();
		var requestUrl = '/desktop/board/boardWritePage/' + categoryNum;
		
		location.href = requestUrl;
	});
	
	// 게시글 카테고리 바꾸기
	$('#changeCategoryInBoardPage').change(function () {
		// var category1 = $('#changeCategoryInBoardPage option:selected').val();
		// var category2 = $(this).val();
		// var category4 = $(this).children('option:selected').text();
		
		var category3 = $(this).children('option:selected').val();
		var requestUrl = '/desktop/board/boardListPage/' + category3 + '/1';
		
		location.href = requestUrl;
	});
	// 게시판 리스트 부분으로 이동
	$('#toBoardList').click(function () {
		funcMovePage('boardListViewDate');
	});
	// top 부분으로 이동
	$('.my-btn-toTop').click(function () {
		funcMovePage('indexTop');
	});
	// 책 등록하기
	$('.my-btn-register').click(function () {
		getBookRegisterPart();
	});
	// 책 등록 action
	
	
	/*
	 * preview
	 */
	// 더보기
	$('#boardPreViewHit #more1').click(function () {
		$('#boardPreViewHit #more1Container').css({"display":"none"});
		$('#boardPreViewHit #thebogi1').css({"display":"block"});
	});
	$('#boardPreViewHit #more2').click(function () {
		$('#boardPreViewHit #more2Container').css({"display":"none"});
		$('#boardPreViewHit #thebogi2').css({"display":"block"});
	});
	$('#boardPreViewHit #more3').click(function () {
		$('#boardPreViewHit #more3Container').css({"display":"none"});
		$('#boardPreViewHit #thebogi3').css({"display":"block"});
	});
	$('#boardPreViewHit #more4').click(function () {
		$('#boardPreViewHit #more4Container').css({"display":"none"});
		$('#boardPreViewHit #thebogi4').css({"display":"block"});
	});
	// 글 상세보기 페이지로 이동
	$('.boardViewAncMini').tooltip();
	
	/*
	 * board list
	 */
	// 게시글 리스트 미리보기
	$('.my-board-grid-title').tooltip();
	$('.my-board-grid-bookTitle').tooltip();
	
	// 게시글 뷰 페이지로 이동
	$('.boardTitlePreview').click(function () {
		var serial = $(this).find('span').text();
		var categoryNum = $('#boardList #saveCategoryNum').text();
		var requestUrl = '/desktop/board/boardViewPage/' + serial + '/' + categoryNum;
		
		location.href = requestUrl;
	});
	$('.boardViewAncMini').click(function () {
		var serial = $(this).find('span').text();
		var categoryNum = $('#boardList #saveCategoryNum').text();
		var requestUrl = '/desktop/board/boardViewPage/' + serial + '/' + categoryNum;
		
		location.href = requestUrl;
	});
	$('.my-board-grid-title').click(function () {
		var serial = $(this).find('span').text();
		var categoryNum = $('#boardList #saveCategoryNum').text();
		var requestUrl = '/desktop/board/boardViewPage/' + serial + '/' + categoryNum;
		
		location.href = requestUrl;
	});

	// 검색
	$('#btnBoardChangeGrp .btnBoardView').click(function () {
		// 하단 검색 폼에 nowPage 입력 후 함수 실행
		$('#boardListSearchForm #nowPage').val($(this).find('span').text());
		movePage();
	});
	$('#boardListSearchForm #btnBoardListSearch').click(function () {
		alert('clicked btnBoardListSearch');
		movePage();
	});
}

// 페이지 이동 함수
function movePage () {
	var params = $('#boardListSearchForm').serialize();
	$.ajax({
		type: 'post',
		url: '/desktop/board/boardListSearch',
		data: params,
		contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
		dataType: 'html',
		success: function (data) {
			$('#boardListViewDate').html(data);
			var searchBySort = $('#boardSearchContainer #searchBySortHidden').text();
			var searchByContent = $('#boardSearchContainer #searchByContentHidden').text();
			$('#boardSearchContainer #boardListSearchForm #searchBySort option[value=' + searchBySort + ']').attr('selected', 'selected');
			$('#boardSearchContainer #boardListSearchForm #searchByContent option[value=' + searchByContent + ']').attr('selected', 'selected');
			
			$('#btnBoardChangeGrp .btnBoardView').click(function () {
				// 하단 검색 폼에 nowPage 입력 후 함수 실행
				$('#boardListSearchForm #nowPage').val($(this).find('span').text());
				movePage();
			});
			$('#boardListSearchForm #btnBoardListSearch').click(function () {
				alert('clicked btnBoardListSearch');
				movePage();
			});
			
			$('.my-board-grid-title').click(function () {
				var serial = $(this).find('span').text();
				var categoryNum = $('#boardList #saveCategoryNum').text();
				var requestUrl = '/desktop/board/boardViewPage/' + serial + '/' + categoryNum;
				
				location.href = requestUrl;
			});
		}
	});
}