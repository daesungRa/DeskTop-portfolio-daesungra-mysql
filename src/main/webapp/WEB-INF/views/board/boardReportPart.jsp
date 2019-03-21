<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board report part</title>
</head>
<body>

	<div class='container'>
		<div class='container'>
			<p>게시글 신고 페이지</p>
		</div>
		<div class='row' style='margin: 40px 100px 40px 40px;'>
			<div class='col-sm-12'>
				<form class='form' id='boardReportForm' name='boardReportForm' method='post' action ='#boardReportAction'>
					<div class='form-group'>
						<label for='reportType'>신고 분류</label>
						<select class='form-control' id='reportType' name='reportType' >
							<option value='1' selected>(통합) 부적절한 게시글</option>
							<option value='2'>광고</option>
							<option value='3'>욕설</option>
							<option value='4'>음란물</option>
							<option value='5'>저작권 침해</option>
						</select>
					</div>
					<div class='form-group'>
						<label for='reportBoardTitle'>신고 게시글 (제목 / 작성자)</label>
						<input class='form-control' type='text' id='reportBoardTitle' name='reportBoardTitle' value='' placeholder='신고 게시글 정보' readonly="readonly" />
					</div>
					<div class='form-group' style='display: none;'>
						<label for='fSerial'>신고 게시글 번호</label>
						<input class='form-control' type='text' id='fSerial' name='fSerial' value='' placeholder='신고 게시글 번호' readonly="readonly" />
					</div>
					<div class='form-group'>
						<label for='rUserId'>신고자</label>
						<input class='form-control' type='text' id='rUserId' name='rUserId' value='' placeholder='신고자 입력' readonly="readonly" />
					</div>
					<div class='form-group'>
						<label for='rContent'>신고 내용 (최대한 상세하게 입력하세요)</label>
						<textarea class='form-control' rows='3' id='rContent' name='rContent' placeholder='신고 내용 입력'></textarea>
					</div>
					<div class='form-group'>
						<input class='btn btn-info' type='button' id='btnBoardReportSubmit' value='제출' style='float: right;' />
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>