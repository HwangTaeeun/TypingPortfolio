<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Document</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<style>

.editPage {
	position: absolute;
	left: 50%;
	transform: translate(-50%, 0);
}

.filebox label {
	padding: .5em .75em;
	color: #333;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	/* border-bottom-color: #e2e2e2; */
	border-radius: .25em;
}

.filebox input[type="file"] { /* 파일 필드 숨기기 */
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

/* imaged preview */
.filebox .upload-display { /* 이미지가 표시될 지역 */
	margin-bottom: 5px;
}

@media ( min-width : 768px) {
	.filebox .upload-display {
		margin-right: 5px;
		margin-bottom: 0;
	}
}

.filebox .upload-thumb-wrap { /* 추가될 이미지를 감싸는 요소 */
	vertical-align: middle;
}

.filebox .upload-display img { /* 추가될 이미지 */
	display: block;
	max-width: 100%;
}

.defaultImg {
	padding: .5em .75em;
	color: #333;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: white;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-radius: .25em;
}

.myBtn {
	border: 1px solid #999999;
	border-radius: .25em;
}
</style>
</head>

<body>
	<!-- 메뉴바  -->
	<div class="w3-green w3-bar">
		<div class="w3-bar-item w3-button" id="openBtn">
			<button class="w3-button">&#9776;</button>
		</div>
		<div class="w3-bar-item w3-right">
			<c:if test="${empty SID}">
				<button class="w3-button w3-hover-green" id="loginBtn">LOGIN</button>
			</c:if>
			<c:if test="${not empty SID}">
				<!-- <button class="w3-button w3-hover-green" id="memInfo">회원정보보기</button> -->
				<button class="w3-button w3-hover-green" id="logout">LOGOUT</button>
			</c:if>
		</div>
	</div>
	
	<!-- 회원정보 변경구간 -->
	<div class="w3-row">
		<div class="w3-col m4 editPage">
			<h3>USER PICTURE</h3>
			 <!-- <form enctype="multipart/form-data" action="editProc.van" method="POST" onsubmit="return nnameCk()" id="frm" > -->
				<img src="/eun/img/man.jpg" style="width: 200px; height: 200px;"
					class="w3-circle w3-margin-top " id="LoadImg">
				<div class="w3-margin-top w3-row">
					<div class="filebox preview-image">
						<label for="input-file" class="w3-left">변경</label> <input
							type="file" id="input-file" class="upload-hidden" name="sFile"
							onchange="LoadImg(this)"
							>
					</div>
					<div class="filebox preview-image">
						<button class="defaultImg w3-margin-left w3-button w3-hover-white"
							id="defalutImgId">기본이미지</button>
					</div>
				</div>
				<hr>
				<h3>NICKNAME</h3>
				<div class="w3-bar">
					<input type="text" class="myBtn" value="${DATA.nname}" id="nname" name="nname">
					<input type="hidden" value="${SID}" name="id">
				</div>
				<span class="w3-small" id="nnameCkId"></span>
				<div class="w3-margin-top w3-center">
					<input type="submit"
						class="w3-button w3-white w3-border w3-hover-white myBtn" value="적용" id="nnameBtn">
						<input type="button"
						class="w3-button w3-white w3-border w3-hover-white myBtn"
						value="돌아가기" id="backBtn">
				</div>
			 <!-- </form> -->
		</div>
	</div>
	<script type="text/javascript" src="/eun/js/jquery-3.4.1.min.js"></script>
	<script>
		//기본이미지로 변경
		$('#defalutImgId').click(function() {
			$('#LoadImg').attr('src', '/eun/img/man.jpg');
		});

		//사진변경시 미리보기
		function LoadImg(value) {
			if (value.files && value.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#LoadImg').attr('src', e.target.result);
				}
				reader.readAsDataURL(value.files[0]);
			}
		}
		
		function nnAjax(){
			var result = true;
			$.ajax({
				url : "/eun/member/nnameCk.van",
				type : "post",
				dataType : "JSON",
				data : {
					"nname" : cnname
				},
				success : function(cnt) {
					var ck = cnt;
					if (ck == 1) {
						alert("if입니다 asassss.");
						$('.w3-small').text('이미 등록된 닉네임 입니다.').css('color',
								'red');
						result = false; 
					} else {
						alert("else입니다.");
						result = false;
					}
				},
				error : function() {
					alert('####통신오류####');
				}
			});
			return result; 
		}

		function nnameCk() {
			var cnname = $('#nname').val();
			var snname = "<%=session.getAttribute("SNNAME") %>"
			var result = true;
			if(snname == cnname){
				alert('적용되었습니다.');
				console.log(cnname);
				return true;
			}else{
				$.ajax({
					url : "/eun/member/nnameCk.van",
					type : "post",
					dataType : "JSON",
					async: false,
					data : {
						"nname" : cnname
					},
					success : function(cnt) {
						var ck = cnt;
						if (ck == 1) {
							$('.w3-small').text('이미 등록된 닉네임 입니다.').css('color',
									'red');
							result = false; 
						} else {
							alert('적용되었습니다.');
							result = true;
						}
					},
					error : function() {
						alert('####통신오류####');
					}
				});
				return result;
			}
			
		}
		//돌아가기 버튼
		$('#backBtn').click(function() {
			$(location).attr('href', '/eun/main.van');
		});
	</script>
</body>

</html>
