<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin book list part</title>
</head>
<body>

	<c:if test='${not empty requestScope.bkvoList and fn:length(requestScope.bkvoList) > 0 }'>
		<c:set var='bkvoList' value='${requestScope.bkvoList }' scope='page' />
		<c:set var='bkPageDto' value='${requestScope.bkPageDto }' scope='page' />
	</c:if>

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
					<div class='row my-adminList-row'>
						<div class='col-md-1' id='newBoardSerial'>${bdvo.serial }</div>
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

</body>
</html>