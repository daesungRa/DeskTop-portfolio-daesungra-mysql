<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board list view part</title>
</head>
<body>

	<c:if test='${not empty requestScope.boardList }'>
		<c:set var='boardList' value='${requestScope.boardList }' scope='page'></c:set>
	</c:if>
	<c:if test='${not empty requestScope.pageDto }'>
		<c:set var='pageDto' value='${requestScope.pageDto }' scope='page'></c:set>
	</c:if>
	<c:if test='${not empty requestScope.category }'>
		<c:set var='category' value='${requestScope.category }' scope='page'></c:set>
	</c:if>
	<c:if test='${not empty requestScope.searchInputData }'>
		<c:set var='searchInputData' value='${requestScope.searchInputData }' scope='page'></c:set>
	</c:if>

	<div style='position: relative; height: 50px;'>
		<span id='categoryContent' style='position: absolute; top: 20%; font-size: 12pt;'>
			<img src='/desktop/resources/imgs/document01.png' alt='icon_pencil for board' style='width: 18px; padding-bottom: 3px; margin-right: 10px;' /> 게시글 목록
		</span>
	</div>
	<div class='row my-board-row' style='border-top: 2px solid black; padding-top: 6px; background-color: #dedede;'>
		<div class='col-md-1 my-board-grid'>NO</div>
		<div class='col-md-5 my-board-grid-title' style='text-align: center;'>제목</div>
		<div class='col-md-1 my-board-grid'>작가</div>
		<div class='col-md-2 my-board-grid'>책제목</div>
		<div class='col-md-1 my-board-grid'>조회</div>
		<div class='col-md-2 my-board-grid'>등록일</div>
	</div>
	<c:forEach var="bvo" items="${boardList }" >
		<div class='row my-board-row'>
			<div class='col-md-1 my-board-grid'>${bvo.serial }</div>
			<c:choose>
				<c:when test="${fn:length(bvo.title) < 24 }">
					<div class='col-md-5 my-board-grid-title'>${bvo.title }<span style='display: none;'>${bvo.serial }</span></div>
				</c:when>
				<c:otherwise>
					<div class='col-md-5 my-board-grid-title' data-toggle="tooltip" data-placement="right" title="${bvo.title }">${fn:substring(bvo.title, 0, 23) }  ... <span style='display: none;'>${bvo.serial }</span><span style='display: none;'>${bvo.serial }</span></div>
				</c:otherwise>
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
			<span class='btnBoardView' style='color: #8a8a8a'>|</span>
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
			<span class='btnBoardView' style='color: #8a8a8a'>|</span>
			<span class='btnBoardView'>다음<span style='display: none;'>${pageDto.nowPage + 1 }</span></span>
			<span class='btnBoardView'>마지막<span style='display: none;'>${pageDto.totPage }</span></span>
		</c:if>
	</div>
	<div class='container' id='boardSearchContainer' style='height: 46px; text-align: center; /* border: 1px solid black; */'>
		<span id='searchBySortHidden' style='display: none;'>${searchInputData.searchBySort }</span>
		<span id='searchByContentHidden' style='display: none;'>${searchInputData.searchByContent }</span>
		<form class='form' id='boardListSearchForm' name='boardListSearchForm' action='#' style='position: relative; display: inline-block; right: 0; width: 70%;'>
			<select class='form-control' id='searchBySort' name='searchBySort' style='display: inline-block; font-size: 8pt; float: left; width: 18%; height: 29px; margin-right: 3px;'>
				<option selected value='1'>최신순</option>
				<option value='2'>오래된순</option>
				<option value='3'>조회순</option>
				<option value='4'>추천순</option>
			</select>
			<select class='form-control' id='searchByContent' name='searchByContent' style='display: inline-block; font-size: 8pt; float: left; width: 24%; height: 29px;'>
				<option selected value='1'>제목 + 내용</option>
				<option value='2'>제목만</option>
				<option value='3'>내용만</option>
				<option value='4'>작가별</option>
			</select>
			<input type='search' name='searchContent' value='' style='display: inline-block; font-size: 8pt; float: left; width: 45%; height: 25px; margin: 3px 0 0 7px;' />
			<%-- <c:choose>
				<c:when test='${not empty pageDto.searchContent }'>
					<input type='search' name='searchContent' value='${pageDto.searchContent }' style='display: inline-block; font-size: 8pt; float: left; width: 45%; height: 25px; margin: 3px 0 0 7px;' />
				</c:when>
				<c:otherwise>
					<input type='search' name='searchContent' value='' style='display: inline-block; font-size: 8pt; float: left; width: 45%; height: 25px; margin: 3px 0 0 7px;' />
				</c:otherwise>
			</c:choose> --%>
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

</body>
</html>