<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>운영 장애 실험실</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/legacy.css">
</head>
<body>
<main class="shell">
    <header class="topbar">
        <div>
            <h1 class="brand-title">운영 장애 실험실</h1>
            <p class="brand-subtitle">벤더, 재고, DB 큐, 배치 수동 실행을 통해 레거시 Spring + MyBatis 환경의 실패 지점을 확인합니다.</p>
        </div>
    </header>

    <nav class="nav">
        <a href="${pageContext.request.contextPath}/">홈</a>
        <a href="${pageContext.request.contextPath}/settlements">정산 작업함</a>
        <a href="${pageContext.request.contextPath}/file-import">파일 가져오기</a>
        <a href="${pageContext.request.contextPath}/async-lab/callable">비동기 확인</a>
    </nav>

    <section class="grid">
        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">벤더 등록</h2>
                <p class="panel-note">중복 코드, 빈 이름, 숫자가 아닌 한도 값을 넣어 UNIQUE, NOT NULL, 숫자 파싱 실패를 확인합니다.</p>
            </div>
            <div class="panel-body">
                <form class="form-row" method="post" action="${pageContext.request.contextPath}/ops/vendors">
                    <div class="field"><label>벤더 코드</label><input name="code" placeholder="V001"><span class="field-help">이미 존재하는 코드를 입력하면 DB UNIQUE 제약 오류가 발생합니다.</span></div>
                    <div class="field"><label>벤더명</label><input name="name" placeholder="테스트 벤더"><span class="field-help">공백이나 누락 값은 레거시 입력 검증 부재를 확인하는 데 사용합니다.</span></div>
                    <div class="field"><label>신용 한도</label><input name="creditLimit" placeholder="1000"><span class="field-help">abc 같은 문자를 넣으면 Long 변환 단계에서 실패합니다.</span></div>
                    <button>등록</button>
                </form>
            </div>
        </article>

        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">재고 등록</h2>
                <p class="panel-note">음수 수량과 숫자가 아닌 수량을 막지 않아 서비스 파싱 또는 DB CHECK 제약 실패를 그대로 노출합니다.</p>
            </div>
            <div class="panel-body">
                <form class="form-row" method="post" action="${pageContext.request.contextPath}/ops/inventory">
                    <div class="field"><label>SKU</label><input name="sku" placeholder="SKU-001"><span class="field-help">상품 재고를 구분하는 코드입니다. 중복 입력 시 DB 제약을 확인합니다.</span></div>
                    <div class="field"><label>품목명</label><input name="name" placeholder="테스트 품목"><span class="field-help">목록과 검색 결과에 표시되는 재고 이름입니다.</span></div>
                    <div class="field"><label>수량</label><input name="quantity" placeholder="10"><span class="field-help">-1 또는 문자 입력으로 CHECK 제약과 숫자 변환 오류를 유도합니다.</span></div>
                    <button>등록</button>
                </form>
            </div>
        </article>

        <article class="panel grid-wide">
            <div class="panel-header">
                <h2 class="panel-title">재고 검색</h2>
                <p class="panel-note">정렬 컬럼은 MyBatis SQL 조각으로 직접 전달되어 잘못된 컬럼명이나 SQL 문법 오류를 확인할 수 있습니다.</p>
            </div>
            <div class="panel-body stack">
                <form class="form-row two" method="get" action="${pageContext.request.contextPath}/ops">
                    <div class="field"><label>검색어</label><input name="keyword" value="${keyword}" placeholder="SKU 또는 품목명"><span class="field-help">SKU와 품목명에 포함된 문자열을 기준으로 재고 목록을 좁힙니다.</span></div>
                    <div class="field"><label>정렬 SQL 조각</label><input name="sortColumn" value="${sortColumn}" placeholder="id desc"><span class="field-help">예: id desc. 잘못된 값은 raw order by 오류 검증에 사용합니다.</span></div>
                    <button>검색</button>
                </form>
                <div class="table-wrap">
                    <table>
                        <tr><th>번호</th><th>SKU</th><th>품목명</th><th>수량</th></tr>
                        <c:forEach var="item" items="${inventory}">
                            <tr><td>${item.id}</td><td>${item.sku}</td><td>${item.name}</td><td>${item.quantity}</td></tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </article>

        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">일일 장애 배치 수동 실행</h2>
                <p class="panel-note">스케줄러가 날짜별로 실행하는 장애 패턴을 버튼으로 즉시 실행해 배치 로그와 예외 처리를 확인합니다.</p>
            </div>
            <div class="panel-body">
                <form class="form-row two" method="post" action="${pageContext.request.contextPath}/batch-lab/run">
                    <div class="field">
                        <label>장애 패턴</label>
                        <select name="pattern">
                            <option value="daily">오늘 날짜 기준 자동 패턴</option>
                            <option value="duplicate">벤더 코드 중복</option>
                            <option value="inventory">재고 음수 조정</option>
                            <option value="status">잘못된 큐 상태값</option>
                            <option value="number">숫자 형식 오류</option>
                            <option value="npe">널 포인터 예외</option>
                        </select>
                        <span class="field-help">선택한 패턴은 배치 서비스에서 바로 실행되며 실패 로그가 남습니다.</span>
                    </div>
                    <button type="submit">패턴 실행</button>
                </form>
            </div>
        </article>

        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">DB 큐 작업 등록</h2>
                <p class="panel-note">큐에 작업을 넣고 강제 오류 코드를 지정해 처리 시점의 예외, SQL 실패, 재고 제약 실패를 확인합니다.</p>
            </div>
            <div class="panel-body">
                <form class="form-row" method="post" action="${pageContext.request.contextPath}/ops/jobs">
                    <div class="field"><label>작업 유형</label><input name="jobType" placeholder="ADJUST"><span class="field-help">큐 작업의 성격을 나타내는 코드입니다.</span></div>
                    <div class="field"><label>작업 데이터</label><input name="payload" placeholder="SKU-BASE"><span class="field-help">재고 SKU 등 처리 대상 데이터를 문자열로 저장합니다.</span></div>
                    <div class="field"><label>강제 오류 코드</label><input name="forceErrorCode" placeholder="NPE"><span class="field-help">NPE, SQL, NEGATIVE_STOCK 값을 넣으면 실행 시 지정된 실패가 발생합니다.</span></div>
                    <button>큐에 등록</button>
                </form>
            </div>
        </article>

        <article class="panel grid-wide">
            <div class="panel-header">
                <h2 class="panel-title">대기 중인 큐 작업</h2>
                <p class="panel-note">각 행의 실행 버튼은 저장된 큐 작업을 즉시 처리하며, 상태와 시도 횟수 변화를 확인합니다.</p>
            </div>
            <div class="panel-body table-wrap">
                <table>
                    <tr><th>번호</th><th>유형</th><th>데이터</th><th>상태</th><th>시도 횟수</th><th>강제 오류</th><th>실행</th></tr>
                    <c:forEach var="job" items="${jobs}">
                        <tr>
                            <td>${job.id}</td><td>${job.jobType}</td><td>${job.payload}</td>
                            <td>
                                <span class="status">
                                    <c:choose>
                                        <c:when test="${job.status == 'READY'}">대기</c:when>
                                        <c:when test="${job.status == 'PROCESSING'}">처리 중</c:when>
                                        <c:when test="${job.status == 'DONE'}">완료</c:when>
                                        <c:when test="${job.status == 'FAILED'}">실패</c:when>
                                        <c:otherwise>${job.status}</c:otherwise>
                                    </c:choose>
                                </span>
                            </td><td>${job.attemptCount}</td><td>${job.forceErrorCode}</td>
                            <td><form method="post" action="${pageContext.request.contextPath}/ops/jobs/${job.id}/run"><button>실행</button></form></td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </article>

        <article class="panel grid-wide">
            <div class="panel-header">
                <h2 class="panel-title">등록된 벤더</h2>
                <p class="panel-note">벤더 등록 실험 결과가 저장되는 목록입니다. 코드 중복 여부와 신용 한도 값이 그대로 표시됩니다.</p>
            </div>
            <div class="panel-body table-wrap">
                <table>
                    <tr><th>번호</th><th>코드</th><th>벤더명</th><th>신용 한도</th></tr>
                    <c:forEach var="vendor" items="${vendors}">
                        <tr><td>${vendor.id}</td><td>${vendor.code}</td><td>${vendor.name}</td><td>${vendor.creditLimit}</td></tr>
                    </c:forEach>
                </table>
            </div>
        </article>
    </section>
</main>
</body>
</html>
