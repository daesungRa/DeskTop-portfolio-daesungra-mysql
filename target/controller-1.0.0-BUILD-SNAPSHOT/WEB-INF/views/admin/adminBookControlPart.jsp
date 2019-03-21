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

	<c:if test='${not empty requestScope.bkvo }'>
		<c:set var='bkvo' value='${requestScope.bkvo }' scope='page' />
	</c:if>
	
	<div class='container' id='adminBookRegisterBody'>
		<div class='row'>
			<div class='col-sm-12' id='bookRegisterInfoInModal'>
				<br/><br/>
				<div class='container' style='margin-bottom: 10px;'>
					<img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board report control' style='width: 15px; padding-bottom: 5px; margin-right: 5px;' />
					<span style='font-size: 14pt;'>책 등록 요청 정보</span>
					<c:choose>
						<c:when test='${bkvo.isPermitted == 0 }'>
							<span class='btn btn-info' id='bookRegisterPermitAction' style='font-size: 10pt; margin: 0 0 5px 10px;'>등록 허가하기</span>
							<span class='btn btn-danger' id='bookRegisterProhibitAction' style='font-size: 10pt; margin: 0 0 5px 10px;'>등록 거부하기</span>
						</c:when>
						<c:when test='${bkvo.isPermitted == 1 }'>
							<span class='btn btn-danger' id='bookRegisterPermitFreeAction' style='font-size: 10pt; margin: 0 0 5px 10px;'>등록 해제하기</span>
						</c:when>
					</c:choose>
					<br/><br/><br/><img src='${bkvo.coverImg }' alt='book cover image' id='image' style='float: right; width: 230px; height: 310px; margin: 0 0 10px 20px;' />
					<!-- <span class='btn btn-info' id='boardDeleteAction' style='font-size: 10pt; margin: 0 0 5px 10px;'>게시글 삭제</span> -->
					<form class='form' id='bookRegisterProhibitForm' name='bookRegisterProhibitForm' style='display: none;'>
						<input class='form-control' type='text' id='bookNo' name='bookNo' value='${bkvo.bookNo }' />
					</form>
				</div>
				<div class='row' style='height: 30px; font-size: 9pt; border-top: 2px solid black; border-bottom: 1px solid black; padding-top: 4px; background-color: #dedede;'>
					<div class='col-md-1'>NO</div>
					<div class='col-md-3'>분류 / 승인 여부</div>
					<div class='col-md-2'>작성자</div>
					<div class='col-md-4'>책제목 / 작가</div>
					<div class='col-md-2'>등록일</div>
				</div>
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
				</div><br/>
				<form class='form' id='bookRegisterPermitForm' style='font-size: 9pt;' enctype='multipart/form-data'>
					<div class='form-inline'>
						<label for='bookNo' style='display: block; width: 13%; text-align: left;'>책 번호</label>
						<input class='form-control' type='text' id='bookNo' name='bookNo' value='${bkvo.bookNo }' placeholder='책 번호' style='margin-left: 10px; width: 80%;' />
						<input class='form-control' type='text' id='oriBookNo' name='oriBookNo' value='${bkvo.bookNo }' placeholder='책 번호' style='display: none; margin-left: 10px; width: 80%;' />
					</div><hr/>
					<div class='form-inline'>
						<label for='title_kor' style='display: block; width: 13%; text-align: left;'>제목 (KOR)</label>
						<input class='form-control' type='text' id='title_kor' name='title_kor' value='${bkvo.title_kor }' placeholder='책 제목 (kor)' style='margin-left: 10px; width: 80%;' />
					</div><hr/>
					<div class='form-inline'>
						<label for='title_eng' style='display: block; width: 13%; text-align: left;'>제목 (ENG)</label>
						<input class='form-control' type='text' id='title_eng' name='title_eng' value='${bkvo.title_eng }' placeholder='책 제목 (eng)' style='margin-left: 10px; width: 80%;' />
					</div><hr/>
					<div class='form-inline'>
						<label for='author' style='display: block; width: 8%; text-align: left;'>작가</label>
						<input class='form-control' type='text' id='author' name='author' value='${bkvo.author }' placeholder='작가명' style='margin-left: 10px; width: 40%;' />
						<label for='postCoverImg' style='display: block; width: 8%; text-align: left; margin-left: 16px;'>표지변경</label>
						<input class='form-control' type='file' id='coverImg' name='coverImg' style='margin-left: 10px; width: 30%;' />
					</div><hr/>
					<div class='form-inline'>
						<label for='publisher' style='display: block; width: 8%; text-align: left;'>출판사</label>
						<input class='form-control' type='text' id='publisher' name='publisher' value='${bkvo.publisher }' placeholder='책 제목' style='margin-left: 10px; width: 20%;' />
						<label for='country' style='display: block; width: 8%; text-align: left; margin-left: 16px;'>국가</label>
						<input class='form-control' type='text' id='country' name='country' value='${bkvo.country }' placeholder='책 제목' style='margin-left: 10px; width: 20%;' />
						<label for='category' style='display: block; width: 8%; text-align: left; margin-left: 16px;'>카테고리</label>
						<select class='form-control' id='category' name='category' style='margin-left: 10px; width: 20%;'>
							<option value='1' selected>인문/사회/정치</option>
							<option value='2'>경제/경영</option>
							<option value='3'>과학/공학/수학/컴퓨터</option>
							<option value='4'>문학/시/소설</option>
							<option value='5'>문화/예술/자기계발/라이프</option>
						</select>
					</div><hr/>
					<div class='form-inline'>
						<label for='introduce' style='display: block; width: 13%; text-align: left;'>소개</label>
						<textarea class='form-control' id='introduce' name='introduce' rows='8' placeholder='책 제목' style='margin-left: 10px; width: 80%;'>${bkvo.introduce }</textarea>
					</div><br/><br/><br/><br/>
				</form>
			</div>
		</div>
	</div>

</body>
</html>