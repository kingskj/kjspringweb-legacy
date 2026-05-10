<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>세션 정산 작업함</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/legacy.css">
</head>
<body>
<main class="shell">
    <header class="topbar">
        <div>
            <h1 class="brand-title">세션 정산 작업함</h1>
            <p class="brand-subtitle">세션에 임시 정산 항목을 담아 커밋하거나 DB에 직접 삽입해 레거시 세션 처리와 정산 제약 오류를 확인합니다.</p>
        </div>
    </header>

    <nav class="nav">
        <a href="${pageContext.request.contextPath}/">홈</a>
        <a href="${pageContext.request.contextPath}/ops">운영 장애 실험실</a>
        <a href="${pageContext.request.contextPath}/file-import">파일 가져오기</a>
    </nav>

    <section class="grid">
        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">정산 직접 등록</h2>
                <p class="panel-note">세션 작업함을 거치지 않고 바로 DB에 저장합니다. 중복 정산, 음수 금액, 잘못된 날짜 입력을 빠르게 확인합니다.</p>
            </div>
            <div class="panel-body">
                <form class="form-row" method="post" action="${pageContext.request.contextPath}/settlements/direct">
                    <div class="field"><label>벤더 코드</label><input name="vendorCode" placeholder="V001"><span class="field-help">정산 대상 벤더 코드입니다. 기존 정산과 같은 조합이면 중복 오류를 확인합니다.</span></div>
                    <div class="field"><label>정산 금액</label><input name="amount" placeholder="1000"><span class="field-help">숫자가 아닌 값이나 음수 입력으로 파싱/DB 제약 실패를 유도합니다.</span></div>
                    <div class="field"><label>영업일</label><input name="businessDate" placeholder="YYYY-MM-DD"><span class="field-help">정산 기준 날짜입니다. 형식 오류는 서비스 처리 실패를 확인하는 데 사용합니다.</span></div>
                    <button>바로 등록</button>
                </form>
            </div>
        </article>

        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">세션 작업함 추가</h2>
                <p class="panel-note">입력값을 먼저 서버 세션에 보관한 뒤 일괄 커밋합니다. 세션 누락, 잘못된 항목, 커밋 중 DB 실패를 확인합니다.</p>
            </div>
            <div class="panel-body stack">
                <form class="form-row" method="post" action="${pageContext.request.contextPath}/settlements/session/add">
                    <div class="field"><label>벤더 코드</label><input name="vendorCode" placeholder="V001"><span class="field-help">세션에 임시 저장할 정산 벤더입니다.</span></div>
                    <div class="field"><label>정산 금액</label><input name="amount" placeholder="1000"><span class="field-help">커밋 시점까지 문자열로 남아 있어 나중에 변환 실패를 만들 수 있습니다.</span></div>
                    <div class="field"><label>영업일</label><input name="businessDate" placeholder="YYYY-MM-DD"><span class="field-help">세션 목록에 보관된 뒤 커밋 요청에서 DB 저장에 사용됩니다.</span></div>
                    <button>작업함에 추가</button>
                </form>
                <form method="post" action="${pageContext.request.contextPath}/settlements/session/commit">
                    <button type="submit">세션 항목 커밋</button>
                </form>
            </div>
        </article>

        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">현재 세션 항목</h2>
                <p class="panel-note">아직 DB에 저장되지 않은 임시 정산 항목입니다. 커밋 버튼을 누르면 이 목록이 순서대로 저장됩니다.</p>
            </div>
            <div class="panel-body">
                <ul class="list">
                    <c:forEach var="item" items="${workItems}">
                        <li>${item.vendorCode} / ${item.amount} / ${item.businessDate}</li>
                    </c:forEach>
                </ul>
            </div>
        </article>

        <article class="panel grid-wide">
            <div class="panel-header">
                <h2 class="panel-title">저장된 정산 목록</h2>
                <p class="panel-note">직접 등록 또는 세션 커밋으로 저장된 정산 결과입니다. 상태값과 중복 저장 여부를 확인합니다.</p>
            </div>
            <div class="panel-body table-wrap">
                <table>
                    <tr><th>번호</th><th>벤더</th><th>금액</th><th>영업일</th><th>상태</th></tr>
                    <c:forEach var="row" items="${settlements}">
                        <tr>
                            <td>${row.id}</td><td>${row.vendorCode}</td><td>${row.amount}</td><td>${row.businessDate}</td>
                            <td>
                                <span class="status">
                                    <c:choose>
                                        <c:when test="${row.status == 'REQUESTED'}">요청됨</c:when>
                                        <c:when test="${row.status == 'APPROVED'}">승인됨</c:when>
                                        <c:when test="${row.status == 'CANCELED'}">취소됨</c:when>
                                        <c:otherwise>${row.status}</c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </article>
    </section>
</main>
</body>
</html>
