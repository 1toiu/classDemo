<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>网上书城系统 - 登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css">
</head>
<body>
<main class="login-page">
    <section class="login-visual">
        <div>
            <p style="letter-spacing:.18em;color:#a8d5c9">ONLINE BOOKSTORE</p>
            <h1 style="font-size:44px;color:#fff;margin:10px 0">网上书城系统</h1>
            <p style="max-width:520px;color:#d7dde6;line-height:1.8">面向 Java Web 课程设计的图书浏览、购物车、下单与后台管理系统。</p>
        </div>
    </section>
    <section class="login-panel">
        <form class="login-box" method="post" action="${pageContext.request.contextPath}/login">
            <div>
                <h1>欢迎登录</h1>
                <p class="subtitle">请选择角色并输入账号信息</p>
            </div>
            <c:if test="${not empty error}">
                <div class="alert">${error}</div>
            </c:if>
            <div class="role-group">
                <label><input type="radio" name="role" value="USER" checked><span>普通用户</span></label>
                <label><input type="radio" name="role" value="ADMIN"><span>管理员</span></label>
            </div>
            <input class="input" type="text" name="username" placeholder="用户名：admin / user" required>
            <input class="input" type="password" name="password" placeholder="密码：123456" required>
            <button class="btn" type="submit">登录系统</button>
            <p class="subtitle">管理员：admin / 123456；普通用户：user / 123456</p>
        </form>
    </section>
</main>
</body>
</html>
