package cn.gzu.classdemo.controller;

import cn.gzu.classdemo.service.BookService;
import cn.gzu.classdemo.service.impl.BookServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/books")
public class BookServlet extends HttpServlet {
    private final BookService bookService = new BookServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        String category = req.getParameter("category");
        req.setAttribute("books", bookService.listBooks(keyword, category));
        req.setAttribute("categories", bookService.listCategories());
        req.setAttribute("keyword", keyword);
        req.setAttribute("category", category);
        req.getRequestDispatcher("/WEB-INF/jsp/user/books.jsp").forward(req, resp);
    }
}
