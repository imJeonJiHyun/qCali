<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보드 디테일</title>
</head>
<body>
	<c:if test="${!empty memberLogin}">
		<h2>로그인 성공</h2>
		<table border="1">
			<tr>
				<th>회원 번호</th>
				<th>회원 ID</th>
				<th>회원 닉네임</th>
				<th>회원 생일</th>
				<th>회원 가입 날짜</th>
				<th>회원 인증 여부</th>
				<th>회원 레벨</th>
			</tr>
			<tr>
				<td>${memberLogin.memberSeq}</td>
				<td>${memberLogin.memberId}</td>
				<td>${memberLogin.memberNickname}</td>
				<td>${memberLogin.memberBirthDay}</td>
				<td>${memberLogin.memberRegDay}</td>
				<td>${memberLogin.memberAuth}</td>
				<td>${memberLogin.memberLevel}</td>
			</tr>
		</table>
		<a href="<c:url value='/member/logout'/>"><button>로그아웃</button></a>
		<a href="<c:url value='/board/write'/>"><button>글쓰기</button></a>


	</c:if>

	<table border="1">
		<tr>
			<th>보드seq</th>
			<th>보드제목</th>
			<th>보드내용</th>
			<th>닉네임</th>
			<th>보드 쓴 날짜</th>
			<th>보드 좋아요</th>
			<th>보드 카운트</th>
		</tr>
		
		<c:if test="${ empty boardList}">
			<tr>
				<td colspan="7">게시판에 저장된 글이 없습니다.</td>
			</tr>
		</c:if>

		<c:if test="${ !empty boardList}">
			<tr>
				<td>${boardList.boardSeq}</td>
				<td>${boardList.boardTitle}</td>
				<td>${boardList.boardContent}</td>
				<td>
					<c:if test="${!empty boarList.memberNickname}">
						탈퇴 회원
					</c:if>
				${boardList.memberNickname}</td>
				<td>${boardList.boardRegday}</td>
				<td>${boardList.boardLike}</td>
				<td>${boardList.boardCount}</td>
			</tr>

			<div style="text-align: right;">
				<a class="text-dark heart" style="text-decoration-line: none;">

					<img id="heart" src="" height="30px">
				</a>
			</div>

			<c:if test="${myArticle == true}">

				<a href="<c:url value='/board/edit?boardSeq=${boardList.boardSeq}'/>">
				<button>글수정</button></a>


				<a href="<c:url value='/board/delete?boardSeq=${boardList.boardSeq}'/>"><button
						onclick="button_event();">글 삭제</button></a>
			</c:if>
		</c:if>
	</table>
	
	<div class="col-md-6">
		<label for="memberNickname" id="memberNickname">작성자 : ${memberLogin.memberNickname}</label>
		<input type="hidden" class="form-control" id="memberNickname" name="memberNickname" value="${memberLogin.memberNickname}"><br/>
		<label for="replyContent"> 댓글 : </label>
		<textarea class="form-control" id="replyContent" name="replyContent"></textarea>
		<button type="button" class="btn btn-outline-success" id="replywriteBtn" name="replywriteBtn">댓글 작성</button>
	</div>
	<br/>
	<hr/>
	
	<div class="container"><!-- 댓글이 들어갈 div -->
		<div id="replyList"></div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
		//하트 함수
		$(document).ready(function() {
			var heartval = ${boardHeart};
			if (heartval > 0) {
				console.log(heartval);
			    $("#heart").prop("src", '<c:url value="/resources"/>'+"/static/images/like2.png");
				$(".heart").prop('name', heartval)
			} else {
				console.log(heartval);
				$("#heart").prop("src", '<c:url value="/resources"/>'+"/static/images/like1.png");
				$(".heart").prop('name', heartval)
			}
			$(".heart").on("click", function() {
				var that = $(".heart");
				console.log(that.prop('name'));
				var sendData = {
					'boardSeq' : '${boardSeq}',
					'heart' : that.prop('name'),
				};
				$.ajax({
					url : '<c:url value="/board/heart"/>',
					type : 'POST',
					data : JSON.stringify(sendData),
					contentType: 'application/json',
					success : function(data) {
						that.prop('name', data);
						console.log("success:" + that.prop('name', data));
						if (data == 1) {
							 $('#heart').prop("src",'<c:url value="/resources"/>'+"/static/images/like2.png");
						} else {
							 $('#heart').prop("src",'<c:url value="/resources"/>'+"/static/images/like1.png");
						}
					}
				});
			});
		});
		
		//댓글 리스트 호출 함수
		$(document).ready(function() {
			getreplylist();
		});
		
		//댓글 리스트 함수
		function getreplylist() {
			var replyurl = "${root}reply/";
			var boardReplySeq = ${boardList.boardSeq};
			$.ajax({
				url : replyurl+boardReplySeq,
				type : 'POST',
				dataType : 'json',
				success: function(result){
					console.log(result);
					var htmls = "";
					
					if(result.length < 1) {
						htmls = "등록된 댓글이 없습니다.";
					} else {
						$(result).each(function() {
							htmls += '<div id="replySeq'+this.replySeq+'">';
							htmls += '<strong>';
							htmls += '작성자 : ' + this.memberNickname;
							htmls += '</strong>&nbsp;&nbsp;&nbsp;&nbsp;';
							htmls += '작성 날짜 : ' + this.replyRegDay;
							htmls += '<br/> <p>';
							htmls += '댓글 내용 : &nbsp;&nbsp;&nbsp;' + this.replyContent;
							htmls += '</p>';
							htmls += '<br/>';
							htmls += '<c:if test="${replyMemberCheck == true}">';
							htmls += '<button type="button" class="btn btn-outline-success" onclick="updateviewBtn(' + this.replySeq +',\'' + '\', \'' + this.replyContent + '\', \''+ this.memberNickname + '\')">';
							htmls += '댓글수정</button>';
							htmls += '<button type="button" class="btn btn-outline-success" onclick="replydelete(' + this.replySeq +')">';
							htmls += '댓글삭제</button>';
							htmls += '</c:if>';
							htmls += '</div>';
							htmls += '<br/>';
						});
					};
						$("#replyList").html(htmls);
				}
			});
		};		

		//댓글 저장 함수
			$('#replywriteBtn').click(function() {
				var replyContent = $('#replyContent').val();
				var paramData = JSON.stringify({"replyContent": replyContent,
					"memberReplySeq": '${memberLogin.memberSeq}', "boardReplySeq":'${boardList.boardSeq}'});
				var headers = {"Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"};
				
				$.ajax({
					url: '<c:url value="/board/replyInsert"/>',
					headers : headers,
					data : paramData,
					type : 'POST',
					dataType : 'text',
					success: function(result){
						getreplylist();
						$('#replyContent').val('');
					},
					error: function(error) {
						console.log("에러 : " + JSON.stringify(error));
					}
				})
			});
		
		
		//댓글 수정 폼 불러오기 함수
		function updateviewBtn(replySeq, memberNickname, replyContent){//변수명 어떻게 해야하는지 확인하기
			console.log("들어오나");
		
			var htmls = "";
			
			htmls += '<div id="replySeq'+replySeq+'">';
			htmls += '<strong>';
			htmls += '작성자 : ' + memberNickname;
			htmls += '</strong>&nbsp;&nbsp;&nbsp;&nbsp;';
			htmls += '<br/><p>';
			htmls += '수정 할 댓글 내용 : &nbsp;&nbsp;&nbsp;';
			htmls += '<textarea class="form-control" id="replyUpdateContent">';
			htmls += replyContent;
			htmls += '</textarea>';
			htmls += '</p>';
			htmls += '<br/>';
			htmls += '<button type="button" class="btn-outline-success"';
			htmls += 'onclik="updateBtn(' + replySeq + ',\'' + memberNickname +'\')">댓글 작성</button>';
			htmls += '<button type="button" class="btn-outline-success" onclick="getreplylist()" >';
			htmls += '취소';
			htmls += '</button>';
			htmls += '</div>';
			htmls += '<br/>';
			$('#replySeq' + replySeq).replaceWith(htmls);
			$('#replySeq' + replySeq + '#replyContent').focus();
		};
		
		//댓글 수정 함수
		function updateBtn(replySeq, memberNickname) {
			var updateurl = "${root}reply/";
			var replyContent = $("#replyUpdateContent").val();
			
			$.ajax({
				url : updateurl+replySeq+'/'+replyContent,
				type : 'POST',
				dataType : 'json',
				success: function(result){
					getreplylist();
				},
				error: function(error){
					console.log("에러 : " + JSON.stringify(error));
				}
			});
		};
		
		//댓글 삭제 함수
		function replydelete(replySeq) {
			var deleteurl = "${root}replydelete/";
			$.ajax({
				url: deleteurl+replySeq,
				type: 'POST',
				dataType: 'json',
				success: function(result){
					getreplylist();
				},
				error: function(error){
					console.log("에러 : " + JSON.stringify(error));
				}
			})
		}
	</script>

	<script type="text/javascript">
		function button_event() {
			if (confirm("정말 삭제하시겠습니까??") == true) { //확인
				document.form.submit();
			} else { //취소
				return;
			}
		}
	</script>
</body>