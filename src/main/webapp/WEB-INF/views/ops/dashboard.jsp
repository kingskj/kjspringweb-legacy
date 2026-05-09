<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Legacy Ops Lab</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/legacy.css">
</head>
<body>
<main class="shell">
    <header class="topbar">
        <div>
            <h1 class="brand-title">Legacy Ops Lab</h1>
            <p class="brand-subtitle">Vendor, inventory, queue, batch failure surface</p>
        </div>
    </header>

    <nav class="nav">
        <a href="${pageContext.request.contextPath}/">Home</a>
        <a href="${pageContext.request.contextPath}/settlements">Settlements</a>
        <a href="${pageContext.request.contextPath}/file-import">File Import</a>
        <a href="${pageContext.request.contextPath}/async-lab/callable">Async</a>
    </nav>

    <section class="grid">
        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">Vendor Insert</h2>
                <p class="panel-note">Duplicate code and bad credit values are useful here.</p>
            </div>
            <div class="panel-body">
                <form class="form-row" method="post" action="${pageContext.request.contextPath}/ops/vendors">
                    <div class="field"><label>Code</label><input name="code" placeholder="V001"></div>
                    <div class="field"><label>Name</label><input name="name" placeholder="vendor name"></div>
                    <div class="field"><label>Credit Limit</label><input name="creditLimit" placeholder="1000"></div>
                    <button>Insert</button>
                </form>
            </div>
        </article>

        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">Inventory Insert</h2>
                <p class="panel-note">Negative and non-numeric quantity values are not blocked.</p>
            </div>
            <div class="panel-body">
                <form class="form-row" method="post" action="${pageContext.request.contextPath}/ops/inventory">
                    <div class="field"><label>SKU</label><input name="sku" placeholder="SKU-001"></div>
                    <div class="field"><label>Name</label><input name="name" placeholder="item name"></div>
                    <div class="field"><label>Quantity</label><input name="quantity" placeholder="10"></div>
                    <button>Insert</button>
                </form>
            </div>
        </article>

        <article class="panel grid-wide">
            <div class="panel-header">
                <h2 class="panel-title">Inventory Search</h2>
                <p class="panel-note">sortColumn is intentionally passed as raw MyBatis SQL.</p>
            </div>
            <div class="panel-body stack">
                <form class="form-row two" method="get" action="${pageContext.request.contextPath}/ops">
                    <div class="field"><label>Keyword</label><input name="keyword" value="${keyword}" placeholder="keyword"></div>
                    <div class="field"><label>Sort Column</label><input name="sortColumn" value="${sortColumn}" placeholder="id desc"></div>
                    <button>Search</button>
                </form>
                <div class="table-wrap">
                    <table>
                        <tr><th>ID</th><th>SKU</th><th>Name</th><th>Qty</th></tr>
                        <c:forEach var="item" items="${inventory}">
                            <tr><td>${item.id}</td><td>${item.sku}</td><td>${item.name}</td><td>${item.quantity}</td></tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </article>

        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">Daily Error Batch</h2>
                <p class="panel-note">Manual trigger for scheduled failure patterns.</p>
            </div>
            <div class="panel-body">
                <form class="form-row two" method="post" action="${pageContext.request.contextPath}/batch-lab/run">
                    <div class="field">
                        <label>Pattern</label>
                        <select name="pattern">
                            <option value="daily">daily pattern</option>
                            <option value="duplicate">duplicate vendor</option>
                            <option value="inventory">negative inventory</option>
                            <option value="status">broken status</option>
                            <option value="number">number format</option>
                            <option value="npe">null pointer</option>
                        </select>
                    </div>
                    <button type="submit">Run Pattern</button>
                </form>
            </div>
        </article>

        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">DB Queue</h2>
                <p class="panel-note">Force codes: NPE, SQL, NEGATIVE_STOCK.</p>
            </div>
            <div class="panel-body">
                <form class="form-row" method="post" action="${pageContext.request.contextPath}/ops/jobs">
                    <div class="field"><label>Job Type</label><input name="jobType" placeholder="ADJUST"></div>
                    <div class="field"><label>Payload</label><input name="payload" placeholder="SKU-BASE"></div>
                    <div class="field"><label>Force Error</label><input name="forceErrorCode" placeholder="NPE"></div>
                    <button>Enqueue</button>
                </form>
            </div>
        </article>

        <article class="panel grid-wide">
            <div class="panel-header">
                <h2 class="panel-title">Queued Jobs</h2>
            </div>
            <div class="panel-body table-wrap">
                <table>
                    <tr><th>ID</th><th>Type</th><th>Payload</th><th>Status</th><th>Attempts</th><th>Force</th><th>Run</th></tr>
                    <c:forEach var="job" items="${jobs}">
                        <tr>
                            <td>${job.id}</td><td>${job.jobType}</td><td>${job.payload}</td>
                            <td><span class="status">${job.status}</span></td><td>${job.attemptCount}</td><td>${job.forceErrorCode}</td>
                            <td><form method="post" action="${pageContext.request.contextPath}/ops/jobs/${job.id}/run"><button>Run</button></form></td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </article>

        <article class="panel grid-wide">
            <div class="panel-header">
                <h2 class="panel-title">Vendors</h2>
            </div>
            <div class="panel-body table-wrap">
                <table>
                    <tr><th>ID</th><th>Code</th><th>Name</th><th>Credit</th></tr>
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
