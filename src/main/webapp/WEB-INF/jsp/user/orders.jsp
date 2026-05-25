<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="zh-CN">
<head><meta charset="utf-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>我的订单 - 现代图书馆</title><%@ include file="../common/tailwind.jspf" %></head>
<body class="min-h-screen flex flex-col bg-background text-on-surface">
<nav class="fixed top-0 left-0 w-full z-50 bg-surface border-b border-outline-variant">
    <div class="max-w-container-max mx-auto flex justify-between items-center px-margin-desktop py-4">
        <div class="flex items-center gap-8"><span class="font-headline-md text-headline-md font-bold text-primary">现代图书馆</span><div class="hidden md:flex gap-6"><a class="text-on-surface-variant font-label-md text-label-md hover:text-primary" href="${pageContext.request.contextPath}/books">首页</a><a class="text-on-surface-variant font-label-md text-label-md hover:text-primary" href="${pageContext.request.contextPath}/cart">购物车</a><a class="text-primary border-b-2 border-primary pb-1 font-label-md text-label-md" href="${pageContext.request.contextPath}/orders">我的订单</a></div></div>
        <div class="flex items-center gap-4"><a href="${pageContext.request.contextPath}/cart"><span class="material-symbols-outlined">shopping_cart</span></a><a href="${pageContext.request.contextPath}/logout" class="hidden md:block font-label-md text-label-md text-primary hover:text-secondary">退出登录</a></div>
    </div>
</nav>
<main class="mt-24 mb-16 px-margin-mobile md:px-margin-desktop max-w-container-max mx-auto w-full flex-grow">
    <header class="mb-10"><h1 class="font-headline-lg text-headline-lg text-primary mb-2">订单历史</h1><p class="font-body-md text-body-md text-on-surface-variant">回顾并追踪您近期的知识获取记录。</p></header>
    <div class="bg-surface-container-lowest rounded-xl border border-outline-variant overflow-hidden">
        <div class="hidden md:grid grid-cols-5 bg-surface-container-low px-6 py-4 border-b border-outline-variant"><span class="font-label-sm text-label-sm text-on-surface-variant uppercase">订单号</span><span class="font-label-sm text-label-sm text-on-surface-variant uppercase">时间</span><span class="font-label-sm text-label-sm text-on-surface-variant uppercase">金额</span><span class="font-label-sm text-label-sm text-on-surface-variant uppercase">状态</span><span class="font-label-sm text-label-sm text-on-surface-variant uppercase text-right">明细</span></div>
        <div class="divide-y divide-outline-variant">
            <c:forEach items="${orders}" var="order">
                <div class="group transition-all hover:bg-surface-container-low">
                    <div class="grid grid-cols-2 md:grid-cols-5 items-start px-6 py-6 gap-y-3">
                        <span class="font-label-md text-label-md text-primary font-bold">${order.orderNo}</span>
                        <span class="font-body-md text-body-md text-on-surface-variant"><fmt:formatDate value="${order.createTime}" pattern="yyyy年MM月dd日 HH:mm"/></span>
                        <span class="font-body-md text-body-md text-primary font-bold">￥<fmt:formatNumber value="${order.totalAmount}" pattern="0.00"/></span>
                        <span><span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${order.status == 'COMPLETED' ? 'bg-tertiary-fixed-dim/20 text-on-tertiary-fixed-variant' : order.status == 'CANCELLED' ? 'bg-error-container text-on-error-container' : 'bg-secondary/10 text-secondary'}">${order.status}</span></span>
                        <div class="col-span-2 md:col-span-1 md:text-right font-body-md text-body-md text-on-surface-variant">
                            <c:forEach items="${order.items}" var="item"><div>${item.bookTitle} × ${item.quantity}</div></c:forEach>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty orders}"><div class="py-12 text-center text-on-surface-variant">暂无订单</div></c:if>
        </div>
    </div>
</main>
</body>
</html>
