<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>File Dropbox Import Lab</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/legacy.css">
</head>
<body>
<main class="shell">
    <header class="topbar">
        <div>
            <h1 class="brand-title">File Dropbox Import Lab</h1>
            <p class="brand-subtitle">Manifest registration and file processing failure path</p>
        </div>
    </header>

    <nav class="nav">
        <a href="${pageContext.request.contextPath}/">Home</a>
        <a href="${pageContext.request.contextPath}/ops">Ops Lab</a>
        <a href="${pageContext.request.contextPath}/settlements">Settlements</a>
    </nav>

    <section class="grid">
        <article class="panel">
            <div class="panel-header">
                <h2 class="panel-title">Register Manifest</h2>
                <p class="panel-note code-line">D:/workspace/kjspringweb-legacy/dropbox</p>
            </div>
            <div class="panel-body">
                <form class="form-row two" method="post" action="${pageContext.request.contextPath}/file-import/register">
                    <div class="field"><label>File Name</label><input name="fileName" placeholder="fileName.csv"></div>
                    <div class="field"><label>Expected Rows</label><input name="expectedRows" placeholder="10"></div>
                    <button>Register</button>
                </form>
            </div>
        </article>

        <article class="panel grid-wide">
            <div class="panel-header">
                <h2 class="panel-title">Manifests</h2>
            </div>
            <div class="panel-body table-wrap">
                <table>
                    <tr><th>ID</th><th>File</th><th>Expected</th><th>Status</th><th>Process</th></tr>
                    <c:forEach var="m" items="${manifests}">
                        <tr>
                            <td>${m.id}</td><td>${m.fileName}</td><td>${m.expectedRows}</td><td><span class="status">${m.status}</span></td>
                            <td><form method="post" action="${pageContext.request.contextPath}/file-import/${m.id}/process"><button>Process</button></form></td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </article>
    </section>
</main>
</body>
</html>
