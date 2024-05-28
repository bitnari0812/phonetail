<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/login.css">
</head>
<body>
<div id="wrap">
	<article>
			<form method="post" action="phonetail.do?command=login" >
					<h2>LogIn</h2>
					<div class="field">
							<label>User ID</label><input name="userid" type="text" />
					</div>
					<div class="field">
							<label>Password</label><input name="pwd" type="password" >
					</div>
					<div class="btn">
	  				        	<input type="submit" value="LOGIN" />
					</div>
					<div style="font-size:80%; font-weight:bold">${message} </div>
			</form>
	</article>
</div>
</body>
</html>
