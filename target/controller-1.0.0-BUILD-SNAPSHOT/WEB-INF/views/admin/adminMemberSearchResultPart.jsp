<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin member search result part</title>
</head>
<body>

	<c:if test='${not empty requestScope.mbvo }'>
		<c:set var='mbvo' value='${requestScope.mbvo }' />
	</c:if>
	
	<div class='row' style='height: 30px; font-size: 9pt; border-top: 2px solid black; border-bottom: 1px solid black; padding-top: 4px; background-color: #dedede;'>
		<div class='col-md-1'></div>
		<div class='col-md-4'>아이디 / 블럭유무</div>
		<div class='col-md-4'>가입일</div>
		<div class='col-md-3'></div>
	</div>
	<c:choose>
		<c:when test='${not empty requestScope.mbvo }'>
			<div class='row my-adminList-row' id='existMemberInfo' style='height: 45px;'>
				<div class='col-md-1'></div>
				<div class='col-md-4' id='inputUserId' style='margin-top: 10px;'>${mbvo.userId }
					<c:choose>
						<c:when test='${mbvo.isBlocked == 0 }'>
							/ <span style='color: #6767ff;'>블럭되지 않음</span>
						</c:when>
						<c:when test='${mbvo.isBlocked == 1 }'>
							/ <span style='color: #ff6767;'>블럭됨</span>
						</c:when>
					</c:choose>
				</div>
				<div class='col-md-4' id='inputMDate' style='margin-top: 10px;'>${mbvo.mDate }</div>
			<c:choose>
				<c:when test='${mbvo.isBlocked == 0 }'>
					<div class='col-md-3'><span class='btn btn-xs btn-danger' id='btnMemberBlockAction' style='font-size: 9pt; margin-top: 2px;'>블럭하기</span></div>
				</c:when>
				<c:when test='${mbvo.isBlocked == 1 }'>
					<div class='col-md-3'><span class='btn btn-xs btn-primary' id='btnMemberBlockFreeAction' style='font-size: 9pt; margin-top: 2px;'>블럭해제</span></div>
				</c:when>
			</c:choose>
			</div>
			<c:if test='${not empty requestScope.mbvo and not empty mbvo.userId }'>
				<form class='form' id='memberBlockActionForm' name='memberBlockActionForm' style='display: none;'>
					<input type='text' id='userId' name='userId' value='${mbvo.userId }' />
				</form>
			</c:if>
		</c:when>
		<c:otherwise>
			<div class='row my-adminList-row' id='noMemberInfo' style='height: 45px;'>
				<div class='col-md-12' style='text-align: center; margin-top: 10px;'>검색 결과가 없습니다</div>
			</div>
		</c:otherwise>
	</c:choose>
	
</body>
</html>