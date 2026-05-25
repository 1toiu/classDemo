package cn.gzu.classdemo.dao;

import cn.gzu.classdemo.entity.Book;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BookMapper {
    List<Book> findAll(@Param("keyword") String keyword, @Param("category") String category);

    List<String> findCategories();

    Book findById(@Param("id") Integer id);

    int insert(Book book);

    int update(Book book);

    int delete(@Param("id") Integer id);

    int decreaseStock(@Param("id") Integer id, @Param("quantity") Integer quantity);

    int countAll();

    List<Book> findLowStock(@Param("limit") int limit);
}
