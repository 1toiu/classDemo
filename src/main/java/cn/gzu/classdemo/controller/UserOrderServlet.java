package cn.gzu.classdemo.controller;

import cn.gzu.classdemo.entity.User;
import cn.gzu.classdemo.service.OrderService;
import cn.gzu.classdemo.service.impl.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/orders")
public class UserOrderServlet extends HttpServlet {
    private final OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("loginUser");
        req.setAttribute("orders", orderService.listUserOrders(user.getId()));
        req.getRequestDispatcher("/WEB-INF/jsp/user/orders.jsp").forward(req, resp);
    }
}
