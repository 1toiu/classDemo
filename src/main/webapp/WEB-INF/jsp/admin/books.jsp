<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="zh-CN">
<head><meta charset="utf-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>图书管理 - 现代书库</title><%@ include file="../common/tailwind.jspf" %></head>
<body class="font-body-md text-on-surface antialiased flex h-screen overflow-hidden bg-background">
<aside class="fixed left-0 top-0 h-full z-40 bg-surface-container-low w-64 flex flex-col border-r border-outline-variant">
    <div class="p-6 flex flex-col gap-2"><h1 class="font-headline-md text-headline-md font-bold text-primary">现代书库</h1><span class="font-label-sm text-label-sm text-on-surface-variant">后台管理系统</span></div>
    <nav class="flex-1 overflow-y-auto font-label-md text-label-md flex flex-col gap-1 px-2"><a class="flex items-center gap-3 px-4 py-3 text-on-surface-variant hover:bg-surface-container rounded-lg" href="${pageContext.request.contextPath}/admin/dashboard"><span class="material-symbols-outlined">dashboard</span>仪表盘</a><a class="flex items-center gap-3 px-4 py-3 text-secondary bg-surface-bright font-bold border-r-4 border-secondary rounded-lg" href="${pageContext.request.contextPath}/admin/books"><span class="material-symbols-outlined">menu_book</span>图书管理</a><a class="flex items-center gap-3 px-4 py-3 text-on-surface-variant hover:bg-surface-container rounded-lg" href="${pageContext.request.contextPath}/admin/orders"><span class="material-symbols-outlined">receipt_long</span>订单管理</a><a class="flex items-center gap-3 px-4 py-3 text-on-surface-variant hover:bg-surface-container rounded-lg" href="${pageContext.request.contextPath}/admin/users"><span class="material-symbols-outlined">group</span>用户管理</a></nav>
    <div class="p-4 border-t border-outline-variant"><a class="flex items-center gap-3 px-4 py-3 text-on-surface-variant hover:bg-surface-container rounded-lg" href="${pageContext.request.contextPath}/logout"><span class="material-symbols-outlined">logout</span>退出登录</a></div>
</aside>
<main class="flex-1 ml-64 flex flex-col h-full overflow-hidden bg-background">
    <header class="sticky top-0 z-30 flex justify-between items-center px-margin-desktop bg-surface/80 backdrop-blur-md w-full h-16 border-b border-outline-variant"><div class="relative w-64"><span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-on-surface-variant text-[20px]">search</span><input class="w-full pl-10 pr-4 py-2 border border-outline-variant rounded-lg text-body-md focus:outline-none focus:border-secondary bg-surface-container-lowest" placeholder="搜索..." type="text"/></div><div class="flex items-center gap-3"><span class="font-label-md text-label-md text-on-surface">个人资料</span></div></header>
    <div class="flex-1 overflow-y-auto p-8">
        <div class="flex justify-between items-end mb-8"><div><h2 class="font-headline-lg text-headline-lg text-primary mb-2">图书管理</h2><p class="font-body-md text-body-md text-on-surface-variant">查看和管理系统中的所有图书资源。</p></div></div>
        <form class="bg-surface-container-lowest border border-outline-variant rounded-xl p-6 grid grid-cols-1 md:grid-cols-3 gap-4 mb-8" method="post" action="${pageContext.request.contextPath}/admin/books/save">
            <input type="hidden" name="id" value="${editBook.id}"/>
            <input class="rounded-lg border-outline-variant" name="title" placeholder="书名" value="${editBook.title}" required/>
            <input class="rounded-lg border-outline-variant" name="author" placeholder="作者" value="${editBook.author}" required/>
            <input class="rounded-lg border-outline-variant" name="category" placeholder="分类" value="${editBook.category}" required/>
            <input class="rounded-lg border-outline-variant" name="price" placeholder="价格" value="${editBook.price}" required/>
            <input class="rounded-lg border-outline-variant" name="stock" placeholder="库存" value="${editBook.stock}" required/>
            <input class="rounded-lg border-outline-variant" name="coverUrl" placeholder="封面路径" value="${empty editBook.coverUrl ? 'assets/img/book-java.svg' : editBook.coverUrl}"/>
            <textarea class="md:col-span-3 rounded-lg border-outline-variant" name="description" placeholder="简介">${editBook.description}</textarea>
            <div class="md:col-span-3 flex gap-3"><button class="bg-primary text-on-primary font-label-md text-label-md px-6 py-2.5 rounded-lg flex items-center gap-2" type="submit"><span class="material-symbols-outlined text-[18px]">add</span>保存书籍</button><a class="border border-outline-variant px-6 py-2.5 rounded-lg" href="${pageContext.request.contextPath}/admin/books">清空</a></div>
        </form>
        <div class="bg-surface-container-lowest border border-outline-variant rounded-xl overflow-hidden">
            <table class="w-full text-left border-collapse"><thead><tr class="bg-surface-container-low border-b border-outline-variant"><th class="py-3 px-6 font-label-sm text-label-sm text-on-surface-variant uppercase">编号</th><th class="py-3 px-6 font-label-sm text-label-sm text-on-surface-variant uppercase">书名</th><th class="py-3 px-6 font-label-sm text-label-sm text-on-surface-variant uppercase">作者</th><th class="py-3 px-6 font-label-sm text-label-sm text-on-surface-variant uppercase">分类</th><th class="py-3 px-6 font-label-sm text-label-sm text-on-surface-variant uppercase">价格</th><th class="py-3 px-6 font-label-sm text-label-sm text-on-surface-variant uppercase">库存</th><th class="py-3 px-6 font-label-sm text-label-sm text-on-surface-variant uppercase text-right">操作</th></tr></thead>
                <tbody class="font-body-md text-body-md text-on-surface"><c:forEach items="${books}" var="book"><tr class="border-b border-outline-variant hover:bg-surface-container-lowest/50"><td class="py-4 px-6 text-on-surface-variant font-medium">BK-${book.id}</td><td class="py-4 px-6 font-medium text-primary">${book.title}</td><td class="py-4 px-6">${book.author}</td><td class="py-4 px-6"><span class="px-2.5 py-1 bg-surface-container-low text-primary font-label-sm text-label-sm rounded-md">${book.category}</span></td><td class="py-4 px-6">￥<fmt:formatNumber value="${book.price}" pattern="0.00"/></td><td class="py-4 px-6 text-secondary font-medium">${book.stock}</td><td class="py-4 px-6 text-right"><div class="flex justify-end gap-3"><a class="text-on-surface-variant hover:text-secondary" href="${pageContext.request.contextPath}/admin/books?id=${book.id}"><span class="material-symbols-outlined text-[20px]">edit</span></a><form method="post" action="${pageContext.request.contextPath}/admin/books/delete" onsubmit="return confirm('确认删除？')"><input type="hidden" name="id" value="${book.id}"/><button class="text-on-surface-variant hover:text-error" type="submit"><span class="material-symbols-outlined text-[20px]">delete</span></button></form></div></td></tr></c:forEach></tbody>
            </table>
        </div>
    </div>
</main>
</body>
</html>
