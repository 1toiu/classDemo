<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="zh-CN">
<head><meta charset="UTF-8"><title>管理员后台</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css"></head>
<body>
<div class="sidebar-layout">
    <aside class="sidebar"><a class="brand" href="${pageContext.request.contextPath}/admin/dashboard">网上书城后台</a><nav class="side-nav"><a class="active" href="${pageContext.request.contextPath}/admin/dashboard">后台首页</a><a href="${pageContext.request.contextPath}/admin/books">图书管理</a><a href="${pageContext.request.contextPath}/admin/orders">订单管理</a><a href="${pageContext.request.contextPath}/admin/users">用户管理</a><a href="${pageContext.request.contextPath}/logout">退出登录</a></nav></aside>
    <main class="admin-main">
        <div class="page-title"><div><h1>后台首页</h1><p class="subtitle">管理员：${sessionScope.loginUser.realName}</p></div></div>
        <section class="grid stats">
            <div class="card stat">书籍总数<strong>${stats.bookCount}</strong></div>
            <div class="card stat">订单总数<strong>${stats.orderCount}</strong></div>
            <div class="card stat">用户总数<strong>${stats.userCount}</strong></div>
            <div class="card stat">今日订单<strong>${stats.todayOrderCount}</strong></div>
        </section>
        <div class="grid" style="grid-template-columns:2fr 1fr;margin-top:22px">
            <section class="card table-wrap">
                <table>
                    <thead><tr><th>最近订单</th><th>用户</th><th>金额</th><th>状态</th></tr></thead>
                    <tbody>
                    <c:forEach items="${recentOrders}" var="order"><tr><td>${order.orderNo}</td><td>${order.user.username}</td><td>￥<fmt:formatNumber value="${order.totalAmount}" pattern="0.00"/></td><td><span class="badge">${order.status}</span></td></tr></c:forEach>
                    </tbody>
                </table>
            </section>
            <section class="card summary">
                <h2>库存预警</h2>
                <c:forEach items="${lowStockBooks}" var="book">
                    <div style="display:flex;justify-content:space-between;border-bottom:1px solid var(--line);padding-bottom:10px"><span>${book.title}</span><strong>${book.stock}</strong></div>
                </c:forEach>
            </section>
        </div>
    </main>
</div>
</body>
</html>
