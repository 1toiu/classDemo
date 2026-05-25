package cn.gzu.classdemo.entity;

import lombok.Data;

import java.util.Date;

@Data
public class User {
    private Integer id;
    private String username;
    private String password;
    private String realName;
    private String email;
    private String role;
    private String status;
    private Date createTime;

    public boolean isAdmin() {
        return "ADMIN".equalsIgnoreCase(role);
    }
}
