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
	</table><br/><br/><br/>
	
	<div class="col-md-6">
		<label for="memberNickname" id="memberNickname">작성자 : ${memberLogin.memberNickname}</label><br/>
		<label for="replyContent"> 댓글 : </label>
		<textarea class="form-control" id="replyContent" name="replyContent"></textarea>
		<button type="button" class="btn btn-outline-success" id="replywriteBtn" name="replywriteBtn">댓글 작성</button>
	</div>
	<br/>
	<hr/>

	<h2>Reply list</h2><h5>댓글 : [ ${replyTotal} ] 개</h5>&nbsp;&nbsp;
	<div id="replyList"></div>
	
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
			var memberSeq = ${member.memberSeq};
			
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
							htmls += '<br/><p>';
							htmls += '댓글 내용 : &nbsp;&nbsp;' + this.replyContent;
							htmls += '</p><br/>';
							if(memberSeq ==  this.memberSeq){
							htmls += '<button type="button" class="btn btn-outline-success" onclick="updateviewBtn(\'' + this.replySeq + '\', \'' + this.replyContent + '\', \''+ this.memberNickname + '\')">수정</button>&nbsp;&nbsp;';
							htmls += '<button type="button" class="btn btn-outline-success" onclick="replyDeleteConfirm(\'' + this.replySeq + '\')">삭제</button>';
							}
							htmls += '</div><br/>';
						});
					};
						$("#replyList").html(htmls);
				}
			});
		}

		
		//댓글 저장 함수
		$(document).on('click', '#replywriteBtn', function() {
			var replyContent = $('#replyContent').val();	
			var paramData = JSON.stringify({
				'replyContent': replyContent, 'boardReplySeq':'${boardList.boardSeq}', 'memberSeq':'${memberLogin.memberSeq}'});
			var headers = {"Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"};
				
			$.ajax({
				url: '<c:url value="/board/replyInsert"/>',
				headers : headers,
				data : paramData,
				type : 'POST',
				contentType : 'application/json',
				
				success: function(result){
					getreplylist();
					console.log("댓글이 입력됐습니다.");
				
				}, error: function(error) {
					console.log("에러 : " + JSON.stringify(error));
				}
			});
		});
		
		
		//댓글 수정 폼 불러오기 함수
		function updateviewBtn(replySeq, replyContent, memberNickname) {
			var htmls = "";
				
			htmls += '<div id="replySeq'+replySeq+'">';
			htmls += '<strong>';
			htmls += '작성자 : '+memberNickname;
			htmls += '</strong>&nbsp;&nbsp;&nbsp;&nbsp;';
			htmls += '<br/><p>';
			htmls += '<textarea class="form-control" id="replyUpdateContent">';
			htmls += replyContent;
			htmls += '</textarea></p><br/>';
			htmls += '<button type="button" class="btn btn-outline-success" onclick="replyUpdateConfirm(\'' + replySeq + '\')">수정 완료</button>&nbsp;&nbsp;';
			htmls += '<button type="button" class="btn btn-outline-success" onclick="getreplylist()">수정 취소</button>';
			htmls += '</div><br/>';
			$('#replySeq'+replySeq).replaceWith(htmls);
			$('#replySeq'+replySeq+'#replyContent').focus();
		}
			
		
		//댓글 수정 호출 함수
		function replyUpdateConfirm(replySeq) {	
			var delConfirm = confirm('댓글 수정을 완료하시겠습니까?');
			
				if (delConfirm) {
			    	alert('수정되었습니다.');
			    	replyUpdateBtn(replySeq);
			   	} else {
			      	alert('수정이 취소되었습니다.');
			      	getreplylist();
			   	}	
		}
		
		
		//댓글 수정 함수
		function replyUpdateBtn(replySeq) {	
			var replyUpdateurl = "${root}replyUpdate/";				
			var replyContent = $('#replyUpdateContent').val();
			var paramData = JSON.stringify({"replyContent": replyContent});
			var headers = {"Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"};
			
			$.ajax({
				url : replyUpdateurl + replySeq,				
				headers : headers,
				data : paramData,
				dataType : 'text',
				type : 'POST',
				contentType : 'application/json',
				
				success: function(result){
					getreplylist();
					console.log("댓글이 수정됐습니다.");
				
				}, error: function(error){
					console.log("에러 : " + JSON.stringify(error));
				}
			});
		}
		
		
		//댓글 삭제 호출 함수
		function replyDeleteConfirm(replySeq) {	
			var delConfirm = confirm('정말 댓글을 삭제하시겠습니까?');
			
				if (delConfirm) {
			    	alert('삭제되었습니다.');
			    	replydelete(replySeq);
			   	} else {
			      	alert('삭제가 취소되었습니다.');
			      	getreplylist();
			   	}	
		}
		
			
		//댓글 삭제 함수
		function replydelete(replySeq) {				
			var replyDeleteurl = "${root}replydelete/";
			var headers = {"Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"};
			
			$.ajax({
				url: replyDeleteurl+replySeq,
				headers : headers,
				type: 'POST',
				dataType : 'text',
				contentType : 'application/json',
				
				success: function(result){
					getreplylist();
				
				}, error: function(error){
					console.log("에러 : " + JSON.stringify(error));
				}
			});
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
</html>