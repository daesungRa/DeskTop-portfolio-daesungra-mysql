<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<title>navBar page(top)</title>
</head>
<body>

	<div class='navbar navbar-expand-md bg-light sticky-top' id='my-nav-top' style='min-height: 40px;'>
		<div class='navbar-header text-light' style='margin-left: 60px;'>
			<a class='navbar-brand' href='/desktop/'>
				<img src='/desktop/resources/imgs/book_logo01.svg' id='navLogo' alt='brand logo' />
			</a>
			<!-- <a id='title' href='/desktop/'>책 상</a> -->
		</div>

		<button class='navbar-toggler collapsed' type='button'
			data-toggle='collapse' data-target='#collapsibleNavbar'>
			<span class='navbar-toggler-icon'></span>
		</button>
		<div class='collapse navbar-collapse' id='collapsibleNavbar' style='font-size: 10pt;'>
			<ul class='navbar-nav'>
				<%-- <c:choose>
					<c:when test="${not empty requestScope.memberInfo and requestScope.memberInfo eq true }">
						<li class='nav-item'><a class='nav-link my-nav' id='memberProfileAnc' href='#'>프로필 관리</a></li>
						<li class='nav-item'><a class='nav-link my-nav' id='memberInfoAnc' href='#'>회원정보 관리</a></li>
					</c:when>
					<c:otherwise> --%>
						<li class='nav-item dropdown'>
							<a class='nav-link dropdown-toggle' data-toggle='dropdown' role='button' id='categoryAnc' href='#'>리뷰 카테고리</a>
							<ul class='dropdown-menu' style='text-align: left;'>
								<li><a class='dropdown-item' id='category1' href='/desktop/board/boardListPage/1/1'>인문/사회/정치</a></li>
								<li><a class='dropdown-item' id='category2' href='/desktop/board/boardListPage/2/1'>경제/경영</a></li>
								<li><a class='dropdown-item' id='category3' href='/desktop/board/boardListPage/3/1'>과학/공학/수학/컴퓨터</a></li>
								<li><a class='dropdown-item' id='category4' href='/desktop/board/boardListPage/4/1'>문학/시/소설</a></li>
								<li><a class='dropdown-item' id='category5' href='/desktop/board/boardListPage/5/1'>문화/예술/자기계발/라이프</a></li>
							</ul>
						</li>
						<!-- <li class='nav-item'><a class='nav-link my-nav-top' id='guestbookAnc' href='#guestbook'>방명록</a></li> -->
						<li class='nav-item'><a class='nav-link my-nav-top' id='writerListAnc' href='/desktop/member/getWriterListPage'>작가별</a></li>
						<li class='nav-item'><a class='nav-link my-nav-top' id='' href='/desktop/member/myPage'>나의 책상</a></li>
						<c:if test='${not empty sessionScope.authority and sessionScope.authority > 0 }'>
							<li class='nav-item'><a class='nav-link my-nav-top' id='getAdminPageAnc' href='/desktop/admin/getAdminPage/1'>관리자 페이지</a></li>
							<c:if test='${not empty sessionScope.authority and sessionScope.authority == 2 }'>
								<li class='nav-item'><a class='nav-link my-nav-top' id='showMemberAdminComponentNav' href='#'>회원관리</a></li>
							</c:if>
						</c:if>
					<%-- </c:otherwise>
				</c:choose> --%>
			</ul>
		</div>

		<c:choose>
			<c:when test="${not empty sessionScope.userId }">
				<div class='dropdown' id='navLoginLogoutJoin'>
					<a class='dropdown-toggle' data-toggle='dropdown' role='button'
						href='#'> 환영해요, ${sessionScope.userName } 님 <span class='caret'></span>
					</a>
					<ul class='dropdown-menu dropdown-menu-right text-right animate slideIn'>
						<li><a class='dropdown-item' id='logoutAnc' href='#logout'>로그아웃</a></li>
						<li><a class='dropdown-item .myPageAnc' id='' href='/desktop/member/myPage'>마이페이지</a></li>
					</ul>
				</div>
			</c:when>
			<c:otherwise>
				<div class='dropdown' id='navLoginLogoutJoin'>
					<a class='dropdown-toggle' data-toggle='dropdown' role='button'
						href='#'>접속<span class='caret'></span>
					</a>
					<ul class='dropdown-menu dropdown-menu-right text-right'>
						<li><a class='dropdown-item' id='loginAnc' href='#login'>로그인</a>
						</li>
						<li><a class='dropdown-item' id='joinAnc' href='#join'>회원가입</a>
						</li>
					</ul>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

</body>
</html>