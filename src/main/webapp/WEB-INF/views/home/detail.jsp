<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${board.title}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/legacy.css">
</head>
<body>
<main class="shell">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/">Home</a>
        <a href="${pageContext.request.contextPath}/legacy/boards">Boards</a>
        <a href="${pageContext.request.contextPath}/ops">Ops Lab</a>
    </nav>
    <section class="panel">
        <div class="panel-header">
            <h1 class="panel-title">${board.title}</h1>
            <p class="panel-note">Board ID ${board.id}</p>
        </div>
        <div class="panel-body">
            <p>${board.content}</p>
            <a class="link-button" href="${pageContext.request.contextPath}/legacy/boards">Back</a>
        </div>
    </section>
</main>
</body>
</html>
