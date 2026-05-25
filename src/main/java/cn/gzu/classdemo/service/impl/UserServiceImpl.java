package cn.gzu.classdemo.service.impl;

import cn.gzu.classdemo.dao.UserMapper;
import cn.gzu.classdemo.entity.User;
import cn.gzu.classdemo.service.UserService;
import cn.gzu.classdemo.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class UserServiceImpl implements UserService {
    @Override
    public User login(String username, String password, String role) {
        try (SqlSession session = MyBatisUtil.openSession()) {
            User user = session.getMapper(UserMapper.class).findByUsername(username);
            if (user == null || !user.getPassword().equals(password)) {
                return null;
            }
            if (!"ENABLED".equalsIgnoreCase(user.getStatus())) {
                return null;
            }
            return user;
        }
    }

    @Override
    public List<User> listUsers() {
        try (SqlSession session = MyBatisUtil.openSession()) {
            return session.getMapper(UserMapper.class).findAll();
        }
    }

    @Override
    public int countUsers() {
        try (SqlSession session = MyBatisUtil.openSession()) {
            return session.getMapper(UserMapper.class).countAll();
        }
    }
}
