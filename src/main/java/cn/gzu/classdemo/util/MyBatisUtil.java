package cn.gzu.classdemo.util;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public final class MyBatisUtil {
    private static final SqlSessionFactory SQL_SESSION_FACTORY;

    static {
        try (InputStream inputStream = Resources.getResourceAsStream("mybatis-config.xml")) {
            SQL_SESSION_FACTORY = new SqlSessionFactoryBuilder().build(inputStream);
        } catch (IOException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    private MyBatisUtil() {
    }

    public static SqlSession openSession() {
        return SQL_SESSION_FACTORY.openSession();
    }
}
