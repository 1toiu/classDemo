package cn.gzu.classdemo.entity;

import lombok.Data;

@Data
public class DashboardStats {
    private int bookCount;
    private int orderCount;
    private int userCount;
    private int todayOrderCount;
}
