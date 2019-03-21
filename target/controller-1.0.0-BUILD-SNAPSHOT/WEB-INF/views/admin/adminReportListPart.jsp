<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board report list part</title>
</head>
<body>

	<c:if test='${not empty requestScope.brvoList and fn:length(requestScope.brvoList) > 0 }'>
		<c:set var='brvoList' value='${requestScope.brvoList }' scope='page' />
		<c:set var='brPageDto' value='${requestScope.brPageDto }' scope='page' />
	</c:if>

	<div id='boardReportListBody'>
		<div class='row' style='height: 30px; font-size: 10pt; border-top: 2px solid black; border-bottom: 1px solid black; padding-top: 4px; background-color: #dedede;'>
			<div class='col-md-1'>NO</div>
			<div class='col-md-3'>분류 / 블럭유무</div>
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

</body>
</html>