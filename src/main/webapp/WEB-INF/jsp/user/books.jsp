<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>网上书城系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css">
</head>
<body>
<header class="topbar">
    <div class="container topbar-inner">
        <a class="brand" href="${pageContext.request.contextPath}/books">网上书城系统</a>
        <nav class="nav">
            <a class="active" href="${pageContext.request.contextPath}/books">首页</a>
            <a href="${pageContext.request.contextPath}/cart">购物车</a>
            <a href="${pageContext.request.contextPath}/orders">我的订单</a>
            <c:choose>
                <c:when test="${empty sessionScope.loginUser}"><a href="${pageContext.request.contextPath}/login">登录</a></c:when>
                <c:otherwise><a href="${pageContext.request.contextPath}/logout">退出登录</a></c:otherwise>
            </c:choose>
        </nav>
    </div>
</header>
<main class="container page">
    <div class="page-title">
        <div>
            <h1>精选书籍</h1>
            <p class="subtitle">浏览课程设计书城中的全部图书，支持搜索与分类筛选。</p>
        </div>
        <form class="toolbar" method="get" action="${pageContext.request.contextPath}/books">
            <input class="input" name="keyword" value="${keyword}" placeholder="搜索书名或作者">
            <select class="select" name="category">
                <option value="">全部分类</option>
                <c:forEach items="${categories}" var="cat">
                    <option value="${cat}" ${cat == category ? 'selected' : ''}>${cat}</option>
                </c:forEach>
            </select>
            <button class="btn secondary" type="submit">筛选</button>
        </form>
    </div>
    <section class="grid book-grid">
        <c:forEach items="${books}" var="book">
            <article class="card book-card">
                <div class="book-cover"><img src="${pageContext.request.contextPath}/${book.coverUrl}" alt="${book.title}"></div>
                <div class="book-body">
                    <span class="badge">${book.category}</span>
                    <h3>${book.title}</h3>
                    <div class="book-meta">作者：${book.author} · 库存：${book.stock}</div>
                    <p class="subtitle">${book.description}</p>
                    <div style="margin-top:auto;display:flex;align-items:center;justify-content:space-between;gap:12px">
                        <span class="price">￥<fmt:formatNumber value="${book.price}" pattern="0.00"/></span>
                        <form method="post" action="${pageContext.request.contextPath}/cart/add">
                            <input type="hidden" name="bookId" value="${book.id}">
                            <input type="hidden" name="quantity" value="1">
                            <button class="btn accent" type="submit">加入购物车</button>
                        </form>
                    </div>
                </div>
            </article>
        </c:forEach>
    </section>
</main>
</body>
</html>
