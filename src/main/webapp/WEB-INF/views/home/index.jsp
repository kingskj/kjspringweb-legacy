<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>kjspringweb legacy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/legacy.css">
</head>
<body>
<main class="shell">
    <header class="topbar">
        <div>
            <h1 class="brand-title">kjspringweb legacy</h1>
            <p class="brand-subtitle">Legacy Spring test target for TurtlePick agent</p>
        </div>
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <button class="secondary" type="submit">Logout</button>
        </form>
    </header>

    <nav class="nav">
        <a href="${pageContext.request.contextPath}/">Home</a>
        <a href="${pageContext.request.contextPath}/ops">Ops Lab</a>
        <a href="${pageContext.request.contextPath}/settlements">Settlements</a>
        <a href="${pageContext.request.contextPath}/file-import">File Import</a>
        <a href="${pageContext.request.contextPath}/async-lab/callable">Async Callable</a>
        <a href="${pageContext.request.contextPath}/async-lab/deferred">Async Deferred</a>
    </nav>

    <section class="grid">
        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">Seed Boards</h2>
                <p class="panel-note">Basic MVC route samples</p>
            </div>
            <div class="panel-body">
                <ul class="list">
                    <c:forEach var="board" items="${boards}">
                        <li><a href="${pageContext.request.contextPath}/legacy/boards/${board.id}">${board.title}</a></li>
                    </c:forEach>
                </ul>
            </div>
        </article>

        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">Failure Labs</h2>
                <p class="panel-note">Inputs are intentionally left unchecked</p>
            </div>
            <div class="panel-body">
                <div class="actions">
                    <a class="link-button" href="${pageContext.request.contextPath}/ops">Operations</a>
                    <a class="link-button" href="${pageContext.request.contextPath}/settlements">Session Workbox</a>
                    <a class="link-button" href="${pageContext.request.contextPath}/file-import">File Dropbox</a>
                    <a class="link-button" href="${pageContext.request.contextPath}/async-lab/callable-error">Async Error</a>
                </div>
            </div>
        </article>
    </section>
</main>
</body>
</html>
