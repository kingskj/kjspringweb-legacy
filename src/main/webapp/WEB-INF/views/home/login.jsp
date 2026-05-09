<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Legacy Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/legacy.css">
</head>
<body>
<main class="login-wrap">
    <section class="panel login-panel">
        <div class="panel-header">
            <h1 class="panel-title">kjspringweb legacy</h1>
            <p class="panel-note">Spring MVC 4.x / session login</p>
        </div>
        <div class="panel-body">
            <form class="stack" action="${pageContext.request.contextPath}/login" method="post">
                <div class="field">
                    <label>Username</label>
                    <input name="username" value="user">
                </div>
                <div class="field">
                    <label>Password</label>
                    <input name="password" type="password" value="password">
                </div>
                <button type="submit">Login</button>
            </form>
        </div>
    </section>
</main>
</body>
</html>
