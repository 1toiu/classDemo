<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="zh-CN">
<head><meta charset="UTF-8"><title>我的订单</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css"></head>
<body>
<header class="topbar"><div class="container topbar-inner"><a class="brand" href="${pageContext.request.contextPath}/books">网上书城系统</a><nav class="nav"><a href="${pageContext.request.contextPath}/books">首页</a><a href="${pageContext.request.contextPath}/cart">购物车</a><a class="active" href="${pageContext.request.contextPath}/orders">我的订单</a><a href="${pageContext.request.contextPath}/logout">退出登录</a></nav></div></header>
<main class="container page">
    <div class="page-title"><div><h1>我的订单</h1><p class="subtitle">查看历史订单及订单明细。</p></div></div>
    <section class="card table-wrap">
        <table>
            <thead><tr><th>订单编号</th><th>下单时间</th><th>金额</th><th>状态</th><th>明细</th></tr></thead>
            <tbody>
            <c:forEach items="${orders}" var="order">
                <tr>
                    <td><strong>${order.orderNo}</strong></td>
                    <td><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>￥<fmt:formatNumber value="${order.totalAmount}" pattern="0.00"/></td>
                    <td><span class="badge ${order.status == 'COMPLETED' ? 'done' : order.status == 'CANCELLED' ? 'cancel' : 'warn'}">${order.status}</span></td>
                    <td>
                        <c:forEach items="${order.items}" var="item">
                            <div>${item.bookTitle} × ${item.quantity}</div>
                        </c:forEach>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty orders}"><tr><td colspan="5" class="empty">暂无订单</td></tr></c:if>
            </tbody>
        </table>
    </section>
</main>
</body>
</html>
