<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
html, body {
	margin: 0;
	height: 100%;
	overflow: hidden;
}

.loginBox {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 500px;
}

/*모달창*/
.modalBack {
	position: absolute;
	left: 0;
	top: 0;
	display: none;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.6);
	z-index: 50;
}

.joinModal {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	position: absolute;
	display: none;
	width: 500px;
	z-index: 100;
	background-color: white;
	padding: 10px;
}
</style>
</head>

<body>
	<div class="loginBox">

		<!-- <form action="/eun/member/loginProc.van" method="POST" id="loginFr" onsubmit="return loginCk"> -->
		<label class="w3-text-blue"><b>I D</b></label> <input id="idId"
			name="id" class="w3-input w3-border" type="text">

		<div class="w3-margin-top">
			<label class="w3-text-blue w3-margin-top"><b>PASSWORD</b></label> <input
				id="pwId" name="pw" class="w3-input w3-border" type="password">
		</div>

		<div class="w3-right w3-margin-top">
			<input type="submit" class="w3-btn w3-blue" id="loginBtn"
				value="LOGIN"> <input type="button" class="w3-btn w3-blue"
				id="joinBtn" value="JOIN">
		</div>
		<!-- </form> -->


	</div>
	<div class="modalBack"></div>
	<div class="joinModal">
		<div>
			<h2 class="w3-text-blue w3-center">
				<b>JOIN</b>
			</h2>
		</div>
		<form name="fr" onsubmit="return finalCk();"
			action="/eun/member/joinProc.van" method="post">
			<div>
				<label class="w3-text-blue"><b>I D</b></label> <input
					class="w3-input" type="text" placeholder="4~12자의 영문 소문자,숫자" id="id"
					name="id"> <span class="w3-small" id="idCkId"></span>
			</div>
			<div class="w3-margin-top">
				<label class="w3-text-blue w3-margin-top"><b>PASSWORD</b></label> <input
					class="w3-input" type="password" placeholder="4~12자의 영문 소문자,숫자"
					id="pw" name="pw">
					<span class="w3-small" id="pwCkId"></span>
			</div>
			<div class="w3-margin-top">
				<label class="w3-text-blue w3-margin-top"><b>PASSWORD
						CONFIRM</b></label> <input class="w3-input" type="password" id="pwC"
					name="pwC">
					<span class="w3-small" id="pwcCkId"></span>
			</div>
			<div class="w3-margin-top">
				<label class="w3-text-blue"><b>NICKNAME</b></label> <input
					class="w3-input" type="text" placeholder="2~8자의 한글,영문,숫자" id="nname"
					name="nname"> 
					<span class="w3-small" id="nnameCkId"></span>
			</div>
			<div class="w3-margin-top">
				<label class="w3-text-blue w3-margin-top"><b>BIRTH</b></label> <input
					class="w3-input" type="text" placeholder="생년만 입력해주세요. ex)1991"
					id="birth" name="birth">
					<span class="w3-small" id="birthCkId"></span>
			</div>

			<div class="w3-right w3-margin-top">
				<input type="submit" class="w3-btn w3-blue" id="joinProcBtn"
					value="JOIN"> <input type="button" class="w3-btn w3-blue"
					id="closeBtn" value="CLOSE">
			</div>
		</form>
	</div>
	<script type="text/javascript" src="/eun/js/jquery-3.4.1.min.js"></script>
	<script>
		var joinTrue = 0;
		var joinTrueN = 0;
		var joinTrueP = 0;
		var joinTruePC = 0;
		var joinTureB = 0;

		//로그인 확인
		$('#loginBtn').click(function() {
			var sid = $('#idId').val();
			var spw = $('#pwId').val();

			$.ajax({
				url : "/eun/member/loginProc.van",
				type : "post",
				dataType : "json",
				data : {
					"id" : sid,
					"pw" : spw
				},
				success : function(cnt) {
					var ck = cnt;
					if (cnt == 1) {
						$(location).attr('href', '/eun/main.van');
					} else {
						alert('아이디 혹은 비밀번호를 확인해주세요');
					}
				},
				error : function() {
					alert('#####통신오류#####');
				}
			});
		});

		//회원가입페이지 열기
		$('#joinBtn').click(function() {
			$('.modalBack').css('display', 'block');
			$('.joinModal').css('display', 'block');
		});

		//회원가입페이지 닫기버튼
		$('#closeBtn').click(function() {
			$('.modalBack').css('display', 'none');
			$('.joinModal').css('display', 'none');
		});

		//아이디중복확인 ajax
		function idCk() {
			var sid = $('#id').val();

			$.ajax({
				url : "/eun/member/idCk.van",
				type : "post",
				dataType : "json",
				data : {
					"id" : sid
				},
				success : function(cnt) {
					var ck = cnt;
					if (ck == 1) {
						$('#idCkId').addClass("w3-text-red").text(
								"이미 등록된 아이디입니다. ");
						joinTrue = 2;
					} else {
						$('#idCkId').removeClass("w3-text-red");
						$('#idCkId').addClass("w3-text-green").text(
								"사용 가능한 아이디입니다.");
						joinTrue = 1;
					}
				},
				error : function(cnt) {
					alert('#####통신에러#####');
				}
			});
		}

		//아이디정규식 확인 후 중복확인
		function idJCk() {
			var jid = $('#id').val();
			var regExp = /^[a-z0-9_]{4,20}$/;
			if (regExp.test(jid)) {
				idCk();
			} else {
				$('#idCkId').addClass("w3-text-red").text(
						"잘못된 형식의 아이디입니다. 4~12자의 영문 소문자,숫자를 사용해주세요. ");
				joinTrue = 2;
			}

		}
		
		
		//비밀번호 정규식
		function pwJCk(){
			var jpw = $('#pw').val();
			var regExp = /^[a-z0-9]{4,12}$/;
			if(regExp.test(jpw)){
				$('#pwCkId').removeClass("w3-text-red").text('');
				joinTrueP = 1; 
			}else{
				$('#pwCkId').addClass("w3-text-red").text("잘못된 형식입니다. 4~12자의 영문 소문자,숫자를 사용해주세요.");
				joinTrueP = 2; 
			}
		}
		
		//비밀번호 일치 확인
		function pwCCk(){
			var spw = $('#pw').val();
			var jpw = $('#pwC').val();
			if(spw == jpw){
				$('#pwcCkId').removeClass("w3-text-red").text('');
				joinTruePC = 1;
			}else{				
				$('#pwcCkId').addClass("w3-text-red").text("비밀번호가 일치하지 않습니다.");
				joinTruePC = 2;
			}
		}
		

		//닉네임체크 ajax
		function nnameCk() {
			var snname = $('#nname').val();

			$.ajax({
				url : "/eun/member/nnameCk.van",
				type : "post",
				dataType : "json",
				data : {
					"nname" : snname
				},
				success : function(cnt) {
					var ck = cnt;
					if (ck == 1) {
						$('#nnameCkId').addClass("w3-text-red").text("이미 사용중인 닉네임입니다.");
						joinTrueN = 2;
					} else {
						$('#nnameCkId').removeClass("w3-text-red");
						$('#nnameCkId').addClass("w3-text-green").text(
								"사용 가능한 닉네임입니다.");
						joinTrueN = 1;
					}
				},
				error : function(cnt) {
					alert('#####통신에러#####');
				}
			});
		}
		
		//닉네임정규식 확인 후 중복확인
		function nnameJCK() {
			var jnname = $('#nname').val();
			var regExp = /^[a-z0-9가-힣]{2,10}$/;
			if (regExp.test(jnname)) {
				nnameCk();
			} else {
				$('#nnameCkId').addClass("w3-text-red").text(
						"잘못된 형식의 닉네임입니다. 2~10자의 영문,한글을 사용해주세요. ");
				joinTrueN = 2;
			}

		}
		
		//생년 정규식확인
		function birthCk(){
			var sbirth = $('#birth').val();
			var regExp = /^[0-9]{4}$/;
			if(regExp.test(sbirth)){
				$('#birthCkId').text('');
				joinTrueB = 1;
			}else{
				$('#birthCkId').addClass("w3-text-red").text("잘못된 형식입니다. ex)1991");
				joinTrueB = 2;
			}
		}

		//마지막 체크
		function finalCk() {
			idJCk();
			pwJCk();
			pwCCk();
			nnameJCK();
			birthCk();
			
			if (joinTrue == 2) {
				alert('아이디를 확인해주세요.')
				return false;
			} else if (joinTrueP == 2) {
				alert('비밀번호를 확인해주세요.')
				return false;
			} else if (joinTruePC == 2) {
				alert('비밀번호가 일치하지 않습니다.')
				return false;
			} else if (joinTrueN == 2) {
				alert('닉네임을 확인해주세요.')
				return false;
			} else if (joinTrueB == 2) {
				alert('생년을 확인해주세요.')
				return false;
			} else{
				return true;
			}
			/* else if (fr.id.value == "") {
				$(this).focus();
				alert('ID를 입력해주세요.');
				return false;
			} else if (fr.pw.value == "") {
				alert('비밀번호를 입력해주세요.');
				return false;
			} else if (fr.pwck.value == "") {
				alert('비밀번호 재확인을 입력해주세요.');
				return false;
			} else if (fr.nname.value == "") {
				alert('닉네임을 입력해주세요.');
				return false;
			} else if (fr.bday.value == "") {
				alert('생일을 입력해주세요.');
				return false;
			} else {
				return true;
			} */
		}

		//아이디 정규식&중복체크
		$('#id').blur(function() {
			idJCk();
		});
		//비밀번호 정규식
		$('#pw').blur(function(){
			pwJCk();
		});
		//비밀번호 일치 확인
		$('#pwC').blur(function(){
			pwCCk();
		});
		
		//닉네임 중복&정규식 체크
		$('#nname').blur(function() {
			nnameJCK();
		});
		
		//생년 정규식체크
		$('#birth').blur(function(){
			birthCk();
		});
	</script>
</body>
</html>