package cn.gzu.classdemo.service;

import cn.gzu.classdemo.entity.User;

import java.util.List;

public interface UserService {
    User login(String username, String password, String role);

    List<User> listUsers();

    int countUsers();
}
