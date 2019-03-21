<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modal component</title>
</head>
<body>
	
	<button type="button" class="btn btn-primary" id='btnShowModal' data-toggle="modal" data-target="#modalWindow" style='display: none;'></button>
    <div id="modalWindow" class="modal fade">
    	<div class="modal-dialog modal-lg modal-dialog-centered" style='z-index: 10;'>
		    <!-- Modal content -->
		    <div class='modal-content' id='modalContent'>
				<div id='innerModalContent'></div>
				<span class='btn btn-primary close' id='closeModal'>닫기</span>
			</div>
		</div>	    
    </div>

</body>
</html>