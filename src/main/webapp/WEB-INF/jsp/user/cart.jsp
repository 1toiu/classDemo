<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>购物车</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css">
</head>
<body>
<header class="topbar"><div class="container topbar-inner"><a class="brand" href="${pageContext.request.contextPath}/books">网上书城系统</a><nav class="nav"><a href="${pageContext.request.contextPath}/books">首页</a><a class="active" href="${pageContext.request.contextPath}/cart">购物车</a><a href="${pageContext.request.contextPath}/orders">我的订单</a><a href="${pageContext.request.contextPath}/logout">退出登录</a></nav></div></header>
<main class="container page">
    <div class="page-title"><div><h1>购物车</h1><p class="subtitle">确认图书数量后提交订单。</p></div></div>
    <c:if test="${not empty error}"><div class="alert" style="margin-bottom:16px">${error}</div></c:if>
    <div class="split">
        <section class="card table-wrap">
            <table>
                <thead><tr><th>书籍</th><th>单价</th><th>数量</th><th>小计</th><th>操作</th></tr></thead>
                <tbody>
                <c:forEach items="${cartItems}" var="item">
                    <tr>
                        <td><strong>${item.book.title}</strong><div class="book-meta">${item.book.author}</div></td>
                        <td>￥<fmt:formatNumber value="${item.book.price}" pattern="0.00"/></td>
                        <td>
                            <form class="toolbar" method="post" action="${pageContext.request.contextPath}/cart/update">
                                <input type="hidden" name="cartId" value="${item.id}">
                                <input class="input" style="width:82px" type="number" name="quantity" min="1" value="${item.quantity}">
                                <button class="btn secondary" type="submit">更新</button>
                            </form>
                        </td>
                        <td>￥<fmt:formatNumber value="${item.subtotal}" pattern="0.00"/></td>
                        <td>
                            <form method="post" action="${pageContext.request.contextPath}/cart/delete" onsubmit="return confirmDelete('确认移出购物车吗？')">
                                <input type="hidden" name="cartId" value="${item.id}">
                                <button class="btn danger" type="submit">删除</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty cartItems}"><tr><td colspan="5" class="empty">购物车为空</td></tr></c:if>
                </tbody>
            </table>
        </section>
        <aside class="card summary">
            <h2>订单摘要</h2>
            <div style="display:flex;justify-content:space-between"><span>商品总数</span><strong>${cartItems.size()}</strong></div>
            <div style="display:flex;justify-content:space-between"><span>订单总额</span><strong class="price">￥<fmt:formatNumber value="${total}" pattern="0.00"/></strong></div>
            <form method="post" action="${pageContext.request.contextPath}/cart/checkout">
                <button class="btn accent" style="width:100%" type="submit" ${empty cartItems ? 'disabled' : ''}>提交订单</button>
            </form>
            <a class="btn secondary" href="${pageContext.request.contextPath}/books">继续选书</a>
        </aside>
    </div>
</main>
<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>
