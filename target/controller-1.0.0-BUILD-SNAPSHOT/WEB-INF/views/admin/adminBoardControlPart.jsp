<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin book controt part</title>
</head>
<body>

	<c:if test='${not empty requestScope.bdvo }'>
		<c:set var='bdvo' value='${requestScope.bdvo }' scope='page' />
	</c:if>
	
	<div class='container' id='adminNewBoardBody'>
		<div class='row'>
			<div class='col-sm-12' id='newBoardInfoInModal'>
				<br/><br/>
				<div class='container' style='margin-bottom: 10px;'>
					<img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board report control' style='width: 15px; padding-bottom: 5px; margin-right: 5px;' />
					<span style='font-size: 14pt;'>게시글 정보</span>
					<c:choose>
						<c:when test='${bdvo.isBlocked == 0 }'>
							<span class='btn btn-info' id='newBoardBlockAction' style='font-size: 10pt; margin: 0 0 5px 10px;'>블럭하기</span>
						</c:when>
						<c:when test='${bdvo.isBlocked == 1 }'>
							<span class='btn btn-danger' id='newBoardBlockFreeAction' style='font-size: 10pt; margin: 0 0 5px 10px;'>블럭 해제하기</span>
						</c:when>
					</c:choose>
					<form class='form' id='newBoardBlockForm' name='newBoardBlockForm' style='display: none;'>
						<input class='form-control' type='text' id='fSerial' name='fSerial' value='${bdvo.serial }' />
					</form>
				</div>
				<div class='row' style='height: 30px; font-size: 9pt; border-top: 2px solid black; border-bottom: 1px solid black; padding-top: 4px; background-color: #dedede;'>
					<div class='col-md-1'>SERIAL</div>
					<div class='col-md-2'>카테고리</div>
					<div class='col-md-1'>작성자</div>
					<div class='col-md-3'>조회수 / 추천수 / 댓글수</div>
					<div class='col-md-3'>블럭 여부 / 삭제 여부</div>
					<div class='col-md-2'>등록일</div>
				</div>
				<div class='row my-adminList-row'>
					<div class='col-md-1' id='newBoardSerial'>${bdvo.serial }</div>
					<div class='col-md-2'>[${bdvo.category }]
						<c:choose>
							<c:when test='${bdvo.category == 1 }'>
								인문/사회/정치
							</c:when>
							<c:when test='${bdvo.category == 2 }'>
								경제/경영
							</c:when>
							<c:when test='${bdvo.category == 3 }'>
								과학/공학/수학/컴퓨터
							</c:when>
							<c:when test='${bdvo.category == 4 }'>
								문학/시/소설
							</c:when>
							<c:when test='${bdvo.category == 5 }'>
								문화/예술/자기계발/라이프
							</c:when>
						</c:choose>
					</div>
					<div class='col-md-1'>${bdvo.userId }</div>
					<div class='col-md-3'>${bdvo.hit } / ${bdvo.thumbUpCnt } / ${bdvo.commentCnt }</div>
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
								/ <span style='color: #7878ff;'>삭제되지 않음</span>
							</c:when>
							<c:when test='${bdvo.isBlocked == 1 }'>
								/ <span style='color: #ff7878;'>삭제됨</span>
							</c:when>
						</c:choose>
					</div>
					<div class='col-md-2'>${bdvo.bDate }</div>
				</div><br/>
				<div class='container' style='margin-bottom: 10px;'>
					<img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board report control' style='width: 15px; padding-bottom: 5px; margin-right: 5px;' />
					<span style='font-size: 11pt;'>관련 도서 정보</span>
				</div>
				<div class='row' style='height: 30px; font-size: 9pt; border-top: 2px solid black; border-bottom: 1px solid black; padding-top: 4px; background-color: #dedede;'>
					<div class='col-md-1'>책번호</div>
					<div class='col-md-3'>제목</div>
					<div class='col-md-3'>작가</div>
					<div class='col-md-2'>출판사</div>
					<div class='col-md-1'>국가</div>
					<div class='col-md-2'>등록일</div>
				</div>
				<div class='row my-adminList-row'>
					<div class='col-md-1' id='newBoardSerial'>${bdvo.bookNo }</div>
					<div class='col-md-3'>${bdvo.title_kor } / ${bdvo.title_eng }</div>
					<div class='col-md-2'>${bdvo.author }</div>
					<div class='col-md-2'>${bdvo.publisher }</div>
					<div class='col-md-2'>${bdvo.country }</div>
					<div class='col-md-2'>${bdvo.pDate }</div>
				</div><br/>
				<div style='font-size: 10pt;'>
					<label for=''>제목</label>
					<input class='form-control' type='text' id='' name='' value='${bdvo.title }' placeholder='게시글 제목' style='font-size: 10pt;' />
					<label for=''>내용</label>
					<textarea class='form-control' rows='5' id='' name='' placeholder='게시글 내용' style='font-size: 10pt;'>${bdvo.content }</textarea>
				</div>
				<br/><br/><br/><br/>
			</div>
		</div>
	</div>

</body>
</html>