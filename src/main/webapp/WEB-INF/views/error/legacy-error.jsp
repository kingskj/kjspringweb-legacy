<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Legacy Error</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/legacy.css">
</head>
<body>
<main class="shell">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/">Home</a>
        <a href="${pageContext.request.contextPath}/ops">Ops Lab</a>
        <a href="javascript:history.back()">Back</a>
    </nav>
    <section class="panel">
        <div class="panel-header">
            <h1 class="panel-title">Legacy Error Observed</h1>
            <p class="panel-note">The server-side failure was intentionally exposed.</p>
        </div>
        <div class="panel-body">
            <div class="error-box">
                <p><strong>Exception Class</strong></p>
                <p class="code-line">${exceptionClass}</p>
                <p><strong>Message</strong></p>
                <p class="code-line">${exceptionMessage}</p>
            </div>
        </div>
    </section>
</main>
</body>
</html>
