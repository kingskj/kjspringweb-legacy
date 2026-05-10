<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>파일 드롭박스 가져오기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/legacy.css">
</head>
<body>
<main class="shell">
    <header class="topbar">
        <div>
            <h1 class="brand-title">파일 드롭박스 가져오기</h1>
            <p class="brand-subtitle">드롭박스 경로의 파일 매니페스트를 등록하고 처리하면서 파일 없음, 행 수 불일치, 숫자 파싱 실패를 확인합니다.</p>
        </div>
    </header>

    <nav class="nav">
        <a href="${pageContext.request.contextPath}/">홈</a>
        <a href="${pageContext.request.contextPath}/ops">운영 장애 실험실</a>
        <a href="${pageContext.request.contextPath}/settlements">정산 작업함</a>
    </nav>

    <section class="grid">
        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">파일 매니페스트 등록</h2>
                <p class="panel-note">처리할 파일명과 예상 행 수를 먼저 DB에 등록합니다. 실제 파일은 아래 드롭박스 경로에 있어야 합니다.</p>
                <p class="panel-note code-line">D:/workspace/kjspringweb-legacy/dropbox</p>
            </div>
            <div class="panel-body">
                <form class="form-row two" method="post" action="${pageContext.request.contextPath}/file-import/register">
                    <div class="field"><label>파일명</label><input name="fileName" placeholder="fileName.csv"><span class="field-help">드롭박스 폴더에서 찾을 CSV 파일명입니다. 없는 파일이면 처리 단계에서 실패합니다.</span></div>
                    <div class="field"><label>예상 행 수</label><input name="expectedRows" placeholder="10"><span class="field-help">실제 파일 행 수와 다르면 행 수 불일치 오류를 확인합니다.</span></div>
                    <button>등록</button>
                </form>
            </div>
        </article>

        <article class="panel grid-wide">
            <div class="panel-header">
                <h2 class="panel-title">등록된 매니페스트</h2>
                <p class="panel-note">각 파일 등록 건의 처리 상태입니다. 처리 버튼을 누르면 파일 존재 여부, 행 수, 데이터 형식 검증이 실행됩니다.</p>
            </div>
            <div class="panel-body table-wrap">
                <table>
                    <tr><th>번호</th><th>파일명</th><th>예상 행 수</th><th>상태</th><th>처리</th></tr>
                    <c:forEach var="m" items="${manifests}">
                        <tr>
                            <td>${m.id}</td><td>${m.fileName}</td><td>${m.expectedRows}</td>
                            <td>
                                <span class="status">
                                    <c:choose>
                                        <c:when test="${m.status == 'REGISTERED'}">등록됨</c:when>
                                        <c:when test="${m.status == 'DONE'}">완료</c:when>
                                        <c:when test="${m.status == 'FAILED'}">실패</c:when>
                                        <c:otherwise>${m.status}</c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                            <td><form method="post" action="${pageContext.request.contextPath}/file-import/${m.id}/process"><button>처리</button></form></td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </article>
    </section>
</main>
</body>
</html>
