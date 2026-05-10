<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>레거시 Spring 검증 서버</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/legacy.css">
</head>
<body>
<main class="shell">
    <header class="topbar">
        <div>
            <h1 class="brand-title">레거시 Spring 검증 서버</h1>
            <p class="brand-subtitle">TurtlePick 에이전트가 WAR, web.xml, XML 설정 기반 Spring MVC 4.x 환경을 추적하는지 확인하는 실험용 화면입니다.</p>
        </div>
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <button class="secondary" type="submit">로그아웃</button>
        </form>
    </header>

    <nav class="nav">
        <a href="${pageContext.request.contextPath}/">홈</a>
        <a href="${pageContext.request.contextPath}/ops">운영 장애 실험실</a>
        <a href="${pageContext.request.contextPath}/settlements">정산 작업함</a>
        <a href="${pageContext.request.contextPath}/file-import">파일 가져오기</a>
        <a href="${pageContext.request.contextPath}/async-lab/callable">호출형 비동기 확인</a>
        <a href="${pageContext.request.contextPath}/async-lab/deferred">지연 결과 비동기 확인</a>
    </nav>

    <section class="grid">
        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">샘플 게시글</h2>
                <p class="panel-note">Spring MVC 컨트롤러, MyBatis XML 매퍼, JSP 렌더링 흐름이 연결되는 기본 조회 예제입니다.</p>
            </div>
            <div class="panel-body">
                <ul class="list">
                    <c:forEach var="board" items="${boards}">
                        <li>
                            <a href="${pageContext.request.contextPath}/legacy/boards/${board.id}">${board.title}</a>
                            <span class="item-desc">게시글 상세 화면으로 이동해 path variable 처리와 DB 단건 조회 흐름을 확인합니다.</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </article>

        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">장애 유도 실험 항목</h2>
                <p class="panel-note">입력값 검증을 일부러 생략해 파싱 오류, DB 제약 위반, 비동기 예외가 서비스/매퍼/서버 단계에서 드러나도록 구성했습니다.</p>
            </div>
            <div class="panel-body">
                <div class="action-list">
                    <a class="link-button described" href="${pageContext.request.contextPath}/ops">
                        <strong>운영 장애 실험실</strong>
                        <span>벤더 중복, 재고 음수, 정렬 SQL 오류, DB 큐 강제 실패를 한 화면에서 실행합니다.</span>
                    </a>
                    <a class="link-button described" href="${pageContext.request.contextPath}/settlements">
                        <strong>세션 정산 작업함</strong>
                        <span>세션에 담은 정산 항목을 커밋하거나 직접 삽입해 중복/금액/날짜 오류를 확인합니다.</span>
                    </a>
                    <a class="link-button described" href="${pageContext.request.contextPath}/file-import">
                        <strong>파일 드롭박스 처리</strong>
                        <span>매니페스트 등록 후 실제 파일 존재 여부와 행 수 불일치 같은 파일 처리 실패를 관찰합니다.</span>
                    </a>
                    <a class="link-button described" href="${pageContext.request.contextPath}/async-lab/callable-error">
                        <strong>비동기 예외 호출</strong>
                        <span>Spring MVC 호출형 비동기 처리 내부에서 발생한 예외가 에러 화면과 로그로 이어지는지 검증합니다.</span>
                    </a>
                </div>
            </div>
        </article>
    </section>
</main>
</body>
</html>
