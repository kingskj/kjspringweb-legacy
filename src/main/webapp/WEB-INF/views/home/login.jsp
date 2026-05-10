<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>레거시 로그인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/legacy.css">
</head>
<body>
<main class="login-wrap">
    <section class="panel login-panel">
        <div class="panel-header">
            <h1 class="panel-title">레거시 Spring 로그인</h1>
            <p class="panel-note">Spring Security 4.x의 서버 세션 기반 form-login 인증을 확인하는 진입 화면입니다.</p>
        </div>
        <div class="panel-body">
            <form class="stack" action="${pageContext.request.contextPath}/login" method="post">
                <div class="field">
                    <label>사용자 아이디</label>
                    <input name="username" value="user">
                    <span class="field-help">기본 사용자 계정은 user, 관리자 계정은 admin입니다.</span>
                </div>
                <div class="field">
                    <label>비밀번호</label>
                    <input name="password" type="password" value="password">
                    <span class="field-help">user 계정 기본값은 password, admin 계정 기본값은 admin입니다.</span>
                </div>
                <button type="submit">로그인</button>
            </form>
        </div>
    </section>
</main>
</body>
</html>
