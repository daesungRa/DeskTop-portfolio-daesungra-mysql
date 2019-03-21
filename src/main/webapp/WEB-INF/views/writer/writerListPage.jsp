<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<title>writer page</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" />
	<link rel='stylesheet' href='//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css'/>
	<link rel='stylesheet' href='/desktop/resources/css/component_large.css' media='screen and (min-width: 800px)' />
	<link rel='stylesheet' href='/desktop/resources/css/component_mini.css' media='screen and (max-width: 799px)' />
	<link rel='stylesheet' href='/desktop/resources/css/writerListPage_large.css' media='screen and (min-width: 800px)' />
	<link rel='stylesheet' href='/desktop/resources/css/writerListPage_mini.css' media='screen and (max-width: 799px)' />
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src='/desktop/resources/js/component.js'></script>
	<script src='/desktop/resources/js/member.js'></script>
	<script src='/desktop/resources/js/writerListPage.js'></script>
</head>
<body style='position: relative; height: 100%; padding-bottom: 200px; min-height: 100%;'>

	<c:if test='${not empty requestScope.mbvoList }'>
		<c:set var='mbvoList' value='${requestScope.mbvoList }' />
	</c:if>

	<!-- include navBar(aside) -->
	<jsp:include page="/WEB-INF/views/component/navBar_aside.jsp"></jsp:include>

	<!-- include content -->
	<div id='boardContent' style='z-index: 0;'>
		<button class='btn btn-light' id='btnShowNavbar'>&gt;&gt;</button>
		<!-- top -->
		<jsp:include page="/WEB-INF/views/component/top.jsp"></jsp:include>
	
		<!-- middle component -->
		<div class='container'>
			<div class='container' style='width: 75%; margin: 30px auto;'>
				<div class='container'>
					<img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board' style='width: 15px; padding-bottom: 4px; margin-right: 7px;' />
					<span id='writerListPageTitle'>작가 페이지</span>
				</div><br/><br/>
				
				<div class='container-fluid' id='writerListPageSubTitle01'>오늘의 인기 작가</div>
				<div class='container' id='writerListPageBody'>
					<c:forEach var="mbvo" items='${mbvoList }'>
						<div class='container my-popularWriter'>
							<span id='userId' style='display: none;'>${mbvo.userId }</span>
							<img src='${mbvo.photo }' alt='writer profile img' class='my-popularWriterImg' id='' />
							<div class='my-popularWriterNames'>
								<span style='font-size: 14pt;'>${mbvo.nickName }</span><br/>
								<span style='color: #565656; font-size: 12pt;'>${mbvo.userName }</span>
							</div>
							<div style='display: inline-block; margin-left: 30px;'>
								<span style='color: #787878; font-size: 10pt;'>댓글수 : ${mbvo.boardCnt }</span><br/>
								<span style='color: #565656; font-size: 10pt;'>추천수 : ${mbvo.thumbUpCnt }</span><br/>
								<span style='color: #565656; font-size: 10pt;'>팔로워 : ${mbvo.fNum }</span>
							</div>
						</div>
					</c:forEach>
					<br/>
					<form class='form' id='searchWriterForm' name='searchWriterForm'>
						<div class='form-inline'>
							<input class='form-control' type='search' id='search' name='search' value='' placeholder='작가 검색' />
							<input class='btn btn-info' type='button' id='btnSearchWriter' name='btnSearchWriter' value='검색' />
						</div>
					</form>
				</div>
				<div class='container' id='selectedWriterBody'>
					
				</div>
			</div>
		</div>
	</div>
	
	<!-- button for to-top -->
	<a class='btn btn-secondary my-btn-toTop' href='#' onclick='funcMovePage("indexTop");' style='z-index: 1;'>top</a>
	
	<!-- include footer -->
	<footer style='z-index: 0;'>
		<jsp:include page="/WEB-INF/views/component/footer.jsp"></jsp:include>
	</footer>
	
    <!-- Modal -->
    <jsp:include page="/WEB-INF/views/component/modal.jsp"></jsp:include>
    
</body>
</html>