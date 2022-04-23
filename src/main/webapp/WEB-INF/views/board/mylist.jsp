<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<style>
ul {
	list-style: none;
	width: 30%;
	display: inline-block;
}

li {
	float: left;
	margin-left: 5px;
}
</style>

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
	
		<a
			href="<c:url value='/board/mylist?memberSeq=${memberLogin.memberSeq}'/>"><button>내가
				쓴 글 모아보기</button></a>


	</c:if>

	<c:if test="${empty memberLogin}">
		<a href="<c:url value='/member/login'/>"><button>로그인</button></a>

	</c:if>

	게시글 수 : ${boardTotal }
	<table border="1">
		<tr>
			<th>보드seq</th>
			<th>보드제목</th>
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
			<c:forEach var="list" items="${boardList}">
				
				<tr>
					<td>${list.boardSeq}</td>

					<td><a href="<c:url value='/board/detail?boardSeq=${list.boardSeq}'/>">${list.boardTitle}</a>

					</td>


					<td>${list.memberNickname}</td>
					<td>${list.boardRegday}</td>
					<td>${list.boardLike}</td>
					<td>${list.boardCount}</td>
					<td>${list.memberSeq}</td>
				</tr>

			</c:forEach>

		</c:if>
		<div>
			<ul>
				<c:if test="${pageMaker.prev }">
					<li><a
						href="mylist${pageMaker.makeQuery(pageMaker.startPage - 1) }&memberSeq=${memberLogin.memberSeq}">Previous</a>
					</li>
				</c:if>

				<c:forEach var="currentPage" begin="${pageMaker.startPage }"
					end="${pageMaker.endPage }">
					<li><a
						href="mylist${pageMaker.makeQuery(currentPage) }&memberSeq=${memberLogin.memberSeq}">${currentPage }</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next }">
					<li ><a
						href="listmy${pageMaker.makeQuery(pageMaker.endPage + 1) }&memberSeq=${memberLogin.memberSeq}'/>">Next</a>
					</li>
				</c:if>
			</ul>
		</div>


	</table>
</body>
</html>