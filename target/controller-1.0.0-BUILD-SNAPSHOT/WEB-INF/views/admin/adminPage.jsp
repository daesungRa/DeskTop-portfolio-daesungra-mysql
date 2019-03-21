<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/functions' prefix='fn' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<title>Admin page</title>
	<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css' />
	<link rel='stylesheet' href='//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css'/>
	<link rel='stylesheet' href='/desktop/resources/css/admin.css' />
	<link rel='stylesheet' href='/desktop/resources/css/component.css' />
	
	<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js'></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js'></script>
	<script src='https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js'></script>
	<script src='/desktop/resources/js/admin.js'></script>
	<script src='/desktop/resources/js/component.js'></script>
</head>
<body style='position: relative; height: 100%; padding-bottom: 200px;'>
	
	<!-- 
		[관리자 페이지]
			- 회원정보 관리 (수퍼관리자만)
			- 게시글 관리
			- 등록 요청중인 책 정보 관리
			- 신고 게시판 관리
	 -->
	 
	 <c:choose>
		<c:when test='${not empty sessionScope.userId and not empty sessionScope.authority and sessionScope.authority > 0 }'>
			<c:set var='authority' value='${sessionScope.authority }' scope='page' />
			<!-- <script>alert('관리자 페이지입니다');</script> -->
		</c:when>
		<c:otherwise>
			<script>
				location.href = '/desktop/';
			</script>
		</c:otherwise>
	</c:choose>
	
	<c:if test='${not empty requestScope.brvoList and fn:length(requestScope.brvoList) > 0 }'>
		<c:set var='brvoList' value='${requestScope.brvoList }' scope='page' />
		<c:set var='brPageDto' value='${requestScope.brPageDto }' scope='page' />
	</c:if>
	
	<c:if test='${not empty requestScope.bkvoList and fn:length(requestScope.bkvoList) > 0 }'>
		<c:set var='bkvoList' value='${requestScope.bkvoList }' scope='page' />
		<c:set var='bkPageDto' value='${requestScope.bkPageDto }' scope='page' />
	</c:if>
	
	<c:if test='${not empty requestScope.bdvoList and fn:length(requestScope.bdvoList) > 0 }'>
		<c:set var='bdvoList' value='${requestScope.bdvoList }' scope='page' />
		<c:set var='bdPageDto' value='${requestScope.bdPageDto }' scope='page' />
	</c:if>

	<!-- top -->
	<jsp:include page="/WEB-INF/views/component/top.jsp"></jsp:include>
	
	<!-- include navbar(top) -->
	<div style='z-index: 5;'>
		<jsp:include page="/WEB-INF/views/component/navBar_top.jsp"></jsp:include>
	</div>
	
	<%
		SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY년 MM월 dd일");
		SimpleDateFormat inputDateFormat = new SimpleDateFormat("YYMMdd");
		
		Date date = new Date();
		String today = dateFormat.format(date);
		String inputDate = inputDateFormat.format(date);
	%>

	<article class='container-fluid' id='adminArticle' style='display: block; /* border: 1px solid black; */ margin: 30px 0 30px 0;'>
		<div class='container' id='adminPageTitle'>
			<div style='position: relative; height: 30px;'>
				<span id='categoryContent' style='position: absolute; top: 20%; font-size: 14pt;'>
					<img src='/desktop/resources/imgs/sample/gear02.svg' alt='icon_pencil for board' style='width: 18px; padding-bottom: 3px; margin-right: 10px;' /> 관리자 페이지 (<%=today %>)
				</span>
				<c:if test='${not empty sessionScope.userId and sessionScope.authority == 2 }'>
					<div class='container' style='position: absolute; top: 17%; left: 320px;'>
						<div class='myBtn' id='showMemberAdminComponent' style='display: inline-block;'>회원관리</div>
					</div>
				</c:if>
			</div>
			<hr style='border-top: 3px double #8c8b8b;'/>
		</div>
		<div class='container-fluid' style='min-height: 420px; /* border: 1px solid black; */ margin-top: 40px;'>
			<div class='row'>
				<div class='col-sm-6' style='/* border: 1px solid black; */'>
					<!-- 신고 목록 -->
					<div id='boardReportListComponent'>
						<div style='position: relative; height: 50px;'>
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 12pt;'>
								<img src='/desktop/resources/imgs/document01.png' alt='icon_pencil for board' style='width: 18px; padding-bottom: 3px; margin-right: 10px;' /> 신고 목록
							</span>
							<form class='form' id='boardReportListForm' name='boardReportListForm' method='post' action='#' style='float: right;'>
								<input class='form-control' type='text' id='nowPage' name='nowPage' value='1' style='display: none;' />
								<select class='form-control' id='dateFlag' name='dateFlag' >
									<option value='0'>전체 조회</option>
									<option value='1'>오늘</option>
									<option value='2'>어제부터</option>
									<option value='3' selected>최근 일주일</option>
									<option value='4'>최근 한 달</option>
								</select>
							</form>
						</div>
						<div id='brlBody'>
							<div id='boardReportListBody'>
								<div class='row' style='height: 30px; font-size: 9pt; border-top: 2px solid black; border-bottom: 1px solid black; padding-top: 4px; background-color: #dedede;'>
									<div class='col-md-1'>NO</div>
									<div class='col-md-3'>분류 / 블럭 여부</div>
									<div class='col-md-2'>신고자</div>
									<div class='col-md-4'>[카테고리] 게시글 / 작성자</div>
									<div class='col-md-2'>등록일</div>
								</div>
								<c:choose>
									<c:when test='${not empty requestScope.brvoList and fn:length(requestScope.brvoList) > 0 }'>
										<c:forEach var="brvo" items="${brvoList }" >
											<div class='row my-adminList-row'>
												<div class='col-md-1' id='boardReportSerial'>${brvo.serial }</div>
												<div class='col-md-3'>[${brvo.reportType }]
													<c:choose>
														<c:when test='${brvo.reportType == 1 }'>
															(통합)부적절한 게시글
														</c:when>
														<c:when test='${brvo.reportType == 2 }'>
															광고
														</c:when>
														<c:when test='${brvo.reportType == 3 }'>
															욕설
														</c:when>
														<c:when test='${brvo.reportType == 4 }'>
															음란물
														</c:when>
														<c:when test='${brvo.reportType == 5 }'>
															저작권 침해
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test='${brvo.isBlocked == 0 }'>
															/<span style='color: #7878ff;'> 블럭되지 않음</span>
														</c:when>
														<c:when test='${brvo.isBlocked == 1 }'>
															/<span style='color: #ff7878;'> 블럭됨</span>
														</c:when>
													</c:choose>
												</div>
												<div class='col-md-2'>${brvo.rUserId }</div>
												<div class='col-md-4'>[${brvo.category }] ${brvo.title } / ${brvo.userId }</div>
												<div class='col-md-2'>${brvo.rDate }</div>
											</div>
										</c:forEach>
										<c:if test='${not empty requestScope.brPageDto }'>
											<div class='container' id='btnBoardReportChangeGrp' style='height: 46px; font-size: 9pt; text-align: center; margin-top: 30px;'>
												<c:if test='${brPageDto.nowPage >= 2 }'>
													<span class='btnAdminBtn'>처음<span style='display: none;'>1</span></span>
													<span class='btnAdminBtn'>이전<span style='display: none;'>${brPageDto.nowPage - 1 }</span></span>
													<span class='btnAdminBtnBar'>|</span>
												</c:if>
												<c:forEach var='i' begin='${brPageDto.startPage }' end='${brPageDto.endPage }' step='1'>
													<c:choose>
														<c:when test='${brPageDto.nowPage == i }'>
															<span class='btnAdminBtnNone'>${i }</span>
														</c:when>
														<c:otherwise>
															<span class='btnAdminBtn'>${i }<span style='display: none;'>${i }</span></span>
														</c:otherwise>
													</c:choose>
												</c:forEach>
												<c:if test='${brPageDto.nowPage < brPageDto.totPage }'>
													<span class='btnAdminBtnBar'>|</span>
													<span class='btnAdminBtn'>다음<span style='display: none;'>${brPageDto.nowPage + 1 }</span></span>
													<span class='btnAdminBtn'>마지막<span style='display: none;'>${brPageDto.totPage }</span></span>
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
						</div>
					</div>
					<!-- /신고 목록 -->
				</div>
				
				<!-- 분할 블럭 -->
				<span class='col-sm-1' style='min-height: 420px; text-align: center;'><span style='height: 100%; display: inline-block; border: 1px solid #787878;'></span></span>
				
				<div class='col-sm-5' style='min-height: 420px; /* border: 1px solid black; */'>
					<!-- 책 등록 요청 -->
					<div id='bookRegisterListBody'>
						<div style='position: relative; height: 50px;'>
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 12pt;'>
								<img src='/desktop/resources/imgs/document01.png' alt='icon_pencil for board' style='width: 18px; padding-bottom: 3px; margin-right: 10px;' /> 등록 요청된 책 목록
							</span>
							<form class='form' id='bookRegisterListForm' name='bookRegisterListForm' method='post' action='#' style='float: right;'>
								<input class='form-control' type='text' id='nowPage' name='nowPage' value='1' style='display: none;' />
								<select class='form-control' id='dateFlag' name='dateFlag' >
									<option value='0'>전체 조회</option>
									<option value='1'>오늘</option>
									<option value='2'>어제부터</option>
									<option value='3' selected>최근 일주일</option>
									<option value='4'>최근 한 달</option>
								</select>
							</form>
						</div>
						<div id='bkrBody'>
							<div class='row' style='height: 30px; font-size: 9pt; border-top: 2px solid black; border-bottom: 1px solid black; padding-top: 4px; background-color: #dedede;'>
								<div class='col-md-1'>NO</div>
								<div class='col-md-3'>분류 / 승인 여부</div>
								<div class='col-md-2'>작성자</div>
								<div class='col-md-4'>책제목 / 작가</div>
								<div class='col-md-2'>등록일</div>
							</div>
							<c:choose>
								<c:when test='${not empty requestScope.bkvoList and fn:length(requestScope.bkvoList) > 0 }'>
									<c:forEach var="bkvo" items="${bkvoList }" >
										<div class='row my-adminList-row'>
											<div class='col-md-1' id='bookRegisterBookNo' style='display: none;'>${bkvo.bookNo }</div>
											<div class='col-md-1'>undef</div>
											<div class='col-md-3'>[${bkvo.category }]
												<c:choose>
													<c:when test='${bkvo.category == 1 }'>
														인문/사회/정치
													</c:when>
													<c:when test='${bkvo.category == 2 }'>
														경제/경영
													</c:when>
													<c:when test='${bkvo.category == 3 }'>
														과학/공학/수학/컴퓨터
													</c:when>
													<c:when test='${bkvo.category == 4 }'>
														문학/시/소설
													</c:when>
													<c:when test='${bkvo.category == 5 }'>
														문화/예술/자기계발/라이프
													</c:when>
												</c:choose>
												<c:choose>
													<c:when test='${bkvo.isPermitted == 0 }'>
														/<span style='color: #ff7878;'> 승인되지 않음</span>
													</c:when>
													<c:when test='${bkvo.isPermitted == 1 }'>
														/<span style='color: #7878ff;'> 승인됨</span>
													</c:when>
												</c:choose>
											</div>
											<div class='col-md-2'>${bkvo.userId }</div>
											<div class='col-md-4'>${bkvo.title_kor }(${bkvo.title_eng }) / ${bkvo.author }</div>
											<div class='col-md-2'>${bkvo.pDate }</div>
										</div>
									</c:forEach>
									<c:if test='${not empty requestScope.bkPageDto }'>
										<div class='container' id='btnBookRegisterChangeGrp' style='height: 46px; font-size: 9pt; text-align: center; margin-top: 30px;'>
											<c:if test='${bkPageDto.nowPage >= 2 }'>
												<span class='btnAdminBtn'>처음<span style='display: none;'>1</span></span>
												<span class='btnAdminBtn'>이전<span style='display: none;'>${bkPageDto.nowPage - 1 }</span></span>
												<span class='btnAdminBtnBar'>|</span>
											</c:if>
											<c:forEach var='i' begin='${bkPageDto.startPage }' end='${bkPageDto.endPage }' step='1'>
												<c:choose>
													<c:when test='${bkPageDto.nowPage == i }'>
														<span class='btnAdminBtnNone'>${i }</span>
													</c:when>
													<c:otherwise>
														<span class='btnAdminBtn'>${i }<span style='display: none;'>${i }</span></span>
													</c:otherwise>
												</c:choose>
											</c:forEach>
											<c:if test='${bkPageDto.nowPage < bkPageDto.totPage }'>
												<span class='btnAdminBtnBar'>|</span>
												<span class='btnAdminBtn'>다음<span style='display: none;'>${bkPageDto.nowPage + 1 }</span></span>
												<span class='btnAdminBtn'>마지막<span style='display: none;'>${bkPageDto.totPage }</span></span>
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
					</div>
					<!-- /책 등록 요청 -->
				</div>
			</div>
		</div>
		
		<!-- 중간선 -->
		<br/><hr style='border-top: 1px solid #8c8b8b;'/><br/>
		
		<div class='container-fluid' id='adminNewBoardComponent' style='width: 80%; min-height: 420px; /* border: 1px solid black; */ margin: 0 auto;'>
			<!-- 새로 등록된 게시글 -->
			<div id='newBoardListComponent'>
				<div style='position: relative; height: 50px;'>
					<span id='categoryContent' style='position: absolute; top: 20%; font-size: 12pt;'>
						<img src='/desktop/resources/imgs/document01.png' alt='icon_pencil for board' style='width: 18px; padding-bottom: 3px; margin-right: 10px;' /> 새로운 게시글 목록
					</span>
					<form class='form' id='newBoardListForm' name='newBoardListForm' method='post' action='#' style='float: right;'>
						<input class='form-control' type='text' id='nowPage' name='nowPage' value='1' style='display: none;' />
						<select class='form-control' id='dateFlag' name='dateFlag' >
							<option value='0'>전체 조회</option>
							<option value='1'>오늘</option>
							<option value='2'>어제부터</option>
							<option value='3' selected>최근 일주일</option>
							<option value='4'>최근 한 달</option>
						</select>
					</form>
				</div>
				<div id='bdlBody'>
					<div id='newBoardListBody'>
						<div class='row' style='height: 30px; font-size: 8pt; border-top: 2px solid black; border-bottom: 1px solid black; padding-top: 4px; background-color: #dedede;'>
							<div class='col-md-1'>SERIAL</div>
							<div class='col-md-2'>제목</div>
							<div class='col-md-1'>작성자</div>
							<div class='col-md-3'>[카테고리] 조회수 / 추천수 / 댓글수</div>
							<div class='col-md-3'>블럭 여부 / 삭제 여부</div>
							<div class='col-md-2'>등록일</div>
						</div>
						<c:choose>
							<c:when test='${not empty requestScope.bdvoList and fn:length(requestScope.bdvoList) > 0 }'>
								<c:forEach var="bdvo" items="${bdvoList }" >
									<div class='row my-adminList-row'>
										<div class='col-md-1' id='newBoardSerial'>${bdvo.serial }</div>
										<div class='col-md-2'>${bdvo.title }</div>
										<div class='col-md-1'>${bdvo.userId }</div>
										<div class='col-md-3'>[${bdvo.category }] ${bdvo.hit } / ${bdvo.thumbUpCnt } / ${bdvo.commentCnt }</div>
										<div class='col-md-3'>
											<c:choose>
												<c:when test='${bdvo.isBlocked == 0 }'>
													<span style='color: #7878ff;'>블럭되지 않음</span>
												</c:when>
												<c:when test='${bdvo.isBlocked == 1 }'>
													<span style='color: #ff7878;'>블럭됨</span>
												</c:when>
											</c:choose>
											<c:choose>
												<c:when test='${bdvo.isBlocked == 0 }'>
													<span style='color: #7878ff;'>삭제되지 않음</span>
												</c:when>
												<c:when test='${bdvo.isBlocked == 1 }'>
													<span style='color: #ff7878;'>삭제됨</span>
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
				</div>
			</div>
			<!-- /새로 등록된 게시글 -->
		</div>
	</article>
	
	<!-- button for to-top -->
	<a class='btn btn-secondary my-btn-toTop' href='#' onclick='funcMovePage("indexTop");'>top</a>
	
	<!-- include footer -->
	<footer>
		<jsp:include page="/WEB-INF/views/component/footer.jsp"></jsp:include>
	</footer>
	
    <!-- Modal -->
    <jsp:include page="/WEB-INF/views/component/modal.jsp"></jsp:include>

</body>
</html>