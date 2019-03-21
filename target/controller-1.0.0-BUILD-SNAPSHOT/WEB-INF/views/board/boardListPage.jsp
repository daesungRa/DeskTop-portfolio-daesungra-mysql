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
<title>Board List Page</title>
	<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css' />
	<link rel='stylesheet' href='//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css'/>
	<link rel='stylesheet' href='/desktop/resources/css/boardListPage.css' />
	<link rel='stylesheet' href='/desktop/resources/css/component.css' />
	
	<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js'></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js'></script>
	<script src='https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js'></script>
	<script src='/desktop/resources/js/index.js'></script>
	<script src='/desktop/resources/js/member.js'></script>
	<script src='/desktop/resources/js/boardListPage.js'></script>
	<script src='/desktop/resources/js/component.js'></script>
</head>
<body style='position: relative; height: 100%; padding-bottom: 200px;'>
	
	<c:if test="${not empty requestScope.boardListDate }">
		<c:set var="boardListDate" value="${requestScope.boardListDate }" scope="page"></c:set>
	</c:if>
	<c:if test="${not empty requestScope.boardListHit }">
		<c:set var="boardListHit" value="${requestScope.boardListHit }" scope="page"></c:set>
	</c:if>
	<c:if test='${not empty requestScope.pageDto }'>
		<c:set var='pageDto' value='${requestScope.pageDto }' scope='page'></c:set>
	</c:if>
	
	<!-- 브라우저 크기 확인 (임시) -->
	<!-- <div id='windowSize' style='width: 180px; border: 1px solid black;'>
		window size : 
		
	</div> -->
	
	<!-- include navBar(aside) -->
	<jsp:include page="/WEB-INF/views/component/navBar_aside.jsp"></jsp:include>
	
	<!-- include content -->
	<div id='boardContent' style='position: relative; z-index: 0; min-height: 100%;'>
		<button class='btn btn-sm btn-light' id='btnShowNavbar'>&gt;&gt;</button>
		<!-- top -->
		<jsp:include page="/WEB-INF/views/component/top.jsp"></jsp:include>
	
		<!-- middle component -->
		<div class='container'>
			<div class='container' id='boardList' style='width: 96%; min-height: 1000px; border-right: 1px solid #bfbfbf; border-left: 1px solid #bfbfbf; padding: 20px 120px 20px 120px;'>
				<div style='position: relative; height: 80px;'>
					<div id='saveCategoryNum' style='display: none;'>${requestScope.category }</div>
					<c:if test='${not empty sessionScope.userId and sessionScope != "" }'>
						<a class='btn btn-secondary my-btn-register' id='btnBookRegister' href='#btnBookRegister'>책 등록</a>
					</c:if>
					<c:choose>
						<c:when test='${requestScope.category == 2 }'>
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 14pt;  width: 150px;'><img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board' style='width: 15px; padding-bottom: 3px; margin-right: 10px;' />경제 / 경영</span>
							<span id='toBoardList'  style='position: absolute; top: 27%; left: 128px; color: #898989; font-size: 6pt; text-align: center; border: 1px solid #898989; border-radius: 10px; padding: 1px 3px 1px 3px;'>글목록</span>
							<span class='toBoardWritePage'  style='position: absolute; top: 27%; left: 178px; color: #898989; font-size: 6pt; text-align: center; border: 1px solid #898989; border-radius: 10px; padding: 1px 3px 1px 3px;'>글쓰기</span>
							<select class='form-control' id='changeCategoryInBoardPage' style='position: absolute; top: 20%; right: 0; font-size: 8pt; width: 16%; height: 29px;'>
								<option value='1'>인문/사회/정치</option>
								<option value='2' selected>경제/경영</option>
								<option value='3'>과학/공학/수학/컴퓨터</option>
								<option value='4'>문학/시/소설</option>
								<option value='5'>문화/예술/자기계발/라이프</option>
							</select>
						</c:when>
						<c:when test='${requestScope.category == 3 }'>
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 14pt;  width: 240px;'><img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board' style='width: 15px; padding-bottom: 3px; margin-right: 10px;' />과학 / 공학 / 수학 / 컴퓨터</span>
							<span id='toBoardList'  style='position: absolute; top: 27%; left: 248px; color: #898989; font-size: 6pt; text-align: center; border: 1px solid #898989; border-radius: 10px; padding: 1px 3px 1px 3px;'>글목록</span>
							<span class='toBoardWritePage'  style='position: absolute; top: 27%; left: 298px; color: #898989; font-size: 6pt; text-align: center; border: 1px solid #898989; border-radius: 10px; padding: 1px 3px 1px 3px;'>글쓰기</span>
							<select class='form-control' id='changeCategoryInBoardPage' style='position: absolute; top: 20%; right: 0; font-size: 8pt; width: 24%; height: 29px;'>
								<option value='1'>인문/사회/정치</option>
								<option value='2'>경제/경영</option>
								<option value='3' selected>과학/공학/수학/컴퓨터</option>
								<option value='4'>문학/시/소설</option>
								<option value='5'>문화/예술/자기계발/라이프</option>
							</select>
						</c:when>
						<c:when test='${requestScope.category == 4 }'>
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 14pt;  width: 150px;'><img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board' style='width: 15px; padding-bottom: 3px; margin-right: 10px;' />문학 / 시 / 소설</span>
							<span id='toBoardList'  style='position: absolute; top: 27%; left: 158px; color: #898989; font-size: 6pt; text-align: center; border: 1px solid #898989; border-radius: 10px; padding: 1px 3px 1px 3px;'>글목록</span>
							<span class='toBoardWritePage'  style='position: absolute; top: 27%; left: 208px; color: #898989; font-size: 6pt; text-align: center; border: 1px solid #898989; border-radius: 10px; padding: 1px 3px 1px 3px;'>글쓰기</span>
							<select class='form-control' id='changeCategoryInBoardPage' style='position: absolute; top: 20%; right: 0; font-size: 8pt; width: 17%; height: 29px;'>
								<option value='1'>인문/사회/정치</option>
								<option value='2'>경제/경영</option>
								<option value='3'>과학/공학/수학/컴퓨터</option>
								<option value='4' selected>문학/시/소설</option>
								<option value='5'>문화/예술/자기계발/라이프</option>
							</select>
						</c:when>
						<c:when test='${requestScope.category == 5 }'>
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 14pt;  width: 310px;'><img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board' style='width: 15px; padding-bottom: 3px; margin-right: 10px;' />문화 / 예술 / 자기계발 / 라이프</span>
							<span id='toBoardList'  style='position: absolute; top: 27%; left: 280px; color: #898989; font-size: 6pt; text-align: center; border: 1px solid #898989; border-radius: 10px; padding: 1px 3px 1px 3px;'>글목록</span>
							<span class='toBoardWritePage'  style='position: absolute; top: 27%; left: 330px; color: #898989; font-size: 6pt; text-align: center; border: 1px solid #898989; border-radius: 10px; padding: 1px 3px 1px 3px;'>글쓰기</span>
							<select class='form-control' id='changeCategoryInBoardPage' style='position: absolute; top: 20%; right: 0; font-size: 8pt; width: 27%; height: 29px;'>
								<option value='1'>인문/사회/정치</option>
								<option value='2'>경제/경영</option>
								<option value='3'>과학/공학/수학/컴퓨터</option>
								<option value='4'>문학/시/소설</option>
								<option value='5' selected>문화/예술/자기계발/라이프</option>
							</select>
						</c:when>
						<c:otherwise>
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 14pt;  width: 180px;'><img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board' style='width: 15px; padding-bottom: 3px; margin-right: 10px;' />인문 / 사회 / 정치</span>
							<span id='toBoardList'  style='position: absolute; top: 27%; left: 180px; color: #898989; font-size: 6pt; text-align: center; border: 1px solid #898989; border-radius: 10px; padding: 1px 3px 1px 3px;'>글목록</span>
							<span class='toBoardWritePage'  style='position: absolute; top: 27%; left: 230px; color: #898989; font-size: 6pt; text-align: center; border: 1px solid #898989; border-radius: 10px; padding: 1px 3px 1px 3px;'>글쓰기</span>
							<select class='form-control' id='changeCategoryInBoardPage' style='position: absolute; top: 20%; right: 0; font-size: 8pt; width: 18%; height: 29px;'>
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
				<br/><br/><br/>
				
				<div class='container' id='boardPreViewHit'>
					<c:choose>
						<c:when test='${fn:length(boardListHit) > 5 }'> <!-- 게시글이 일골 개 이상일 때 -->
							<div style='height: 280px; background-color: #fff; border-radius: 10px; /* border: 1px solid black; */'>
								<div class='container' style='position: relative; height: 90px;'>
									<div class='boardSerialPreview' style='position: absolute; top: 0; left: 0; width: 30px; height: 50px; display: none'>${boardListHit[0].serial }</div>
									<div style='position: absolute; top: 0; left: 30px;'>
										<c:choose>
											<c:when test='${boardListHit[0].isBlocked == 0 }'>
												<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${boardListHit[0].title }<p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${boardListHit[0].commentCnt }]</p><span style='display: none;'>${boardListHit[0].serial }</span></div><br/>
											</c:when>
											<c:when test='${boardListHit[0].isBlocked == 1 }'>
												<div class='boardTitlePreview' style='display: inline-block; color: #bb3434; font-size: 16pt; margin-bottom: 10px;'>신고에 의해 블럭 처리된 게시글입니다<span style='display: none;'>${boardListHit[0].serial }</span></div><br/>
											</c:when>
										</c:choose>
										<span style='font-size: 10pt; color: #ababab;'>by&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${boardListHit[0].userId }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>book&nbsp;&nbsp;</span><div class='bookTitlePreview' style='display: inline-block; font-size: 10pt; color: #676767;' data-toggle="tooltip" data-placement="right" title="${boardListHit[0].title_kor }(${boardListHit[0].pDate }) / ${boardListHit[0].author }">${boardListHit[0].title_kor }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>views&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${boardListHit[0].hit }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>up&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${boardListHit[0].thumbUpCnt }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>when&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${boardListHit[0].bDate }</div>
									</div>
								</div>
								<div class='container' style='display: inline-block; float: left; padding: 30px 30px 0 30px;'>
									<img src='${boardListHit[0].coverImg }' alt="${boardListHit[0].title_kor } img" style='float: left; width: 80px; height: 100px; border-radius: 20px; margin-right: 20px;' />
									<c:choose>
										<c:when test='${fn:length(boardListHit[0].content) > 150 }'>
											<%-- 개행 문자열 치환 ("<br/>" to "\n")
											<%
												String content = ((BoardVo) ((List<BoardVo>) request.getAttribute("boardListHit")).get(0)).getContent();
												content = content.replaceAll("<br/>", "\n");
											%>
											<textarea cols="50" rows='30'><%=content %></textarea>
											 --%>
											<p>${fn:substring(boardListHit[0].content, 0, 149) } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${boardListHit[0].serial }</span></span></p>
										</c:when>
										<c:otherwise>
											<p>${boardListHit[0].content } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${boardListHit[0].serial }</span></span></p>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<c:forEach var='bvo' begin='1' end='2' step='1' items='${boardListHit }'>
								<br/><br/><br/><hr style='border: 1px solid #cfcfcf;'/><br/><br/><br/><br/><br/>
								
								<div style='height: 280px; background-color: #fff; border-radius: 10px; /* border: 1px solid black; */'>
									<div class='container' style='position: relative; height: 90px;'>
										<div class='boardSerialPreview' style='position: absolute; top: 0; left: 0; width: 30px; height: 50px; display: none'>${bvo.serial }</div>
										<div style='position: absolute; top: 0; left: 30px;'>
											<c:choose>
												<c:when test='${bvo.isBlocked == 0 }'>
													<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${bvo.title }<p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${bvo.commentCnt }]</p><span style='display: none;'>${bvo.serial }</span></div><br/>
												</c:when>
												<c:when test='${bvo.isBlocked == 1 }'>
													<div class='boardTitlePreview' style='display: inline-block; color: #bb3434; font-size: 16pt; margin-bottom: 10px;'>신고에 의해 블럭 처리된 게시글입니다<span style='display: none;'>${bvo.serial }</span></div><br/>
												</c:when>
											</c:choose>
											<span style='font-size: 10pt; color: #ababab;'>by&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.userId }</div>&nbsp;&nbsp;
											<span style='font-size: 10pt; color: #ababab;'>book&nbsp;&nbsp;</span><div class='bookTitlePreview' style='display: inline-block; font-size: 10pt; color: #676767;' data-toggle="tooltip" data-placement="right" title="${bvo.title_kor }(${bvo.pDate }) / ${bvo.author }">${bvo.title_kor }</div>&nbsp;&nbsp;
											<span style='font-size: 10pt; color: #ababab;'>views&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.hit }</div>&nbsp;&nbsp;
											<span style='font-size: 10pt; color: #ababab;'>up&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.thumbUpCnt }</div>&nbsp;&nbsp;
											<span style='font-size: 10pt; color: #ababab;'>when&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.bDate }</div>
										</div>
									</div>
									<div class='container' style='display: inline-block; float: left; padding: 30px 30px 0 30px;'>
										<img src='${bvo.coverImg }' alt="${bvo.title_kor } img" style='float: left; width: 80p; height: 100px; margin-right: 20px; border-radius: 20px;' />
										<c:choose>
											<c:when test='${fn:length(bvo.content) > 150 }'>
												<p>${fn:substring(bvo.content, 0, 149) } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${bvo.serial }</span></span></p>
											</c:when>
											<c:otherwise>
												<p>${bvo.content } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${bvo.serial }</span></span></p>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</c:forEach>
							
							<div id='more1Container'>
								<br/><br/><br/><br/>
								<div class='container' style='text-align: center;'>
									<div class='myBtn' id='more1' style='display: inline-block;'>더보기</div>
								</div>
								
								<br/>
								<hr style='border-top: 3px double #8c8b8b;'/>
								<br/><br/>
							</div>
								
							<div id='thebogi1' style='display: none;'>
								<c:forEach var='bvo' begin='3' end='5' step='1' items='${boardListHit }'>
									<br/><br/><br/><hr style='border: 1px solid #cfcfcf;'/><br/><br/><br/><br/><br/>
									
									<div style='height: 280px; background-color: #fff; border-radius: 10px; /* border: 1px solid black; */'>
										<div class='container' style='position: relative; height: 90px;'>
											<div class='boardSerialPreview' style='position: absolute; top: 0; left: 0; width: 30px; height: 50px; display: none'>${bvo.serial }</div>
											<div style='position: absolute; top: 0; left: 30px;'>
												<c:choose>
													<c:when test='${bvo.isBlocked == 0 }'>
														<c:choose>
															<c:when test='${fn:length(bvo.title) < 35 }'>
																<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${bvo.title }<p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${bvo.commentCnt }]</p><span style='display: none;'>${bvo.serial }</span></div><br/>
															</c:when>
															<c:otherwise>
																<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${fn:substring(bvo.title, 0, 34) }  ... <p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${bvo.commentCnt }]</p><span style='display: none;'>${bvo.serial }</span><span style='display: none;'>${bvo.serial }</span></div><br/>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:when test='${bvo.isBlocked == 1 }'>
														<div class='boardTitlePreview' style='display: inline-block; color: #bb3434; font-size: 16pt; margin-bottom: 10px;'>신고에 의해 블럭 처리된 게시글입니다<span style='display: none;'>${bvo.serial }</span></div><br/>
													</c:when>
												</c:choose>
												<span style='font-size: 10pt; color: #ababab;'>by&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.userId }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>book&nbsp;&nbsp;</span><div class='bookTitlePreview' style='display: inline-block; font-size: 10pt; color: #676767;' data-toggle="tooltip" data-placement="right" title="${bvo.title_kor }(${bvo.pDate }) / ${bvo.author }">${bvo.title_kor }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>views&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.hit }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>up&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.thumbUpCnt }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>when&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.bDate }</div>
											</div>
										</div>
										<div class='container' style='display: inline-block; float: left; padding: 30px 30px 0 30px;'>
											<img src='${bvo.coverImg }' alt="${bvo.title_kor } img" style='float: left; width: 80p; height: 100px; margin-right: 20px; border-radius: 20px;' />
											<c:choose>
												<c:when test='${fn:length(bvo.content) > 150 }'>
													<p>${fn:substring(bvo.content, 0, 149) } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${bvo.serial }</span></span></p>
												</c:when>
												<c:otherwise>
													<p>${bvo.content } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${bvo.serial }</span></span></p>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</c:forEach>
								
								<div id='more2Container'>
									<br/><br/><br/><br/>
									<div class='container' style='text-align: center;'>
										<div class='myBtn' id='more2' style='display: inline-block;'>더보기</div>
									</div>
								
									<br/>
									<hr style='border-top: 3px double #8c8b8b;'/>
									<br/><br/>
								</div>
							</div>
							
							<div id='thebogi2' style='display: none;'>
								<c:forEach var='bvo' begin='6' end='8' step='1' items='${boardListHit }'>
									<br/><br/><br/><hr style='border: 1px solid #cfcfcf;'/><br/><br/><br/><br/><br/>
									
									<div style='height: 280px; background-color: #fff; border-radius: 10px; /* border: 1px solid black; */'>
										<div class='container' style='position: relative; height: 90px;'>
											<div class='boardSerialPreview' style='position: absolute; top: 0; left: 0; width: 30px; height: 50px; display: none'>${bvo.serial }</div>
											<div style='position: absolute; top: 0; left: 30px;'>
												<c:choose>
													<c:when test='${bvo.isBlocked == 0 }'>
														<c:choose>
															<c:when test='${fn:length(bvo.title) < 35 }'>
																<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${bvo.title }<p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${bvo.commentCnt }]</p><span style='display: none;'>${bvo.serial }</span></div><br/>
															</c:when>
															<c:otherwise>
																<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${fn:substring(bvo.title, 0, 34) }  ... <p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${bvo.commentCnt }]</p><span style='display: none;'>${bvo.serial }</span><span style='display: none;'>${bvo.serial }</span></div><br/>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:when test='${bvo.isBlocked == 1 }'>
														<div class='boardTitlePreview' style='display: inline-block; color: #bb3434; font-size: 16pt; margin-bottom: 10px;'>신고에 의해 블럭 처리된 게시글입니다<span style='display: none;'>${bvo.serial }</span></div><br/>
													</c:when>
												</c:choose>
												<span style='font-size: 10pt; color: #ababab;'>by&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.userId }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>book&nbsp;&nbsp;</span><div class='bookTitlePreview' style='display: inline-block; font-size: 10pt; color: #676767;' data-toggle="tooltip" data-placement="right" title="${bvo.title_kor }(${bvo.pDate }) / ${bvo.author }">${bvo.title_kor }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>views&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.hit }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>up&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.thumbUpCnt }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>when&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.bDate }</div>
											</div>
										</div>
										<div class='container' style='display: inline-block; float: left; padding: 30px 30px 0 30px;'>
											<img src='${bvo.coverImg }' alt="${bvo.title_kor } img" style='float: left; width: 80p; height: 100px; margin-right: 20px; border-radius: 20px;' />
											<c:choose>
												<c:when test='${fn:length(bvo.content) > 150 }'>
													<p>${fn:substring(bvo.content, 0, 149) } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${bvo.serial }</span></span></p>
												</c:when>
												<c:otherwise>
													<p>${bvo.content } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${bvo.serial }</span></span></p>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</c:forEach>
								
								<div id='more3Container'>
									<br/><br/><br/><br/>
									<div class='container' style='text-align: center;'>
										<div class='myBtn' id='more3' style='display: inline-block;'>더보기</div>
									</div>
									
									<br/>
									<hr style='border-top: 3px double #8c8b8b;'/>
									<br/><br/>
								</div>
							</div>
							
							<div id='thebogi3' style='display: none;'>
								<c:forEach var='bvo' begin='9' end='11' step='1' items='${boardListHit }'>
									<br/><br/><br/><hr style='border: 1px solid #cfcfcf;'/><br/><br/><br/><br/><br/>
									
									<div style='height: 280px; background-color: #fff; border-radius: 10px; /* border: 1px solid black; */'>
										<div class='container' style='position: relative; height: 90px;'>
											<div class='boardSerialPreview' style='position: absolute; top: 0; left: 0; width: 30px; height: 50px; display: none'>${bvo.serial }</div>
											<div style='position: absolute; top: 0; left: 30px;'>
												<c:choose>
													<c:when test='${bvo.isBlocked == 0 }'>
														<c:choose>
															<c:when test='${fn:length(bvo.title) < 35 }'>
																<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${bvo.title }<p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${bvo.commentCnt }]</p><span style='display: none;'>${bvo.serial }</span></div><br/>
															</c:when>
															<c:otherwise>
																<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${fn:substring(bvo.title, 0, 34) }  ... <p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${bvo.commentCnt }]</p><span style='display: none;'>${bvo.serial }</span><span style='display: none;'>${bvo.serial }</span></div><br/>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:when test='${bvo.isBlocked == 1 }'>
														<div class='boardTitlePreview' style='display: inline-block; color: #bb3434; font-size: 16pt; margin-bottom: 10px;'>신고에 의해 블럭 처리된 게시글입니다<span style='display: none;'>${bvo.serial }</span></div><br/>
													</c:when>
												</c:choose>
												<span style='font-size: 10pt; color: #ababab;'>by&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.userId }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>book&nbsp;&nbsp;</span><div class='bookTitlePreview' style='display: inline-block; font-size: 10pt; color: #676767;' data-toggle="tooltip" data-placement="right" title="${bvo.title_kor }(${bvo.pDate }) / ${bvo.author }">${bvo.title_kor }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>views&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.hit }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>up&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.thumbUpCnt }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>when&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.bDate }</div>
											</div>
										</div>
										<div class='container' style='display: inline-block; float: left; padding: 30px 30px 0 30px;'>
											<img src='${bvo.coverImg }' alt="${bvo.title_kor } img" style='float: left; width: 80p; height: 100px; margin-right: 20px; border-radius: 20px;' />
											<c:choose>
												<c:when test='${fn:length(bvo.content) > 150 }'>
													<p>${fn:substring(bvo.content, 0, 149) } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${bvo.serial }</span></span></p>
												</c:when>
												<c:otherwise>
													<p>${bvo.content } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${bvo.serial }</span></span></p>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</c:forEach>
								
								<div id='more4Container'>
									<br/><br/><br/><br/>
									<div class='container' style='text-align: center;'>
										<div class='myBtn' id='more4' style='display: inline-block;'>더보기</div>
									</div>
									
									<br/>
									<hr style='border-top: 3px double #8c8b8b;'/>
									<br/><br/>
								</div>
							</div>
							
							<div id='thebogi4' style='display: none;'>
								<c:forEach var='bvo' begin='12' end='${fn:length(boardListHit) - 1 }' step='1' items='${boardListHit }'>
									<br/><br/><br/><hr style='border: 1px solid #cfcfcf;'/><br/><br/><br/><br/><br/>
									
									<div style='height: 280px; background-color: #fff; border-radius: 10px; /* border: 1px solid black; */'>
										<div class='container' style='position: relative; height: 90px;'>
											<div class='boardSerialPreview' style='position: absolute; top: 0; left: 0; width: 30px; height: 50px; display: none'>${bvo.serial }</div>
											<div style='position: absolute; top: 0; left: 30px;'>
												<c:choose>
													<c:when test='${bvo.isBlocked == 0 }'>
														<c:choose>
															<c:when test='${fn:length(bvo.title) < 35 }'>
																<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${bvo.title }<p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${bvo.commentCnt }]</p><span style='display: none;'>${bvo.serial }</span></div><br/>
															</c:when>
															<c:otherwise>
																<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${fn:substring(bvo.title, 0, 34) }  ... <p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${bvo.commentCnt }]</p><span style='display: none;'>${bvo.serial }</span><span style='display: none;'>${bvo.serial }</span></div><br/>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:when test='${bvo.isBlocked == 1 }'>
														<div class='boardTitlePreview' style='display: inline-block; color: #bb3434; font-size: 16pt; margin-bottom: 10px;'>신고에 의해 블럭 처리된 게시글입니다<span style='display: none;'>${bvo.serial }</span></div><br/>
													</c:when>
												</c:choose>
												<span style='font-size: 10pt; color: #ababab;'>by&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.userId }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>book&nbsp;&nbsp;</span><div class='bookTitlePreview' style='display: inline-block; font-size: 10pt; color: #676767;' data-toggle="tooltip" data-placement="right" title="${bvo.title_kor }(${bvo.pDate }) / ${bvo.author }">${bvo.title_kor }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>views&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.hit }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>up&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.thumbUpCnt }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>when&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.bDate }</div>
											</div>
										</div>
										<div class='container' style='display: inline-block; float: left; padding: 30px 30px 0 30px;'>
											<img src='${bvo.coverImg }' alt="${bvo.title_kor } img" style='float: left; width: 80p; height: 100px; margin-right: 20px; border-radius: 20px;' />
											<c:choose>
												<c:when test='${fn:length(bvo.content) > 150 }'>
													<p>${fn:substring(bvo.content, 0, 149) } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${bvo.serial }</span></span></p>
												</c:when>
												<c:otherwise>
													<p>${bvo.content } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${bvo.serial }</span></span></p>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</c:forEach>
								
								<br/>
								<hr style='border-top: 3px double #8c8b8b;'/>
								<br/><br/>
							</div>
						</c:when>
						<c:when test='${fn:length(boardListHit) > 2 and fn:length(boardListHit) <= 5 }'> <!-- 게시글이 세 개에서 여섯 개 사이일 때 -->
							<div style='height: 280px; background-color: #fff; border-radius: 10px; /* border: 1px solid black; */'>
								<div class='container' style='position: relative; height: 90px;'>
									<div class='boardSerialPreview' style='position: absolute; top: 0; left: 0; width: 30px; height: 50px; display: none'>${boardListHit[0].serial }</div>
									<div style='position: absolute; top: 0; left: 30px;'>
										<c:choose>
											<c:when test='${boardListHit[0].isBlocked == 0 }'>
												<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${boardListHit[0].title }<p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${boardListHit[0].commentCnt }]</p><span style='display: none;'>${boardListHit[0].serial }</span></div><br/>
											</c:when>
											<c:when test='${boardListHit[0].isBlocked == 1 }'>
												<div class='boardTitlePreview' style='display: inline-block; color: #bb3434; font-size: 16pt; margin-bottom: 10px;'>신고에 의해 블럭 처리된 게시글입니다<span style='display: none;'>${boardListHit[0].serial }</span></div><br/>
											</c:when>
										</c:choose>
										<span style='font-size: 10pt; color: #ababab;'>by&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${boardListHit[0].userId }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>book&nbsp;&nbsp;</span><div class='bookTitlePreview' style='display: inline-block; font-size: 10pt; color: #676767;' data-toggle="tooltip" data-placement="right" title="${boardListHit[0].title_kor }(${boardListHit[0].pDate }) / ${boardListHit[0].author }">${boardListHit[0].title_kor }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>views&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${boardListHit[0].hit }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>up&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${boardListHit[0].thumbUpCnt }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>when&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${boardListHit[0].bDate }</div>
									</div>
								</div>
								<div class='container' style='display: inline-block; float: left; padding: 30px 30px 0 30px;'>
									<img src='${boardListHit[0].coverImg }' alt="${boardListHit[0].title_kor } img" style='float: left; width: 80px; height: 100px; border-radius: 20px; margin-right: 20px;' />
									<c:choose>
										<c:when test='${fn:length(boardListHit[0].content) > 150 }'>
											<%-- 개행 문자열 치환 ("<br/>" to "\n")
											<%
												String content = ((BoardVo) ((List<BoardVo>) request.getAttribute("boardListHit")).get(0)).getContent();
												content = content.replaceAll("<br/>", "\n");
											%>
											<textarea cols="50" rows='30'><%=content %></textarea>
											 --%>
											<p>${fn:substring(boardListHit[0].content, 0, 149) } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${boardListHit[0].serial }</span></span></p>
										</c:when>
										<c:otherwise>
											<p>${boardListHit[0].content } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${boardListHit[0].serial }</span></span></p>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<c:forEach var='bvo' begin='1' end='2' step='1' items='${boardListHit }'>
								<br/><br/><br/><hr style='border: 1px solid #cfcfcf;'/><br/><br/><br/><br/><br/>
								
								<div style='height: 280px; background-color: #fff; border-radius: 10px; /* border: 1px solid black; */'>
									<div class='container' style='position: relative; height: 90px;'>
										<div class='boardSerialPreview' style='position: absolute; top: 0; left: 0; width: 30px; height: 50px; display: none'>${bvo.serial }</div>
										<div style='position: absolute; top: 0; left: 30px;'>
											<c:choose>
												<c:when test='${bvo.isBlocked == 0 }'>
													<c:choose>
														<c:when test='${fn:length(bvo.title) < 35 }'>
															<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${bvo.title }<p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${bvo.commentCnt }]</p><span style='display: none;'>${bvo.serial }</span></div><br/>
														</c:when>
														<c:otherwise>
															<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${fn:substring(bvo.title, 0, 34) }  ... <p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${bvo.commentCnt }]</p><span style='display: none;'>${bvo.serial }</span><span style='display: none;'>${bvo.serial }</span></div><br/>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:when test='${bvo.isBlocked == 1 }'>
													<div class='boardTitlePreview' style='display: inline-block; color: #bb3434; font-size: 16pt; margin-bottom: 10px;'>신고에 의해 블럭 처리된 게시글입니다<span style='display: none;'>${bvo.serial }</span></div><br/>
												</c:when>
											</c:choose>
											<span style='font-size: 10pt; color: #ababab;'>by&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.userId }</div>&nbsp;&nbsp;
											<span style='font-size: 10pt; color: #ababab;'>book&nbsp;&nbsp;</span><div class='bookTitlePreview' style='display: inline-block; font-size: 10pt; color: #676767;' data-toggle="tooltip" data-placement="right" title="${bvo.title_kor }(${bvo.pDate }) / ${bvo.author }">${bvo.title_kor }</div>&nbsp;&nbsp;
											<span style='font-size: 10pt; color: #ababab;'>views&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.hit }</div>&nbsp;&nbsp;
											<span style='font-size: 10pt; color: #ababab;'>up&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.thumbUpCnt }</div>&nbsp;&nbsp;
											<span style='font-size: 10pt; color: #ababab;'>when&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.bDate }</div>
										</div>
									</div>
									<div class='container' style='display: inline-block; float: left; padding: 30px 30px 0 30px;'>
										<img src='${bvo.coverImg }' alt="${bvo.title_kor } img" style='float: left; width: 80p; height: 100px; margin-right: 20px; border-radius: 20px;' />
										<c:choose>
											<c:when test='${fn:length(bvo.content) > 150 }'>
												<p>${fn:substring(bvo.content, 0, 149) } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${bvo.serial }</span></span></p>
											</c:when>
											<c:otherwise>
												<p>${bvo.content } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${bvo.serial }</span></span></p>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</c:forEach>
							
							<div id='more1Container'>
								<br/><br/><br/><br/>
								<div class='container' style='text-align: center;'>
									<div class='myBtn' id='more1' style='display: inline-block;'>더보기</div>
								</div>
								
								<br/>
								<hr style='border-top: 3px double #8c8b8b;'/>
								<br/><br/>
							</div>
								
							<div id='thebogi1' style='display: none;'>
								<c:forEach var='bvo' begin='3' end='${fn:length(boardListHit) - 1 }' step='1' items='${boardListHit }'>
									<br/><br/><br/><hr style='border: 1px solid #cfcfcf;'/><br/><br/><br/><br/><br/>
									
									<div style='height: 280px; background-color: #fff; border-radius: 10px; /* border: 1px solid black; */'>
										<div class='container' style='position: relative; height: 90px;'>
											<div class='boardSerialPreview' style='position: absolute; top: 0; left: 0; width: 30px; height: 50px; display: none'>${bvo.serial }</div>
											<div style='position: absolute; top: 0; left: 30px;'>
												<c:choose>
													<c:when test='${bvo.isBlocked == 0 }'>
														<c:choose>
															<c:when test='${fn:length(bvo.title) < 35 }'>
																<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${bvo.title }<p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${bvo.commentCnt }]</p><span style='display: none;'>${bvo.serial }</span></div><br/>
															</c:when>
															<c:otherwise>
																<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${fn:substring(bvo.title, 0, 34) }  ... <p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${bvo.commentCnt }]</p><span style='display: none;'>${bvo.serial }</span><span style='display: none;'>${bvo.serial }</span></div><br/>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:when test='${bvo.isBlocked == 1 }'>
														<div class='boardTitlePreview' style='display: inline-block; color: #bb3434; font-size: 16pt; margin-bottom: 10px;'>신고에 의해 블럭 처리된 게시글입니다<span style='display: none;'>${bvo.serial }</span></div><br/>
													</c:when>
												</c:choose>
												<span style='font-size: 10pt; color: #ababab;'>by&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.userId }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>book&nbsp;&nbsp;</span><div class='bookTitlePreview' style='display: inline-block; font-size: 10pt; color: #676767;' data-toggle="tooltip" data-placement="right" title="${bvo.title_kor }(${bvo.pDate }) / ${bvo.author }">${bvo.title_kor }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>views&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.hit }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>up&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.thumbUpCnt }</div>&nbsp;&nbsp;
												<span style='font-size: 10pt; color: #ababab;'>when&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.bDate }</div>
											</div>
										</div>
										<div class='container' style='display: inline-block; float: left; padding: 30px 30px 0 30px;'>
											<img src='${bvo.coverImg }' alt="${bvo.title_kor } img" style='float: left; width: 80p; height: 100px; margin-right: 20px; border-radius: 20px;' />
											<c:choose>
												<c:when test='${fn:length(bvo.content) > 150 }'>
													<p>${fn:substring(bvo.content, 0, 149) } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${bvo.serial }</span></span></p>
												</c:when>
												<c:otherwise>
													<p>${bvo.content } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${bvo.serial }</span></span></p>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</c:forEach>
								
								<br/><br/><br/>
								<hr style='border-top: 3px double #8c8b8b;'/>
								<br/><br/>
							</div>
						</c:when>
						<c:when test='${fn:length(boardListHit) == 2 }'> <!-- 게시글이 두 개일 때 -->
							<div style='height: 280px; background-color: #fff; border-radius: 10px; /* border: 1px solid black; */'>
								<div class='container' style='position: relative; height: 90px;'>
									<div class='boardSerialPreview' style='position: absolute; top: 0; left: 0; width: 30px; height: 50px; display: none'>${boardListHit[0].serial }</div>
									<div style='position: absolute; top: 0; left: 30px;'>
										<c:choose>
											<c:when test='${boardListHit[0].isBlocked == 0 }'>
												<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${boardListHit[0].title }<p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${boardListHit[0].commentCnt }]</p><span style='display: none;'>${boardListHit[0].serial }</span></div><br/>
											</c:when>
											<c:when test='${boardListHit[0].isBlocked == 1 }'>
												<div class='boardTitlePreview' style='display: inline-block; color: #bb3434; font-size: 16pt; margin-bottom: 10px;'>신고에 의해 블럭 처리된 게시글입니다<span style='display: none;'>${boardListHit[0].serial }</span></div><br/>
											</c:when>
										</c:choose>
										<span style='font-size: 10pt; color: #ababab;'>by&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${boardListHit[0].userId }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>book&nbsp;&nbsp;</span><div class='bookTitlePreview' style='display: inline-block; font-size: 10pt; color: #676767;' data-toggle="tooltip" data-placement="right" title="${boardListHit[0].title_kor }(${boardListHit[0].pDate }) / ${boardListHit[0].author }">${boardListHit[0].title_kor }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>views&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${boardListHit[0].hit }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>up&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${boardListHit[0].thumbUpCnt }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>when&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${boardListHit[0].bDate }</div>
									</div>
								</div>
								<div class='container' style='display: inline-block; float: left; padding: 30px 30px 0 30px;'>
									<img src='${boardListHit[0].coverImg }' alt="${boardListHit[0].title_kor } img" style='float: left; width: 80px; height: 100px; border-radius: 20px; margin-right: 20px;' />
									<c:choose>
										<c:when test='${fn:length(boardListHit[0].content) > 150 }'>
											<%-- 개행 문자열 치환 ("<br/>" to "\n")
											<%
												String content = ((BoardVo) ((List<BoardVo>) request.getAttribute("boardListHit")).get(0)).getContent();
												content = content.replaceAll("<br/>", "\n");
											%>
											<textarea cols="50" rows='30'><%=content %></textarea>
											 --%>
											<p>${fn:substring(boardListHit[0].content, 0, 149) } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${boardListHit[0].serial }</span></span></p>
										</c:when>
										<c:otherwise>
											<p>${boardListHit[0].content } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${boardListHit[0].serial }</span></span></p>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							
							<br/><br/><br/><hr style='border: 1px solid #cfcfcf;'/><br/><br/><br/><br/><br/>
							
							<div style='height: 280px; background-color: #fff; border-radius: 10px; /* border: 1px solid black; */'>
								<div class='container' style='position: relative; height: 90px;'>
									<div class='boardSerialPreview' style='position: absolute; top: 0; left: 0; width: 30px; height: 50px; display: none'>${bvo.serial }</div>
									<div style='position: absolute; top: 0; left: 30px;'>
										<c:choose>
											<c:when test='${bvo.isBlocked == 0 }'>
												<c:choose>
													<c:when test='${fn:length(bvo.title) < 35 }'>
														<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${bvo.title }<p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${bvo.commentCnt }]</p><span style='display: none;'>${bvo.serial }</span></div><br/>
													</c:when>
													<c:otherwise>
														<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${fn:substring(bvo.title, 0, 34) }  ... <p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${bvo.commentCnt }]</p><span style='display: none;'>${bvo.serial }</span><span style='display: none;'>${bvo.serial }</span></div><br/>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:when test='${bvo.isBlocked == 1 }'>
												<div class='boardTitlePreview' style='display: inline-block; color: #bb3434; font-size: 16pt; margin-bottom: 10px;'>신고에 의해 블럭 처리된 게시글입니다<span style='display: none;'>${bvo.serial }</span></div><br/>
											</c:when>
										</c:choose>
										<span style='font-size: 10pt; color: #ababab;'>by&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.userId }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>book&nbsp;&nbsp;</span><div class='bookTitlePreview' style='display: inline-block; font-size: 10pt; color: #676767;' data-toggle="tooltip" data-placement="right" title="${bvo.title_kor }(${bvo.pDate }) / ${bvo.author }">${bvo.title_kor }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>views&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.hit }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>up&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.thumbUpCnt }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>when&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.bDate }</div>
									</div>
								</div>
								<div class='container' style='display: inline-block; float: left; padding: 30px 30px 0 30px;'>
									<img src='${bvo.coverImg }' alt="${bvo.title_kor } img" style='float: left; width: 80p; height: 100px; margin-right: 20px; border-radius: 20px;' />
									<c:choose>
										<c:when test='${fn:length(bvo.content) > 150 }'>
											<p>${fn:substring(bvo.content, 0, 149) } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${bvo.serial }</span></span></p>
										</c:when>
										<c:otherwise>
											<p>${bvo.content } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${bvo.serial }</span></span></p>
										</c:otherwise>
									</c:choose>
								</div>
							</div><br/>
							<hr style='border-top: 3px double #8c8b8b;'/>
							<br/><br/>
						</c:when>
						<c:when test='${fn:length(boardListHit) == 1 }'> <!-- 게시글이 한 개일 때 -->
							<div style='height: 280px; background-color: #fff; border-radius: 10px; /* border: 1px solid black; */'>
								<div class='container' style='position: relative; height: 90px;'>
									<div class='boardSerialPreview' style='position: absolute; top: 0; left: 0; width: 30px; height: 50px; display: none'>${boardListHit[0].serial }</div>
									<div style='position: absolute; top: 0; left: 30px;'>
										<c:choose>
											<c:when test='${boardListHit[0].isBlocked == 0 }'>
												<div class='boardTitlePreview' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${boardListHit[0].title }<p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${boardListHit[0].commentCnt }]</p><span style='display: none;'>${boardListHit[0].serial }</span></div><br/>
											</c:when>
											<c:when test='${boardListHit[0].isBlocked == 1 }'>
												<div class='boardTitlePreview' style='display: inline-block; color: #bb3434; font-size: 16pt; margin-bottom: 10px;'>신고에 의해 블럭 처리된 게시글입니다<span style='display: none;'>${boardListHit[0].serial }</span></div><br/>
											</c:when>
										</c:choose>
										<span style='font-size: 10pt; color: #ababab;'>by&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${boardListHit[0].userId }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>book&nbsp;&nbsp;</span><div class='bookTitlePreview' style='display: inline-block; font-size: 10pt; color: #676767;' data-toggle="tooltip" data-placement="right" title="${boardListHit[0].title_kor }(${boardListHit[0].pDate }) / ${boardListHit[0].author }">${boardListHit[0].title_kor }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>views&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${boardListHit[0].hit }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>up&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${boardListHit[0].thumbUpCnt }</div>&nbsp;&nbsp;
										<span style='font-size: 10pt; color: #ababab;'>when&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${boardListHit[0].bDate }</div>
									</div>
								</div>
								<div class='container' style='display: inline-block; float: left; padding: 30px 30px 0 30px;'>
									<img src='${boardListHit[0].coverImg }' alt="${boardListHit[0].title_kor } img" style='float: left; width: 80px; height: 100px; border-radius: 20px; margin-right: 20px;' />
									<c:choose>
										<c:when test='${fn:length(boardListHit[0].content) > 150 }'>
											<%-- 개행 문자열 치환 ("<br/>" to "\n")
											<%
												String content = ((BoardVo) ((List<BoardVo>) request.getAttribute("boardListHit")).get(0)).getContent();
												content = content.replaceAll("<br/>", "\n");
											%>
											<textarea cols="50" rows='30'><%=content %></textarea>
											 --%>
											<p>${fn:substring(boardListHit[0].content, 0, 149) } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${boardListHit[0].serial }</span></span></p>
										</c:when>
										<c:otherwise>
											<p>${boardListHit[0].content } <span class='boardViewAncMini' data-toggle="tooltip" data-placement="top" title="글 상세보기" > ... <span style='display: none;'>${boardListHit[0].serial }</span></span></p>
										</c:otherwise>
									</c:choose>
								</div>
							</div><br/>
							<hr style='border-top: 3px double #8c8b8b;'/>
							<br/><br/>
						</c:when>
						<c:when test='${fn:length(boardListHit) < 1 }'>
							<div style='height: 180px;'>
								<div id='noSelectResult'>
									<p>검색결과가 없습니다.</p>
									<p>이 카테고리의 첫 리뷰를 남겨주세요!</p>
								</div>
							</div><br/>
							<hr style='border-top: 3px double #8c8b8b;'/>
							<br/><br/>
						</c:when>
					</c:choose>
				</div>
				
				<div id='boardListViewDate'>
					<div style='position: relative; height: 50px;'>
						<span id='categoryContent' style='position: absolute; top: 20%; font-size: 12pt;'>
							<img src='/desktop/resources/imgs/document01.png' alt='icon_pencil for board' style='width: 18px; padding-bottom: 3px; margin-right: 10px;' /> 게시글 목록
						</span>
						<c:if test='${not empty sessionScope.userId and sessionScope != "" }'>
							<a class='btn btn-secondary toBoardWritePage' id='toBoardWritePage' href='#btnBookRegister' style='top: 11px; right: 70px; width: 65px; height: 30px; font-size: 9pt;'>글쓰기</a>
							<a class='btn btn-secondary my-btn-register' id='btnBookRegister' href='#btnBookRegister' style='top: 11px; width: 65px; height: 30px; font-size: 9pt;'>책등록</a>
						</c:if>
					</div>
					<div class='row my-board-row' style='height: 30px; border-top: 2px solid black; padding-top: 4px; background-color: #dedede;'>
						<div class='col-md-1 my-board-grid'>NO</div>
						<div class='col-md-5 my-board-grid-title-top'>제목</div>
						<div class='col-md-1 my-board-grid'>작가</div>
						<div class='col-md-2 my-board-grid'>책제목</div>
						<div class='col-md-1 my-board-grid'>조회</div>
						<div class='col-md-2 my-board-grid'>등록일</div>
					</div>
					<c:forEach var="bvo" items="${boardListDate }" >
						<div class='row my-board-row'>
							<div class='col-md-1 my-board-grid'>${bvo.serial }</div>
							<c:choose>
								<c:when test='${bvo.isBlocked == 0 }'>
									<c:choose>
										<c:when test="${fn:length(bvo.title) < 24 }">
											<div class='col-md-5 my-board-grid-title'>${bvo.title }<c:if test='${bvo.commentCnt > 0 }'><p style='display: inline-block; color: #48baff; font-size: 8pt;'>&nbsp;[${bvo.commentCnt }]</p></c:if><span style='display: none;'>${bvo.serial }</span></div>
										</c:when>
										<c:otherwise>
											<div class='col-md-5 my-board-grid-title' data-toggle="tooltip" data-placement="right" title="${bvo.title }">${fn:substring(bvo.title, 0, 23) }  ... <c:if test='${bvo.commentCnt > 0 }'><p style='display: inline-block; color: #48baff; font-size: 10pt;'>&nbsp;[${bvo.commentCnt }]</p></c:if><span style='display: none;'>${bvo.serial }</span></div>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:when test='${bvo.isBlocked == 1 }'>
									<div class='col-md-5 my-board-grid-title' style='color: #bb3434;'>신고에 의해 블럭된 게시글입니다<span style='display: none;'>${bvo.serial }</span></div>
								</c:when>
							</c:choose>
							<div class='col-md-1 my-board-grid'>${bvo.userId }</div>
							<c:choose>
								<c:when test="${fn:length(bvo.title_kor) < 7 }">
									<div class='col-md-2 my-board-grid-bookTitle' data-toggle="tooltip" data-placement="right" title="[${bvo.title_kor }] / ${bvo.author }">${bvo.title_kor }</div>
								</c:when>
								<c:otherwise>
									<div class='col-md-2 my-board-grid-bookTitle' data-toggle="tooltip" data-placement="right" title="[${bvo.title_kor }] / ${bvo.author }">${fn:substring(bvo.title_kor, 0, 6) }  ... <span style='display: none;'>${bvo.serial }</span></div>
								</c:otherwise>
							</c:choose>
							<div class='col-md-1 my-board-grid'>${bvo.hit }</div>
							<div class='col-md-2 my-board-grid'>${fn:substring(bvo.bDate, 2, 10) }</div>
						</div>
					</c:forEach>
					<div class='container' id='btnBoardChangeGrp' style='height: 46px; font-size: 9pt; text-align: center; margin-top: 30px;'>
						<c:if test='${pageDto.nowPage >= 2 }'>
							<span class='btnBoardView'>처음<span style='display: none;'>1</span></span>
							<span class='btnBoardView'>이전<span style='display: none;'>${pageDto.nowPage - 1 }</span></span>
							<span class='btnBoardViewBar'>|</span>
						</c:if>
						<c:forEach var='i' begin='${pageDto.startPage }' end='${pageDto.endPage }' step='1'>
							<c:choose>
								<c:when test='${pageDto.nowPage == i }'>
									<span class='btnBoardViewNone'>${i }</span>
								</c:when>
								<c:otherwise>
									<span class='btnBoardView'>${i }<span style='display: none;'>${i }</span></span>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test='${pageDto.nowPage < pageDto.totPage }'>
							<span class='btnBoardViewBar'>|</span>
							<span class='btnBoardView'>다음<span style='display: none;'>${pageDto.nowPage + 1 }</span></span>
							<span class='btnBoardView'>마지막<span style='display: none;'>${pageDto.totPage }</span></span>
						</c:if>
					</div>
					<div class='container' id='boardSearchContainer' style='height: 46px; text-align: center; /* border: 1px solid black; */'>
						<form class='form' id='boardListSearchForm' name='boardListSearchForm' action='#' method='post'  style='position: relative; display: inline-block; right: 0; width: 70%;'>
							<select class='form-control' id='searchBySort' name='searchBySort' style='display: inline-block; font-size: 8pt; float: left; width: 18%; height: 29px; margin-right: 3px;'>
								<option value='1' selected="selected">최신순</option>
								<option value='2'>오래된순</option>
								<option value='3'>조회순</option>
								<option value='4'>추천순</option>
							</select>
							<select class='form-control' id='searchByContent' name='searchByContent' style='display: inline-block; font-size: 8pt; float: left; width: 24%; height: 29px;'>
								<option value='1' selected="selected">제목 + 내용</option>
								<option value='2'>제목만</option>
								<option value='3'>내용만</option>
								<option value='4'>작가별</option>
							</select>
							<input type='search' name='searchContent' style='display: inline-block; font-size: 8pt; float: left; width: 45%; height: 25px; margin: 3px 0 0 7px;' />
							<input type='text' name='category' value='${requestScope.category }' style='display: none' />
							<c:choose>
								<c:when test='${not empty pageDto.nowPage }'>
									<input type='text' id='nowPage' name='nowPage' value='${pageDto.nowPage }' style='display: none;' />
								</c:when>
								<c:otherwise>
									<input type='text' id='nowPage' name='nowPage' value='1' style='display: none;' />
								</c:otherwise>
							</c:choose>
							<input id='btnBoardListSearch' type='button' value='검색' style='display: inline-block; font-size: 8pt; float: right; width: 10%; height: 25px; margin-top: 2px;' />
						</form>
					</div><br/><br/>
				</div>
			</div>
		</div>
		<!-- <div class='container' style='height: 40px;'></div> -->
	</div>
	
	<!-- include footer -->
	<footer>
		<jsp:include page="/WEB-INF/views/component/footer.jsp"></jsp:include>
	</footer>
	
	<!-- report icon -->
	<div class='btn btn-secondary' id='reportIcon' style='display: none;'>
		<img src='/desktop/resources/imgs/sample/warning-light02.svg' alt='report icon' style='width: 23px; padding-bottom: 3px;' />
	</div>
		
	<!-- button for to-top -->
	<a class='btn btn-secondary my-btn-toTop' href='#toTop'>top</a>
	
	<!-- Modal -->
    <jsp:include page="/WEB-INF/views/component/modal.jsp"></jsp:include>
	
	<script>funcBoardListPage();</script>
	
</body>
</html>