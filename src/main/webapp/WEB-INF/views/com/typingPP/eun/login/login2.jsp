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
		<form action="/eun/main.van" method="post">
			<label class="w3-text-blue"><b>I D</b></label> 
			<input id="idId" name="id" class="w3-input w3-border" type="text">
			
			<div class="w3-margin-top">
			<label class="w3-text-blue w3-margin-top"><b>PASSWORD</b></label> 
			<input id="pwId" name="pw" class="w3-input w3-border" type="password">
			</div>

			<div class="w3-right w3-margin-top">
				<input type="submit" class="w3-btn w3-blue" id="loginBtn" value="LOGIN">
				<input type="button" class="w3-btn w3-blue" id="joinBtn" value="JOIN">
			</div>
		</form>
	</div>
	<div class="modalBack"></div>
	<div class="joinModal">
		<div>
			<h2 class="w3-text-blue w3-center">
				<b>JOIN</b>
			</h2>
		</div>
		<form name="fr" onsubmit="return finalCk();" action="/eun/member/joinProc.van" method="post">
			<div>
				<label class="w3-text-blue"><b>I D</b></label> 
				<input class="w3-input" type="text" placeholder="5~8자의 영문 소문자,숫자" id="id" name="id">
				
			</div>
			<div class="w3-margin-top">
				<label class="w3-text-blue w3-margin-top"><b>PASSWORD</b></label> <input
					class="w3-input" type="password" placeholder="5~8자의 영문 소문자,숫자"
					id="pw" name="pw">
			</div>
			<div class="w3-margin-top">
				<label class="w3-text-blue w3-margin-top"><b>PASSWORD
						CONFIRM</b></label> <input class="w3-input" type="password" id="pwC"
					name="pwC">
			</div>
			<div class="w3-margin-top">
				<label class="w3-text-blue"><b>NICKNAME</b></label> 
				<input class="w3-input" type="text" placeholder="2~8자" id="nname" name="nname" >
				
			</div>
			<div class="w3-margin-top">
				<label class="w3-text-blue w3-margin-top"><b>BIRTH</b></label> <input
					class="w3-input" type="text" placeholder="생년만 입력해주세요. ex)1991"
					id="birth" name="birth">
			</div>

			<div class="w3-right w3-margin-top">
				<input type="submit" class="w3-btn w3-blue" id="joinProcBtn" value="JOIN">
				<input type="button" class="w3-btn w3-blue" id="closeBtn" value="CLOSE">
			</div>
				</form>
	</div>
	<script type="text/javascript" src="/eun/js/jquery-3.4.1.min.js"></script>
	<script>
		var joinTrue = 0;
		var joinTrueN = 0;
	
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
		
		//아이디체크 css블락
		function idCkB(){
			$('#idCkBtn').css('display','block');
		}
		//아이디체크 css none;
		function idCkN(){
			$('#idCkBtn').css('display','none');
		}
		
		//아이디체크 ajax
		function idCk(){
			var sid = $('#id').val();
			
			$.ajax({
				url : "/eun/member/idCk.van",
				type : "post",
				dataType : "json",
				data : {
					"id" : sid
				},
				success : function(cnt){
					var ck = cnt;
					if(ck == 1){
		
						joinTrue = 2;
					}else{
						
						joinTrue = 1;
					}
				},
				error : function(cnt){
					alert('#####통신에러#####');
				}
			});
		}
		
		//닉네임체크 ajax
		function nnameCk(){
			var snname = $('#nname').val();
			
			$.ajax({
				url : "/eun/member/nnameCk.van",
				type : "post",
				dataType : "json",
				data : {
					"nname" : snname
				},
				success : function(cnt){
					var ck = cnt;
					if(ck == 1){
						
						joinTrueN = 2;
					}else{
						
						joinTrueN = 1;
					}
				},
				error : function(cnt){
					alert('#####통신에러#####');
				}
			});
		}
		
		//마지막 체크
		function finalCk(){
			idCk();
			nnameCk();
			
			if(joinTrue == 2){
				return false;	
			}else if(joinTrueN == 2){
				return false;
			}else if(fr.id.value ==""){
				alert('ID를 입력해주세요.');
				return false;
			}else if(fr.pw.value ==""){
				alert('비밀번호를 입력해주세요.');
				return false;
			}else if(fr.pwck.value ==""){
				alert('비밀번호 재확인을 입력해주세요.');
				return false;
			}else if(fr.nname.value ==""){
				alert('닉네임을 입력해주세요.');
				return false;
			}else if(fr.bday.value ==""){
				alert('생일을 입력해주세요.');
				return false;
			}else{
				return true;
			}
	
		}
		
		//아이디 중복체크
		$('#idCkBtn').click(function(){
			idCk();
		});
		
		//닉네임 중복체크
		$('#nnameCkBtn').click(function(){
			nnameCk();
		});
	</script>
</body>

</html>
