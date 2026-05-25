package cn.gzu.classdemo.controller;

import cn.gzu.classdemo.entity.Book;
import cn.gzu.classdemo.service.BookService;
import cn.gzu.classdemo.service.OrderService;
import cn.gzu.classdemo.service.UserService;
import cn.gzu.classdemo.service.impl.BookServiceImpl;
import cn.gzu.classdemo.service.impl.OrderServiceImpl;
import cn.gzu.classdemo.service.impl.UserServiceImpl;
import cn.gzu.classdemo.util.WebUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {
    private final BookService bookService = new BookServiceImpl();
    private final OrderService orderService = new OrderServiceImpl();
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo() == null ? "/dashboard" : req.getPathInfo();
        if ("/books".equals(path)) {
            req.setAttribute("books", bookService.listBooks(req.getParameter("keyword"), req.getParameter("category")));
            req.setAttribute("editBook", bookService.getBook(WebUtil.getInt(req, "id")));
            req.getRequestDispatcher("/WEB-INF/jsp/admin/books.jsp").forward(req, resp);
            return;
        }
        if ("/orders".equals(path)) {
            req.setAttribute("orders", orderService.listOrders(req.getParameter("status"), req.getParameter("keyword")));
            req.setAttribute("status", req.getParameter("status"));
            req.getRequestDispatcher("/WEB-INF/jsp/admin/orders.jsp").forward(req, resp);
            return;
        }
        if ("/users".equals(path)) {
            req.setAttribute("users", userService.listUsers());
            req.getRequestDispatcher("/WEB-INF/jsp/admin/users.jsp").forward(req, resp);
            return;
        }
        req.setAttribute("stats", orderService.getDashboardStats());
        req.setAttribute("recentOrders", orderService.listRecentOrders(5));
        req.setAttribute("lowStockBooks", bookService.listLowStock(5));
        req.getRequestDispatcher("/WEB-INF/jsp/admin/dashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String path = req.getPathInfo() == null ? "" : req.getPathInfo();
        if ("/books/save".equals(path)) {
            Book book = new Book();
            book.setId(WebUtil.getInt(req, "id"));
            book.setTitle(req.getParameter("title"));
            book.setAuthor(req.getParameter("author"));
            book.setCategory(req.getParameter("category"));
            book.setPrice(WebUtil.getDecimal(req, "price"));
            book.setStock(WebUtil.getInt(req, "stock", 0));
            book.setDescription(req.getParameter("description"));
            book.setCoverUrl(req.getParameter("coverUrl"));
            bookService.saveBook(book);
            resp.sendRedirect(req.getContextPath() + "/admin/books");
            return;
        }
        if ("/books/delete".equals(path)) {
            bookService.deleteBook(WebUtil.getInt(req, "id"));
            resp.sendRedirect(req.getContextPath() + "/admin/books");
            return;
        }
        if ("/orders/status".equals(path)) {
            orderService.changeStatus(WebUtil.getInt(req, "id"), req.getParameter("status"));
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
        }
    }
}
