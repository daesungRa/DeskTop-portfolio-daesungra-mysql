<%@page import="com.daesungra.domain.BoardVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<title>Board Write Page</title>
	<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css' />
	<link rel='stylesheet' href='https://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css'>
	<link rel='stylesheet' href='//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css'/>
	<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css'>
	<link rel='stylesheet' href='/desktop/resources/css/boardListPage.css' />
	<link rel='stylesheet' href='/desktop/resources/css/component.css' />
	
	<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js'></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js'></script>
	<script src='https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js'></script>
	<script src='https://code.jquery.com/jquery-1.10.2.js'></script>
	<script src='https://code.jquery.com/ui/1.10.4/jquery-ui.js'></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
	<script src='/desktop/resources/js/index.js'></script>
	<script src='/desktop/resources/js/boardWritePage.js'></script>
	<script src='/desktop/resources/js/component.js'></script>
</head>
<body style='position: relative; height: 100%; padding-bottom: 200px;'>

	<c:if test='${not empty requestScope.category }'>
		<c:set var='categoryNum' value='${requestScope.category }' scope="page"></c:set>
	</c:if>

	<!-- include navBar(aside) -->
	<jsp:include page="/WEB-INF/views/component/navBar_aside.jsp"></jsp:include>
	
	<!-- include content -->
	<div id='boardContent' style='z-index: 0; min-height: 1100px;'>
		<button class='btn btn-sm btn-light' id='btnShowNavbar'>&gt;&gt;</button>
		<!-- top -->
		<jsp:include page="/WEB-INF/views/component/top.jsp"></jsp:include>
		
		<!-- middle component -->
		<div class='container'>
			<div class='container' id='boardList' style='width: 96%; border-right: 1px solid #bfbfbf; border-left: 1px solid #bfbfbf; padding: 20px 120px 20px 120px;'>
				<div style='position: relative; height: 80px;'>
					<div id='saveCategoryNum' style='display: none;'>${categoryNum }</div>
					<c:choose>
						<c:when test='${requestScope.category == 2 }'>
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 14pt;  width: 180px;'><img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board' style='width: 15px; padding-bottom: 3px; margin-right: 10px;' />글쓰기</span>
							<span id='showCategoryContent'  style='position: absolute; top: 30%; left: 83px; color: #898989; font-size: 6pt; text-align: center; padding: 1px 3px 1px 3px;'>경제 / 경영</span>
							<select class='form-control' id='changeCategoryInWritePage' style='position: absolute; top: 20%; right: 0; font-size: 8pt; width: 16%; height: 29px;'>
								<option value='1'>인문/사회/정치</option>
								<option value='2' selected>경제/경영</option>
								<option value='3'>과학/공학/수학/컴퓨터</option>
								<option value='4'>문학/시/소설</option>
								<option value='5'>문화/예술/자기계발/라이프</option>
							</select>
						</c:when>
						<c:when test='${requestScope.category == 3 }'>
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 14pt;  width: 180px;'><img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board' style='width: 15px; padding-bottom: 3px; margin-right: 10px;' />글쓰기</span>
							<span id='showCategoryContent'  style='position: absolute; top: 30%; left: 83px; color: #898989; font-size: 6pt; text-align: center; padding: 1px 3px 1px 3px;'>과학 / 공학 / 수학 / 컴퓨터</span>
							<select class='form-control' id='changeCategoryInWritePage' style='position: absolute; top: 20%; right: 0; font-size: 8pt; width: 24%; height: 29px;'>
								<option value='1'>인문/사회/정치</option>
								<option value='2'>경제/경영</option>
								<option value='3' selected>과학/공학/수학/컴퓨터</option>
								<option value='4'>문학/시/소설</option>
								<option value='5'>문화/예술/자기계발/라이프</option>
							</select>
						</c:when>
						<c:when test='${requestScope.category == 4 }'>
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 14pt;  width: 180px;'><img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board' style='width: 15px; padding-bottom: 3px; margin-right: 10px;' />글쓰기</span>
							<span id='showCategoryContent'  style='position: absolute; top: 30%; left: 83px; color: #898989; font-size: 6pt; text-align: center; padding: 1px 3px 1px 3px;'>문학 / 시 / 소설</span>
							<select class='form-control' id='changeCategoryInWritePage' style='position: absolute; top: 20%; right: 0; font-size: 8pt; width: 17%; height: 29px;'>
								<option value='1'>인문/사회/정치</option>
								<option value='2'>경제/경영</option>
								<option value='3'>과학/공학/수학/컴퓨터</option>
								<option value='4' selected>문학/시/소설</option>
								<option value='5'>문화/예술/자기계발/라이프</option>
							</select>
						</c:when>
						<c:when test='${requestScope.category == 5 }'>
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 14pt;  width: 180px;'><img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board' style='width: 15px; padding-bottom: 3px; margin-right: 10px;' />글쓰기</span>
							<span id='showCategoryContent'  style='position: absolute; top: 30%; left: 83px; color: #898989; font-size: 6pt; text-align: center; padding: 1px 3px 1px 3px;'>문화 / 예술 / 자기계발 / 라이프</span>
							<select class='form-control' id='changeCategoryInWritePage' style='position: absolute; top: 20%; right: 0; font-size: 8pt; width: 27%; height: 29px;'>
								<option value='1'>인문/사회/정치</option>
								<option value='2'>경제/경영</option>
								<option value='3'>과학/공학/수학/컴퓨터</option>
								<option value='4'>문학/시/소설</option>
								<option value='5' selected>문화/예술/자기계발/라이프</option>
							</select>
						</c:when>
						<c:otherwise>
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 14pt;  width: 180px;'><img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board' style='width: 15px; padding-bottom: 3px; margin-right: 10px;' />글쓰기</span>
							<span id='showCategoryContent'  style='position: absolute; top: 30%; left: 83px; color: #898989; font-size: 6pt; text-align: center; padding: 1px 3px 1px 3px;'>인문 / 사회 / 정치</span>
							<select class='form-control' id='changeCategoryInWritePage' style='position: absolute; top: 20%; right: 0; font-size: 8pt; width: 18%; height: 29px;'>
								<option value='1' selected>인문/사회/정치</option>
								<option value='2'>경제/경영</option>
								<option value='3'>과학/공학/수학/컴퓨터</option>
								<option value='4'>문학/시/소설</option>
								<option value='5'>문화/예술/자기계발/라이프</option>
							</select>
						</c:otherwise>
					</c:choose>
					<br/>
					<hr style='border-top: 3px double #8c8b8b; margin-top: 30px;'/>
				</div>
				
				<div class='container' id='' style='font-weight: bolder;'>
					<form class='form' id='searchBookInfoForm' name='searchBookInfoForm' method='post'>
						<div class='form-inline' style='margin: 10px 0 10px 0;'>
							<span style='color: #898989; font-size: 10pt;'>by&nbsp;&nbsp;</span><span>${sessionScope.userId }&nbsp;&nbsp;</span>
						</div>
						<input class='form-control' id='searchBookInBoardWrite' name='searchBookInfo' type='search' placeholder='책 검색' style='width: 50%; font-weight: bolder;' />
					</form>
					<form class='form' id='boardWriteForm' name='boardWriteForm' action='#' method='post'>
						<input class='form-control' id='bookNo' name='bookNo' type='hidden' value='0000' />
						<input type='hidden' id='existingBookCheck' value='unChecked' />
						<input class='form-control' id='category' name='category' type='hidden' value='${categoryNum }' />
						<input class='form-control' id='title' name='title' type='text' placeholder='제목을 입력하세요' style='margin: 5px 0 5px 0; font-weight: bolder;' />
						<textarea class='form-control' id='summernote' name='content' placeholder='내용을 입력하세요'></textarea>
						<div class='form-group' id='submitGrp' style='width: 135px; margin: 25px auto;'>
							<input class='btn btn-info' id='btnBoardWriteSubmit' name='btnBoardWriteSubmit' type='button' value='제 출' />
							<input class='btn btn-info' id='btnBoardWriteCancel' name='btnBoardWriteCancel' type='button' value='취 소' style='margin-left: 5px;' />
						</div>
					</form>
				</div>
			</div>
		</div>
		
	</div>
	
	<!-- include footer -->
	<footer>
		<jsp:include page="/WEB-INF/views/component/footer.jsp"></jsp:include>
	</footer>
	
	<!-- button for to-top -->
	<a class='btn btn-secondary my-btn-toTop' href='#'>top</a>
	
	<!-- Modal -->
    <jsp:include page="/WEB-INF/views/component/modal.jsp"></jsp:include>

</body>
</html>