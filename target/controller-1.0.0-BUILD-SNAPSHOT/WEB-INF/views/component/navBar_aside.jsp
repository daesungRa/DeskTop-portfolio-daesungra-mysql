<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<title>navBar page(aside)</title>
</head>
<body>

	<div id='navbarAside' style='position: fixed; display: none; width: 17%; height: 100%; border-right: 1px solid #aaa; z-index: 1;'>
		<div style='width:100%; height:12%; background-color: #fff; border-bottom:1px solid #aaa;'>
			<div class='' style='height: 20px; margin: 30px auto; text-align: center;'>
				<a href='/desktop/'>
					<img src='/desktop/resources/imgs/book_logo01.svg' id='navLogo' alt='brand logo' />
				</a>
				<a id='title' href='/desktop/'>DESK TOP</a>
			</div>
			<div class='container' id='navAsideMember'>
				<c:choose>
					<c:when test="${not empty sessionScope.userId }">
						<div class='dropdown' id='navAsideMemberControl'>
							<a class='dropdown-toggle' data-toggle='dropdown' role='button'
								href='#' style='color: #ababab;'>${sessionScope.userName }<span
								class='caret'></span>
							</a>
							<ul class='dropdown-menu dropdown-menu-left animate slideIn'>
								<li><a class='dropdown-item' id='logoutAnc' href='#logout'>로그아웃</a></li>
								<li><a class='dropdown-item' id='myPage' href='/desktop/member/myPage'>마이페이지</a></li>
							</ul>
						</div>
					</c:when>
					<c:otherwise>
						<div class='dropdown' id='navAsideMemberControl'>
							<a class='dropdown-toggle' data-toggle='dropdown' role='button'
								href='#'>접속 <span class='caret'></span>
							</a>
							<ul class='dropdown-menu text-left' style='list-style: none;'>
								<li><a class='dropdown-item' id='loginAnc' href='#login'>로그인</a>
								</li>
								<li><a class='dropdown-item' id='joinAnc' href='#join'>회원가입</a>
								</li>
							</ul>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class='my-nav-vertical' style='background-color: #efefef;'>
			<br/>
			<ul class='' style='list-style: none;'>
				<li class='dropdown'>
					<a class='dropdown-toggle my-nav' data-toggle='dropdown' role='button' id='categoryAnc' href='#'>리뷰 카테고리</a>
					<ul class='dropdown-menu my-nav' style='text-align: left;'>
						<li><a class='dropdown-item my-nav' id='' href='/desktop/board/boardListPage/1/1'>인문/사회/정치</a></li>
						<li><a class='dropdown-item my-nav' id='' href='/desktop/board/boardListPage/2/1'>경제/경영</a></li>
						<li><a class='dropdown-item my-nav' id='' href='/desktop/board/boardListPage/3/1'>과학/공학/수학/컴퓨터</a></li>
						<li><a class='dropdown-item my-nav' id='' href='/desktop/board/boardListPage/4/1'>문학/시/소설</a></li>
						<li><a class='dropdown-item my-nav' id='' href='/desktop/board/boardListPage/5/1'>문화/예술/자기계발/라이프</a></li>
					</ul>
				</li>
				<!-- <li class='nav-item'><a class='nav-link my-nav' id='guestbookAnc' href='#guestbook'>방명록</a></li> -->
				<li class='nav-item'><a class='nav-link my-nav-top' id='writerListAnc' href='/desktop/member/getWriterListPage'>작가별</a></li>
				<li class='nav-item'><a class='nav-link my-nav-top' id='' href='/desktop/member/myPage'>나의 책상</a></li>
				<c:if test='${not empty sessionScope.authority and sessionScope.authority > 0 }'>
					<li class='nav-item'><a class='nav-link my-nav-top' id='getAdminPageAnc' href='/desktop/admin/getAdminPage/1'>관리자 페이지</a></li>
				</c:if>
			</ul>
		</div>
	</div>

</body>
</html>