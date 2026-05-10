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
        <a href="${pageContext.request.contextPath}/">홈</a>
        <a href="${pageContext.request.contextPath}/legacy/boards">게시글 목록</a>
        <a href="${pageContext.request.contextPath}/ops">운영 장애 실험실</a>
    </nav>
    <section class="panel">
        <div class="panel-header">
            <h1 class="panel-title">${board.title}</h1>
            <p class="panel-note">게시글 번호 ${board.id}번입니다. 이 화면은 URL 경로 변수, DB 단건 조회, JSP 출력 흐름을 확인하는 상세 예제입니다.</p>
        </div>
        <div class="panel-body">
            <p>${board.content}</p>
            <a class="link-button" href="${pageContext.request.contextPath}/legacy/boards">목록으로 돌아가기</a>
        </div>
    </section>
</main>
</body>
</html>
