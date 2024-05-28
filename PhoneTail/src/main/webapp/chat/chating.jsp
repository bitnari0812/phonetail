<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="css/chat.css">

</head>
<body>
<div id="main_container">
	<div class="reply">
		<div class="reply_row">
			<div class="reply_col reply_title">작성자</div>
			<div class="reply_col reply_title" style="text-align:center">내용</div>
			<div class="reply_col reply_title">작성일시</div>
			<div class="reply_col reply_title">작성/삭제</div>
		</div>
		<form action="board.do" name="reply">
				<input type="hidden" name="command" value="insertReply" /> 
				<input type="hidden" name="userid" value="${loginUser.userid}" />
				<input type="hidden" name="boardnum" value="${board.num}" />
				<div class="reply_row">
						<div class="reply_col">${loginUser.userid}</div>
						<div class="reply_col"><input type="text" name="content" size="75"></div>
						<div class="reply_col">
							<c:set var="now" value="<%=new java.util.Date()%>" />
							<fmt:formatDate value="${now}" pattern="MM/dd hh:mm"/>
						</div>
						<div class="reply_col">
							<input type="submit" value="답글 작성" onClick="return replyCheck();">
						</div>
				</div>
		</form>
		
		<c:forEach items="${replyList}" var="reply">
			<div class="reply_row">
				<div class="reply_col">${reply.userid}</div>
				<div class="reply_col">
					<fmt:formatDate value="${reply.writedate}" pattern="MM/dd hh:mm"/>
				</div>
				<div class="reply_col">${reply.content}</div>
				<div class="reply_col">
					<c:if test="${reply.userid == loginUser.userid}">
						<input type="button" value="삭제"  
						onClick="location.href='board.do?command=deleteReply&replynum=${reply.replynum}&boardnum=${reply.boardnum}'"/>
					</c:if>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
</body>
</html>