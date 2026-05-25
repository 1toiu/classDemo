package cn.gzu.classdemo.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class CartItem {
    private Integer id;
    private Integer userId;
    private Integer bookId;
    private Integer quantity;
    private Date createTime;
    private Book book;

    public BigDecimal getSubtotal() {
        if (book == null || book.getPrice() == null || quantity == null) {
            return BigDecimal.ZERO;
        }
        return book.getPrice().multiply(BigDecimal.valueOf(quantity));
    }
}
