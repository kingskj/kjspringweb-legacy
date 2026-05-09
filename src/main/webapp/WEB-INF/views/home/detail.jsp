<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${board.title}</title>
</head>
<body>
<h1>${board.title}</h1>
<p>${board.content}</p>
<a href="${pageContext.request.contextPath}/legacy/boards">Back</a>
</body>
</html>
