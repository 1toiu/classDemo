package cn.gzu.classdemo.dao;

import cn.gzu.classdemo.entity.CartItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CartMapper {
    List<CartItem> findByUserId(@Param("userId") Integer userId);

    CartItem findOne(@Param("userId") Integer userId, @Param("bookId") Integer bookId);

    int insert(CartItem item);

    int increase(@Param("id") Integer id, @Param("quantity") Integer quantity);

    int updateQuantity(@Param("id") Integer id, @Param("quantity") Integer quantity, @Param("userId") Integer userId);

    int delete(@Param("id") Integer id, @Param("userId") Integer userId);

    int clearByUserId(@Param("userId") Integer userId);
}
