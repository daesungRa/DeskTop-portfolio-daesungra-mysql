/*
 * 작성자: 라대성
 * 작성일: 190216
 * 기능: mypage
 */

/*
 * login
 */
// 입력 내용 체크 후 로그인 실행 함수
function funcLoginAction () {
	var loginFrm = $('#loginFrm');
	var userId = $('#loginFrm #userId');
	var userPwd = $('#loginFrm #userPwd');
	var btnLoginSubmit = $('#loginFrm #btnLoginSubmit');
	
	userId.focus();
	userId.select();
	
	userId.keyup(function (ev) {
		if (ev.keyCode == '13') {
			userPwd.focus();
			userPwd.select();
		}
	});
	userPwd.keyup(function (ev) {
		if (ev.keyCode == '13') {
			btnLoginSubmit.trigger('click');
		}
	});
	
	btnLoginSubmit.click(function () {
		if (userId.val() == '') {
			alert('아이디를 입력하세요.');
			userId.focus();
		} else if (userPwd.val() == '') {
			alert('비밀번호를 입력하세요.');
			userPwd.focus();
		} else {
			// loginFrm.submit();
			$.post('/desktop/member/login',
			{
				userId: $('#loginFrm #userId').val(),
				userPwd: $('#loginFrm #userPwd').val()
			},
			function (data, status){
				var result = data;
				if (result == '1') { // 일반 유저 로그인
					if ($('#boardViewContainer') != null &&  $('#boardCommentContent') != null) {
						location.reload();
					} else {
						location.href = '/desktop';
					}
				} else if (result == '2') { // 관리자 로그인
					location.href = '/desktop/admin/getAdminPage/1';
				} else if (result == '0') { // 로그인 실패
					alert('아이디나 암호를 확인해주세요.');
					userPwd.val('');
					userId.focus();
					userId.select();
				} else if (result == "99") {
					alert('블럭된 계정입니다. 관리자에게 문의하십시오');
					userPwd.val('');
					userId.focus();
					userId.select();
				}
			});
		}
	});
	
	// 아이디 찾기 페이지 로드
	$('#finduserIdAnc').click(function () {
		$.ajax({
			type: 'get',
			url: '/desktop/member/findIdForm',
			dataType: 'html',
			success: function (html, status) {
				innerModalContent.innerHTML = html;
				modalWindow.style.display = 'block';
				
				funcFinduserId();
			}
		})
	});

	// 비밀번호 찾기 페이지 로드
	$('#finduserPwdAnc').click(function () {
		$.ajax({
			type: 'get',
			url: '/desktop/member/findPwdForm',
			dataType: 'html',
			success: function (html, status) {
				innerModalContent.innerHTML = html;
				modalWindow.style.display = 'block';
				
				funcFinduserPwd();
			}
		})
	});
	
	// 회원가입 페이지 로드
	$('#logintojoinAnc').click(function () {
		$.ajax({
			type: 'get',
			url: '/desktop/member/joinForm',
			dataType: 'html',
			success: function (html, status) {
				innerModalContent.innerHTML = html;
				modalWindow.style.display = 'block';
				
				funcJoinAction();
			}
		})
	});
}

// 아이디 찾기 함수
function funcFinduserId () {
	// 뒤로가기 (로그인 파트로)
	$('.my-find-part #toLoginPart').click(function () {
		$.ajax({
			type: 'get',
			url: '/desktop/member/loginForm',
			dataType: 'html',
			success: function (html, status) {
				innerModalContent.innerHTML = html;
				//$('#btnShowModal').trigger('click');
				
				funcLoginAction();
			}
		});
	});
	
	// 아이디 찾기 액션
	$('.my-find-part #findIdForm #btnFindId').click(function () {
		var userName = $('.my-find-part #findIdForm #userName').val();
		var receiver = $('.my-find-part #findIdForm #receiver').val();
		
		if (userName != '') {
			if (receiver != '') {
				var params = $('.my-find-part #findIdForm').serialize();
				$.ajax({
					type: 'post',
					url: '/desktop/email/findIdAction',
					data: params,
					dataType: 'text',
					success: function (text) {
						if (text == '1') { // 성공
							alert('메일 발송을 완료했습니다. 확인 후 로그인 하십시오');

							$.ajax({
								type: 'get',
								url: '/desktop/member/loginForm',
								dataType: 'html',
								success: function (html, status) {
									innerModalContent.innerHTML = html;
									//$('#btnShowModal').trigger('click');
									
									funcLoginAction();
								}
							});
						} else if (text == '0') { // 서버 실패
							alert('메일 발송에 실패했습니다. 관리자에게 문의하십시오');

							$.ajax({
								type: 'get',
								url: '/desktop/member/loginForm',
								dataType: 'html',
								success: function (html, status) {
									innerModalContent.innerHTML = html;
									//$('#btnShowModal').trigger('click');
									
									funcLoginAction();
								}
							});
						} else if (text == '2') { // 일치 정보 없음
							alert('입력하신 정보에 해당하는 계정이 존재하지 않습니다.\n확인 후 다시 시도하세요');

							$('.my-find-part #findIdForm #userName').focus();
							$('.my-find-part #findIdForm #userName').select();
						}
					}
				});
			} else {
				alert('이메일을 입력하세요');
				$('.my-find-part #findIdForm #receiver').focus();
				$('.my-find-part #findIdForm #receiver').select();
			}
		} else {
			alert('이름을 입력하세요');
			$('.my-find-part #findIdForm #userName').focus();
			$('.my-find-part #findIdForm #userName').select();
		}
	});
}

// 비밀번호 찾기 함수
function funcFinduserPwd () {
	// 뒤로가기 (로그인 파트로)
	$('.my-find-part #toLoginPart').click(function () {
		$.ajax({
			type: 'get',
			url: '/desktop/member/loginForm',
			dataType: 'html',
			success: function (html, status) {
				innerModalContent.innerHTML = html;
				//$('#btnShowModal').trigger('click');
				
				funcLoginAction();
			}
		});
	});
	
	// 비밀번호 찾기 액션
	$('.my-find-part #findPwdForm #btnFindPwd').click(function () {
		var userId = $('.my-find-part #findPwdForm #userId').val();
		var userName = $('.my-find-part #findPwdForm #userName').val();
		var receiver = $('.my-find-part #findPwdForm #receiver').val();
		
		if (userId != '') {
			if (userName != '') {
				if (receiver != '') {
					var params = $('.my-find-part #findPwdForm').serialize();
					$.ajax({
						type: 'post',
						url: '/desktop/email/findPwdAction',
						data: params,
						dataType: 'text',
						success: function (text) {
							if (text == '1') {
								alert('메일 발송을 완료했습니다. 확인 후 로그인 하십시오');

								$.ajax({
									type: 'get',
									url: '/desktop/member/loginForm',
									dataType: 'html',
									success: function (html, status) {
										innerModalContent.innerHTML = html;
										
										funcLoginAction();
									}
								});
							} else {
								alert('메일 발송에 실패했습니다. 관리자에게 문의하십시오');

								$.ajax({
									type: 'get',
									url: '/desktop/member/loginForm',
									dataType: 'html',
									success: function (html, status) {
										innerModalContent.innerHTML = html;
										
										funcLoginAction();
									}
								});
							}
						}
					});
				} else {
					alert('이메일을 입력하세요');
					$('.my-find-part #findPwdForm #receiver').focus();
					$('.my-find-part #findPwdForm #receiver').select();
				}
			} else {
				alert('이름을 입력하세요');
				$('.my-find-part #findPwdForm #userName').focus();
				$('.my-find-part #findPwdForm #userName').select();
			}
		} else {
			alert('아이디를 입력하세요');
			$('.my-find-part #findPwdForm #userId').focus();
			$('.my-find-part #findPwdForm #userId').select();
		}
	});
}

/*
 * join
 */
// 입력정보 체크 후 조인 실행 함수
function funcJoinAction () {
	var xhr = new XMLHttpRequest();
	var joinFrm = document.joinFrm;
	
	joinFrm.userId.focus();
	joinFrm.userId.select();
	
	// userId
	joinFrm.btnIdChk.onclick = function () {
		funcIdChk(xhr);
	}
	// userPwd
	joinFrm.userPwd01.onkeyup = function () {
		funcPwdChk(userPwd01, userPwd02);
	}
	joinFrm.userPwd02.onkeyup = function () {
		funcPwdChk(userPwd01, userPwd02);
	}
	// userName
	joinFrm.userName.onkeyup = function () {
		funcNameChk();
	}
	// email
	joinFrm.email.onkeyup = function () {
		funcEmailChk();
	}
	// phone
	joinFrm.phone.onkeyup = function () {
		funcPhoneChk();
	}
	// postal, address
	joinFrm.btnPostal.onclick = function () {
        searchPostal();
    }
	// photo file
	joinFrm.photo.onchange = imagePreView;
	// btn submit
	joinFrm.btnJoinSubmit.onclick = function () {
		funcJoinSubmit(joinFrm);
	}
	// cancel
	joinFrm.btnJoinCancel.onclick = function () {
		$('#joinAnc').trigger('click');
	}
}

// 아이디 체크 함수
function funcIdChk (xhr) {
	var userId = document.getElementById('userId');
	var btnIdChk = document.getElementById('btnIdChk');
	var userIdChk = document.getElementById('userIdChk');
	var userIdChkResult = document.getElementById('userIdChkResult');
	
	if (userId.value == '') {
		alert('아이디를 입력하세요');
		userId.focus();
		return;
	}

	if (btnIdChk.value == '중복확인') { // 기본 ajax 방식
		xhr.open('post', '/desktop/member/idChk');
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xhr.send('userId=' + userId.value);
		xhr.onreadystatechange = function () {
			if(xhr.readyState == 4 && xhr.status == 200) {
				var result = xhr.responseText;
				if (result != '1') {
					alert('아이디 중복확인 완료');
					userId.setAttribute("readonly", true);
					userIdChk.value = 'checked';
					btnIdChk.value = '재설정';
					userIdChkResult.innerHTML = '중복확인 완료';
				} else {
					alert('이미 존재하는 아이디입니다');
					userIdChk.value = 'unChecked';
					userId.focus();
					userId.select();
					userIdChkResult.innerHTML = '';
				}
			}
		}
	} else if (btnIdChk.value == '재설정') {
		userId.removeAttribute("readonly");
		userIdChk.value = 'unChecked';
		btnIdChk.value = '중복확인';
		userId.focus();
		userId.select();
		userIdChkResult.innerHTML = '';
	}
}
	// 비번 체크 함수
function funcPwdChk (userPwd01, userPwd02) {
	var userPwdChk = document.getElementById('userPwdChk');
	var userPwdChkResult = document.getElementById('userPwdChkResult');
	
	if (userPwd01.value != userPwd02.value || userPwd01.value == '') {
		userPwdChk.value = 'unChecked';
		userPwdChkResult.innerHTML = '비밀번호가 일치하지 않습니다';
	} else if (userPwd01.value == userPwd02.value || userPwd01.value != '') {
		userPwdChk.value = 'checked';
		userPwdChkResult.innerHTML = '';
	}
}
	// 이름 체크 함수
function funcNameChk () {
	var joinFrm = document.joinFrm;
	var userNameExp = /^[가-힣a-zA-Z]+$/;
	var userName = document.getElementById('userName');
	var userNameChk = document.getElementById('userNameChk');
	var userNameChkResult = document.getElementById('userNameChkResult');
	
	if (userNameExp.test(userName.value)) {
		userNameChk.value = 'checked';
		userNameChkResult.innerHTML = '';
	} else {
		userNameChk.value = 'unChecked';
		userNameChkResult.innerHTML = '한글 혹은 영문으로만 입력하십시오';
	}
}
	// 이메일 체크
function funcEmailChk () {
	var emailExp = /^\w+@\w+.\w(.\w){1,2}/;
	var email = document.getElementById('email');
	var emailChk = document.getElementById('emailChk');
	var emailChkResult = document.getElementById('emailChkResult');
	
	if (emailExp.test(email.value)) {
		emailChk.value = 'checked';
		emailChkResult.innerHTML = '';
	} else {
		emailChk.value = 'unChecked';
		emailChkResult.innerHTML = '이메일 형식에 맞게 입력하십시오';
	}
}
	// 전화번호 체크
function funcPhoneChk () {
	var phoneExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
	var phone = document.getElementById('phone');
	var phoneChk = document.getElementById('phoneChk');
	var phoneChkResult = document.getElementById('phoneChkResult');
	
	if (phoneExp.test(phone.value)) {
		phoneChk.value = 'checked';
		phoneChkResult.innerHTML = '';
	} else {
		phoneChk.value = 'unChecked';
		phoneChkResult.innerHTML = '연락처 형식에 맞게 입력하십시오';
	}
}
	// 우편번호 찾기 API (daum kakao)
function searchPostal () {
    new daum.Postcode({
        oncomplete: function(data) {
            var frm = document.joinFrm;
            frm.postal.value = data.zonecode;
            frm.address.value = data.address;
        }
    }).open();
}
	// 이미지 미리보기 함수
function imagePreView (e) {
    var profile = document.getElementById('image');
    var url = e.srcElement;
    var file = url.files[0];
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function (e2) {
        var img = new Image();
        img.src = e2.target.result;
        profile.src = img.src;
    }
}
	// 최종 제출 함수
function funcJoinSubmit (frm) {
	// 폼 내부 모든 input 중 타입이 hidden 인 태그만 검증
	var inputs = frm.getElementsByTagName('input');
	for (var i = 0; i < inputs.length; i++) {
		var tag = inputs[i];
		if (tag.type.toLowerCase() == 'hidden') {
			var chkState = tag.value;
			// 현재 태그가 unChecked 상태라면 메시지 발생 후 포커싱
			if (chkState == 'unChecked') {
				if (tag.id == 'userIdChk') {
					alert('아이디 중복확인이 필요합니다');
					frm.userId.focus();
					frm.userId.select();
					return;
				} else if (tag.id == 'userPwdChk') {
					alert('비밀번호는 영문, 숫자, 특수문자 조합만 가능합니다');
					frm.userPwd.focus();
					frm.userPwd.select();
					return;
				} else if (tag.id == 'userNameChk') {
					alert('이름은 한글 혹은 영문으로만 입력하십시오');
					frm.userName.focus();
					frm.userName.select();
					return;
				} else if (tag.id == 'emailChk') {
					alert('이메일 형식에 맞게 입력하십시오');
					frm.email.focus();
					frm.email.select();
					return;
				} else if (tag.id == 'phoneChk') {
					alert("연락처 형식에 맞게 입력하십시오 ( '-' 포함)");
					frm.phone.focus();
					frm.phone.select();
					return;
				}
			}
		}
	} // 입력 데이터 검증 로직 끝
	
	// frm.submit();
	var formData = new FormData(frm);
	$.ajax({
		url: '/desktop/member/join',
		data: formData,
		contentType: false,
		processData: false,
		type: 'post',
		success: function (data) {
			var result = data;
			alert("조인 결과: " + result);
			if (result == '1') { // 회원가입 성공, 로그인 페이지로 이동
				alert('회원가입에 성공했습니다. 로그인해 주십시오.');
				
				// 로그인 모달 열기
				var modalWindow = document.getElementById('modalWindow');
				var modalContent = document.getElementById('modalContent');
				var innerModalContent = document.getElementById('innerModalContent');
				
				$.ajax({
					type: 'get',
					url: '/desktop/member/loginForm',
					dataType: 'html',
					success: function (html, status) {
						modalContent.setAttribute('style', 'height: 60%; margin: 12% auto;');
						innerModalContent.setAttribute('style', 'position: absolute; width: 96%; height: 90%; top: -10px;');
						
						innerModalContent.innerHTML = html;
						modalWindow.style.display = 'block';
						
						funcLoginAction();
					}
				})
			} else if (data == '0') { // 회원가입 실패, 페이지 이동 없음
				alert('회원가입에 실패했습니다. 입력 정보를 다시 확인하세요.');
				frm.userId.focus();
				frm.userId.select();
			} else {
				alert('회원가입에 실패했습니다. 관리자에게 문의하십시오.');
				frm.userId.focus();
				frm.userId.select();
			}
		}
	})
} // end of join function

/*
 * view
 */
// 회원정보 조회 페이지가 성공적으로 로드되면 실행되는 함수
// 수정 페이지로 이동, 회원탈퇴 로직 처리
function funcMemberInfo () {
	var modalWindow = document.getElementById('modalWindow');
	var modalContent = document.getElementById('modalContent');
	var innerModalContent = document.getElementById('innerModalContent');
	
	$('#profileForm #descIsPublic').tooltip();
	
	$('#btnModifyProfile').click(function () {
		$('#profileForm #alertUserName').css({"display":"block"});
		$('#profileForm #nickName').removeAttr('readonly');
		$('#profileForm #interest').removeAttr('readonly');
		$('#profileForm #introduce').removeAttr('readonly');

		$('#profileForm #isPublic').removeAttr('disabled');
		$('#profileForm #descIsPublic').css({"display":"none"});
		$('#profileForm #btnModifyProfile').css({"display":"none"});
		$('#profileForm #btnModifyProfileSubmit').css({"display":"inline-block"});
		$('#profileForm #btnModifyProfileCancel').css({"display":"inline-block"});
		
		funcModifyProfileAction();
	});
	
	$('#showModifyPage').click(function () { // 회원정보 수정 페이지 로드
		// alert('회원정보 수정 페이지입니다.');
		/*swal({
		  title: "회원정보 수정",
		  text: "회원정보 수정 페이지입니다",
		  icon: "success",
		});*/
		$('#infoTitle').text('회원정보 수정');
		// $('#userId').removeAttr('readonly');
		$('#joinFrm #userIdChkResult').text('아이디는 수정 불가합니다.');
		// $('#btnIdChk').css('display', 'block');
		$('#userIdChk').val('checked'); // 아이디는 세션 아이디 사용
		$('#userPwdChk').val('checked'); // 비번은 사용자 입력 비번 사용
		$('#joinFrm #userName').removeAttr('readonly');
		$('#joinFrm #userNameChk').val('checked');
		$('#joinFrm #email').removeAttr('readonly');
		$('#joinFrm #emailChk').val('checked');
		$('#joinFrm #phone').removeAttr('readonly');
		$('#joinFrm #phoneChk').val('checked');
		$('#btnPostal').css('display', 'block');
		$('#addressAdd').removeAttr('readonly');
		$('#joinFrm #shiftPhoto').css('display', 'block');
		$('#btnModifySubmit').css('display', 'inline-block');
		$('#btnModifyCancel').css('display', 'inline-block');
		$('#showModifyPage').css('display', 'none');
		$('#btnMemberLeave').css('display', 'none');
		
		funcModifyAction();
	});
	$('#btnMemberLeave').click(function () { // 회원탈퇴. 비번 확인 필수
		var inputPwd = prompt('회원탈퇴를 위해 가입 시 등록한 비밀번호를 입력하십시오.');
		if (inputPwd != null && inputPwd != '') {
			var result = confirm('정말 탈퇴하시겠습니까? 관련된 모든 정보는 삭제됩니다.');
			if (result) {
				$.post(
					'/desktop/member/memberLeave',
					{userPwd: inputPwd},
					function (data, status){
						if (data == '1') {
							alert('회원탈퇴가 완료되었습니다.');
							location.href = '/desktop'; // 탈퇴시 관련 파일도 삭제되도록
						} else if (data == '0') {
							alert('회원탈퇴에 실패했습니다. 입력 정보를 다시 확인해주세요.');
							// location.href = '/desktop';
						}
						return;
					}
				);
			} else {
				alert('회원탈퇴가 취소되었습니다.');	
			}
		} else {
			alert('회원탈퇴가 취소되었습니다.');	
		}
	});
}

/*
 * modify
 */
// 입력정보 체크 후 modify 실행 함수
// 각종 체크 함수는 조인 로직의 것을 활용
function funcModifyAction () {
	var xhr = new XMLHttpRequest();
	var joinFrm = document.joinFrm;
	
	joinFrm.userName.focus();
	joinFrm.userName.select();
	
	// userId
	joinFrm.btnIdChk.onclick = function () {
		funcIdChk(xhr);
	}
	// userPwd
	joinFrm.userPwd01.onkeyup = function () {
		funcPwdChk(userPwd01, userPwd02);
	}
	joinFrm.userPwd02.onkeyup = function () {
		funcPwdChk(userPwd01, userPwd02);
	}
	// userName
	joinFrm.userName.onkeyup = function () {
		funcNameCheck();
	}
	// email
	joinFrm.email.onkeyup = function () {
		funcEmailChk();
	}
	// phone
	joinFrm.phone.onkeyup = function () {
		funcPhoneChk();
	}
	// postal, address
	joinFrm.btnPostal.onclick = function () {
        searchPostal();
    }
	// photo file
	joinFrm.photo.onchange = imagePreView;
	// btn submit
	joinFrm.btnModifySubmit.onclick = function () {
		funcModifySubmit(joinFrm);
	}
	// cancel
	joinFrm.btnModifyCancel.onclick = function () {
		// window.location.reload(); // 수정 요망
		$('#navtab-info-tag').trigger('click');
	}
}
//회원정보 수정 최종 제출 함수
function funcModifySubmit (frm) {
	// 폼 내부 모든 input 중 타입이 hidden 인 태그만 검증
	var inputs = frm.getElementsByTagName('input');
	for (var i = 0; i < inputs.length; i++) {
		var tag = inputs[i];
		if (tag.type.toLowerCase() == 'hidden') {
			var chkState = tag.value;
			// 현재 태그가 unChecked 상태라면 메시지 발생 후 포커싱
			if (chkState == 'unChecked') {
				if (tag.id == 'userPwdChk') {
					alert('비밀번호는 영문, 숫자, 특수문자 조합만 가능합니다');
					frm.userPwd.focus();
					frm.userPwd.select();
					return;
				} else if (tag.id == 'userNameChk') {
					alert('이름은 한글 혹은 영문으로만 입력하십시오');
					frm.userName.focus();
					frm.userName.select();
					return;
				} else if (tag.id == 'emailChk') {
					alert('이메일 형식에 맞게 입력하십시오');
					frm.email.focus();
					frm.email.select();
					return;
				} else if (tag.id == 'phoneChk') {
					alert("연락처 형식에 맞게 입력하십시오 ( '-' 포함)");
					frm.phone.focus();
					frm.phone.select();
					return;
				}
			}
		}
	}
	if ($('#joinFrm #userName').val() == '') {
		alert('이름을 입력하십시오');
		return;
	}
	if ($('#joinFrm #email').val() == '') {
		alert('이메일을 입력하십시오');
		return;
	}
	if ($('#joinFrm #phone').val() == '') {
		alert('연락처를 입력하십시오');
		return;
	} // 입력 데이터 검증 로직 끝
	
	// 비밀번호 입력 및 수정 최종 확인 메시지
	var inputPwd = prompt('회원정보 수정을 위해 가입 시 등록한 비밀번호를 입력하십시오.');
	if (inputPwd != null && inputPwd != '') {
		$('#userPwd01').val(inputPwd); // 입력받은 비밀번호를 폼 태그 내에 세팅
	} else {
		alert('회원정보 수정 취소');
		frm.userName.focus();
		frm.userName.select();
		return;
	}
	
	// 제출
	// frm.submit();
	var formData = new FormData(frm);
	alert('회원정보 수정 시작');
	$.ajax({
		url: '/desktop/member/memberModify',
		data: formData,
		contentType: false,
		processData: false,
		type: 'post',
		success: function (data) {
					var result = data;
					alert("회원정보 수정 결과: " + result);
					if (result == '1') { // 회원정보 수정 성공, 뷰 페이지로 이동
						alert('회원정보 수정에 성공했습니다.');
						
						// view 모달 열기
						$('#navtab-info-tag').trigger('click');
					} else if (data == '0') { // 회원정보 수정 실패, 페이지 이동 없음
						alert('회원정보 수정에 실패했습니다. 입력 정보를 다시 확인하세요. 혹은 비밀번호가 일치하지 않았을 수 있습니다.');
						frm.userName.focus();
						frm.userName.select();
					} else {
						alert('회원정보 수정에 실패했습니다. 관리자에게 문의하십시오.');
						frm.userName.focus();
						frm.userName.select();
					}
				}
	});
} // end of modify info function
	// [modify] 이름 체크 함수
function funcNameCheck () {
	/*var userNameExp = /^[가-힣a-zA-Z]+$/;
	var userName = document.getElementById('userName');
	var userNameChk = document.getElementById('userNameChk');
	var userNameChkResult = document.getElementById('userNameChkResult');
	
	if (userNameExp.test(userName.value)) {
		userNameChk.value = 'checked';
		userNameChkResult.innerHTML = '';
	} else {
		userNameChk.value = 'unChecked';
		userNameChkResult.innerHTML = '한글 혹은 영문으로만 입력하십시오';
	}*/
}
	// 프로필 수정 페이지에서 실행됨
function funcModifyProfileAction () {
	var profileForm = document.profileForm;
	profileForm.photo.onchange = imagePreView2; // 사진이 변경되면 이미지 프리뷰
	
	profileForm.nickName.focus();
	profileForm.nickName.select();
	
	$('#profileForm #shiftPhoto').css({"display":"block"}); // 블럭, 프로필 사진 변경
	$('#isPublic').change(function () { // 공개유무 설정. 0 은 비공개, 1 은 공개
		var isPublic = $('#profileForm #isPublic');

		if ($('#profileForm #iPsPublic').attr('checked') == 'checked') {
			$('#profileForm #isPublic').val('0');
			$('#profileForm #isPublic').attr('checked', false);
		} else if ($('#profileForm #isPublic').attr('checked') == null) {
			$('#profileForm #isPublic').val('1');
			$('#profileForm #isPublic').attr('checked', true);
		}
		alert($('#profileForm #isPublic').attr('checked') + ' >> ' + $('#profileForm #isPublic').val());
	});
	$('#profileForm #btnModifyProfileCancel').click(function () { // 프로필 업데이트 취소
		$('#navtab-profile-tag').trigger('click');
	});
	
	$('#btnModifyProfileSubmit').click(function () {
		funcModifyProfileSubmit(profileForm);
	});
}
	// 프로필은 접속정보만 확인되면 별도 제약없이 바로 변경됨
function funcModifyProfileSubmit (frm) {
	// 제출
	// frm.submit();
	var formData = new FormData(frm);
	alert('프로필 수정 시작');
	$.ajax({
		url: '/desktop/member/profileModify',
		data: formData,
		contentType: false,
		processData: false,
		type: 'post',
		success: function (data) {
					var result = data;
					alert("프로필 수정 결과: " + result);
					if (result == '1') { // 회원정보 수정 성공, 뷰 페이지로 이동
						alert('프로필 수정에 성공했습니다.');
						
						$('#navtab-profile-tag').trigger('click');
					} else if (data == '0') { // 회원정보 수정 실패, 페이지 이동 없음
						alert('프로필 수정에 실패했습니다. 입력 정보를 다시 확인하세요.');
						frm.nickName.focus();
						frm.nickName.select();
					} else {
						alert('프로필 수정에 실패했습니다. 관리자에게 문의하십시오.');
						frm.nickName.focus();
						frm.nickName.select();
					}
				}
	});
} // end of modify profile function
// 이미지 미리보기 함수 2
function imagePreView2 (e) {
    var profile = document.getElementById('profileImagePreview');
    var url = e.srcElement;
    var file = url.files[0];
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function (e2) {
        var img = new Image();
        img.src = e2.target.result;
        profile.src = img.src;
    }
}