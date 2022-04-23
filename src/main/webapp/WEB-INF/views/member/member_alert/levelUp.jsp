<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>

	alert("${nickname} 님   레벨 ${level}로 변경되었습니다.");
	document.location.href="<c:url value='/board/list'/>";
</script>