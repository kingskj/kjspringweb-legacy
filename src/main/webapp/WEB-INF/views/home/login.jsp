<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>login</title>
</head>
<body>
<h1>Login</h1>
<form action="${pageContext.request.contextPath}/login" method="post">
    <label>Username <input name="username" value="user"></label><br>
    <label>Password <input name="password" type="password" value="password"></label><br>
    <button type="submit">Login</button>
</form>
</body>
</html>
