package cn.gzu.classdemo.service;

import cn.gzu.classdemo.entity.DashboardStats;
import cn.gzu.classdemo.entity.Order;

import java.util.List;

public interface OrderService {
    void submitOrder(Integer userId);

    List<Order> listUserOrders(Integer userId);

    List<Order> listOrders(String status, String keyword);

    void changeStatus(Integer id, String status);

    DashboardStats getDashboardStats();

    List<Order> listRecentOrders(int limit);
}
