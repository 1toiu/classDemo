package cn.gzu.classdemo.dao;

import cn.gzu.classdemo.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    User findByUsername(@Param("username") String username);

    List<User> findAll();

    int countAll();

    int insert(User user);

    int update(User user);
}
