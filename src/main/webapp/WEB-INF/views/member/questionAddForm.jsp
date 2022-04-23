<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문등록</title>

</head>
<body>




<form action="${pageContext.request.contextPath}/member/questionAdd" method="POST" >

<table border="1">

		<tr>
			<th>질문등록 </th>
			<td><textarea rows="" cols="" name="questionContent"></textarea>${msg}</td>
	
			
		</tr>

	</table>
	
	<br>
	<input type="submit" value="질문 등록하기" >
</form>




</body>
</html>