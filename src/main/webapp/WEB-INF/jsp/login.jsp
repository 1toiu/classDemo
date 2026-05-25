<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>网上书城系统 - 登录</title>
    <%@ include file="common/tailwind.jspf" %>
    <style>
        .login-canvas { min-height: 100vh; display: flex; }
    </style>
</head>
<body class="bg-surface text-on-surface">
<main class="login-canvas relative overflow-hidden">
    <div class="hidden lg:flex lg:w-1/2 relative bg-primary-container overflow-hidden items-center justify-center">
        <div class="absolute inset-0 opacity-40">
            <img alt="Modern Library Interior" class="w-full h-full object-cover"
                 src="https://lh3.googleusercontent.com/aida-public/AB6AXuDF0xaYo58wZ7Y4q8U_bWvRJa0040lqOWUfnCLEOfdZ1eib9hq3dA6xqKkWjZL7PtbnZEtSYvfL2dReIjVagrbHM4zcSbGyN-YDxvJTMgp_LtOEf-xGRXMzR4I25AZjDF9-Adn9XzQ-6gJIujdOahmPDybkpB6blMHPA-tm7cxtMSphx2uklrzdcggcnHncWTqM_FvdEQw-_MkOeHB-BWVV1FVtQZA0_wYkTLppw4I4o1Hg86u48p_4HkePQcdUeDmgmlzMIa5KJ27X"/>
        </div>
        <div class="relative z-10 p-16 max-w-xl">
            <span class="text-secondary-fixed font-label-md text-label-md tracking-widest uppercase">知识门户</span>
            <h1 class="font-display text-display text-on-primary my-6 leading-tight">网上书城系统</h1>
            <p class="font-body-lg text-body-lg text-primary-fixed-dim opacity-90 leading-relaxed">
                为课程设计打造的数字书城。浏览图书、管理购物车、追踪订单，并完成后台维护。
            </p>
            <div class="mt-12 flex gap-8">
                <div class="flex flex-col"><span class="font-headline-md text-headline-md text-on-primary">6+</span><span class="font-label-sm text-label-sm text-primary-fixed-dim">精选书目</span></div>
                <div class="flex flex-col"><span class="font-headline-md text-headline-md text-on-primary">MVC</span><span class="font-label-sm text-label-sm text-primary-fixed-dim">分层架构</span></div>
            </div>
        </div>
        <div class="absolute inset-0 bg-gradient-to-t from-primary via-transparent to-transparent opacity-60"></div>
    </div>

    <div class="w-full lg:w-1/2 flex items-center justify-center p-margin-mobile md:p-margin-desktop bg-surface">
        <div class="w-full max-w-md">
            <div class="lg:hidden mb-12 text-center">
                <h1 class="font-headline-md text-headline-md text-primary mb-2">网上书城系统</h1>
                <p class="font-label-md text-label-md text-on-surface-variant">The Modern Library Portal</p>
            </div>
            <div class="mb-10">
                <h2 class="font-headline-lg text-headline-lg text-primary mb-2">欢迎回来</h2>
                <p class="font-body-md text-body-md text-on-surface-variant">请输入您的凭据以访问系统。</p>
            </div>
            <c:if test="${not empty error}">
                <div class="mb-5 px-4 py-3 rounded-lg bg-error-container text-on-error-container font-label-md text-label-md">${error}</div>
            </c:if>
            <form class="space-y-6" method="post" action="${pageContext.request.contextPath}/login">
                <div class="space-y-3">
                    <label class="font-label-md text-label-md text-on-surface-variant">访问角色</label>
                    <div class="flex p-1 bg-surface-container-low rounded-lg border border-outline-variant">
                        <label class="flex-1 cursor-pointer">
                            <input checked class="sr-only peer" name="role" type="radio" value="USER"/>
                            <div class="py-2.5 text-center rounded-md font-label-md text-label-md transition-all peer-checked:bg-primary peer-checked:text-on-primary text-on-surface-variant hover:text-primary">普通用户</div>
                        </label>
                        <label class="flex-1 cursor-pointer">
                            <input class="sr-only peer" name="role" type="radio" value="ADMIN"/>
                            <div class="py-2.5 text-center rounded-md font-label-md text-label-md transition-all peer-checked:bg-primary peer-checked:text-on-primary text-on-surface-variant hover:text-primary">管理员</div>
                        </label>
                    </div>
                </div>
                <div class="space-y-2">
                    <label class="font-label-md text-label-md text-on-surface-variant" for="username">用户名</label>
                    <div class="relative">
                        <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-outline text-[20px]">person</span>
                        <input class="w-full pl-11 pr-4 py-3 bg-surface-container-lowest border border-outline-variant rounded-lg focus:ring-2 focus:ring-secondary/20 focus:border-secondary transition-all outline-none font-body-md text-body-md" id="username" name="username" placeholder="admin / user" type="text" required/>
                    </div>
                </div>
                <div class="space-y-2">
                    <label class="font-label-md text-label-md text-on-surface-variant" for="password">密码</label>
                    <div class="relative">
                        <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-outline text-[20px]">lock</span>
                        <input class="w-full pl-11 pr-4 py-3 bg-surface-container-lowest border border-outline-variant rounded-lg focus:ring-2 focus:ring-secondary/20 focus:border-secondary transition-all outline-none font-body-md text-body-md" id="password" name="password" placeholder="123456" type="password" required/>
                    </div>
                </div>
                <button class="w-full py-4 bg-primary text-on-primary font-label-md text-label-md rounded-lg shadow-sm hover:bg-primary/90 active:scale-[0.98] transition-all flex items-center justify-center gap-2 group" type="submit">
                    登录
                    <span class="material-symbols-outlined text-[18px] group-hover:translate-x-1 transition-transform">arrow_forward</span>
                </button>
            </form>
        </div>
    </div>
</main>
</body>
</html>
