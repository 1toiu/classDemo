package cn.gzu.classdemo.service.impl;

import cn.gzu.classdemo.dao.BookMapper;
import cn.gzu.classdemo.dao.CartMapper;
import cn.gzu.classdemo.dao.OrderMapper;
import cn.gzu.classdemo.dao.UserMapper;
import cn.gzu.classdemo.entity.CartItem;
import cn.gzu.classdemo.entity.DashboardStats;
import cn.gzu.classdemo.entity.Order;
import cn.gzu.classdemo.entity.OrderItem;
import cn.gzu.classdemo.service.OrderService;
import cn.gzu.classdemo.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class OrderServiceImpl implements OrderService {
    @Override
    public void submitOrder(Integer userId) {
        try (SqlSession session = MyBatisUtil.openSession()) {
            CartMapper cartMapper = session.getMapper(CartMapper.class);
            BookMapper bookMapper = session.getMapper(BookMapper.class);
            OrderMapper orderMapper = session.getMapper(OrderMapper.class);
            List<CartItem> items = cartMapper.findByUserId(userId);
            if (items.isEmpty()) {
                throw new IllegalStateException("购物车为空，无法提交订单");
            }

            BigDecimal total = BigDecimal.ZERO;
            for (CartItem item : items) {
                total = total.add(item.getSubtotal());
            }

            Order order = new Order();
            order.setOrderNo("OD" + new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()));
            order.setUserId(userId);
            order.setTotalAmount(total);
            order.setStatus("SUBMITTED");
            orderMapper.insert(order);

            for (CartItem item : items) {
                int changed = bookMapper.decreaseStock(item.getBookId(), item.getQuantity());
                if (changed == 0) {
                    throw new IllegalStateException("库存不足：" + item.getBook().getTitle());
                }
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(order.getId());
                orderItem.setBookId(item.getBookId());
                orderItem.setBookTitle(item.getBook().getTitle());
                orderItem.setPrice(item.getBook().getPrice());
                orderItem.setQuantity(item.getQuantity());
                orderMapper.insertItem(orderItem);
            }
            cartMapper.clearByUserId(userId);
            session.commit();
        }
    }

    @Override
    public List<Order> listUserOrders(Integer userId) {
        try (SqlSession session = MyBatisUtil.openSession()) {
            OrderMapper mapper = session.getMapper(OrderMapper.class);
            List<Order> orders = mapper.findByUserId(userId);
            fillItems(mapper, orders);
            return orders;
        }
    }

    @Override
    public List<Order> listOrders(String status, String keyword) {
        try (SqlSession session = MyBatisUtil.openSession()) {
            OrderMapper mapper = session.getMapper(OrderMapper.class);
            List<Order> orders = mapper.findAll(status, keyword);
            fillItems(mapper, orders);
            return orders;
        }
    }

    @Override
    public void changeStatus(Integer id, String status) {
        try (SqlSession session = MyBatisUtil.openSession()) {
            session.getMapper(OrderMapper.class).updateStatus(id, status);
            session.commit();
        }
    }

    @Override
    public DashboardStats getDashboardStats() {
        try (SqlSession session = MyBatisUtil.openSession()) {
            DashboardStats stats = new DashboardStats();
            stats.setBookCount(session.getMapper(BookMapper.class).countAll());
            stats.setOrderCount(session.getMapper(OrderMapper.class).countAll());
            stats.setUserCount(session.getMapper(UserMapper.class).countAll());
            stats.setTodayOrderCount(session.getMapper(OrderMapper.class).countToday());
            return stats;
        }
    }

    @Override
    public List<Order> listRecentOrders(int limit) {
        try (SqlSession session = MyBatisUtil.openSession()) {
            OrderMapper mapper = session.getMapper(OrderMapper.class);
            List<Order> orders = mapper.findRecent(limit);
            fillItems(mapper, orders);
            return orders;
        }
    }

    private void fillItems(OrderMapper mapper, List<Order> orders) {
        for (Order order : orders) {
            order.setItems(mapper.findItems(order.getId()));
        }
    }
}
