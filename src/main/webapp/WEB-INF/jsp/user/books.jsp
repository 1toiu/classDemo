<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="light" lang="zh-CN">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>网上书城系统</title>
    <%@ include file="../common/tailwind.jspf" %>
</head>
<body class="text-on-surface bg-background">
<nav class="fixed top-0 left-0 w-full z-50 bg-surface border-b border-outline-variant">
    <div class="max-w-container-max mx-auto flex justify-between items-center px-margin-desktop py-4">
        <div class="flex items-center gap-8">
            <span class="font-headline-md text-headline-md font-bold text-primary">现代图书馆</span>
            <div class="hidden md:flex items-center gap-6">
                <a class="text-primary border-b-2 border-primary pb-1 font-label-md text-label-md" href="${pageContext.request.contextPath}/books">首页</a>
                <a class="text-on-surface-variant font-label-md text-label-md hover:text-primary transition-colors" href="${pageContext.request.contextPath}/cart">购物车</a>
                <a class="text-on-surface-variant font-label-md text-label-md hover:text-primary transition-colors" href="${pageContext.request.contextPath}/orders">我的订单</a>
            </div>
        </div>
        <div class="flex items-center gap-4">
            <form class="relative hidden lg:flex items-center" method="get" action="${pageContext.request.contextPath}/books">
                <span class="material-symbols-outlined absolute left-3 text-on-surface-variant">search</span>
                <input name="keyword" value="${keyword}" class="pl-10 pr-4 py-2 bg-surface-container-low border border-outline-variant rounded-lg text-body-md focus:outline-none focus:border-secondary transition-all w-64" placeholder="搜索书名，作者..." type="text"/>
            </form>
            <a class="p-2 text-on-surface-variant hover:text-primary transition-colors" href="${pageContext.request.contextPath}/cart"><span class="material-symbols-outlined">shopping_cart</span></a>
            <a class="p-2 text-on-surface-variant hover:text-primary transition-colors" href="${pageContext.request.contextPath}/login"><span class="material-symbols-outlined">account_circle</span></a>
            <div class="h-6 w-px bg-outline-variant mx-2"></div>
            <a class="font-label-md text-label-md text-on-surface-variant hover:text-error transition-colors" href="${pageContext.request.contextPath}/logout">退出登录</a>
        </div>
    </div>
</nav>

<main class="mt-24 max-w-container-max mx-auto px-margin-desktop pb-20">
    <section class="mb-12">
        <div class="flex flex-col md:flex-row md:items-end justify-between gap-6">
            <div>
                <h1 class="font-display text-display text-primary mb-2">发现你的下一部读物</h1>
                <p class="font-body-lg text-body-lg text-on-surface-variant max-w-2xl">为现代探索者精选的知识瑰宝。浏览我们的技术卓越与课程设计系列。</p>
            </div>
            <div class="flex flex-wrap gap-2">
                <a class="px-4 py-2 ${empty category ? 'bg-primary text-on-primary' : 'bg-surface-container-low border border-outline-variant text-on-surface-variant'} rounded-full font-label-md text-label-md" href="${pageContext.request.contextPath}/books">全部书籍</a>
                <c:forEach items="${categories}" var="cat">
                    <a class="px-4 py-2 ${cat == category ? 'bg-primary text-on-primary' : 'bg-surface-container-low border border-outline-variant text-on-surface-variant hover:bg-surface-container-high'} rounded-full font-label-md text-label-md transition-colors" href="${pageContext.request.contextPath}/books?category=${cat}">${cat}</a>
                </c:forEach>
            </div>
        </div>
    </section>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
        <c:forEach items="${books}" var="book" varStatus="s">
            <article class="bg-surface border border-outline-variant rounded-lg overflow-hidden transition-all duration-300 card-hover flex flex-col">
                <div class="aspect-[3/4] bg-surface-container relative group overflow-hidden">
                    <img alt="${book.title}" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" src="${pageContext.request.contextPath}/${book.coverUrl}"/>
                    <c:if test="${s.index == 0}"><div class="absolute top-3 left-3 bg-white/90 backdrop-blur-sm px-2 py-1 rounded text-[10px] font-bold uppercase tracking-wider text-primary border border-outline-variant/30">新品上架</div></c:if>
                </div>
                <div class="p-6 flex-grow flex flex-col">
                    <div class="flex justify-between items-start mb-2">
                        <span class="font-label-sm text-label-sm px-2 py-0.5 bg-surface-container-low rounded border border-outline-variant text-on-surface-variant">${book.category}</span>
                        <span class="font-label-md text-label-md font-bold text-secondary">￥<fmt:formatNumber value="${book.price}" pattern="0.00"/></span>
                    </div>
                    <h3 class="font-headline-md text-headline-md text-primary mb-1">${book.title}</h3>
                    <p class="font-label-md text-label-md text-on-surface-variant mb-3">作者：${book.author}</p>
                    <p class="font-body-md text-body-md text-on-surface-variant line-clamp-3 mb-4">${book.description}</p>
                    <div class="mt-auto pt-4 border-t border-outline-variant flex items-center justify-between">
                        <span class="font-label-sm text-label-sm ${book.stock <= 5 ? 'text-error font-bold' : 'text-on-surface-variant'}">库存: ${book.stock}</span>
                        <form method="post" action="${pageContext.request.contextPath}/cart/add">
                            <input type="hidden" name="bookId" value="${book.id}"/>
                            <input type="hidden" name="quantity" value="1"/>
                            <button class="flex items-center gap-2 px-4 py-2 bg-primary text-on-primary rounded-lg font-label-md text-label-md hover:bg-primary/90 transition-all active:scale-95" type="submit">
                                <span class="material-symbols-outlined text-[18px]">add_shopping_cart</span>加入购物车
                            </button>
                        </form>
                    </div>
                </div>
            </article>
        </c:forEach>
    </div>
</main>
<footer class="w-full py-8 px-margin-desktop flex flex-col md:flex-row justify-between items-center max-w-container-max mx-auto border-t border-outline-variant mt-20">
    <div><span class="font-headline-md text-headline-md font-bold text-primary">现代图书馆</span><p class="font-label-sm text-label-sm text-on-surface-variant mt-1">© 2026 现代图书馆。保留所有权利。</p></div>
    <div class="flex gap-8 mt-4 md:mt-0"><a class="font-label-sm text-label-sm text-on-surface-variant hover:text-secondary" href="#">隐私政策</a><a class="font-label-sm text-label-sm text-on-surface-variant hover:text-secondary" href="#">联系我们</a></div>
</footer>
<%@ include file="../common/ai-chat.jspf" %>
</body>
</html>
