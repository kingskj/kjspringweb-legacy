<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Session Settlement Lab</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/legacy.css">
</head>
<body>
<main class="shell">
    <header class="topbar">
        <div>
            <h1 class="brand-title">Session Settlement Lab</h1>
            <p class="brand-subtitle">Session workbox and direct DB insert paths</p>
        </div>
    </header>

    <nav class="nav">
        <a href="${pageContext.request.contextPath}/">Home</a>
        <a href="${pageContext.request.contextPath}/ops">Ops Lab</a>
        <a href="${pageContext.request.contextPath}/file-import">File Import</a>
    </nav>

    <section class="grid">
        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">Direct Insert</h2>
                <p class="panel-note">Bypasses the session workbox.</p>
            </div>
            <div class="panel-body">
                <form class="form-row" method="post" action="${pageContext.request.contextPath}/settlements/direct">
                    <div class="field"><label>Vendor Code</label><input name="vendorCode" placeholder="V001"></div>
                    <div class="field"><label>Amount</label><input name="amount" placeholder="1000"></div>
                    <div class="field"><label>Business Date</label><input name="businessDate" placeholder="YYYY-MM-DD"></div>
                    <button>Insert Direct</button>
                </form>
            </div>
        </article>

        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">Session Workbox</h2>
                <p class="panel-note">Commit can fail if the session list is missing or malformed.</p>
            </div>
            <div class="panel-body stack">
                <form class="form-row" method="post" action="${pageContext.request.contextPath}/settlements/session/add">
                    <div class="field"><label>Vendor Code</label><input name="vendorCode" placeholder="V001"></div>
                    <div class="field"><label>Amount</label><input name="amount" placeholder="1000"></div>
                    <div class="field"><label>Business Date</label><input name="businessDate" placeholder="YYYY-MM-DD"></div>
                    <button>Add</button>
                </form>
                <form method="post" action="${pageContext.request.contextPath}/settlements/session/commit">
                    <button type="submit">Commit Session Items</button>
                </form>
            </div>
        </article>

        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">Current Session Items</h2>
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
                <h2 class="panel-title">Settlements</h2>
            </div>
            <div class="panel-body table-wrap">
                <table>
                    <tr><th>ID</th><th>Vendor</th><th>Amount</th><th>Date</th><th>Status</th></tr>
                    <c:forEach var="row" items="${settlements}">
                        <tr><td>${row.id}</td><td>${row.vendorCode}</td><td>${row.amount}</td><td>${row.businessDate}</td><td><span class="status">${row.status}</span></td></tr>
                    </c:forEach>
                </table>
            </div>
        </article>
    </section>
</main>
</body>
</html>
