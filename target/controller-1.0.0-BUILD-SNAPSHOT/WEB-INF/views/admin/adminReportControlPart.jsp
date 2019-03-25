<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board report control part</title>
</head>
<body>

	<c:if test='${not empty requestScope.brvo }'>
		<c:set var='brvo' value='${requestScope.brvo }' scope='page' />
	</c:if>
	
	<div class='container' id='adminReportBody'>
		<div class='row'>
			<div class='col-sm-12' id='reportContent'>
				<div class='container' style='margin-bottom: 10px;'>
					<br/>
					<img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board report control' style='width: 15px; padding-bottom: 5px; margin-right: 5px;' />
					<span style='font-size: 14pt;'>게시글 신고</span>
					<span class='btn btn-info' id='boardReportComplete' style='font-size: 10pt; margin: 0 0 5px 10px;'>처리 완료하기</span>
					<form class='form' id='reportCompleteForm' name='reportCompleteForm' style='display: none;'>
						<input class='form-control' type='text' id='serial' name='serial' value='${brvo.serial }' />
					</form>
				</div>
				<div class='row' style='height: 30px; font-size: 10pt; border-top: 2px solid black; border-bottom: 1px solid black; padding-top: 4px; background-color: #dedede;'>
					<div class='col-sm-1'>NO</div>
					<div class='col-sm-3'>분류</div>
					<div class='col-sm-2'>신고자</div>
					<div class='col-sm-3'>처리 여부</div>
					<div class='col-sm-3'>등록일</div>
				</div>
				<div class='row' style='height: 30px; font-size: 10pt; border-bottom: 1px solid black; padding-top: 4px;'>
					<div class='col-sm-1' id='reportSerialInBoardReportPage'>${brvo.serial }</div>
					<div class='col-sm-3'>[${brvo.reportType }]
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
					</div>
					<div class='col-sm-2'>${brvo.rUserId }</div>
					<div class='col-sm-3'>
						<c:choose>
							<c:when test='${brvo.isDelete == 0 }'>
								처리되지 않음 (0)
							</c:when>
							<c:when test='${brvo.isDelete == 1 }'>
								처리됨 (1)
							</c:when>
						</c:choose>
					</div>
					<div class='col-sm-3'>${brvo.rDate }</div>
				</div><br/>
				<label for='reportText'>신고 내용</label>
				<textarea class='form-control' id='reportText' rows='3' readonly>${brvo.rContent }</textarea>
			</div>
		</div>
			
		<br/><hr style='border-top: 3px double #8c8b8b;'/><br/>
			
		<div class='row'>
			<div class='col-sm-12' id='boardContentInBoardReportPage'>
				<div class='container' style='margin-bottom: 10px;'>
					<img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board report control' style='width: 15px; padding-bottom: 5px; margin-right: 5px;' />
					<span style='font-size: 14pt;'>신고된 게시글 정보</span>
					<c:choose>
						<c:when test='${brvo.isBlocked == 0 }'>
							<span class='btn btn-primary' id='boardBlockAction' style='font-size: 10pt; margin: 0 0 5px 10px;'>게시글 블럭하기</span>
						</c:when>
						<c:when test='${brvo.isBlocked == 1 }'>
							<span class='btn btn-danger' id='boardBlockFreeAction' style='font-size: 10pt; margin: 0 0 5px 10px;'>블럭 해제하기</span>
						</c:when>
					</c:choose>
					<!-- <span class='btn btn-info' id='boardDeleteAction' style='font-size: 10pt; margin: 0 0 5px 10px;'>게시글 삭제</span> -->
					<form class='form' id='boardControlForm' name='boardControlForm' style='display: none;'>
						<input class='form-control' type='text' id='fSerial' name='fSerial' value='${brvo.fSerial }' />
					</form>
				</div>
				<div class='row' style='height: 30px; font-size: 10pt; border-top: 2px solid black; border-bottom: 1px solid black; padding-top: 4px; background-color: #dedede;'>
					<div class='col-sm-1'>NO</div>
					<div class='col-sm-3'>카테고리</div>
					<div class='col-sm-2'>작성자</div>
					<div class='col-sm-3'>블럭 여부</div>
					<div class='col-sm-3'>등록일</div>
				</div>
				<div class='row' id='toBoardViewPageFromBoardReportPage' data-toggle="tooltip" data-placement="right" title="해당 게시글의 view 페이지로 이동" style='height: 30px; font-size: 10pt; border-bottom: 1px solid black; padding-top: 4px;'>
					<div id='boardSerialInBoardReportPage' class='col-sm-1'>${brvo.fSerial }</div>
					<div id='boardCategoryInBoardReportPage' style='display: none;'>${brvo.category }</div>
					<div class='col-sm-3'>[${brvo.category }]
						<c:choose>
							<c:when test='${brvo.category == 1 }'>
								인문/사회/정치
							</c:when>
							<c:when test='${brvo.category == 2 }'>
								경제/경영
							</c:when>
							<c:when test='${brvo.category == 3 }'>
								과학/공학/수학/컴퓨터
							</c:when>
							<c:when test='${brvo.category == 4 }'>
								문학/시/소설
							</c:when>
							<c:when test='${brvo.category == 5 }'>
								문화/예술/자기계발/라이프
							</c:when>
						</c:choose>
					</div>
					<div class='col-sm-2'>${brvo.userId }</div>
					<div class='col-sm-3'>
						<c:choose>
							<c:when test='${brvo.isBlocked == 0 }'>
								블럭되지 않음 (0)
							</c:when>
							<c:when test='${brvo.isBlocked == 1 }'>
								블럭됨 (1)
							</c:when>
						</c:choose>
					</div>
					<div class='col-sm-3'>${brvo.bDate }</div>
				</div><br/>
				<label for='boardTitle'>게시글 제목</label>
				<input class='form-control' type='text' id='boardTitle' value='${brvo.title }' placeholder='게시글 제목' readonly />
				<label for='boardContent'>본문 내용</label>
				<textarea class='form-control' id='boardContent' rows='3' placeholder='게시글 본문 내용' readonly>${brvo.content }</textarea><br/><br/><br/><br/>
			</div>
		</div>
	</div>

</body>
</html>