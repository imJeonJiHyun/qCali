<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<form action="${pageContext.request.contextPath}/member/mypage/confirmPwd" method="POST">
	<table border="1">
		<tr>
				<td>비밀번호 : </td>
				<td><input name="memberPassword" type="password" placeholder="비밀번호를 입력해주세요"/>
				${msg}
				</td>
			</tr>
		
		</table>
	
		
		<input type="submit" value="입력하기" />
		</form>
		

</body>
</html>