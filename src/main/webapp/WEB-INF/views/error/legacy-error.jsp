<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>레거시 오류 확인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/legacy.css">
</head>
<body>
<main class="shell">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/">홈</a>
        <a href="${pageContext.request.contextPath}/ops">운영 장애 실험실</a>
        <a href="javascript:history.back()">이전 화면</a>
    </nav>
    <section class="panel">
        <div class="panel-header">
            <h1 class="panel-title">레거시 오류가 감지되었습니다</h1>
            <p class="panel-note">서버 내부에서 발생한 예외를 숨기지 않고 표시합니다. TurtlePick 에이전트의 예외 추적과 로그 수집을 확인하기 위한 화면입니다.</p>
        </div>
        <div class="panel-body">
            <div class="error-box">
                <p><strong>예외 클래스</strong></p>
                <p class="code-line">${exceptionClass}</p>
                <p><strong>예외 메시지</strong></p>
                <p class="code-line">${exceptionMessage}</p>
            </div>
        </div>
    </section>
</main>
</body>
</html>
