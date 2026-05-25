package cn.gzu.classdemo.filter;

import cn.gzu.classdemo.entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        User user = (User) req.getSession().getAttribute("loginUser");
        if (user == null || !user.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/books");
            return;
        }
        chain.doFilter(request, response);
    }
}
