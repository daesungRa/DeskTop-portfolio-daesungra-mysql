<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin member control part</title>
</head>
<body>
	
	<div class='container' id='adminMemberControlBody'>
		<div class='row'>
			<div class='col-sm-12' id='memberInfoModal'>
				<br/><br/>
				<div class='container' style='width: 90%; margin-bottom: 10px;'>
					<img src='/desktop/resources/imgs/icon_pencil01.png' alt='icon_pencil for board report control' style='width: 15px; padding-bottom: 5px; margin-right: 5px;' />
					<span style='font-size: 14pt;'>회원 조회</span>
				</div>
				<div class='container' style='width: 90%;'>
					<form class='form' id='memberInfoForm' name='memberInfoForm'>
						<div class='form-inline'>
							<input class='form-control' type='text' id='userId' name='userId' placeholder='조회할 아이디를 입력하세요' style='width: 40%; font-size: 10pt;' />
							<span class='btn btn-info' id='btnSearchMemberInfo' style='width: 70px; font-size: 10pt; margin-left: 15px;'>조회</span>
						</div>
					</form>
				</div><br/><br/>
				<div class='container' id='memberSearchResult' style='width: 80%;'>
					<div class='row' style='height: 30px; font-size: 9pt; border-top: 2px solid black; border-bottom: 1px solid black; padding-top: 4px; background-color: #dedede;'>
						<div class='col-md-1'></div>
						<div class='col-md-4'>아이디 / 블럭유무</div>
						<div class='col-md-4'>가입일</div>
						<div class='col-md-3'></div>
					</div>
					<div class='row my-adminList-row' id='noMemberInfo' style='height: 45px;'>
						<div class='col-md-12' style='text-align: center; margin-top: 10px;'>검색 결과가 없습니다</div>
					</div>
				</div>
				<br/><br/><br/><br/>
			</div>
		</div>
	</div>

</body>
</html>