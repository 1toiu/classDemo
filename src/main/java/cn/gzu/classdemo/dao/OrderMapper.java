package cn.gzu.classdemo.dao;

import cn.gzu.classdemo.entity.Order;
import cn.gzu.classdemo.entity.OrderItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderMapper {
    int insert(Order order);

    int insertItem(OrderItem item);

    List<Order> findByUserId(@Param("userId") Integer userId);

    List<Order> findAll(@Param("status") String status, @Param("keyword") String keyword);

    List<OrderItem> findItems(@Param("orderId") Integer orderId);

    int updateStatus(@Param("id") Integer id, @Param("status") String status);

    int countAll();

    int countToday();

    List<Order> findRecent(@Param("limit") int limit);
}
