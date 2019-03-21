<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<title>My Page</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" />
	<link rel='stylesheet' href='//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css'/>
	<link rel='stylesheet' href='/desktop/resources/css/index.css' />
	<link rel='stylesheet' href='/desktop/resources/css/component.css' />
	<link rel='stylesheet' href='/desktop/resources/css/member.css' />
	<link rel='stylesheet' href='/desktop/resources/css/board.css' />
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src='/desktop/resources/js/index.js'></script>
	<script src='/desktop/resources/js/component.js'></script>
	<script src='/desktop/resources/js/member.js'></script>
	<script src='/desktop/resources/js/myPage.js'></script>
</head>
<body style='position: relative; height: 100%; padding-bottom: 200px; min-height: 100%;'>

	<c:if test='${not empty requestScope.bdvoList }'>
		<c:set var='bdvoList' value='${requestScope.bdvoList }' scope='page' />
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
				<p id='myPageTitle'>마이 페이지</p>
				<p id='myPageDesc'>나만의 매력적인 프로필을 만드세요!</p>
				
				<div class='row my-myPage-memberinfo'>
					<div class='col-sm-2' id='myPageLeftComponent'>
						<img src='/desktop/resources/imgs/blank_profile01.png' id='profileImagePreview' alt='profile image preview'/><br/><br/>
						<p>구독자 수</p>
						<div id='inputFNum'></div><br/>
						<P>구독중인 작가</p>
						<div id='inputFollowee'>보기 </div><br/>
						<p>웹페이지</p>
						<div id='inputWebPage'>새로 등록해주세요</div><br/>
						<!-- <p>활동</p>
						<div id='inputActivity'>특별한 활동이<br/>없습니다</div><br/> -->
						<p>계정 생성일</p>
						<div id='inputMDate'></div>
					</div>
					<hr/>
					<div class='col-sm-10'>
						<ul class='nav nav-tabs my-tabs'>
							<li class='active' id='navtab-profile-tag-li'><a data-toggle='tab' id='navtab-profile-tag' href='#profile-tag'>프로필</a></li>
							<li id='navtab-info-tag-li'><a data-toggle='tab' id='navtab-info-tag' href='#info-tag'>회원정보</a></li>
						</ul><br/>
						
						<div class='tab-content my-tab-pane'>
							<div id='profile-tag' class='tab-pane fade'>
								<div id='memberProfileContent'></div>
							</div>
							<div id='info-tag' class='tab-pane fade'>
								<div id='memberInfoContent'></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class='container' id='myBoardListBody'>
				<div style='position: relative; height: 50px;'>
					<span id='categoryContent' style='position: absolute; top: 20%; font-size: 12pt;'>
						<img src='/desktop/resources/imgs/document01.png' alt='icon_pencil for board' style='width: 18px; padding-bottom: 3px; margin-right: 10px;' /> 내가 쓴 게시글 목록
					</span>
				</div>
				<div id='newBoardListBody'>
					<div class='row' style='height: 30px; font-size: 10pt; border-top: 2px solid black; border-bottom: 1px solid black; padding-top: 4px; background-color: #dedede;'>
						<div class='col-md-1'>SERIAL</div>
						<div class='col-md-3'>제목</div>
						<div class='col-md-2'>작성자</div>
						<div class='col-md-4'>[카테고리] 조회수 / 블럭 여부 / 삭제 여부</div>
						<div class='col-md-2'>등록일</div>
					</div>
					<c:choose>
						<c:when test='${not empty requestScope.bdvoList and fn:length(requestScope.bdvoList) > 0 }'>
							<c:forEach var="bdvo" items="${bdvoList }" >
								<div class='row my-adminList-row' data-toggle='tooltip' data-placement='right' title='해당 게시글 보기'>
									<div class='col-md-1' id='myBoardSerial'>${bdvo.serial }</div>
									<div class='col-md-1' id='myBoardCategory' style='display: none;'>${bdvo.category }</div>
									<div class='col-md-3'>${bdvo.title }</div>
									<div class='col-md-2'>${bdvo.userId }</div>
									<div class='col-md-4'>[${bdvo.category }] ${bdvo.hit }
										<c:choose>
											<c:when test='${bdvo.isBlocked == 0 }'>
												/<span style='color: #7878ff;'> 블럭되지 않음</span>
											</c:when>
											<c:when test='${bdvo.isBlocked == 1 }'>
												/<span style='color: #ff7878;'> 블럭됨</span>
											</c:when>
										</c:choose>
										<c:choose>
											<c:when test='${bdvo.isBlocked == 0 }'>
												/<span style='color: #7878ff;'> 삭제되지 않음</span>
											</c:when>
											<c:when test='${bdvo.isBlocked == 1 }'>
												/<span style='color: #ff7878;'> 삭제됨</span>
											</c:when>
										</c:choose>
									</div>
									<div class='col-md-2'>${bdvo.bDate }</div>
								</div>
							</c:forEach>
							<c:if test='${not empty requestScope.bdPageDto }'>
								<div class='container' id='btnNewBoardChangeGrp' style='height: 46px; font-size: 9pt; text-align: center; margin-top: 30px;'>
									<c:if test='${bdPageDto.nowPage >= 2 }'>
										<span class='btnAdminBtn'>처음<span style='display: none;'>1</span></span>
										<span class='btnAdminBtn'>이전<span style='display: none;'>${bdPageDto.nowPage - 1 }</span></span>
										<span class='btnAdminBtnBar'>|</span>
									</c:if>
									<c:forEach var='i' begin='${bdPageDto.startPage }' end='${bdPageDto.endPage }' step='1'>
										<c:choose>
											<c:when test='${bdPageDto.nowPage == i }'>
												<span class='btnAdminBtnNone'>${i }</span>
											</c:when>
											<c:otherwise>
												<span class='btnAdminBtn'>${i }<span style='display: none;'>${i }</span></span>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if test='${bdPageDto.nowPage < bdPageDto.totPage }'>
										<span class='btnAdminBtnBar'>|</span>
										<span class='btnAdminBtn'>다음<span style='display: none;'>${bdPageDto.nowPage + 1 }</span></span>
										<span class='btnAdminBtn'>마지막<span style='display: none;'>${bdPageDto.totPage }</span></span>
									</c:if>
								</div>
							</c:if>
						</c:when>
						<c:otherwise>
							<div style='height: 180px;'>
								<div id='noSelectResult'>
									<p>검색결과가 없습니다.</p>
								</div>
							</div><br/>
							<hr style='border-top: 3px double #8c8b8b;'/>
							<br/><br/>
						</c:otherwise>
					</c:choose>
				</div>
			</div><br/><br/>
			
		</div>
	</div>
	
	<!-- include footer -->
	<footer>
		<jsp:include page="/WEB-INF/views/component/footer.jsp"></jsp:include>
	</footer>
	
	<!-- button for to-top -->
	<a class='btn btn-secondary my-btn-toTop' href='#' onclick='funcMovePage("indexTop");'>top</a>
	
	<!-- Modal -->
    <jsp:include page="/WEB-INF/views/component/modal.jsp"></jsp:include>

</body>
</html>