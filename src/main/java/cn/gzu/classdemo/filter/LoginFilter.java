package cn.gzu.classdemo.filter;

import cn.gzu.classdemo.entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(urlPatterns = {"/cart/*", "/orders/*", "/admin/*", "/ai/*"})
public class LoginFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        User user = (User) req.getSession().getAttribute("loginUser");
        if (user == null) {
            if (req.getServletPath().startsWith("/ai/")) {
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                resp.setContentType("application/json;charset=UTF-8");
                resp.getWriter().write("{\"error\":\"请先登录后再使用 AI 客服\"}");
                return;
            }
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        chain.doFilter(request, response);
    }
}
