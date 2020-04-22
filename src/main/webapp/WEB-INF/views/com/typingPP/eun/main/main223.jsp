<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="kor">

<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <style>
        .wrapper {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 600px;
        }

        /*단어, 스코어 등등 화면*/
        .word {
            height: 300px;
            border-radius: 25px;
        }

        /*단어 폰트크기*/
        .wordClass {
            position: relative;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 40px;
        }


        .startBtn {
            display: block;
        }

        .typingWord {
            display: none;
        }

        #countId {
            display: none;
        }

    </style>
</head>

<body>
	<form id="scoreForm" action="/eun/game/scoreProc.van" method="POST">
		<input type="hidden" id="inputScore" name="score">
	</form>
	
    <div class="w3-sidebar w3-bar-block w3-border-right  w3-black" style="display: none" id="mysidebar">
        <button class="w3-bar-item w3-large" id="closeBtn">Close &times;</button>
        <span class="w3-bar-item"><img src="/eun/img/man.jpg" class="w3-circle" style="width: 100%"></span>
        <c:if test="${empty SID}">
        <span class="w3-bar-item">GUEST</span>        
        </c:if>
        <c:if test="${not empty SID}">
        <span class="w3-bar-item" id="userId">${DATA.id}</span>        
        <span class="w3-bar-item">티어 : 골드</span>
        <span class="w3-bar-item" id="userScore">최고점수 : ${DATA.score}</span>
        </c:if>
    </div>
    <div class="w3-green w3-bar">
        <div class="w3-bar-item w3-button" id="openBtn">
            <button class="w3-button">&#9776;</button>
        </div>
        <div class="w3-bar-item w3-right">
        <c:if test="${empty SID}">
            <button class="w3-button w3-hover-green" id="loginBtn">LOGIN</button>
        </c:if>
        <c:if test="${not empty SID}">
            <button class="w3-button w3-hover-green" id="memInfo">회원정보보기</button>
            <button class="w3-button w3-hover-green" id="logout">LOGOUT</button>
        </c:if>
        </div>
    </div>
    <div class="wrapper">
        <div class="word w3-display-container w3-green">
            <div class="w3-display-topleft w3-margin">time : <span id="timeId">60.0</span></div>
            <div class="w3-display-topright w3-margin">score : <span id="scoreId">0</span></div>
            <div class="w3-display-topmiddle w3-margin">tier : <span id="tierId">bronze</span></div>
            <div class="wordClass">
                <div class="w3-center">
                    <div class="w3-button w3-green" id="startBtnId">시작하기</div>
                    <!--시작하기 버튼 -->
                    
                    <div id="countId">READY!</div>
                    <!--카운트 숫자 -->
                    
                    <span class="typingWord" id="engWord"></span>
                    <span class="typingWord" id="korWord"></span>
                </div>
            </div>
        </div>
        <input type="text" class="w3-input w3-center w3-margin-top" id="typingInput">
    </div>
    <div class="w3-sidebar w3-bar-block w3-margin-top ranking" style="width:20%;right:0">
    	<h5 class="w3-bar-item w3-center">RANKING</h5>
    	<c:forEach var="list" items="${LIST}">
        	<p class="w3-bar-item w3-center">${list.id}===${list.score}점</p>
    	</c:forEach>
        
    </div>
    <script type="text/javascript" src="/eun/js/jquery-3.4.1.min.js"></script>
    <script>
  //사이드바
    $('#openBtn').click(function() {
        $('#mysidebar').css("display", "block");
    });

    $('#closeBtn').click(function() {
        $('#mysidebar').css("display", "none");
    });
    
    
    //로그인&로그아웃
    $('#loginBtn').click(function(){
    $(location).attr('href','/eun/member/login.van');
    });
    $('#logout').click(function(){
    	$(location).attr('href','/eun/member/logout.van');
    });
    
    
        //최초 카운트 숫자, 카운트 함수 , 타이머변수
        var timeB = 59;
        var timeC = 9;
        var num = 4;
        var intervalCount;
        var timeCount;
        var tier;

        //단어모음
        var engDaneo = ["apple", "grape", "study", "mouse", "exercise", "doctor"];
        var korDaneo = ["사과", "포도", "공부하다", "쥐", "운동하다", "의사"];
        var ran = (Math.floor(Math.random() * 3)) * 2;

        //스코어
        var score = 0;

        //입력창 포커스
        function inputFocus() {
            $('#typingInput').focus();
        }

        //입력단어가 틀렸을때 색상표시
        function color() {
            var input = $('#typingInput').val();
            var wordL = (engDaneo[ran] + korDaneo[ran]);
            $('#typingInput').keyup(function() {
                alert(input);
                for (var i = 0; i < wordL.length; i++) {
                    var wordLTest = wordL.charAt(i);
                    if(input == wordLTest){
                    }
                }
            });

        };
        
        
        //최고기록 갱신
        function HighScore(){
        	$('#inputScore').val(score);
			$('#scoreForm').submit();
        }
				
		
        //60초타이머 함수 / 소수점 초를 9부터시작해서 0이되면 다시 9로 돌아오면서 초를 --함 
        function timer() {
            $('#timeId').text(timeB + '.' + timeC);
            timeC--;
            if (timeB == 0 && timeC == -1) {
                clearInterval(timeCount);
                $("#typingInput").attr("readonly", true).css("background", "#999");
                var testII =  "<%=session.getAttribute("SID") %>"
                var testScore = "<%=session.getAttribute("SSCORE") %>"
                alert(testII);
 				alert(testScore);
            } else if (timeC == -1) {
                timeC = 9;
                timeB--;
            }
        }

        //3~1초 카운트 다운
        function countDown() {

            num--;

            $('#countId').text(num);
            if (num == 0) {
                num = 4;
                clearInterval(intervalCount);
                //60초카운트다운
                timeCount = setInterval("timer()", 100);


                inputFocus();
                $('#countId').css('display', 'none');
                $('.typingWord').css('display', 'block');
                showWord();
            }
        };
        
        
        //현재티어적기
        function tierText(tier){
            $('#tierId').text(tier);
        }

        //ㅅ히작버튼
        function start(tier) {
            $('#timeId').text('60.0');
            $('#startBtnId').css('display', 'none');
            tierText(tier);
            $('#countId').css('display', 'block');
            intervalCount = setInterval("countDown()", 1000); //카운트다운

        }
        
        //레벨업했을떄
        function levelUpF(){
            timeCount = setInterval("timer()", 100);
            showWord();
             $('.typingWord').css('display', 'block');
            
        }

        
        function levelUp(tier) {
            tierText(tier);
            clearInterval(timeCount);
            timeB = 60;
            timeC = 0;
            $('#timeId').text(timeB + '.' + timeC);
            $('.typingWord').css('display', 'none');
            levelUpF();
            
        }


        //화면에 단어를 표시 & input과 단어 내용 확인
        function showWord() {
            if (ran == 6) {
                ran = 0;
            }
            $('#engWord').text(engDaneo[ran]);
            $('#korWord').text(korDaneo[ran]);

            var engWord = $('#engWord').text();
            var korWord = $('#korWord').text();
            var engKor = (engWord + korWord);

            $('#typingInput').keypress(function(key) {
                
                
                var input = $('#typingInput').val();
            var wordL = (engDaneo[ran] + korDaneo[ran]);
            $('#typingInput').keyup(function() {
                for (var i = 0; i < wordL.length; i++) {
                    var wordLTest = wordL.charAt(i);
                    if(input == wordLTest){
                    }
                }
            });
                
                
                
                if (key.keyCode == 13) {
                    if (engKor == $('#typingInput').val()) {
                        score = score + 10;
                        if (score == 20) {
                            levelUp('Silver');
                        }
                        if (score == 40){
                            //goldUp();
                            levelUp('Gold');
                        }
                        if (score == 60){
                            levelUp('Platinum');
                        }
                        $('#typingInput').val('');
                        $('#scoreId').text(score);
                        
                        ran++;
                        showWord();
                    }
                }

            });
        }

        $(document).ready(function() {
            //드래그 금지
            $(document).bind("selectstart", function(e) {
                return false;
            });

            $('#startBtnId').click(function() {
                start('bronze');
            });

        });

    </script>
</body>

</html>