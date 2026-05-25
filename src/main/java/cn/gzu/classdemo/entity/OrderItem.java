package cn.gzu.classdemo.entity;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class OrderItem {
    private Integer id;
    private Integer orderId;
    private Integer bookId;
    private String bookTitle;
    private BigDecimal price;
    private Integer quantity;
}
