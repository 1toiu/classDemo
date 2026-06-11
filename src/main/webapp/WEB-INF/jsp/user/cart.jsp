<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="light" lang="zh-CN">
<head><meta charset="utf-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>购物车 | 现代图书馆</title><%@ include file="../common/tailwind.jspf" %></head>
<body class="bg-background text-on-surface">
<header class="fixed top-0 left-0 w-full z-50 bg-surface border-b border-outline-variant">
    <div class="max-w-container-max mx-auto flex justify-between items-center px-margin-desktop py-4">
        <div class="font-headline-md text-headline-md font-bold text-primary">现代图书馆</div>
        <nav class="hidden md:flex items-center gap-8">
            <a class="text-on-surface-variant font-label-md text-label-md hover:text-primary" href="${pageContext.request.contextPath}/books">首页</a>
            <a class="text-primary border-b-2 border-primary pb-1 font-label-md text-label-md" href="${pageContext.request.contextPath}/cart">购物车</a>
            <a class="text-on-surface-variant font-label-md text-label-md hover:text-primary" href="${pageContext.request.contextPath}/orders">我的订单</a>
        </nav>
        <a class="hidden md:inline text-on-surface-variant font-label-md text-label-md hover:text-secondary" href="${pageContext.request.contextPath}/logout">退出登录</a>
    </div>
</header>
<main class="mt-24 mb-16 px-margin-desktop max-w-container-max mx-auto">
    <section class="mb-12"><h1 class="font-headline-lg text-headline-lg text-primary">购物车</h1><p class="font-body-md text-body-md text-on-surface-variant mt-2">您的收藏中有 ${cartItems.size()} 件商品。</p></section>
    <c:if test="${not empty error}"><div class="mb-6 px-4 py-3 rounded-lg bg-error-container text-on-error-container">${error}</div></c:if>
    <div class="flex flex-col lg:grid lg:grid-cols-12 lg:gap-12">
        <div class="lg:col-span-8">
            <div class="overflow-x-auto">
                <table class="w-full border-collapse">
                    <thead class="bg-surface-container-low border-b border-outline-variant"><tr><th class="text-left py-4 px-4 font-label-sm text-label-sm uppercase text-on-surface-variant">商品</th><th class="text-center py-4 px-4 font-label-sm text-label-sm uppercase text-on-surface-variant">数量</th><th class="text-right py-4 px-4 font-label-sm text-label-sm uppercase text-on-surface-variant">单价</th><th class="text-right py-4 px-4 font-label-sm text-label-sm uppercase text-on-surface-variant">总额</th><th class="py-4 px-4"></th></tr></thead>
                    <tbody class="divide-y divide-outline-variant">
                    <c:forEach items="${cartItems}" var="item">
                        <tr class="group hover:bg-surface-container-lowest transition-colors">
                            <td class="py-6 px-4"><div class="flex items-center gap-4"><div class="w-16 h-24 bg-surface-container rounded overflow-hidden flex-shrink-0"><img class="w-full h-full object-cover" src="${pageContext.request.contextPath}/${item.book.coverUrl}" alt="${item.book.title}"/></div><div><p class="font-label-md text-label-md text-primary font-bold">${item.book.title}</p><p class="font-label-sm text-label-sm text-on-surface-variant">${item.book.category} · ${item.book.author}</p></div></div></td>
                            <td class="py-6 px-4">
                                <form class="flex items-center justify-center border border-outline-variant rounded-lg w-fit mx-auto overflow-hidden" method="post" action="${pageContext.request.contextPath}/cart/update">
                                    <input type="hidden" name="cartId" value="${item.id}"/>
                                    <button class="px-3 py-1 hover:bg-surface-container" type="submit" name="quantity" value="${item.quantity - 1}">-</button>
                                    <span class="px-4 py-1 font-label-md text-label-md border-x border-outline-variant">${item.quantity}</span>
                                    <button class="px-3 py-1 hover:bg-surface-container" type="submit" name="quantity" value="${item.quantity + 1}">+</button>
                                </form>
                            </td>
                            <td class="py-6 px-4 text-right font-body-md text-body-md text-on-surface-variant">￥<fmt:formatNumber value="${item.book.price}" pattern="0.00"/></td>
                            <td class="py-6 px-4 text-right font-label-md text-label-md text-primary font-bold">￥<fmt:formatNumber value="${item.subtotal}" pattern="0.00"/></td>
                            <td class="py-6 px-4 text-right"><form method="post" action="${pageContext.request.contextPath}/cart/delete" onsubmit="return confirm('确认移出购物车吗？')"><input type="hidden" name="cartId" value="${item.id}"/><button class="material-symbols-outlined text-on-surface-variant hover:text-error" type="submit">delete</button></form></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty cartItems}"><tr><td colspan="5" class="py-12 text-center text-on-surface-variant">购物车为空</td></tr></c:if>
                    </tbody>
                </table>
            </div>
        </div>
        <aside class="lg:col-span-4 mt-12 lg:mt-0">
            <div class="bg-surface border border-outline-variant rounded-xl p-8 sticky top-24">
                <h2 class="font-headline-md text-headline-md text-primary mb-6">订单摘要</h2>
                <div class="space-y-4 mb-8">
                    <div class="flex justify-between"><span class="font-body-md text-body-md text-on-surface-variant">小计 (${cartItems.size()} 件商品)</span><span class="font-body-md text-body-md text-primary">￥<fmt:formatNumber value="${total}" pattern="0.00"/></span></div>
                    <div class="flex justify-between"><span class="font-body-md text-body-md text-on-surface-variant">标准运费</span><span class="font-body-md text-body-md text-primary">￥0.00</span></div>
                    <div class="pt-4 border-t border-outline-variant flex justify-between items-center"><span class="font-label-md text-label-md text-primary font-bold">订单总额</span><span class="font-headline-md text-headline-md text-primary font-bold">￥<fmt:formatNumber value="${total}" pattern="0.00"/></span></div>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/cart/checkout"><button class="w-full py-4 bg-primary text-on-primary rounded-lg font-label-md text-label-md hover:opacity-90 active:scale-95 transition-all uppercase tracking-widest" type="submit" ${empty cartItems ? 'disabled' : ''}>立即结算</button></form>
                <a class="mt-3 w-full py-4 bg-transparent border border-outline-variant text-primary rounded-lg font-label-md text-label-md hover:bg-surface-container transition-all flex justify-center" href="${pageContext.request.contextPath}/books">继续购物</a>
            </div>
        </aside>
    </div>
</main>
<%@ include file="../common/ai-chat.jspf" %>
</body>
</html>
