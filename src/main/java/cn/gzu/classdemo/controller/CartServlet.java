package cn.gzu.classdemo.controller;

import cn.gzu.classdemo.entity.CartItem;
import cn.gzu.classdemo.entity.User;
import cn.gzu.classdemo.service.CartService;
import cn.gzu.classdemo.service.OrderService;
import cn.gzu.classdemo.service.impl.CartServiceImpl;
import cn.gzu.classdemo.service.impl.OrderServiceImpl;
import cn.gzu.classdemo.util.WebUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/cart/*")
public class CartServlet extends HttpServlet {
    private final CartService cartService = new CartServiceImpl();
    private final OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("loginUser");
        List<CartItem> items = cartService.listCart(user.getId());
        req.setAttribute("cartItems", items);
        req.setAttribute("total", cartService.sumTotal(items));
        req.getRequestDispatcher("/WEB-INF/jsp/user/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        User user = (User) req.getSession().getAttribute("loginUser");
        String path = req.getPathInfo() == null ? "" : req.getPathInfo();
        try {
            if ("/add".equals(path)) {
                cartService.addToCart(user.getId(), WebUtil.getInt(req, "bookId"), WebUtil.getInt(req, "quantity", 1));
            } else if ("/update".equals(path)) {
                cartService.updateQuantity(user.getId(), WebUtil.getInt(req, "cartId"), WebUtil.getInt(req, "quantity", 1));
            } else if ("/delete".equals(path)) {
                cartService.remove(user.getId(), WebUtil.getInt(req, "cartId"));
            } else if ("/checkout".equals(path)) {
                orderService.submitOrder(user.getId());
                resp.sendRedirect(req.getContextPath() + "/orders");
                return;
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            doGet(req, resp);
        }
    }
}
