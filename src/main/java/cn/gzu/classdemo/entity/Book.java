package cn.gzu.classdemo.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class Book {
    private Integer id;
    private String title;
    private String author;
    private String category;
    private BigDecimal price;
    private Integer stock;
    private String description;
    private String coverUrl;
    private Date createTime;
}
