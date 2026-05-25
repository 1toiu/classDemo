package cn.gzu.classdemo.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Data
public class Order {
    private Integer id;
    private String orderNo;
    private Integer userId;
    private BigDecimal totalAmount;
    private String status;
    private Date createTime;
    private User user;
    private List<OrderItem> items;
}
