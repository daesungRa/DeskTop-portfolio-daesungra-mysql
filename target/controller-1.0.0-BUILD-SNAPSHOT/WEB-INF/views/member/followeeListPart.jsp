<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>followee list part</title>
</head>
<body>

	<c:if test='${not empty requestScope.followeeList }'>
		<c:set var='followeeList' value='${requestScope.followeeList }' scope='page' />
	</c:if>
	
	<div class='container' id='followeeListBody' style='width: 80%; margin: 20px auto;'>
		<br/>
		<span id='followeeListTitle'>현재 구독중인 작가</span><br/>
		<hr/>
		<c:forEach var='followee' items='${followeeList }'>
			<div class='row my-followee' data-toggle='tooltip' data-placement='right' title='작가 상세 페이지로 이동'>
				<div class='col-sm-1'></div>
				<div class='col-sm-2 my-followeeImg'>
					<img src='${followee.photo }' class='followeePhoto' alt='followee photo' />
				</div>
				<div class='col-sm-9 my-followeeInfo'>
					<span class='userId' style='display: none;'>${followee.userId }</span>
					<span style='font-size: 14pt;'>${followee.nickName }</span><br/>
					<span style='font-size: 10pt; color: #9b9b9b;'>${followee.introduce }</span>
				</div>
			</div>
		</c:forEach>
		<br/><br/><br/>
	</div>

</body>
</html>