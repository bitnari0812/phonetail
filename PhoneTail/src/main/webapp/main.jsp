<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<link rel="stylesheet" href="css/main.css">
</head>
<body>
<h1>Main</h1>
<a href="phonetail.do?command=productList">상품목록</a>
<a href="phonetail.do?command=chatList">채팅게시판</a>
<a href="phonetail.do?command=qnaList">qna게시판</a>
<a href="phonetail.do?command=loginForm">로그인</a><br><br>
${login.userid}(${login.name})님이 로그인 하셨습니다<br>
</body>
</html>