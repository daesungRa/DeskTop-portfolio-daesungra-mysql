<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<title>selected writer part</title>
</head>
<body>

	<c:if test='${not empty requestScope.mbvo }'>
		<c:set var='mbvo' value='${requestScope.mbvo }' />
	</c:if>
	<c:if test='${not empty requestScope.bdvoList }'>
		<c:set var='bdvoList' value='${requestScope.bdvoList }' />
	</c:if>

	<div class='container' style='margin: 20px 0 20px 0;'>
		<div class='row' style='margin-top: 30px;'>
			<div class='col-sm-1'></div>
			<div class='col-sm-6' id=''>
				<div style='display: inline-block;'>
					<span style='font-size: 18pt;'>${mbvo.nickName }</span><br/>
					<span>${mbvo.userName }</span>
				</div>
				<img src='${mbvo.photo }' alt='writer profile img' class='my-popularWriterImg' id='' style='display: inline-block;' />
			</div>
			<div class='col-sm-5'></div>
		</div>
		<div class='row my-selectedWriterInfo'>
			<div class='col-sm-1'></div>
			<div class='col-sm-7'>
				<span style='color: #787878; font-size: 9pt;'>댓글수 ${mbvo.boardCnt }</span>&nbsp;&nbsp;
				<span style='color: #787878; font-size: 9pt;'>추천수 ${mbvo.thumbUpCnt }</span>&nbsp;&nbsp;
				<span style='color: #787878; font-size: 9pt;'>팔로워 ${mbvo.fNum }</span>&nbsp;&nbsp;
				<c:if test='${not empty sessionScope.userId and sessionScope.userId != mbvo.userId }'>
					<c:choose>
						<c:when test='${mbvo.isFollow == 0 }'>
							<span id='followAction'>구독하기<span style='display: none;'>${mbvo.userId }</span></span>
						</c:when>
						<c:when test='${mbvo.isFollow > 0 }'>
							<span id='unFollowAction'>구독해제<span style='display: none;'>${mbvo.userId }</span></span>
						</c:when>
					</c:choose>
				</c:if>
			</div>
			<div class='col-sm-4'></div>
		</div>
		<div class='row my-selectedWriterInfo' style='margin-top: 10px;'>
			<div class='col-sm-1'></div>
			<div class='col-sm-8' id=''>
				<span>${mbvo.introduce }</span>
			</div>
			<div class='col-sm-3'></div>
		</div><br/><br/><br/><br/>
		<div class='container' style='width: 85%;'>
			<div style='color: #787878; font-size: 10pt; border-bottom: 1px solid #bdbdbd; padding-bottom: 10px;'>작가의 게시글</div>
			<c:choose>
				<c:when test='${not empty requestScope.bdvoList }'>
					<c:forEach var='bdvo' items='${bdvoList }'>
						<div class='row my-selectedWriter'>
							<div class='col-sm-9' style='margin-top: 20px;'>
								<div>
									<span class='boardSerial' style='display: none;'>${bdvo.serial }</span>
									<span class='boardCategory' style='display: none;'>${bdvo.category }</span>
									<span class='boardTitle'>${bdvo.title }</span><br/><br/>
									<c:choose>
										<c:when test='${fn:length(bdvo.content) > 50 }'>
											<span class='boardContent'>${fn:substring(bdvo.content, 0, 49) } ...</span>
										</c:when>
										<c:when test='${fn:length(bdvo.content) <= 50 }'>
											<span class='boardContent'>${bdvo.content }</span>
										</c:when>
									</c:choose>
								</div>
								<div>
									<span style='font-size: 9pt; color: #ababab;'>book&nbsp;&nbsp;</span><div class='bookTitlePreview' style='display: inline-block; font-size: 9pt; color: #676767;' data-toggle="tooltip" data-placement="right" title="${bdvo.title_kor }(${bdvo.pDate }) / ${bdvo.author }">${bdvo.title_kor }</div>&nbsp;&nbsp;
									<span style='font-size: 9pt; color: #ababab;'>when&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 9pt; color: #676767;'>${bdvo.bDate }</div><br/>
									<span style='font-size: 9pt; color: #ababab;'>views&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 9pt; color: #676767;'>${bdvo.hit }</div>&nbsp;&nbsp;
									<span style='font-size: 9pt; color: #ababab;'>comments&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 9pt; color: #676767;'>${bdvo.commentCnt }</div>&nbsp;&nbsp;
									<span style='font-size: 9pt; color: #ababab;'>up&nbsp;&nbsp;</span><div style='display: inline-block; font-size: 9pt; color: #676767;'>${bdvo.thumbUpCnt }</div>
								</div>
							</div>
							<div class='col-sm-3' style='margin-top: 20px;'>
								<img src='${bdvo.coverImg }' alt='book cover img' class='my-popularWriterImg' style='border-radius: 10px;' />
							</div>
							<hr/>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class='container-fluid' style='color: #787878; font-size: 10pt; text-align: center; border-bottom: 1px solid #bdbdbd; padding-bottom: 10px;'>
						<p style='margin: 100px auto;'>등록된 게시글이 없습니다.</p>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
    
</body>
</html>