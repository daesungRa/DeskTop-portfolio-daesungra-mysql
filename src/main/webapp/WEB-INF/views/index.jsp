<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<meta charset='utf-8'>
	<meta name='viewport' content='width=device-width, initial-scale=1'>
	<title>Welcome to Chaek-Sang</title>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" />
	<link rel='stylesheet' href='//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css'/>
	<link rel='stylesheet' href='/desktop/resources/css/index_large.css' media='screen and (min-width: 769px)' />
	<link rel='stylesheet' href='/desktop/resources/css/index_mini.css' media='screen and (max-width: 768px)' />
	<link rel='stylesheet' href='/desktop/resources/css/component_large.css' media='screen and (min-width: 769px)' />
	<link rel='stylesheet' href='/desktop/resources/css/component_mini.css' media='screen and (max-width: 768px)' />
	<link rel='stylesheet' href='/desktop/resources/css/member_large.css' media='screen and (min-width: 769px)' />
	<link rel='stylesheet' href='/desktop/resources/css/member_mini.css' media='screen and (max-width: 768px)' />
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src='/desktop/resources/js/index.js'></script>
	<script src='/desktop/resources/js/component.js'></script>
	<script src='/desktop/resources/js/member.js'></script>
</head>
<body style='position: relative; height: 100%; padding-bottom: 200px; min-height: 3818px;'>	
	<!-- 브라우저 크기 확인 (임시) -->
	<!-- <div id='windowSize' style='width: 180px; border: 1px solid black;'>
		window size : 
	</div> -->
	
	<c:if test='${not empty notLoginMsg }'>
		<script>alert('${notLoginMsg}');</script>
	</c:if>
	
	<!-- top -->
	<jsp:include page="/WEB-INF/views/component/top.jsp"></jsp:include>
	
	<!-- include navbar(top) -->
	<jsp:include page="/WEB-INF/views/component/navBar_top.jsp"></jsp:include>
	
	<!-- include header -->
	<header id='indexHeader' style='z-index: 0;'>
		<jsp:include page="/WEB-INF/views/component/header.jsp"></jsp:include>
	</header>

	<!-- article component -->
	<article id='article'>
		<div class='container-fluid my-index-article' id='introducePart'>
			<div class='row my-index-article-row'>
				<div class='col-md-3' id='introPart-left'>
					<img src='/desktop/resources/imgs/book_back01.jpg' class='introImg' id='' alt='' /><br/><br/>
					<div class='container-fluid'>
						<span style='font-size: 16pt;'>책 리뷰</span><br/><br/>
						<span style='font-size: 11pt;'>나만의 감성적인 책 리뷰를 작성하세요</span>
					</div>
				</div>
				<div class='col-md-3' id='introPart-center'>
					<img src='/desktop/resources/imgs/communication02.jpg' class='introImg' id='' alt='' /><br/><br/>
					<div class='container-fluid'>
						<span style='font-size: 16pt;'>커뮤니티</span><br/><br/>
						<span style='font-size: 11pt;'>댓글, 피드백, 추천, 구독 등<br/>커뮤니티 기능</span>
					</div>
				</div>
				<div class='col-md-3' id='introPart-right'>
					<img src='/desktop/resources/imgs/security03.jpg' class='introImg' id='' alt='' /><br/><br/>
					<div class='container-fluid'>
						<span style='font-size: 16pt;'>계정 보안</span><br/><br/>
						<span style='font-size: 11pt;'>SHA-512 알고리즘으로<br/>암호화된 안전한 계정관리</span>
					</div>
				</div>
				<div class='col-md-3' id='introPart-end'>
					<img src='/desktop/resources/imgs/admin01.jpg' class='introImg' id='' alt='' /><br/><br/>
					<div class='container-fluid'>
						<span style='font-size: 16pt;'>관리자</span><br/><br/>
						<span style='font-size: 11pt;'>게시글 신고, 책 등록요청,<br/>새로운 게시글 및 회원관리</span>
					</div>
				</div>
			</div>
		</div>
		
		<div class='container my-index-article-detail' id='bookSharePart'>
			<div class='row my-index-article-row'>
				<div class='col-md-6' id='bookImg-left'>
				</div>
				<div class='col-md-6' id='bookImg-right' style='text-align: left; padding-left: 40px;'>
					<br/><br/>
					<span style='font-size: 28pt;'>Book Review</span><br/><br/><br/>
					<span style='font-size: 18pt;'>Search Book</span><br/>
					<span style='font-size: 12pt;'>리뷰를 작성할 책을 검색할 수 있습니다</span><br/><br/><br/>
					<span style='font-size: 18pt;'>Register New Book</span><br/>
					<span style='font-size: 12pt;'>검색된 책이 없다면 새롭게 등록 요청할 수 있습니다</span><br/><br/><br/>
					<span style='font-size: 18pt;'>Write a Book Review</span><br/>
					<span style='font-size: 12pt;'>나만의 책 리뷰를 작성하세요!</span>
				</div>
			</div>
		</div>
		
		<div class='container-fluid my-index-article-detail' id='communicationPart' style='width: 80%;'>
			<div class='row my-index-article-row'>
				<div class='col-md-6' id='communication-left'  style='text-align: right; padding-right: 40px;'>
					<br/><br/>
					<span style='font-size: 28pt;'>Communication</span><br/><br/><br/>
					<span style='font-size: 18pt;'>Comments</span><br/>
					<span style='font-size: 12pt;'>리뷰에 대한 댓글 및 대댓글 작성이 가능합니다</span><br/><br/><br/><br/>
					<span style='font-size: 18pt;'>Make a Recommendation<br/>And Subscribe</span><br/>
					<span style='font-size: 12pt;'>리뷰에 대한 추천, 작가 구독이 가능합니다</span><br/>
					<span style='font-size: 12pt;'>뷰, 추천이 많은 리뷰 순으로 정렬됩니다</span>
				</div>
				<div class='col-md-6' id='communication-right'>
				</div>
			</div>
		</div>
		
		<div class='container-fluid my-index-article-detail' id='encryptionPart' style='width: 80%;'>
			<div class='row my-index-article-row'>
				<div class='col-md-6' id='encryption-left'>
				</div>
				<div class='col-md-6' id='encryption-right' style='text-align: left; padding-left: 40px;'>
					<br/><br/><br/>
					<span style='font-size: 28pt;'>Security</span><br/><br/><br/>
					<span style='font-size: 18pt;'>Hashed Password</span><br/>
					<span style='font-size: 12pt;'>USER PASSWORD = 해싱된 문자열 + 무작위 해싱 문자열 (SALT)</span><br/><br/>
					<a class='btn btn-xs btn-dark' id='showSampleSecurityCode' href='#dev'>샘플 코드 보기</a><br/><br/>
					<span style='font-size: 18pt;'>Email Authentication</span><br/>
					<span style='font-size: 12pt;'>가입시 입력한 이메일 정보를 활용한 아이디 / 비밀번호 찾기</span>
				</div>
			</div>
		</div>
		
		<div class='container my-index-article-detail' id='authorityPart'>
			<div class='row my-index-article-row'>
				<div class='col-md-6' id='authority-left' style='text-align: right; padding-right: 40px; padding-top: 20px;'>
					<span style='font-size: 28pt;'>Administration</span><br/><br/><br/>
					<span style='font-size: 18pt;'>부적절한 게시글 신고</span><br/>
					<span style='font-size: 12pt;'>신고 카테고리별 관리, 블럭 처리</span><br/><br/>
					<span style='font-size: 18pt;'>새 책 등록요청</span><br/>
					<span style='font-size: 12pt;'>등록 요청된 책 정보에 대한 수정 및 승인, 거부</span><br/><br/>
					<span style='font-size: 18pt;'>새로운 게시글 관리</span><br/>
					<span style='font-size: 12pt;'>새 게시물을 기간별로 검색 후 관리</span><br/><br/>
					<span style='font-size: 18pt;'>(SUPER) 회원 관리</span><br/>
					<span style='font-size: 12pt;'>SUPER 관리자는 회원 계정에 대한 블럭처리,<br/>권한 부여 등이 가능합니다</span>
				</div>
				<div class='col-md-6' id='authority-right'>
				</div>
			</div>
		</div>
		
		<div class='container-fluid my-index-article-dev' id='devPart'>
			<div class='row my-index-article-row'>
				<span class='col-md-2' id='dev-left'></span>
				<div class='col-md-4' id='dev-centerImg' style='text-align: right; padding: 100px 60px 0 0; /* border: 1px solid black; */'>
					<img src='/desktop/resources/imgs/my-img01.jpg' class='dev-img' id='dev-img' alt='dev-img' /><br/><br/>
				</div>
				<div class='col-md-6' id='dev-centerIntro' style='text-align: left; padding: 70px 0 0 40px; /* border: 1px solid black; */'>
					<div class='container-fluid'>
						<span style='font-size: 24pt;'>개발자 소개</span><br/><br/><br/>
						<div class='row' style='margin-bottom: 20px;'>
							<div class='col-md-2'>
								<span style='font-size: 13pt; font-weight: bolder;'>누구?</span>
							</div>
							<div class='col-md-10'>
								<span style='font-size: 12pt;'>소통과 협력을 모토로 삼는 개발자</span>
							</div>
						</div>
						<div class='row'>
							<div class='col-md-2'>
								<span style='font-size: 13pt; font-weight: bolder;'>기술스택</span>
							</div>
							<div class='col-md-2'>
								<span style='font-size: 10pt;'>OS, 배포</span>
							</div>
							<div class='col-md-8'>
								<span style='font-size: 10pt;'>Ubuntu 16.04 LTS<br/>AWS EC2 + RDS<br/>Git, Github - <span class='githubAnc' data-toggle='tooltip' data-placement='right' title='해당 깃헙 페이지로 이동합니다.'>소스 보기</span></span>
							</div>
						</div>
						<div class='row'>
							<div class='col-md-2'>
							</div>
							<div class='col-md-2'>
								<span style='font-size: 10pt;'>개발환경</span>
							</div>
							<div class='col-md-8'>
								<span style='font-size: 10pt;'>OpenJDK 1.8.0 (Eclipse Photon)<br/>MySql 8.0.11 (HeidiSQL)<br/>MyBatis 3</span>
							</div>
						</div>
						<div class='row'>
							<div class='col-md-2'>
							</div>
							<div class='col-md-2'>
								<span style='font-size: 10pt;'>기술목록</span>
							</div>
							<div class='col-md-8'>
								<span style='font-size: 10pt;'>Javascript, Ajax, jQuery, Bootstrap 5, JSON<br/>JSP, Spring 4.3.18</span>
							</div>
						</div>
						<div class='row' style='margin-bottom: 20px;'>
							<div class='col-md-2'>
							</div>
							<div class='col-md-2'>
								<span style='font-size: 10pt;'>API</span>
							</div>
							<div class='col-md-8'>
								<span style='font-size: 10pt;'>jQuery UI Autocomplete<br/>Apache-commons-FileUpload<br/>javax-mail</span>
							</div>
						</div>
						<div class='row'>
							<div class='col-md-2'>
								<span style='font-size: 13pt; font-weight: bolder;'>발자취</span>
							</div>
							<div class='col-md-4'>
								<span style='font-size: 10pt;'>~ 2016.03</span>
							</div>
							<div class='col-md-6'>
								<span style='font-size: 10pt;'>충남대 환경소재공학과 재학</span>
							</div>
						</div>
						<div class='row'>
							<div class='col-md-2'>
							</div>
							<div class='col-md-4'>
								<span style='font-size: 10pt;'>2016.03 ~ 2018.08</span>
							</div>
							<div class='col-md-6'>
								<span style='font-size: 10pt;'>충북대 사회학과 편입 후 졸업</span>
							</div>
						</div>
						<div class='row'>
							<div class='col-md-2'>
							</div>
							<div class='col-md-4'>
								<span style='font-size: 10pt;'>2018.07 ~ 2018.11<br/></span><br/>
							</div>
							<div class='col-md-6'>
								<span style='font-size: 10pt;'>c 언어 기초 독학 후</span><br/>
								<span style='font-size: 10pt;'>자바 공부 시작</span>
							</div>
						</div>
						<div class='row'>
							<div class='col-md-2'>
							</div>
							<div class='col-md-4'>
								<span style='font-size: 10pt;'>2018.07 ~ 2018.12</span><br/>
							</div>
							<div class='col-md-6'>
								<span style='font-size: 10pt;'>정보처리기사 취득</span>
							</div>
						</div>
						<div class='row'>
							<div class='col-md-2'>
							</div>
							<div class='col-md-4'>
								<span style='font-size: 10pt;'>2018.12 ~ </span><br/>
							</div>
							<div class='col-md-6'>
								<span style='font-size: 10pt;'>중앙 HTA 풀스택 양성과정 수강중<br/>(~ 19.05 수료예정)</span>
							</div>
						</div>
						<div class='row' style='margin-bottom: 20px;'>
							<div class='col-md-2'>
							</div>
							<div class='col-md-4'>
								<span style='font-size: 10pt;'>2019.02 ~ </span><br/>
							</div>
							<div class='col-md-6'>
								<span style='font-size: 10pt;'>개인 포트폴리오 웹사이트 제작</span>
							</div>
						</div>
						<div class='row' style='margin-bottom: 20px;'>
							<div class='col-md-2'>
								<span style='font-size: 13pt; font-weight: bolder;'>목표!</span>
							</div>
							<div class='col-md-10'>
								<span style='font-size: 12pt;'>최고는 아니어도 기술적으로 인정받는 사람 되기</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</article>
	
	<!-- guide -->
	<a class='btn btn-secondary my-btn-guide' id='guideThisPage' href='#' style='z-index: 1;' data-toggle='tooltip' data-placement='top' title='Guide this Website'>Help</a>
	
	<!-- button for to-top -->
	<a class='btn btn-secondary my-btn-toTop' href='#' onclick='funcMovePage("indexTop");' style='z-index: 1;' data-toggle='tooltip' data-placement='top' title='go to header'>top</a>
	
	<!-- include footer -->
	<footer style='z-index: 0;'>
		<jsp:include page="/WEB-INF/views/component/footer.jsp"></jsp:include>
	</footer>
	
    <!-- Modal -->
    <jsp:include page="/WEB-INF/views/component/modal.jsp"></jsp:include>
	
</body>
</html>
