/*
 * 작성자: 라대성
 * 작성일: 190303
 * 기능: boardWritePage
 */
$(function () {
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
	
	// 게시글 카테고리 바꾸기
	$('#changeCategoryInWritePage').change(function () {
		var category3 = $(this).children('option:selected').val();
		var requestUrl = '/desktop/board/boardWritePage/' + category3;
		
		location.href = requestUrl;
	});
	
	// 책 정보 검색
	var availableTags = [
	      "ActionScript",
	      "AppleScript",
	      "Asp",
	      "BASIC",
	      "C",
	      "C++",
	      "Clojure",
	      "COBOL",
	      "ColdFusion",
	      "Erlang",
	      "Fortran",
	      "Groovy",
	      "Haskell",
	      "Java",
	      "JavaScript",
	      "Lisp",
	      "Perl",
	      "PHP",
	      "Python",
	      "Ruby",
	      "Scala",
	      "Scheme"
	    ];
	$('#searchBookInBoardWrite').autocomplete({
		source: function (request, response) {
			$.ajax({
				type: 'post',
				url: '/desktop/board/searchBookInfo',
				dataType: 'json',
				data: {searchBookInfo : request.term},
				success: function (data) {
					if (data != null && data != '') {
						response($.map (data, function (item) {
							return {
								label: item.title_eng+ "(" + item.pDate + ")",
								value: item.title_eng+ "(" + item.pDate + ")",
								data: item.bookNo
							}
						}));
					} else {
						response($.map ([{"result":"검색 결과가 없습니다"}], function (item) {
							return {
								label: item.result,
								value: item.result
							}
						}));
					}
				},
				error: function (xhr, status, error) { }
			});
		},
		minLength: 2,
		matchContains: true,
		autoFocus: true,
		focus: function (event, ui) {
			event.preventDefault();
		},
		select: function (event, ui) {
			$('#boardWriteForm #bookNo').val(ui.item.data);
			$('#boardWriteForm #existingBookCheck').val('checked');
		}
	});
	// 글쓰기 폼 (summernote)
	$('#summernote').summernote({
		height: 430,
		minHeight: 430,
		maxHeight: null,
		placeholder: '내용을 입력하세요'
	});
	// 글쓰기 submit
	$('#boardWriteForm #btnBoardWriteSubmit').click(function () {
		if ($('#boardWriteForm #existingBookCheck').val() == 'unChecked') {
			alert('리뷰를 작성할 책을 검색하세요');
			$('#searchBookInfoForm #searchBookInBoardWrite').focus();
			$('#searchBookInfoForm #searchBookInBoardWrite').select();
		} else if ($('#boardWriteForm #existingBookCheck').val() == 'checked') {
			var result = confirm('글을 등록하시겠습니까?');
			if (result) {
				var categoryNum = $('#boardList #saveCategoryNum').text();
				var params = $('#boardWriteForm').serialize();
				$.ajax({
					type: 'POST',
					url: '/desktop/board/boardWriteAction',
					data: params,
					contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
					dataType: 'html',
					success: function (data) {
						location.href = '/desktop/board/boardListPage/' + categoryNum + '/1';
						if (data == '1') {
							alert('게시글 등록 완료');
						} else if (data == '0') {
							alert('게시글 등록 실패. 입력 정보를 확인하세요');
						} else {
							alert('게시글 등록 실패. 관리자에게 문의하세요');
						}
					}
				});
			}
		}
		
		// multipart 사용시
		/*var formData = new FormData($('#boardWriteForm'));
		$.ajax({
			type: 'post',
			url: '/desktop/board/boardWriteAction',
			data: formData,
			contentType: false,
			processData: false,
			success: function (data) {
				// write 완료되면 해당 view 페이지 자동응답
				
			}
		});*/
		
		/*$.post('list.bd',
		{
			category: '1'
		},
		function (data, status){
			$('#content').html(data);
		});*/
	});
	
	// 글쓰기 cancel > 같은 카테고리의 리스트 페이지로 이동
	$('#boardWriteForm #btnBoardWriteCancel').click(function () {
		var categoryNum = $('#saveCategoryNum').text();
		var requestUrl = '/desktop/board/boardListPage/' + categoryNum + '/1';
		
		location.href = requestUrl;
	});
	
	// top 부분으로 이동
	$('.my-btn-toTop').click(function () {
		funcMovePage('indexTop');
	});
	
});