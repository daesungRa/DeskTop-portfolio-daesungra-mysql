<%@page import="com.daesungra.domain.MemberVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<title>Member Info Page</title>
</head>
<body>
	
	<c:choose>
		<c:when test='${requestScope.flag == "2" }'>
			<c:set var="vo" value="${requestScope.memberVo }" scope='page'></c:set>
			<div id='flag' hidden="">2</div>
		</c:when>
		<c:when test='${requestScope.flag == "1" }'>
			<c:set var="vo" value="${requestScope.memberVo }" scope='page'></c:set>
			<div id='flag' hidden="">1</div>
		</c:when>
		<c:otherwise>
			<c:set var="vo" value="${requestScope.memberVo }" scope='page'></c:set>
			<div id='flag' hidden="">0</div>
		</c:otherwise>
	</c:choose>

	<div class='container'>
		<div class='container' id='memberModifyForm'>
			<form class='form' name='joinFrm' id='joinFrm' action='#joinAction' method='post' enctype='multipart/form-data'>
				<div class='form-group'>
					<div class='form-inline'>
						<label for="userId">아이디</label>
						<input class='form-control' type='text' id='userId' name='userId' maxlength='30' value='${vo.userId }' placeholder='아이디 입력 (필수)' readonly="readonly" style='width: 50%;' />
						<input class='btn btn-primary' type='button' id='btnIdChk' name='btnIdChk' value='중복확인' style='margin-right: 10px; display: none;'></input>
						<input type='hidden' id='userIdChk' value='unChecked' readonly/>&nbsp;&nbsp;&nbsp;&nbsp;
						<div id='userIdChkResult' style='color: #0000ff; width: 40%;'></div>
					</div>
				</div>
				<div class='form-group'>
					<div class='form-inline'>
						<label for="userPwd01" style='display: none;'>비밀번호</label>
						<input class='form-control' type='password' id='userPwd01' name='userPwd' maxlength='30' value='' placeholder='비밀번호 입력 (필수)' style='display: none; width: 60%;' />
						<input class='form-control' type='password' id='userPwd02' name='userPwdChk' maxlength='30' placeholder='비밀번호 확인 (필수)' style='display: none; width: 60%;' />
						<input type='hidden' id='userPwdChk' value='unChecked' readonly/>
						<div id='userPwdChkResult' style='color: #ff0000;'></div>
					</div>
				</div>
				<div class='form-group'>
					<div class='form-inline'>
						<label for="userName">이름</label>
						<input class='form-control' type='text' id='userName' name='userName' value='${vo.userName }' placeholder='이름 입력' readonly style='width: 50%;' />
						<input type='hidden' id='userNameChk' value='unChecked' readonly/>
						<div id='userNameChkResult' style='color: #ff0000;'></div>
					</div>
				</div>
				<div class='form-group'>
					<div class='form-inline'>
						<label for="email">이메일</label>
						<input class='form-control' type='email' id='email' name='email' value='${vo.email }' placeholder='이메일 입력' readonly="readonly" style='width: 50%;' />
						<input type='hidden' id='emailChk' value='unChecked' readonly/>
						<div id='emailChkResult' style='color: #ff0000;'></div>
					</div>
				</div>
				<div class='form-group'>
					<div class='form-inline'>
						<label for="phone">연락처</label>
						<input class='form-control' type='text' id='phone' name='phone' value='${vo.phone }' placeholder="연락처 입력 ('-' 포함, 필수)" readonly="readonly" style='width: 50%;' />
						<input type='hidden' id='phoneChk' value='unChecked' readonly/>
						<div id='phoneChkResult' style='color: #ff0000;'></div>
					</div>
				</div>
				<div class='form-group'>
					<label for="postal">주소정보</label>
					<div class='form-inline'>
						<input class='form-control' type='text' id='postal' name='postal' value='${vo.postal }' placeholder='우편번호' style='width: 30%; margin-right: 10px;' readonly="readonly"/>
						<input class='btn btn-primary' type='button' id='btnPostal' name='btnPostal' value='주소 찾기' style='display: none;'></input>
					</div>
					<input class='form-control' type='text' id='address' name='address' value='${vo.address }' placeholder='주소 입력' readonly="readonly"/>
					<input class='form-control' type='text' id='addressAdd' name='addressAdd' value='${vo.addressAdd }' placeholder='추가 주소 입력' readonly="readonly" />
				</div>
				<div class='form-group' id='shiftPhoto' style='display: none;'>
					<label for="photo" style='width: 95px;'>프로필 사진 변경</label><br/>
					<%
						String dir = "";
						String fileName = "";
						if (request.getAttribute("memberVo") != null && ((MemberVo)request.getAttribute("memberVo")).getPhoto() != null) { // 전달된 vo 객체에 photo 가 존재한다면(없다면 빈 문자열 세팅)
							dir = ""; // 파일이 저장된 디렉토리
							fileName = ((MemberVo) request.getAttribute("memberVo")).getPhoto();
							fileName = fileName.substring(fileName.lastIndexOf("/") + 1, fileName.length()); // 파일명만 따오기
						}
					%>
					<%-- <script>alert('<%=dir + fileName %>');</script> --%>
					<input type='file' id='photo' name='photo' value='<%=dir + fileName %>' style='padding: 3px 0 3px 3px; border: 1px solid #cdcdcd; border-radius: 5px;' /><br/>
				</div>	
				<div class='form-group'>
					<input class='btn btn-primary' type='button' id='btnModifySubmit' name='btnModifySubmit' value='제 출' style='display: none;' />
					<input class='btn btn-primary' type='button' id='btnModifyCancel' name='btnModifyCancel' value='취 소' style='display: none;' />
				</div>
				<div class='form-group'>
					<input class='btn btn-primary' type='button' id='showModifyPage' name='showModifyPage' value='정보 수정' />
					<!-- <input class='btn btn-primary' type='button' id='btnChangePwd' name='btnChangePwd' value='비밀번호 변경' /> -->
					<input class='btn btn-primary' type='button' id='btnMemberLeave' name='btnMemberLeave' value='회원 탈퇴' />
				</div>
				<div class='form-group' id='hiddenVal'>
					<input class='form-control' type='hidden' id='mDate' name='mDate' value='${vo.mDate }' />
					<input class='form-control' type='hidden' id='fNum' name='fNum' value='${vo.fNum }' />
				</div>
			</form>
			<p/>
		</div>
		<div class='container' id='memberImg'>
			<c:choose>
				<c:when test="${not empty vo and not empty vo.photo }">
					<img id='image' src='${vo.photo }' width='150px' height='200px' /><br/>
					${vo.photo }<br/>
					<p>이미지 미리보기(${vo.photoOri })</p>
				</c:when>
				<c:otherwise>
					<img id='image' src='https://via.placeholder.com/150x200?text=Your Imgs here' width='150px' height='200px' /><br/>
					<p>등록된 사진이 없습니다</p>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

</body>
</html>