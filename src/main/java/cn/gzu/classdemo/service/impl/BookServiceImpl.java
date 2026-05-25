package cn.gzu.classdemo.service.impl;

import cn.gzu.classdemo.dao.BookMapper;
import cn.gzu.classdemo.entity.Book;
import cn.gzu.classdemo.service.BookService;
import cn.gzu.classdemo.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class BookServiceImpl implements BookService {
    @Override
    public List<Book> listBooks(String keyword, String category) {
        try (SqlSession session = MyBatisUtil.openSession()) {
            return session.getMapper(BookMapper.class).findAll(keyword, category);
        }
    }

    @Override
    public List<String> listCategories() {
        try (SqlSession session = MyBatisUtil.openSession()) {
            return session.getMapper(BookMapper.class).findCategories();
        }
    }

    @Override
    public Book getBook(Integer id) {
        try (SqlSession session = MyBatisUtil.openSession()) {
            return session.getMapper(BookMapper.class).findById(id);
        }
    }

    @Override
    public void saveBook(Book book) {
        try (SqlSession session = MyBatisUtil.openSession()) {
            BookMapper mapper = session.getMapper(BookMapper.class);
            if (book.getId() == null) {
                mapper.insert(book);
            } else {
                mapper.update(book);
            }
            session.commit();
        }
    }

    @Override
    public void deleteBook(Integer id) {
        try (SqlSession session = MyBatisUtil.openSession()) {
            session.getMapper(BookMapper.class).delete(id);
            session.commit();
        }
    }

    @Override
    public int countBooks() {
        try (SqlSession session = MyBatisUtil.openSession()) {
            return session.getMapper(BookMapper.class).countAll();
        }
    }

    @Override
    public List<Book> listLowStock(int limit) {
        try (SqlSession session = MyBatisUtil.openSession()) {
            return session.getMapper(BookMapper.class).findLowStock(limit);
        }
    }
}
