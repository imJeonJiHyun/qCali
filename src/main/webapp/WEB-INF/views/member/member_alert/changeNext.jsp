<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	alert("회원 정보가 변경되었습니다.");
	document.location.href="<c:url value='/board/list'/>";
</script>