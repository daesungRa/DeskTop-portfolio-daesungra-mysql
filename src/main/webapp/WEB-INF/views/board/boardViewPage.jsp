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
<title>Board View Page</title>
	<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css' />
	<link rel='stylesheet' href='https://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css'>
	<link rel='stylesheet' href='//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css'/>
	<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css'>
	<link rel='stylesheet' href='/desktop/resources/css/boardViewPage.css' />
	<link rel='stylesheet' href='/desktop/resources/css/component.css' />
	
	<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js'></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js'></script>
	<script src='https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js'></script>
	<script src='https://code.jquery.com/jquery-1.10.2.js'></script>
	<script src='https://code.jquery.com/ui/1.10.4/jquery-ui.js'></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
	<script src='/desktop/resources/js/index.js'></script>
	<script src='/desktop/resources/js/member.js'></script>
	<script src='/desktop/resources/js/boardViewPage.js'></script>
	<script src='/desktop/resources/js/component.js'></script>
</head>
<body style='position: relative; height: 100%; padding-bottom: 200px;'>

	<c:choose>
		<c:when test='${not empty requestScope.boardVo }'>
			<c:set var='bvo' value='${requestScope.boardVo }' scope="page"></c:set>
			<c:set var='commentList' value='${requestScope.commentList }' scope="page"></c:set>
			<c:set var='categoryNum' value='${bvo.category }' scope="page"></c:set>
		</c:when>
		<c:when test='${not empty requestScope.category }'>
			<c:set var='categoryNum' value='${requestScope.category }' scope="page"></c:set>
			<script>alert('조회 정보가 없습니다');location.href = '/desktop/board/boardListPage/' + ${categoryNum} + '/1';</script>
		</c:when>
	</c:choose>

	<!-- include navBar(aside) -->
	<jsp:include page="/WEB-INF/views/component/navBar_aside.jsp"></jsp:include>
	
	<!-- include content -->
	<div id='boardContent' style='z-index: 0;'>
		<button class='btn btn-sm btn-light' id='btnShowNavbar'>&gt;&gt;</button>
		<!-- top -->
		<jsp:include page="/WEB-INF/views/component/top.jsp"></jsp:include>
		
		<!-- middle component -->
		<div class='container'>
			<div class='container' id='boardViewContainer' style='width: 96%; min-height: 1100px; border-right: 1px solid #bfbfbf; border-left: 1px solid #bfbfbf; padding: 20px 120px 20px 120px;'>
				<div style='position: relative; height: 80px;'>
					<div id='saveCategoryNum' style='display: none;'>${categoryNum }</div>
					<c:choose>
						<c:when test='${requestScope.category == 2 }'>
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 14pt;  width: 180px;'><img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board' style='width: 15px; padding-bottom: 3px; margin-right: 10px;' /><span id='titleName'>글보기</span></span>
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
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 14pt;  width: 180px;'><img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board' style='width: 15px; padding-bottom: 3px; margin-right: 10px;' /><span id='titleName'>글보기</span></span>
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
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 14pt;  width: 180px;'><img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board' style='width: 15px; padding-bottom: 3px; margin-right: 10px;' /><span id='titleName'>글보기</span></span>
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
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 14pt;  width: 180px;'><img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board' style='width: 15px; padding-bottom: 3px; margin-right: 10px;' /><span id='titleName'>글보기</span></span>
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
							<span id='categoryContent' style='position: absolute; top: 20%; font-size: 14pt;  width: 180px;'><img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board' style='width: 15px; padding-bottom: 3px; margin-right: 10px;' /><span id='titleName'>글보기</span></span>
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
				
				<div class='container' id='boardTitleContent' style='position: relative; height: 100px; margin: 60px auto;'>
					<div id='inputBoardSerial' style='position: absolute; top: 0; left: 0; width: 30px; height: 50px; display: none'>${bvo.serial }</div>
					<div style='position: absolute; top: 0; left: 30px;'>
						<c:choose>
							<c:when test='${bvo.isBlocked == 0 }'>
								<div id='inputBoardTitle' style='display: inline-block; font-size: 16pt; margin-bottom: 10px;'>${bvo.title }</div><br/>
							</c:when>
							<c:when test='${bvo.isBlocked == 1 }'>
								<div id='inputBoardTitle' style='display: inline-block; color: #bb3434; font-size: 16pt; margin-bottom: 10px;'>신고에 의해 블럭 처리된 게시글입니다</div><br/>
							</c:when>
						</c:choose>
						<span style='font-size: 10pt; color: #ababab;'>by&nbsp;&nbsp;</span><div id='inputBoardUserId' style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.userId }</div>&nbsp;&nbsp;
						<span style='font-size: 10pt; color: #ababab;'>book&nbsp;&nbsp;</span><div class='bookTitlePreview' style='display: inline-block; font-size: 10pt; color: #676767;' data-toggle="tooltip" data-placement="right" title="${bvo.title_kor }(${bvo.pDate }) / ${bvo.author }">${bvo.title_kor }</div>&nbsp;&nbsp;
						<span style='font-size: 10pt; color: #ababab;'>views&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.hit }</div>&nbsp;&nbsp;
						<span style='font-size: 10pt; color: #ababab;'>up&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.thumbUpCnt }</div>&nbsp;&nbsp;
						<span style='font-size: 10pt; color: #ababab;'>when&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 10pt; color: #676767;'>${bvo.bDate }</div>
					</div>
				</div>
				
				<hr style='border: 1px solid #dedede;'/>
				
				<div class='row' id='boardTextContent'>
					<div class='col-md-10' id='' style='font-weight: bolder; border-right: 1px solid #bcbcbc; padding: 60px 0 60px 0; margin-bottom: 0;'>
						<div class='container' style='background-color: #fff;'>
							<div class='container' style='padding: 0 30px 0 30px;'>
								<c:choose>
									<c:when test='${bvo.isBlocked == 0 }'>
										<img src='${bvo.coverImg }' alt="${bvo.title_kor } img" style='float: left; width: 120p; height: 140px; margin-right: 20px; border-radius: 20px;' />
										<div style='color: #353535; font-size: 10pt; letter-spacing: 1px; word-spacing: 2px; line-height: 25px;'>${bvo.content }</div>
									</c:when>
									<c:when test='${bvo.isBlocked == 1 }'>
										<div style='color: #bb3434; font-size: 10pt; letter-spacing: 1px; word-spacing: 2px; line-height: 25px;'>신고에 의해 블럭 처리된 게시글입니다</div>
									</c:when>
								</c:choose>
							</div>
						</div>
					</div>
					<div class='col-md-2' id='rightSideComponent' style='text-align: center;'>
						<br/><br/><br/>
						<c:choose>
							<c:when test='${bvo.isBlocked == 1 }'>
								<p style='color: #bb3434;'>blocked</p>
							</c:when>
							<c:when test='${bvo.isBlocked == 0 }'>
								<img src='/desktop/resources/imgs/sample/balloon02.svg' id='iconComment' alt='toCommentPart' style='width: 20px;' data-toggle="tooltip" data-placement="right" title='댓글보기' /><br/>
								<c:choose>
									<c:when test='${empty bvo.isThumbUp or bvo.isThumbUp == 0 }'>
										<div id='thumbUp'>
											<img src='/desktop/resources/imgs/sample/heart_empty01.svg' id='iconThumbUpDown' alt='thumbUpDown' style='width: 20px; margin-top: 15px;' data-toggle="tooltip" data-placement="right" title='추천하기' />
											<span id='status' style='display: none;'>0</span><br/>
										</div>
									</c:when>
									<c:when test='${not empty bvo.isThumbUp and bvo.isThumbUp > 0 }'>
										<div id='thumbUp'>
											<img src='/desktop/resources/imgs/sample/heart_filled01.svg' id='iconThumbUpDown' alt='thumbUpDown' style='width: 20px; margin-top: 15px;' data-toggle="tooltip" data-placement="right" title='추천해제' />
											<span id='status' style='display: none;'>1</span><br/>
										</div>
									</c:when>
								</c:choose>
								<c:if test='${not empty sessionScope.userId }'>
									<div class='dropdown'>
										<span class='' data-toggle='dropdown' role='button' aria-expanded='false'>
											<img src='/desktop/resources/imgs/sample/gear02.svg' id='iconSettings' alt='boardSettings' style='width: 20px; margin-top: 15px;' data-toggle="tooltip" data-placement="right" title='글 설정' />
										</span>
										<ul class='dropdown-menu dropdown-menu-left'>
											<c:choose>
												<c:when test='${not empty sessionScope.userId and bvo.userId == sessionScope.userId }'>
													<li><a class='dropdown-item' id='toBoardModifyPage' href='#boardModifyPage'>게시글 수정</a></li>
													<li><a class='dropdown-item' id='toBoardDeleteAction' href='#boardDeleteAction'>게시글 삭제</a></li>
												</c:when>
												<c:when test='${not empty sessionScope.userId }'>
													<li><a class='dropdown-item showReportPage' href='#showReportPage'>신고하기<span id='viewUserId' style='display: none;'>${sessionScope.userId }</span></a></li>
												</c:when>
											</c:choose>
										</ul>
									</div>
								</c:if>
							</c:when>
						</c:choose>
					</div>
				</div>
				
				<div class='container' id='boardModifyPage' style='width: 90%; display: none; margin: 40px 0 80px 0;'>
					<form class='form' id='boardModifyAction' name='boardModifyAction' action='/desktop/board/boardModifyAction' method='post' style='font-size: 10pt; font-weight: bolder;'>
						<input class='form-control' id='serial' name='serial' type='hidden' value='${bvo.serial }' />
						<input class='form-control' id='bookNo' name='bookNo' type='hidden' value='${bvo.bookNo }' />
						<input class='form-control' id='category' name='category' type='hidden' value='${categoryNum }' />
						<input class='form-control' id='bDate' name='bDate' type='hidden' value='${bvo.bDate }' />
						<input class='form-control' id='hit' name='hit' type='hidden' value='${bvo.hit }' />
						<input class='form-control' id='title' name='title' type='text' value='${bvo.title }' style='margin: 5px 0 15px 0; font-weight: bolder;' />
						<textarea class='form-control' id='summernote' name='content' rows='15' placeholder='작성된 내용이 없습니다'>${bvo.content }</textarea>
						<div class='form-group' id='submitGrp' style='width: 135px; margin: 25px auto;'>
							<input class='btn btn-info' id='btnBoardModifySubmit' name='btnBoardWriteSubmit' type='button' value='제 출' />
							<input class='btn btn-info' id='btnBoardModifyCancel' name='btnBoardWriteCancel' type='button' value='취 소' style='margin-left: 5px;' />
						</div>
					</form>
				</div>
				
				<hr style='border: 1px solid #dedede;'/>
				
				<c:choose>
					<c:when test='${bvo.isBlocked == 1 }'>
						<div class='container' id='boardCommentContent' style='width: 80%; padding: 30px 0 60px 0; text-align: center;'>
							<br/><br/><p style='color: #bb3434;'>blocked</p>
						</div>
					</c:when>
					<c:when test='${bvo.isBlocked == 0 }'>
						<div class='container' id='boardCommentContent' style='width: 80%; padding: 30px 0 60px 0;'>
							<form class='form' id='commentForm' name='commentForm' action='#commentWriteAction' method='post'>
								<div class='form-group'>
									<c:choose>
										<c:when test='${not empty sessionScope.userId and not empty sessionScope.userName }'>
											<label for='' style='margin-bottom: 15px;'>댓글 쓰기</label>
											<textarea class='form-control' id='content' name='content' rows='5' placeholder='댓글 내용을 입력하세요' style='font-size: 10pt;'></textarea><br/>
											<span id='btnSubmitCommentMain'>제출</span>
										</c:when>
										<c:otherwise>
											<label for='' style='margin-bottom: 15px;'>댓글 쓰기</label><span id='btnLoginInComment'>&nbsp;&nbsp;&nbsp;로그인</span>
											<textarea class='form-control' id='' name='' rows='5' placeholder='댓글을 작성하려면 로그인 후 이용하세요' style='font-size: 10pt;' readonly></textarea>
										</c:otherwise>
									</c:choose>
								</div>
								<div class='form-group' id='commentExtraInfo'>
									<input type='hidden' id='fSerial' name='fSerial' value='${bvo.serial }' />
								</div>
							</form><br/>
							<c:if test='${not empty requestScope.commentList }'>
								<span>&nbsp;&nbsp;&nbsp;댓글 목록&nbsp;&nbsp;<span style=''>${fn:length(commentList) }</span></span>
								<div class='container' id='listOfComment' style='margin-bottom: 40px;'>
									<hr style='border-top: 1px solid #9a9a9a;'/>
									<c:forEach var='i' begin='0' end='${fn:length(commentList) - 1 }' step='1'>
										<c:choose>
											<c:when test='${commentList[i].indent == 0 }'>
												<div id='commentContainer${commentList[i].serial }' style='margin: 30px 0 10px 0;'>
													<div class='container' style='position: relative; height: 45px;'>
														<img class='memImgInComment' src='${commentList[i].photo }' alt='member profile img' style='position: absolute; left: 0; top: 0; width: 35px; height: 40px; border-radius: 20px;' />
														<div class='memProfileInComment' style='position: absolute; left: 45px; top: 0; height: 30px;'>
															<span class='userIdInComment' style='color: #454545; font-size: 10pt;'>${commentList[i].userId }</span><br/>
															<span class='commentDate' style='color: #9a9a9a; font-size: 9pt;'>${commentList[i].cDate }</span>
														</div>
														<c:if test='${not empty sessionScope.userId and commentList[i].userId == sessionScope.userId }'>
															<div class='dropdown' style='float: right;'>
																<span class='' data-toggle='dropdown' role='button' aria-expanded='false'>
																	<img src='/desktop/resources/imgs/sample/gear02.svg' class='iconCommentSettings' alt='commentSettings' style='width: 12px; margin-top: 15px;' data-toggle="tooltip" data-placement="right" title='댓글 설정' />
																</span>
																<ul class='dropdown-menu dropdown-menu-left'>
																	<li><a class='dropdown-item my-toCommentDeleteAction' href='#commentDeleteAction'>댓글 삭제<span style='display: none;'>${commentList[i].serial }</span></a></li>
																</ul>
															</div>
														</c:if>
													</div><br/>
													<div class='container'>
														<span style='color: #787878; font-size: 11pt;'>${commentList[i].content }</span><br/><br/>
														<span class='serialWithWriteCommentReply' style='display: none;'>${commentList[i].serial }</span>
														&nbsp;&nbsp;<span class='writeCommentReply'>답글 쓰기</span>
														<c:if test='${commentList[i + 1].indent > 0 }'>
															<span class='serialWithShowCommentReply' style='display: none;'>${commentList[i + 1].serial }</span>
															&nbsp;&nbsp;&nbsp;<span class='showCommentReply'>답글 보기</span>
														</c:if>
													</div>
												</div>
												<div class='container' id='commentReplyForm${commentList[i].serial }' style='display: none;'>
													<form class='form my-commentReplyForm' name='commentReplyForm' action='#commentWriteAction' method='post'>
														<div class='form-group'>
															<c:choose>
																<c:when test='${not empty sessionScope.userId and not empty sessionScope.userName }'>
																	<hr/>
																	<label for='' style='font-size: 9pt; margin-bottom: 15px;'>&nbsp;&nbsp;&nbsp;&nbsp;댓글 쓰기</label>
																	<textarea class='form-control' id='' name='content' rows='5' placeholder='댓글 내용을 입력하세요' style='font-size: 10pt;'></textarea><br/>
																	<span class='btnSubmitCommentSub'>제출</span>
																</c:when>
																<c:otherwise>
																	<hr/>
																	<label for='' style='font-size: 9pt; margin-bottom: 15px;'>&nbsp;&nbsp;&nbsp;&nbsp;댓글 쓰기</label>
																	<textarea class='form-control' id='' rows='5' placeholder='댓글을 작성하려면 로그인 후 이용하세요' style='font-size: 10pt;' readonly></textarea>
																</c:otherwise>
															</c:choose>
														</div>
														<div class='form-group' id='subCommentExtraInfo'>
															<input type='hidden' id='fSerial' name='fSerial' value='${bvo.serial }' />
															<input type='hidden' id='pSerial' name='gSerial' value='${commentList[i].serial }' />
														</div>
													</form>
												</div>
											</c:when>
											<c:when test='${commentList[i].indent > 0 }'>
												<div id='commentContainer${commentList[i].serial }reply' style='margin: 30px 0 10px 0; display: none; background-color: #efefef; border-radius: 20px; padding: 40px 10px 0 0;'>
													<div class='container' style='position: relative; height: 45px;'>
														<span style='position: absolute; left: 30px; top: 0;'>ㄴ</span>
														<img class='memImgInComment' src='${commentList[i].photo }' alt='member profile img' style='position: absolute; left: 60px; top: 0; width: 35px; height: 40px; border-radius: 20px;' />
														<div class='memProfileInComment' style='position: absolute; left: 105px; top: 0; height: 30px;'>
															<span class='userIdInComment' style='color: #454545; font-size: 10pt;'>${commentList[i].userId }</span><br/>
															<span class='commentDate' style='color: #9a9a9a; font-size: 9pt;'>${commentList[i].cDate }</span>
														</div>
														<c:if test='${not empty sessionScope.userId and commentList[i].userId == sessionScope.userId }'>
															<div class='dropdown' style='float: right;'>
																<span class='' data-toggle='dropdown' role='button' aria-expanded='false'>
																	<img src='/desktop/resources/imgs/sample/gear02.svg' class='iconCommentSettings' alt='commentSettings' style='width: 12px; margin-top: 15px;' data-toggle="tooltip" data-placement="right" title='댓글 설정' />
																</span>
																<ul class='dropdown-menu dropdown-menu-left'>
																	<li><a class='dropdown-item my-toCommentDeleteAction' href='#commentDeleteAction'>댓글 삭제<span style='display: none;'>${commentList[i].serial }</span></a></li>
																</ul>
															</div>
														</c:if>
													</div><br/>
													<div class='container' style='position: relative;'>
														<span style='position: absolute; left: 60px; color: #787878; font-size: 11pt;'>${commentList[i].content }</span><br/><br/>
														<c:if test='${commentList[i + 1].indent > 0 }'>
															<span class='serialWithShowCommentReply' style='display: none;'>${commentList[i + 1].serial }</span>
															&nbsp;&nbsp;&nbsp;<span class='showCommentReply' style='display: none;'>답글 보기</span>
														</c:if>
													</div>
												</div>
												<%-- <c:if test='${commentList[i + 1].indent == 0 }'>
													<div class='container' id='commentReplyForm${commentList[i].serial }'>
														<form class='form my-commentReplyForm' name='commentReplyForm' action='' method='post' style='width: 80%; display: block;'>
															<div class='form-group'>
																<c:choose>
																	<c:when test='${not empty sessionScope.userId and not empty sessionScope.userName }'>
																		<hr/>
																		<label for='' style='font-size: 9pt; margin-bottom: 15px;'>&nbsp;&nbsp;&nbsp;&nbsp;댓글 쓰기</label>
																		<textarea class='form-control' id='' rows='5' placeholder='댓글 내용을 입력하세요' style='font-size: 10pt;'></textarea><br/>
																		<span id='btnSubmitCommentMain'>제출</span>
																	</c:when>
																	<c:otherwise>
																		<hr/>
																		<label for='' style='font-size: 9pt; margin-bottom: 15px;'>&nbsp;&nbsp;&nbsp;&nbsp;댓글 쓰기</label>
																		<textarea class='form-control' id='' rows='5' placeholder='댓글을 작성하려면 로그인 후 이용하세요' style='font-size: 10pt;' readonly></textarea>
																	</c:otherwise>
																</c:choose>
															</div>
														</form>
													</div>
												</c:if> --%>
											</c:when>
										</c:choose>
									</c:forEach>
									<hr/>
								</div>
							</c:if>
						</div>
					</c:when>
				</c:choose>
				
			</div>
		</div>
	</div>
	
	<!-- include footer -->
	<footer>
		<jsp:include page="/WEB-INF/views/component/footer.jsp"></jsp:include>
	</footer>
	
	<!-- report icon -->
	<div class='btn btn-secondary' id='reportIcon'>
		<img src='/desktop/resources/imgs/sample/warning-light02.svg' class='showReportPage' alt='report icon' style='width: 23px; padding-bottom: 3px;' />
	</div>
	
	<!-- button for to-top -->
	<a class='btn btn-secondary my-btn-toTop' href='#'>top</a>
	
	<!-- Modal -->
    <jsp:include page="/WEB-INF/views/component/modal.jsp"></jsp:include>

</body>
</html>