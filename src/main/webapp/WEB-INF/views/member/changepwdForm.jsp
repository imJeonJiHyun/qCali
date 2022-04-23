<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
	<script type="text/javascript">

	function pwCheck() {

	    if(document.getElementById('memberPassword').value!='' && document.getElementById('memberPasswordCheck').value!='') {
	        if(document.getElementById('memberPassword').value==document.getElementById('memberPasswordCheck').value) {
	            document.getElementById('pwSame').innerHTML='비밀번호가 일치합니다.';
	            document.getElementById('pwSame').style.color='blue';
	        }
	        else {
	            document.getElementById('pwSame').innerHTML='비밀번호가 일치하지 않습니다.';
	            document.getElementById('pwSame').style.color='red';
	        }
	    }
	}

	</script>
<body>


<form:form commandName="changepwdData" action="${pageContext.request.contextPath}/member/mypage/changePwd"  >

<table border="1">

		<tr>
			<th>비밀번호</th><td><form:password path="memberPassword" id="memberPassword"/>
		
			<form:errors path="memberPassword"/>
				</td>
		</tr>
		<tr>
			<th>비밀번호 확인</th><td><form:password path="memberPasswordCheck" id="memberPasswordCheck" />
			<form:errors path="memberPasswordCheck"/>
			<button type="button" onclick="pwCheck()">비밀번호 확인</button>
			<span id="pwSame"></span>
		</td>
		</tr>

	</table>
	${msg}
	<br>
	<input type="submit" value="비밀번호 변경하기" >
</form:form>

</body>
</html>