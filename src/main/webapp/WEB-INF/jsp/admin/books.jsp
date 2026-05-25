<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="zh-CN">
<head><meta charset="UTF-8"><title>图书管理</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css"></head>
<body>
<div class="sidebar-layout">
    <aside class="sidebar"><a class="brand" href="${pageContext.request.contextPath}/admin/dashboard">网上书城后台</a><nav class="side-nav"><a href="${pageContext.request.contextPath}/admin/dashboard">后台首页</a><a class="active" href="${pageContext.request.contextPath}/admin/books">图书管理</a><a href="${pageContext.request.contextPath}/admin/orders">订单管理</a><a href="${pageContext.request.contextPath}/admin/users">用户管理</a><a href="${pageContext.request.contextPath}/logout">退出登录</a></nav></aside>
    <main class="admin-main">
        <div class="page-title"><div><h1>图书管理</h1><p class="subtitle">维护书籍基础信息与库存。</p></div></div>
        <form class="card form-grid" method="post" action="${pageContext.request.contextPath}/admin/books/save">
            <input type="hidden" name="id" value="${editBook.id}">
            <input class="input" name="title" placeholder="书名" value="${editBook.title}" required>
            <input class="input" name="author" placeholder="作者" value="${editBook.author}" required>
            <input class="input" name="category" placeholder="分类" value="${editBook.category}" required>
            <input class="input" name="price" placeholder="价格" value="${editBook.price}" required>
            <input class="input" name="stock" placeholder="库存" value="${editBook.stock}" required>
            <input class="input" name="coverUrl" placeholder="封面路径，如 assets/img/book-java.svg" value="${empty editBook.coverUrl ? 'assets/img/book-java.svg' : editBook.coverUrl}">
            <textarea class="textarea full" name="description" placeholder="简介">${editBook.description}</textarea>
            <div class="full toolbar"><button class="btn accent" type="submit">保存书籍</button><a class="btn secondary" href="${pageContext.request.contextPath}/admin/books">清空表单</a></div>
        </form>
        <section class="card table-wrap" style="margin-top:22px">
            <table>
                <thead><tr><th>编号</th><th>书名</th><th>作者</th><th>分类</th><th>价格</th><th>库存</th><th>操作</th></tr></thead>
                <tbody>
                <c:forEach items="${books}" var="book">
                    <tr>
                        <td>${book.id}</td><td><strong>${book.title}</strong></td><td>${book.author}</td><td>${book.category}</td><td>￥<fmt:formatNumber value="${book.price}" pattern="0.00"/></td><td>${book.stock}</td>
                        <td class="toolbar">
                            <a class="btn secondary" href="${pageContext.request.contextPath}/admin/books?id=${book.id}">编辑</a>
                            <form method="post" action="${pageContext.request.contextPath}/admin/books/delete" onsubmit="return confirmDelete('删除后不可恢复，确认删除？')"><input type="hidden" name="id" value="${book.id}"><button class="btn danger" type="submit">删除</button></form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </section>
    </main>
</div>
<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>
