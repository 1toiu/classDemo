package cn.gzu.classdemo.service.impl;

import cn.gzu.classdemo.dao.CartMapper;
import cn.gzu.classdemo.entity.CartItem;
import cn.gzu.classdemo.service.CartService;
import cn.gzu.classdemo.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.math.BigDecimal;
import java.util.List;

public class CartServiceImpl implements CartService {
    @Override
    public List<CartItem> listCart(Integer userId) {
        try (SqlSession session = MyBatisUtil.openSession()) {
            return session.getMapper(CartMapper.class).findByUserId(userId);
        }
    }

    @Override
    public void addToCart(Integer userId, Integer bookId, Integer quantity) {
        try (SqlSession session = MyBatisUtil.openSession()) {
            CartMapper mapper = session.getMapper(CartMapper.class);
            CartItem existed = mapper.findOne(userId, bookId);
            if (existed == null) {
                CartItem item = new CartItem();
                item.setUserId(userId);
                item.setBookId(bookId);
                item.setQuantity(quantity);
                mapper.insert(item);
            } else {
                mapper.increase(existed.getId(), quantity);
            }
            session.commit();
        }
    }

    @Override
    public void updateQuantity(Integer userId, Integer cartId, Integer quantity) {
        try (SqlSession session = MyBatisUtil.openSession()) {
            session.getMapper(CartMapper.class).updateQuantity(cartId, Math.max(1, quantity), userId);
            session.commit();
        }
    }

    @Override
    public void remove(Integer userId, Integer cartId) {
        try (SqlSession session = MyBatisUtil.openSession()) {
            session.getMapper(CartMapper.class).delete(cartId, userId);
            session.commit();
        }
    }

    @Override
    public BigDecimal sumTotal(List<CartItem> items) {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items) {
            total = total.add(item.getSubtotal());
        }
        return total;
    }
}
