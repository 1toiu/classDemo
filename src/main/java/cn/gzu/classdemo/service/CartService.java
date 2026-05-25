package cn.gzu.classdemo.service;

import cn.gzu.classdemo.entity.CartItem;

import java.math.BigDecimal;
import java.util.List;

public interface CartService {
    List<CartItem> listCart(Integer userId);

    void addToCart(Integer userId, Integer bookId, Integer quantity);

    void updateQuantity(Integer userId, Integer cartId, Integer quantity);

    void remove(Integer userId, Integer cartId);

    BigDecimal sumTotal(List<CartItem> items);
}
