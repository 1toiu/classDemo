package cn.gzu.classdemo.service;

import cn.gzu.classdemo.entity.Book;

import java.util.List;

public interface BookService {
    List<Book> listBooks(String keyword, String category);

    List<String> listCategories();

    Book getBook(Integer id);

    void saveBook(Book book);

    void deleteBook(Integer id);

    int countBooks();

    List<Book> listLowStock(int limit);
}
