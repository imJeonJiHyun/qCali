<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
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


	<a href="<c:url value='/member/mypage/changePwd?memberSeq=${memberLogin.memberSeq}'/>"><button>비밀번호 변경하기</button></a>
	<a href="<c:url value='/member/mypage/changeNickname?memberSeq=${memberLogin.memberSeq}'/>"><button>닉네임 변경하기</button></a>
	<a href="<c:url value='/board/mylist?memberSeq=${memberLogin.memberSeq}'/>"><button>내가 쓴 글 모아보기</button></a>
	
	<a href="<c:url value='/member/logout'/>"><button>로그아웃</button></a>
	
	<a href="<c:url value='/member/mypage/delete?memberSeq=${memberLogin.memberSeq }'/>" ><button>회원탈퇴</button></a>
	

	

	</c:if>
	<c:if test="${empty memberLogin}">
		<script>
	alert("로그인 정보가 없습니다.");
	document.location.href="<c:url value='/member/login'/>";
</script>
	</c:if>

	
</body>
</html>