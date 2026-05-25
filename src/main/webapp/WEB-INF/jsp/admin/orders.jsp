<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="zh-CN">
<head><meta charset="UTF-8"><title>订单管理</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css"></head>
<body>
<div class="sidebar-layout">
    <aside class="sidebar"><a class="brand" href="${pageContext.request.contextPath}/admin/dashboard">网上书城后台</a><nav class="side-nav"><a href="${pageContext.request.contextPath}/admin/dashboard">后台首页</a><a href="${pageContext.request.contextPath}/admin/books">图书管理</a><a class="active" href="${pageContext.request.contextPath}/admin/orders">订单管理</a><a href="${pageContext.request.contextPath}/admin/users">用户管理</a><a href="${pageContext.request.contextPath}/logout">退出登录</a></nav></aside>
    <main class="admin-main">
        <div class="page-title">
            <div><h1>订单管理</h1><p class="subtitle">查询订单、查看明细并修改状态。</p></div>
            <form class="toolbar" method="get" action="${pageContext.request.contextPath}/admin/orders">
                <input class="input" name="keyword" placeholder="订单号或用户">
                <select class="select" name="status"><option value="">全部状态</option><option value="SUBMITTED">已提交</option><option value="COMPLETED">已完成</option><option value="CANCELLED">已取消</option></select>
                <button class="btn secondary" type="submit">筛选</button>
            </form>
        </div>
        <section class="card table-wrap">
            <table>
                <thead><tr><th>订单编号</th><th>用户</th><th>时间</th><th>金额</th><th>状态</th><th>明细</th><th>操作</th></tr></thead>
                <tbody>
                <c:forEach items="${orders}" var="order">
                    <tr>
                        <td><strong>${order.orderNo}</strong></td><td>${order.user.username}</td><td><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm"/></td><td>￥<fmt:formatNumber value="${order.totalAmount}" pattern="0.00"/></td><td><span class="badge">${order.status}</span></td>
                        <td><c:forEach items="${order.items}" var="item"><div>${item.bookTitle} × ${item.quantity}</div></c:forEach></td>
                        <td>
                            <form class="toolbar" method="post" action="${pageContext.request.contextPath}/admin/orders/status">
                                <input type="hidden" name="id" value="${order.id}">
                                <select class="select" name="status"><option value="SUBMITTED">已提交</option><option value="COMPLETED">已完成</option><option value="CANCELLED">已取消</option></select>
                                <button class="btn secondary" type="submit">更新</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </section>
    </main>
</div>
</body>
</html>
