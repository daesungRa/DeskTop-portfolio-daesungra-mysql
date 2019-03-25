<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>show sample code</title>
</head>
<body>

	<div class="container-fluid my-guide-part">
	    <div class="row" style='margin: 40px auto;'>
	    	<div class='col-sm-1'></div>
	        <div class="col-md-10" id='findIdBody'>
	            <div class="account-wall">
	            	<div class='container' style='text-align: center;'>
	                	<span id='guideTitle'>비밀번호 암호화</span><hr style=''/><br/>
	                </div>
	                <p>사용자가 입력한 비밀번호 암호화를 위해 GetHashedData 클래스를 만들었습니다.<br/>각 메서드는 인스턴스 구현 없이 공통적으로 사용하기 위해 static 으로 만들었습니다.</p>
	                <span style='font-size: 14pt;'>1. getHashed64Bytes</span><br/><br/>
	                <p>
	                	&nbsp;&nbsp;다음 메서드는 입력받은 문자열을 해싱된 바이트 배열로 변환합니다.<br/>
	                	java.security 패키지의 MessageDigest 클래스로부터 SHA512 알고리즘이 적용된 인스턴스를 생성하고,<br/>
	                	byte[] 로 변환한 입력 문자열을 투입해 update 후 반환합니다
	                </p>
	                <img class='container-fluid' src='/desktop/resources/imgs/sampleCodeResult/getHashed64Bytes.png' alt='getHashed64Bytes' /><br/><br/>
	                <span style='font-size: 14pt;'>2. getRandom64Bytes</span><br/><br/>
	                <p>
	                	&nbsp;&nbsp;다음 메서드는 임의의 난수 바이트 배열 생성기입니다(PRNG).<br/>
	                	java.security 패키지의 SecureRandom 클래스로부터 SHA1PRNG 알고리즘이 적용된 인스턴스를 생성하고,<br/>
	                	generateSeed 메서드에 입력된 수 만큼의 byte[] 을 반환합니다.
	                </p>
	                <img class='container-fluid' src='/desktop/resources/imgs/sampleCodeResult/getRandom64Bytes.png' alt='getRandom64Bytes' /><br/><br/>
	                <span style='font-size: 14pt;'>3. getHashedStringFromBytes</span><br/><br/>
	                <p>
	                	&nbsp;&nbsp;다음 메서드는 입력받은 바이트 배열을 128 자리의 문자열로 변환합니다.<br/>
	                	64 자리 바이트 배열의 각 인덱스 숫자들을 16진수 문자열로 변환하고,<br/>두 자리 문자열로 보정하여(substring) StringBuffer 에 append 합니다.<br/>	                	
	                </p>
	                <img class='container-fluid' src='/desktop/resources/imgs/sampleCodeResult/getHashedStringFromBytes.png' alt='getHashedStringFromBytes' /><br/><br/>
	                <span style='font-size: 14pt;'>4. 해싱된 문자열 반환</span><br/><br/>
	                <p>
	                	&nbsp;&nbsp;generateRandomString 을 활용해 랜덤 문자열을 생성하고,<br/>generateHashedString 을 활용해 입력 문자열에 대한 해싱 결과를 얻습니다.
	                </p>
	                <img class='container-fluid' src='/desktop/resources/imgs/sampleCodeResult/getResultMethod.png' alt='getResultMethod' /><br/><br/>
	                <form class="form" id='findIdForm' name='findIdForm' method='post' action ='#findId'>
		                <input type="button" class="btn btn-md btn-info btn-block" id='btnCloseSampleCode' value='닫 기'>
	                </form>
	            </div>
	        </div>
	        <div class='col-sm-1'></div>
	    </div>
	</div>

</body>
</html>