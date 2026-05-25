<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="zh-CN">
<head><meta charset="UTF-8"><title>用户管理</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css"></head>
<body>
<div class="sidebar-layout">
    <aside class="sidebar"><a class="brand" href="${pageContext.request.contextPath}/admin/dashboard">网上书城后台</a><nav class="side-nav"><a href="${pageContext.request.contextPath}/admin/dashboard">后台首页</a><a href="${pageContext.request.contextPath}/admin/books">图书管理</a><a href="${pageContext.request.contextPath}/admin/orders">订单管理</a><a class="active" href="${pageContext.request.contextPath}/admin/users">用户管理</a><a href="${pageContext.request.contextPath}/logout">退出登录</a></nav></aside>
    <main class="admin-main">
        <div class="page-title"><div><h1>用户管理</h1><p class="subtitle">查看系统用户、角色与账户状态。</p></div></div>
        <section class="card table-wrap">
            <table>
                <thead><tr><th>ID</th><th>用户名</th><th>姓名</th><th>邮箱</th><th>角色</th><th>状态</th><th>创建时间</th></tr></thead>
                <tbody>
                <c:forEach items="${users}" var="user">
                    <tr><td>${user.id}</td><td><strong>${user.username}</strong></td><td>${user.realName}</td><td>${user.email}</td><td><span class="badge">${user.role}</span></td><td>${user.status}</td><td><fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm"/></td></tr>
                </c:forEach>
                </tbody>
            </table>
        </section>
    </main>
</div>
</body>
</html>
