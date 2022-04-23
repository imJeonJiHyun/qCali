<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>




<meta charset="UTF-8">
<title>Insert title here</title>
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
				
					<td>
					<c:if test="${empty boarList.memberNickname }">
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

				<a href="<c:url value='/board/edit?boardSeq=${boardList.boardSeq}'/>"><button>글
						수정</button></a>


				<a href="<c:url value='/board/delete?boardSeq=${boardList.boardSeq}'/>"><button
						onclick="button_event();">글 삭제</button></a>


			</c:if>




		</c:if>


	</table>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
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