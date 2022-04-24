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
					<c:if test="${empty boarList.memberNickname}">
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
	</table>
	
		<!-- 댓글 입력 폼 -->
    <table style="padding-top: 100px">
    	 <tr>
    	 <c:if test="${!empty my}">
       		<td >댓글 쓰기</td>
       		<td><textarea name="replyContent" id="replyContent" cols="20" rows="3"></textarea></td>
       		<td><button type="button" class="btn btn-sm btn-primary" id="btnReplySave">댓글 등록</button></td>
       	</c:if>    
       </tr>
    </table>
    	
    	<!-- 댓글 리스트 폼 -->
		<div id="replyList"></div>

		
		
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
		
		
		//댓글 저장 함수
		$(document).on('click', '#btnReplySave', function(){
			
			var replyContent = $('#replyContent').val();
			
			var paramData = JSON.stringify
			({"replyContent": replyContent, "boardSeq":'${boardList.boardSeq}'});
			
			var headers = {"Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"};
			
			$.ajax({
				url: '<c:url value="/board/reply"/>'
				, headers : headers
				, data : paramData
				, type : 'POST'
				, contentType : 'application/json'
				, success: function(result){
					
					console.log("댓글이 입력됐습니다.");
				}
				, error: function(error){
					console.log("에러 : " + error);
				}// Ajax success end
			}); // Ajax end
		});
		
		
		//댓글 리스트 함수
		$(document).ready(function(){
			showReplyList();
		});
		
		function showReplyList(){
			var paramData = {"boardSeq":'${boardList.boardSeq}'};
			var headers = {"Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"};
			$.ajax({
	            type: 'POST',
	            url : '<c:url value="/board/reply"/>',
	            data: JSON.stringify(paramData),
	            contentType : 'application/json; charset=utf-8',
	            success: function(result) {
	               	var htmls = "";
				if(result.length < 1){
					htmls.push("등록된 댓글이 없습니다.");
				} else {	
	                 	htmls += '<table border = "1">';					
		                     $(result).each(function(){	 
			                 htmls += '<tr>';
			        	     htmls += '<th>작성자</th>';
			        	     htmls += '<th>내용</th>';
			        	     htmls += '<th>작성 날짜</th>';
			        	     htmls += '<th>수정</th>';
			        	  	 htmls += '<th>삭제</th>';
			        		 htmls += '</tr>';		                    	 
		                     htmls += "<c:forEach var ="replyList" items="${replyList}">";
		                     htmls += "<tr>";
		              		 htmls += "<td>"+${replyList.memberNickname}+"</td>";
		                     htmls += "<td>"+${replyList.replyContent}+"</td>";
		               		 htmls += "<td>"+${replyList.replyRegDay}+"</td>";             	
		               		 htmls += "<td><button type=\"button\" id=\"replyUpdateBtn\" data-replySeq=\"${replyList.replySeq}\">수정</button></td>";
		           			 htmls += "<td><button type=\"button\" class=\"replyDelete\" data-replySeq=\"${replyList.replySeq}\">삭제</button></td>";
		            		 htmls += "</tr>";
		            		 htmls += "</c:forEach>";
		            		 
		            		 //아래 코드 작동 되는지 확인하기
		            		 
		                     htmls += '<div class="media text-muted pt-3" id="replySeq' + this.${replyList.replySeq} + '">';
		                     htmls += '<svg class="bd-placeholder-img mr-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder:32x32">';
		                     htmls += '<title>Placeholder</title>';
		                     htmls += '<rect width="100%" height="100%" fill="#007bff"></rect>';
		                     htmls += '<text x="50%" fill="#007bff" dy=".3em">32x32</text>';
		                     htmls += '</svg>';
		                     htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
		                     htmls += '<span class="d-block">';
		                     htmls += '<strong class="text-gray-dark">' + this.${replyList.memberNickname} + '</strong>';
		                     htmls += '<span style="padding-left: 7px; font-size: 9pt">';
		                     htmls += '<a href="javascript:void(0)" onclick="fn_editReply(' + this.${replyList.replySeq} + ', \'' + this.${replyList.memberNickname} + '\', \'' + this.${replyList.replyContent} + '\' )" style="padding-right:5px">수정</a>';
		                     htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + this.${replyList.replySeq} + ')" >삭제</a>';
		                     htmls += '</span>';
		                     htmls += '</span>';
		                     htmls += this.${replyList.replyContent};
		                     htmls += '</p>';
		                     htmls += '</div>';
		                	 });	//each end
		                htmls += '</table>';
						$("#replyList").html(htmls);
	            		} //else end
	            }// Ajax success end
			});	// Ajax end
		}
		
		
		//댓글 수정 폼 불러오기 함수
		function fn_editReply(replySeq, memberNickname, replyContent){ //변수명 어떻게 해야하는지 확인하기

			var htmls = "";
			htmls += '<div class="media text-muted pt-3" id="replySeq' + ${replySeq} + '">';
			htmls += '<svg class="bd-placeholder-img mr-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder:32x32">';
			htmls += '<title>Placeholder</title>';
			htmls += '<rect width="100%" height="100%" fill="#007bff"></rect>';
			htmls += '<text x="50%" fill="#007bff" dy=".3em">32x32</text>';
			htmls += '</svg>';
			htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
			htmls += '<span class="d-block">';
			htmls += '<strong class="text-gray-dark">' + ${memberNickname} + '</strong>';
			htmls += '<span style="padding-left: 7px; font-size: 9pt">';
			htmls += '<a href="javascript:void(0)" onclick="fn_updateReply(' + ${replySeq} + ', \'' + ${memberNickname} + '\')" style="padding-right:5px">저장</a>';
			htmls += '<a href="javascript:void(0)" onClick="showReplyList()">취소<a>';
			htmls += '</span>';
			htmls += '</span>';		
			htmls += '<textarea name="replyContent" id="replyContent" class="form-control" rows="3">';
			htmls += ${replyContent};
			htmls += '</textarea>';
			htmls += '</p>';
			htmls += '</div>';
			$('#replySeq' + replySeq).replaceWith(htmls);
			$('#replySeq' + replySeq + ' #editContent').focus();
		}
		
		
		//댓글 수정 저장 함수
		function fn_updateReply(rid, reg_id){
			
			var replyEditContent = $('#editContent').val();
			var paramData = JSON.stringify({"content": replyEditContent, "rid": rid});
			var headers = {"Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"};
			$.ajax({
				url: "${updateReplyURL}"
				, headers : headers
				, data : paramData
				, type : 'POST'
				, dataType : 'text'
				, success: function(result){
                	console.log(result);
					showReplyList();
				}
				, error: function(error){
					console.log("에러 : " + error);
				}
			});
		}
		
		
		//댓글 삭제 함수
		function fn_deleteReply(rid){
			var paramData = {"rid": rid};
			$.ajax({
				url: "${deleteReplyURL}"
				, data : paramData
				, type : 'POST'
				, dataType : 'text'
				, success: function(result){
					showReplyList();
				}
				, error: function(error){
					console.log("에러 : " + error);
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