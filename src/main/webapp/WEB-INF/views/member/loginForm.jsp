<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
body {
	text-align: center;
}

table {
	margin: auto;
	width: 50%;
	height: 150px;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<h2>로그인</h2>
	<form:form commandName="loginMemberData">

		<table border="1">
			<tr>
				<td>아이디 :</td>
				<td><form:input path="memberId" placeholder="필수입력" /> <form:errors
						path="memberId" /></td>
			</tr>

			<tr>
				<td>비밀번호 :</td>
				<td><form:input path="memberPassword" type="password"
						placeholder="필수입력" /> <form:errors path="memberPassword" /></td>
			</tr>

		</table>
		<br>
		${msg}<br>
		<br>
		<input type="submit" value="로그인" />

	</form:form>

	<a href="<c:url value='/member/findPwd'/>"><button>비밀번호 찾기</button></a>
	<a href="<c:url value='/member/insert'/>"><button>회원가입</button></a>

	<fieldset>

		<div id="googleLoginBtn" style="cursor: pointer">
			<img id="googleLoginImg"
				src="<c:url value='/resources'/>/static/images/google_login_button.png" />
		</div>
	</fieldset>


</body>

<script>
 	const onClickGoogleLogin = (e) => {
    	//구글 인증 서버로 인증코드 발급 요청
 		window.location.replace("https://accounts.google.com/o/oauth2/v2/auth?client_id=68355066340-ghvpek91dtd21jgoiprdgc0115p2d42d.apps.googleusercontent.com&redirect_uri=http://localhost:8080/exam/login/google/auth&response_type=code&scope=email%20profile%20openid%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fdrive.file&access_type=offline")
 	}
	
	const googleLoginBtn = document.getElementById("googleLoginBtn");
	googleLoginBtn.addEventListener("click", onClickGoogleLogin);
    
</script>
</html>